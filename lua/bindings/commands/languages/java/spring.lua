local run = require("languages.java.spring.run")

return {

    {
        name = "SpringRun",
        callback = run.run,
        desc = "Run Spring Boot",
    },

    {
        name = "SpringDebug",
        callback = run.debug,
        desc = "Debug Spring Boot",
    },

}
