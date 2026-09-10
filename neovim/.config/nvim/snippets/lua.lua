return {
  ["Function definition"] = {
    prefix = "fn",
    body = {
      "function ${1:name}($2)",
      "\t$0",
      "end",
    },
  },
}
