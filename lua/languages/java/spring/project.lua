---@diagnostic disable: missing-fields

local M = {}

local java_project = require("languages.java.project")

local cache = nil

local FEATURES = {
    ["spring-boot-starter-web"] = "web",
    ["spring-boot-starter-webflux"] = "webflux",
    ["spring-boot-starter-security"] = "security",
    ["spring-boot-starter-data-jpa"] = "jpa",
    ["spring-boot-starter-actuator"] = "actuator",
    ["spring-boot-devtools"] = "devtools",
    ["spring-boot-docker-compose"] = "docker_compose",
}

----------------------------------------------------------------------
-- Helpers
----------------------------------------------------------------------

local function read(path)
    local fd = io.open(path, "r")

    if not fd then
        return nil
    end

    local text = fd:read("*a")
    fd:close()

    return text
end

local function metadata()
    if cache then
        return cache
    end

    local root = java_project.root()

    cache = {
        root = root,
        build = nil,
        version = nil,

        dependencies = {
            web = false,
            webflux = false,
            security = false,
            jpa = false,
            actuator = false,
            devtools = false,
            docker_compose = false,
        },
    }

    if not root then
        return cache
    end

    --------------------------------------------------
    -- Maven
    --------------------------------------------------

    if java_project.is_maven() then
        cache.build = "maven"

        local pom = read(root .. "/pom.xml")

        if pom then
            cache.version =
                pom:match(
                    '<parent>.-<groupId>%s*org%.springframework%.boot%s*</groupId>.-<version>(.-)</version>'
                )
                or pom:match(
                    'org%.springframework%.boot.-<version>(.-)</version>'
                )

            for dependency, feature in pairs(FEATURES) do
                if pom:find(dependency, 1, true) then
                    cache.dependencies[feature] = true
                end
            end
        end
    end

    --------------------------------------------------
    -- Gradle
    --------------------------------------------------

    if java_project.is_gradle() then
        cache.build = "gradle"

        local gradle =
            read(root .. "/build.gradle")
            or read(root .. "/build.gradle.kts")

        if gradle then
            cache.version =
                gradle:match(
                    'id%s*%(%s*"org%.springframework%.boot"%s*%)%s*version%s*"([^"]+)"'
                )
                or gradle:match(
                    "id%s*'org%.springframework%.boot'%s*version%s*'([^']+)'"
                )

            for dependency, feature in pairs(FEATURES) do
                if gradle:find(dependency, 1, true) then
                    cache.dependencies[feature] = true
                end
            end
        end
    end

    return cache
end

----------------------------------------------------------------------
-- Cache
----------------------------------------------------------------------

function M.invalidate()
    cache = nil
end

----------------------------------------------------------------------
-- General
----------------------------------------------------------------------

function M.exists()
    return metadata().version ~= nil
end

function M.root()
    return metadata().root
end

function M.version()
    return metadata().version
end

function M.build()
    return metadata().build
end

function M.is_maven()
    return metadata().build == "maven"
end

function M.is_gradle()
    return metadata().build == "gradle"
end

----------------------------------------------------------------------
-- Dependencies
----------------------------------------------------------------------

function M.dependencies()
    return metadata().dependencies
end

function M.has(feature)
    return metadata().dependencies[feature] == true
end

function M.has_web()
    return M.has("web")
end

function M.has_webflux()
    return M.has("webflux")
end

function M.has_security()
    return M.has("security")
end

function M.has_jpa()
    return M.has("jpa")
end

function M.has_actuator()
    return M.has("actuator")
end

function M.has_devtools()
    return M.has("devtools")
end

function M.has_docker_compose()
    return M.has("docker_compose")
end

return M
