local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local react_snippets = {
  -- className
  s({ trig = ";cl" }, {
    t("className={`"),
    i(1, ""),
    t("`}"),
  }),

  -- style
  s({ trig = ";st" }, {
    t("={{"),
    i(1, ""),
    t("}}"),
  }),
}

local react_js_ts_snippets = {
  s({ trig = ";con" }, {
    t("console.log("),
    t('"'),
    i(1, "variable name"),
    t(" in ", {}),
    i(2, "filepath"),
    t('", '),
    f(function(args)
      -- Return the variable name for the actual value
      return args[1][1] or ""
    end, { 1 }),
    t(")"),
  }),

  -- useEffect
  s({ trig = ";ue" }, {
    t("useEffect(()=> {"),
    i(1, ""),
    t("},[])"),
  }),
}

local js_ts_snippets = {}

ls.add_snippets("javascriptreact", react_snippets)
ls.add_snippets("typescriptreact", react_snippets)
ls.add_snippets("javascript", react_js_ts_snippets)
ls.add_snippets("javascriptreact", react_js_ts_snippets)
ls.add_snippets("typescript", react_js_ts_snippets)
ls.add_snippets("typescriptreact", react_js_ts_snippets)
