local ls = require("luasnip")
local rep = require("luasnip.extras").rep
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function capitalize(args)
  local word = args[1][1] or ""
  return word:sub(1, 1):upper() .. word:sub(2)
end

local function singularize(args)
  local plural = args[1][1] or ""
  if plural:sub(-1) == "s" then
    return plural:sub(1, -2)
  else
    return plural
  end
end

local function get_file_path()
  local file_path = vim.fn.expand("%:p")
  file_path = file_path:gsub("^/Users/zachshort", "") -- change this to your file directory to remove it
  return file_path
end

local react_js_ts_snippets = {
  s({ trig = "<(%w+)$", regTrig = true, name = "JSX Tag Close" }, {
    f(function(_, snip)
      local tag = snip.captures[1]
      return "<" .. tag .. "></" .. tag .. ">"
    end, {}),
  }),

  s({ trig = ";cl" }, {
    t("className={`"),
    i(1, ""),
    t("`}"),
  }),

  s({ trig = ";st" }, {
    t("={{"),
    i(1, ""),
    t("}}"),
  }),

  s({ trig = ";con" }, {
    t("console.log("),
    i(1, "var"),
    t(', "'),
    rep(1),
    t(" in "),
    f(get_file_path, {}),
    t('")'),
  }),

  s({ trig = ";us", name = "useState" }, {
    t("const ["),
    i(1, "state"),
    t(", set"),
    f(capitalize, { 1 }),
    t("] = useState("),
    i(2),
    t(")"),
  }),

  s({ trig = ";map", name = "JSX map block" }, {
    t({ "", "{" }),
    i(1, "items"),
    t(".map(("),
    f(singularize, { 1 }),
    t(") => {"),
    t({ "", "    return {" }),
    t({ "", "      " }),
    i(2, "<></>"),
    t({ "", "    }" }),
    t({ "", "  })" }),
    t({ "", "}" }),
  }),

  s({ trig = ";filtermap", name = "JSX map block with filter" }, {
    t({ "", "{" }),
    i(1, "items"),
    t(".filter(()=> )"),
    t(".map(("),
    f(singularize, { 1 }),
    t(") => {"),
    t({ "", "    return {" }),
    t({ "", "      " }),
    i(2, "<></>"),
    t({ "", "    }" }),
    t({ "", "  })" }),
    t({ "", "}" }),
  }),
}

local python_snippets = {
  s({ trig = ";pri" }, {
    t("print("),
    i(1, "var"),
    t(', "'),
    rep(1),
    t(" in "),
    f(get_file_path, {}),
    t('")'),
  }),
}

ls.add_snippets("javascript", react_js_ts_snippets)
ls.add_snippets("javascriptreact", react_js_ts_snippets)
ls.add_snippets("typescript", react_js_ts_snippets)
ls.add_snippets("typescriptreact", react_js_ts_snippets)
ls.add_snippets("python", python_snippets)
