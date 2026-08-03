local map = require("utils.keymap").set

local run = require("languages.java.spring.run")

return {

    ----------------------------------------------------------------------------
    -- Which-Key
    ----------------------------------------------------------------------------

    {
        "<leader>js",
        group = "Spring",
    },

    ----------------------------------------------------------------------------
    -- Run
    ----------------------------------------------------------------------------

    map(
        "n",
        "<leader>jsr",
        run.run,
        "Run Spring Boot"
    ),

    map(
        "n",
        "<leader>jsd",
        run.debug,
        "Debug Spring Boot"
    ),

}
