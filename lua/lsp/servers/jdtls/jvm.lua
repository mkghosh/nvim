local path = require("utils.path")

local jdtls = path.mason("packages", "jdtls")

return {

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",

    "-Dosgi.bundles.defaultStartLevel=4",

    "-Declipse.product=org.eclipse.jdt.ls.core.product",

    "-Dlog.protocol=true",

    "-Dlog.level=ALL",

    "-Xms1g",

    "-Xmx2G",

    "-javaagent:" .. jdtls .. "/lombok.jar",

    "--add-opens=java.base/java.util=ALL-UNNAMED",

    "--add-opens=java.base/java.lang=ALL-UNNAMED",

}
