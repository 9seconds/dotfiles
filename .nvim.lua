local conform = require("_.conform")
local lint = require("_.lint")

conform:set("lua", "stylua")

lint:set("python", "mypy")
lint:set("python", "ruff")
lint:set("lua", "selene")
