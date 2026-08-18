local M = {}

--------------------------------------------------------------------------------
-- Language
--------------------------------------------------------------------------------

M.filetypes = {
    "java",
}

M.root_markers = {
    "mvnw",
    "pom.xml",

    "gradlew",
    "build.gradle",
    "build.gradle.kts",

    ".git",
}

--------------------------------------------------------------------------------
-- Runtime
--------------------------------------------------------------------------------

M.runtime = {
    version = 21,
    lombok = true,
}

--------------------------------------------------------------------------------
-- Workspace
--------------------------------------------------------------------------------

M.workspace = {
    name = "jdtls",
}

--------------------------------------------------------------------------------
-- Toolchain
--------------------------------------------------------------------------------

M.tools = {

    lsp = "jdtls",

    dap = "java-debug-adapter",

    formatter = {
        "google-java-format",
    },

    linter = {},

}

--------------------------------------------------------------------------------
-- Build Systems
--------------------------------------------------------------------------------

M.build = {

    maven = {
        wrapper = "mvnw",
        executable = "mvn",
        prefer_wrapper = false,
    },

    gradle = {
        wrapper = "gradlew",
        executable = "gradle",
        prefer_wrapper = false,
    },

}

--------------------------------------------------------------------------------
-- Tasks
--------------------------------------------------------------------------------

M.tasks = {

    build = {
        title = "Java: Build",

        maven = "package",
        gradle = "build",
    },

    clean = {
        title = "Java: Clean",

        maven = "clean",
        gradle = "clean",
    },

    install = {
        title = "Java: Install",

        maven = "install",
        gradle = "publishToMavenLocal",
    },

    deploy = {
        title = "Java: Deploy",

        maven = "clean deploy",
        gradle = "publish",
    },

    test = {
        title = "Java: Test",

        maven = "test",
        gradle = "test",
    },

}

return M
