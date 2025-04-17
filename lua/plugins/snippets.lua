local ls = require("luasnip")
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
  return vim.fn.expand("%:p")
end

local react_js_ts_snippets = {
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

  -- console.log
  s({ trig = ";con" }, {
    t("console.log("),
    i(1, "var"),
    t(", ' in "),
    f(get_file_path, {}),
    t("')"),
  }),

  -- useEffect
  s({ trig = ";ue" }, {
    t("useEffect(() => {"),
    i(1, ""),
    t("}, [])"),
  }),

  -- useState
  s({ trig = ";us", name = "useState" }, {
    t("const ["),
    i(1, "state"),
    t(", set"),
    f(capitalize, { 1 }),
    t("] = useState("),
    i(2),
    t(")"),
  }),

  -- .map
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

  -- filter map
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
  --
}

ls.add_snippets("javascript", react_js_ts_snippets)
ls.add_snippets("javascriptreact", react_js_ts_snippets)
ls.add_snippets("typescript", react_js_ts_snippets)
ls.add_snippets("typescriptreact", react_js_ts_snippets)
