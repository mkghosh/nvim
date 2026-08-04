local map = require("utils.keymap").set

local run = require("languages.java.spring.run")

return {

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
