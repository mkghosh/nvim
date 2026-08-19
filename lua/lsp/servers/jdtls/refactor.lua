---@diagnostic disable: undefined-field

local M = {}

local api = vim.api
local jdtls = require("jdtls")

----------------------------------------------------------------------
-- Basic JDTLS refactoring
----------------------------------------------------------------------

function M.organize_imports()
    jdtls.organize_imports()
end

function M.extract_method(visual)
    jdtls.extract_method(visual)
end

function M.extract_variable(visual)
    jdtls.extract_variable(visual)
end

function M.extract_constant(visual)
    jdtls.extract_constant(visual)
end

----------------------------------------------------------------------
-- Helpers
----------------------------------------------------------------------

local function get_jdtls_client(bufnr)
    bufnr = bufnr or api.nvim_get_current_buf()

    local clients = vim.lsp.get_clients({
        bufnr = bufnr,
        name = "jdtls",
    })

    return clients[1]
end


local function get_current_file_uri(bufnr)
    bufnr = bufnr or api.nvim_get_current_buf()

    if not api.nvim_buf_is_valid(bufnr) then
        return nil
    end

    local name = api.nvim_buf_get_name(bufnr)

    if name == "" then
        return nil
    end

    return vim.uri_from_fname(name)
end


local function apply_workspace_edit(edit)
    if not edit then
        vim.notify(
            "JDTLS returned no workspace edit",
            vim.log.levels.ERROR
        )
        return false
    end

    local ok, err = pcall(
        vim.lsp.util.apply_workspace_edit,
        edit,
        "utf-16"
    )

    if not ok then
        vim.notify(
            "Failed to apply JDTLS workspace edit:\n"
            .. tostring(err),
            vim.log.levels.ERROR
        )

        return false
    end

    return true
end


----------------------------------------------------------------------
-- Move a Java file
--
-- IMPORTANT:
--
-- This intentionally follows nvim-jdtls' own implementation:
--
--   java/getMoveDestinations
--          ↓
--   user selects destination
--          ↓
--   java/move
--          ↓
--   result.edit
--
-- The getMoveDestinations request uses params = vim.NIL.
----------------------------------------------------------------------

