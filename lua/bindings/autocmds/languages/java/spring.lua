local autocmd = require("utils.autocmd")

local project = require("languages.java.spring.project")

local group = autocmd.group("JavaSpring")

return {

    autocmd.create("BufWritePost", {
        group = group,

        pattern = {
            "pom.xml",
            "build.gradle",
            "build.gradle.kts",
        },

        desc = "Invalidate Spring project metadata",

        callback = project.invalidate,
    }),

}