local function move_file_command(
    command,
    code_action_params,
    bufnr
)
    bufnr = bufnr or api.nvim_get_current_buf()

    local client = get_jdtls_client(bufnr)

    if not client then
        vim.notify(
            "JDTLS is not attached",
            vim.log.levels.ERROR
        )
        return
    end

    local uri = command.arguments[3].uri

    if not uri then
        vim.notify(
            "JDTLS move command did not contain a source URI",
            vim.log.levels.ERROR
        )
        return
    end

    local function is_valid_java_package(package_name)
        if not package_name or package_name == "" then
            return false
        end

        -- Package must not start or end with '.'
        if package_name:sub(1, 1) == "."
            or package_name:sub(-1) == "."
        then
            return false
        end

        -- Validate every package component independently.
        for part in package_name:gmatch("[^.]+") do
            if not part:match("^[%a_][%w_]*$") then
                return false
            end
        end

        return true
    end
    ------------------------------------------------------------------
    -- This is intentionally vim.NIL.
    --
    -- This is how nvim-jdtls itself constructs the request.
    ------------------------------------------------------------------

    local params = {
        moveKind = "moveResource",

        sourceUris = {
            uri,
        },

        params = vim.NIL,
    }

    ---@diagnostic disable-next-line: param-type-mismatch
    client:request(
        "java/getMoveDestinations",
        params,
        function(err, result, ctx)
            if err then
                vim.notify(
                    "JDTLS getMoveDestinations failed:\n"
                    .. vim.inspect(err),
                    vim.log.levels.ERROR
                )
                return
            end

            if not result then
                vim.notify(
                    "JDTLS returned no move destinations",
                    vim.log.levels.ERROR
                )
                return
            end

            if result.errorMessage then
                vim.notify(
                    result.errorMessage,
                    vim.log.levels.ERROR
                )
                return
            end

            if not result.destinations
                or #result.destinations == 0
            then
                vim.notify(
                    "Couldn't find any destination packages",
                    vim.log.levels.WARN
                )
                return
            end

            local destinations = vim.tbl_filter(
                function(x)
                    return not x.isDefaultPackage
                end,
                result.destinations
            )

            if #destinations == 0 then
                vim.notify(
                    "No valid destination packages found",
                    vim.log.levels.WARN
                )
                return
            end

            vim.ui.select(
                destinations,
                {
                    prompt = "Target package> ",

                    format_item = function(x)
                        local name =
                            x.project
                            .. " » "

                        if x.isParentOfSelectedFile then
                            name = name .. "* "
                        end

                        name =
                            name .. x.displayName

                        local sourceset =
                            string.match(
                                x.path,
                                "src/(%a+)/"
                            )

                        if sourceset then
                            return sourceset
                                .. " » "
                                .. name
                        end

                        return x.path
                            .. " » "
                            .. name
                    end,
                },
                function(destination)
                    if not destination then
                        return
                    end

                    --------------------------------------------------
                    -- IMPORTANT:
                    --
                    -- Use the ORIGINAL CodeAction params here.
                    --
                    -- Do NOT reconstruct this with
                    -- make_range_params().
                    --------------------------------------------------

                    local move_params = {
                        moveKind = "moveResource",

                        sourceUris = {
                            uri,
                        },

                        params = code_action_params,

                        destination = destination,

                        updateReferences = true,
                    }

                    ---@diagnostic disable-next-line: param-type-mismatch
                    client:request(
                        "java/move",
                        move_params,
                        function(
                            move_err,
                            refactor_result
                        )
                            if move_err then
                                vim.notify(
                                    "JDTLS move failed:\n"
                                    .. vim.inspect(move_err),
                                    vim.log.levels.ERROR
                                )
                                return
                            end

                            if not refactor_result then
                                vim.notify(
                                    "JDTLS returned no move result",
                                    vim.log.levels.ERROR
                                )
                                return
                            end

                            if refactor_result.errorMessage then
                                vim.notify(
                                    refactor_result.errorMessage,
                                    vim.log.levels.ERROR
                                )
                                return
                            end

                            --------------------------------------------------
                            -- JDTLS returns:
                            --
                            -- {
                            --     edit = {
                            --         changes = ...,
                            --         documentChanges = ...
                            --     }
                            -- }
                            --
                            -- The actual WorkspaceEdit is result.edit.
                            --------------------------------------------------

                            if not refactor_result.edit then
                                vim.notify(
                                    "JDTLS move result contains no edit:\n"
                                    .. vim.inspect(refactor_result),
                                    vim.log.levels.ERROR
                                )
                                return
                            end

                            if apply_workspace_edit(
                                    refactor_result.edit
                                ) then
                                vim.notify(
                                    "Java file moved successfully",
                                    vim.log.levels.INFO
                                )

                                --------------------------------------------------
                                -- Refresh the current buffer if it still
                                -- represents the old file.
                                --------------------------------------------------

                                vim.schedule(function()
                                    vim.cmd("checktime")
                                end)
                            end
                        end,
                        ctx.bufnr
                    )
                end
            )
        end,
        bufnr
    )
end


----------------------------------------------------------------------
-- Move file through JDTLS code action
--
-- This is the preferred entry point.
--
-- JDTLS gives us the command:
--
-- java.action.applyRefactoringCommand
--
-- arguments:
--
--   1 = "moveFile"
--   2 = original CodeAction params
--   3 = source resource
----------------------------------------------------------------------

function M.move_file()
    local bufnr = api.nvim_get_current_buf()

    local client = get_jdtls_client(bufnr)

    if not client then
        vim.notify(
            "JDTLS is not attached",
            vim.log.levels.ERROR
        )
        return
    end

    local params =
        vim.lsp.util.make_range_params(
            api.nvim_get_current_win(),
            "utf-16"
        )

    params.context = {
        diagnostics = vim.diagnostic.get(bufnr),
    }

    ---@diagnostic disable-next-line: param-type-mismatch
    client:request(
        "textDocument/codeAction",
        params,
        function(err, actions)
            if err then
                vim.notify(
                    "JDTLS codeAction failed:\n"
                    .. vim.inspect(err),
                    vim.log.levels.ERROR
                )
                return
            end

            if not actions then
                vim.notify(
                    "JDTLS returned no code actions",
                    vim.log.levels.WARN
                )
                return
            end

            for _, action in ipairs(actions) do
                local command =
                    action.command

                if command
                    and command.command
                    == "java.action.applyRefactoringCommand"
                then
                    local arguments =
                        command.arguments

                    if arguments
                        and arguments[1]
                        == "moveFile"
                    then
                        move_file_command(
                            command,
                            arguments[2],
                            bufnr
                        )

                        return
                    end
                end
            end

            vim.notify(
                "JDTLS did not offer a move-file refactoring here",
                vim.log.levels.WARN
            )
        end,
        bufnr
    )
end

----------------------------------------------------------------------
-- Find Java files directly inside a package directory
----------------------------------------------------------------------

local function find_java_files(package_dir)
    local files = {}

    local ok, iterator =
        pcall(vim.fs.dir, package_dir)

    if not ok or not iterator then
        return files
    end

    for name, file_type in iterator do
        if file_type == "file"
            and vim.endswith(name, ".java")
        then
            table.insert(
                files,
                vim.fs.joinpath(
                    package_dir,
                    name
                )
            )
        end
    end

    return files
end


----------------------------------------------------------------------
-- Move / rename package
--
-- JDTLS does not expose a simple packageRename command through
-- nvim-jdtls. Instead we use JDTLS' moveResource operation.
--
-- For a package:
--
--   com.finxcrm.Config
--
-- containing:
--
--   JacksonConfig.java
--   FooConfig.java
--
-- we send all source URIs together.
--
-- JDTLS then returns a WorkspaceEdit containing:
--
--   package declaration edits
--   file rename operations
--   reference updates
----------------------------------------------------------------------
----------------------------------------------------------------------
-- Move / Rename Java Package
--
-- We deliberately do NOT modify the working move_file() implementation.
--
-- Strategy:
--
--   1. Find all Java files directly inside the current package.
--   2. Ask JDTLS for the normal moveFile code action for one of them.
--   3. Extract the ORIGINAL CodeAction params from that command.
--   4. Ask JDTLS for move destinations for all package files.
--   5. Ask JDTLS to move all files together.
--   6. Apply result.edit exactly like the working move_file().
--
-- This causes JDTLS to:
--
--   - change package declarations
--   - rename/move the Java files
--   - update references
----------------------------------------------------------------------

local function find_java_files(package_dir)
    local files = {}

    local ok, iterator =
        pcall(vim.fs.dir, package_dir)

    if not ok or not iterator then
        return files
    end

    for name, file_type in iterator do
        if file_type == "file"
            and vim.endswith(name, ".java")
        then
            table.insert(
                files,
                vim.fs.joinpath(package_dir, name)
            )
        end
    end

    table.sort(files)

    return files
end


local function get_move_file_command(
    client,
    bufnr,
    callback
)
    local win = vim.api.nvim_get_current_win()

    if not vim.api.nvim_win_is_valid(win) then
        vim.notify(
            "Current window is invalid",
            vim.log.levels.ERROR
        )
        return
    end

    ---@type lsp.CodeActionParams
    local params =
        vim.lsp.util.make_range_params(
            win,
            "utf-16"
        )

    params.context = {
        diagnostics =
            vim.diagnostic.get(bufnr),
    }

    ---@diagnostic disable-next-line: param-type-mismatch
    client:request(
        "textDocument/codeAction",
        params,
        function(err, actions)
            if err then
                vim.notify(
                    "JDTLS codeAction failed:\n"
                    .. vim.inspect(err),
                    vim.log.levels.ERROR
                )
                return
            end

            if not actions then
                vim.notify(
                    "JDTLS returned no code actions",
                    vim.log.levels.WARN
                )
                return
            end

            for _, action in ipairs(actions) do
                local command =
                    action.command

                if command
                    and command.command
                    == "java.action.applyRefactoringCommand"
                then
                    local arguments =
                        command.arguments

                    if arguments
                        and arguments[1]
                        == "moveFile"
                    then
                        --------------------------------------------------
                        -- arguments[2] is the ORIGINAL CodeActionParams.
                        --
                        -- This is exactly what the working move_file()
                        -- implementation passes to java/move.
                        --------------------------------------------------

                        callback(
                            command,
                            arguments[2]
                        )

                        return
                    end
                end
            end

            vim.notify(
                "JDTLS did not offer moveFile for the package file",
                vim.log.levels.WARN
            )
        end,
        bufnr
    )
end


function M.move_package()
    local bufnr = vim.api.nvim_get_current_buf()

    local client = get_jdtls_client(bufnr)

    if not client then
        vim.notify(
            "JDTLS is not attached",
            vim.log.levels.ERROR
        )
        return
    end

    local current_file =
        vim.api.nvim_buf_get_name(bufnr)

    if current_file == "" then
        vim.notify(
            "Current buffer has no file",
            vim.log.levels.ERROR
        )
        return
    end

    local package_dir =
        vim.fs.dirname(current_file)

    local java_files =
        find_java_files(package_dir)

    if #java_files == 0 then
        vim.notify(
            "No Java files found in package:\n"
            .. package_dir,
            vim.log.levels.WARN
        )
        return
    end

    local source_uris = {}

    for _, file in ipairs(java_files) do
        table.insert(
            source_uris,
            vim.uri_from_fname(file)
        )
    end

    ------------------------------------------------------------------
    -- Get the real moveFile CodeAction parameters from JDTLS.
    ------------------------------------------------------------------

    get_move_file_command(
        client,
        bufnr,
        function(
            _move_command,
            code_action_params
        )
            if not code_action_params then
                vim.notify(
                    "Could not obtain JDTLS move parameters",
                    vim.log.levels.ERROR
                )
                return
            end

            ------------------------------------------------------------------
            -- Ask JDTLS for existing destinations.
            ------------------------------------------------------------------

            local destination_request = {
                moveKind = "moveResource",

                sourceUris = source_uris,

                params = vim.NIL,
            }

            ---@diagnostic disable-next-line: param-type-mismatch
            client:request(
                "java/getMoveDestinations",
                destination_request,
                function(
                    destination_err,
                    destination_result
                )
                    if destination_err then
                        vim.notify(
                            "JDTLS getMoveDestinations failed:\n"
                            .. vim.inspect(
                                destination_err
                            ),
                            vim.log.levels.ERROR
                        )
                        return
                    end

                    if not destination_result then
                        vim.notify(
                            "JDTLS returned no package destinations",
                            vim.log.levels.ERROR
                        )
                        return
                    end

                    if destination_result.errorMessage then
                        vim.notify(
                            destination_result.errorMessage,
                            vim.log.levels.ERROR
                        )
                        return
                    end

                    local destinations =
                        destination_result.destinations
                        or {}

                    ------------------------------------------------------------------
                    -- Remove the current package from the list.
                    ------------------------------------------------------------------

                    local current_uri =
                        vim.uri_from_fname(package_dir)

                    destinations =
                        vim.tbl_filter(
                            function(destination)
                                if destination.isDefaultPackage then
                                    return false
                                end

                                return destination.uri
                                    ~= current_uri
                            end,
                            destinations
                        )

                    ------------------------------------------------------------------
                    -- Add our own "Create new package..." entry.
                    --
                    -- We use a special marker so vim.ui.select()
                    -- can distinguish it from a real JDTLS destination.
                    ------------------------------------------------------------------

                    table.insert(
                        destinations,
                        {
                            __create_new_package = true,
                            displayName =
                            "+ Create new package...",
                        }
                    )

                    ------------------------------------------------------------------
                    -- SAME display format as move_file().
                    ------------------------------------------------------------------

                    vim.ui.select(
                        destinations,
                        {
                            prompt = string.format(
                                "Rename/move package (%d Java files) to: ",
                                #java_files
                            ),

                            format_item = function(x)
                                if x.__create_new_package then
                                    return x.displayName
                                end

                                local name =
                                    x.project
                                    .. " » "
                                    .. (
                                        x.isParentOfSelectedFile
                                        and "* "
                                        or ""
                                    )
                                    .. x.displayName

                                local sourceset =
                                    string.match(
                                        x.path,
                                        "src/(%a+)/"
                                    )

                                return (
                                        sourceset
                                        and sourceset
                                        or x.path
                                    )
                                    .. " » "
                                    .. name
                            end,
                        },
                        function(destination)
                            if not destination then
                                return
                            end

                            ------------------------------------------------------------------
                            -- CREATE NEW PACKAGE
                            ------------------------------------------------------------------

                            if destination.__create_new_package then
                                vim.ui.input(
                                    {
                                        prompt =
                                        "New package: ",
                                    },
                                    function(package_name)
                                        if not package_name
                                            or package_name == ""
                                        then
                                            return
                                        end

                                        ------------------------------------------------------
                                        -- Basic Java package validation.
                                        ------------------------------------------------------

                                        if not is_valid_java_package(package_name) then
                                            vim.notify(
                                                "Invalid Java package name: "
                                                .. package_name,
                                                vim.log.levels.ERROR
                                            )
                                            return
                                        end
                                        ------------------------------------------------------
                                        -- Determine source set.
                                        --
                                        -- Example:
                                        --
                                        -- /finxcrm/src/main/java/com/finxcrm/Config
                                        --
                                        -- becomes:
                                        --
                                        -- /finxcrm/src/main/java
                                        ------------------------------------------------------

                                        local source_root =
                                            package_dir:match(
                                                "^(.-/src/[^/]+/java)"
                                            )

                                        if not source_root then
                                            vim.notify(
                                                "Could not determine Java source root from:\n"
                                                .. package_dir,
                                                vim.log.levels.ERROR
                                            )
                                            return
                                        end

                                        ------------------------------------------------------
                                        -- Convert:
                                        --
                                        -- com.finxcrm.security
                                        --
                                        -- to:
                                        --
                                        -- com/finxcrm/security
                                        ------------------------------------------------------

                                        local relative_package =
                                            package_name:gsub(
                                                "%.",
                                                "/"
                                            )

                                        local new_package_dir =
                                            vim.fs.joinpath(
                                                source_root,
                                                relative_package
                                            )

                                        ------------------------------------------------------
                                        -- Don't allow moving to the same package.
                                        ------------------------------------------------------

                                        if vim.fs.normalize(
                                                new_package_dir
                                            ) == vim.fs.normalize(
                                                package_dir
                                            ) then
                                            vim.notify(
                                                "Destination package is the current package",
                                                vim.log.levels.WARN
                                            )
                                            return
                                        end

                                        ------------------------------------------------------
                                        -- If it already exists, use it as an existing
                                        -- destination.
                                        ------------------------------------------------------

                                        local stat =
                                            vim.uv.fs_stat(
                                                new_package_dir
                                            )

                                        if stat then
                                            if stat.type ~= "directory" then
                                                vim.notify(
                                                    "Destination exists but is not a directory:\n"
                                                    .. new_package_dir,
                                                    vim.log.levels.ERROR
                                                )
                                                return
                                            end

                                            --------------------------------------------------
                                            -- Construct a destination compatible with
                                            -- JDTLS getMoveDestinations().
                                            --------------------------------------------------

                                            local project_name =
                                                package_dir:match(
                                                    "/([^/]+)/src/"
                                                )

                                            if not project_name then
                                                project_name =
                                                    destination.project
                                            end

                                            destination = {
                                                displayName =
                                                    package_name,

                                                isDefaultPackage =
                                                    false,

                                                isParentOfSelectedFile =
                                                    false,

                                                path =
                                                    "/" .. project_name
                                                    .. "/src/main/java/"
                                                    .. relative_package,

                                                project =
                                                    project_name,

                                                uri =
                                                    vim.uri_from_fname(
                                                        new_package_dir
                                                    ),
                                            }
                                        else
                                            --------------------------------------------------
                                            -- Create the directory.
                                            --
                                            -- We create the COMPLETE package hierarchy.
                                            --------------------------------------------------

                                            local ok, mkdir_err =
                                                pcall(
                                                    vim.fn.mkdir,
                                                    new_package_dir,
                                                    "p"
                                                )

                                            if not ok then
                                                vim.notify(
                                                    "Failed to create package directory:\n"
                                                    .. tostring(
                                                        mkdir_err
                                                    ),
                                                    vim.log.levels.ERROR
                                                )
                                                return
                                            end

                                            --------------------------------------------------
                                            -- Verify it really exists.
                                            --------------------------------------------------

                                            local created_stat =
                                                vim.uv.fs_stat(
                                                    new_package_dir
                                                )

                                            if not created_stat
                                                or created_stat.type
                                                ~= "directory"
                                            then
                                                vim.notify(
                                                    "Package directory was not created:\n"
                                                    .. new_package_dir,
                                                    vim.log.levels.ERROR
                                                )
                                                return
                                            end

                                            local project_name =
                                                package_dir:match(
                                                    "/([^/]+)/src/"
                                                )

                                            if not project_name then
                                                vim.notify(
                                                    "Could not determine Maven project name",
                                                    vim.log.levels.ERROR
                                                )
                                                return
                                            end

                                            destination = {
                                                displayName =
                                                    package_name,

                                                isDefaultPackage =
                                                    false,

                                                isParentOfSelectedFile =
                                                    false,

                                                path =
                                                    "/" .. project_name
                                                    .. "/src/main/java/"
                                                    .. relative_package,

                                                project =
                                                    project_name,

                                                uri =
                                                    vim.uri_from_fname(
                                                        new_package_dir
                                                    ),
                                            }
                                        end

                                        ------------------------------------------------------
                                        -- Perform the actual JDTLS move.
                                        ------------------------------------------------------

                                        local move_params = {
                                            moveKind =
                                            "moveResource",

                                            sourceUris =
                                                source_uris,

                                            params =
                                                code_action_params,

                                            destination =
                                                destination,

                                            updateReferences =
                                                true,
                                        }

                                        vim.notify(
                                            "Creating package and moving "
                                            .. #java_files
                                            .. " Java files to "
                                            .. package_name
                                            .. "...",
                                            vim.log.levels.INFO
                                        )

                                        ---@diagnostic disable-next-line: param-type-mismatch
                                        client:request(
                                            "java/move",
                                            move_params,
                                            function(
                                                move_err,
                                                move_result
                                            )
                                                if move_err then
                                                    vim.notify(
                                                        "JDTLS package move failed:\n"
                                                        .. vim.inspect(
                                                            move_err
                                                        ),
                                                        vim.log.levels.ERROR
                                                    )
                                                    return
                                                end

                                                if not move_result then
                                                    vim.notify(
                                                        "JDTLS returned no package move result",
                                                        vim.log.levels.ERROR
                                                    )
                                                    return
                                                end

                                                if move_result.errorMessage then
                                                    vim.notify(
                                                        move_result.errorMessage,
                                                        vim.log.levels.ERROR
                                                    )
                                                    return
                                                end

                                                if not move_result.edit then
                                                    vim.notify(
                                                        "JDTLS returned no workspace edit:\n"
                                                        .. vim.inspect(
                                                            move_result
                                                        ),
                                                        vim.log.levels.ERROR
                                                    )
                                                    return
                                                end

                                                local ok, apply_err =
                                                    pcall(
                                                        vim.lsp.util.apply_workspace_edit,
                                                        move_result.edit,
                                                        "utf-16"
                                                    )

                                                if not ok then
                                                    vim.notify(
                                                        "Failed to apply package move:\n"
                                                        .. tostring(
                                                            apply_err
                                                        ),
                                                        vim.log.levels.ERROR
                                                    )
                                                    return
                                                end

                                                vim.notify(
                                                    string.format(
                                                        "Package moved successfully: %d Java files → %s",
                                                        #java_files,
                                                        package_name
                                                    ),
                                                    vim.log.levels.INFO
                                                )

                                                vim.schedule(
                                                    function()
                                                        vim.cmd(
                                                            "checktime"
                                                        )
                                                    end
                                                )
                                            end,
                                            bufnr
                                        )
                                    end
                                )

                                return
                            end

                            ------------------------------------------------------------------
                            -- EXISTING PACKAGE
                            --
                            -- This is the exact working path we already tested.
                            ------------------------------------------------------------------

                            local move_params = {
                                moveKind = "moveResource",

                                sourceUris =
                                    source_uris,

                                params =
                                    code_action_params,

                                destination =
                                    destination,

                                updateReferences =
                                    true,
                            }

                            ---@diagnostic disable-next-line: param-type-mismatch
                            client:request(
                                "java/move",
                                move_params,
                                function(
                                    move_err,
                                    move_result
                                )
                                    if move_err then
                                        vim.notify(
                                            "JDTLS package move failed:\n"
                                            .. vim.inspect(
                                                move_err
                                            ),
                                            vim.log.levels.ERROR
                                        )
                                        return
                                    end

                                    if not move_result then
                                        vim.notify(
                                            "JDTLS returned no package move result",
                                            vim.log.levels.ERROR
                                        )
                                        return
                                    end

                                    if move_result.errorMessage then
                                        vim.notify(
                                            move_result.errorMessage,
                                            vim.log.levels.ERROR
                                        )
                                        return
                                    end

                                    if not move_result.edit then
                                        vim.notify(
                                            "JDTLS returned no workspace edit:\n"
                                            .. vim.inspect(
                                                move_result
                                            ),
                                            vim.log.levels.ERROR
                                        )
                                        return
                                    end

                                    local ok, apply_err =
                                        pcall(
                                            vim.lsp.util.apply_workspace_edit,
                                            move_result.edit,
                                            "utf-16"
                                        )

                                    if not ok then
                                        vim.notify(
                                            "Failed to apply package move:\n"
                                            .. tostring(
                                                apply_err
                                            ),
                                            vim.log.levels.ERROR
                                        )
                                        return
                                    end

                                    vim.notify(
                                        string.format(
                                            "Package moved successfully: %d Java files",
                                            #java_files
                                        ),
                                        vim.log.levels.INFO
                                    )

                                    vim.schedule(
                                        function()
                                            vim.cmd("checktime")
                                        end
                                    )
                                end,
                                bufnr
                            )
                        end
                    )
                end,
                bufnr
            )
        end
    )
end

return M
