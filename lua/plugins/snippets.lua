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
local go_snippets = {
  s({ trig = ";fmt" }, {
    t("fmt.Println("),
    i(1, "var"),
    t(', "'),
    rep(1),
    t(" in "),
    f(get_file_path, {}),
    t('")'),
  }),

  s({ trig = ";log" }, {
    t("log.Println("),
    i(1, "var"),
    t(', "'),
    rep(1),
    t(" in "),
    f(get_file_path, {}),
    t('")'),
  }),

  s({ trig = ";err" }, {
    t("if err != nil {"),
    t({ "", "\treturn " }),
    i(1, "err"),
    t({ "", "}" }),
  }),

  s({ trig = ";errl" }, {
    t("if err != nil {"),
    t({ "", '\tlog.Printf("Error in ' }),
    f(get_file_path, {}),
    t(': %v", err)'),
    t({ "", "\treturn " }),
    i(1, "err"),
    t({ "", "}" }),
  }),

  s({ trig = ";errp" }, {
    t("if err != nil {"),
    t({ "", "\tpanic(err)" }),
    t({ "", "}" }),
  }),

  s({ trig = ";errc" }, {
    t("if err != nil {"),
    t({ "", "\tc.JSON(http." }),
    i(1, "StatusInternalServerError"),
    t(', gin.H{"'),
    i(2, "error"),
    t('": "'),
    i(3, ""),
    t('"})'),
    t({ "", "\treturn" }),
    t({ "", "}" }),
  }),

  s({ trig = ";func" }, {
    t("func "),
    i(1, "functionName"),
    t("("),
    i(2, ""),
    t(") "),
    i(3, ""),
    t(" {"),
    t({ "", "\t" }),
    i(4, ""),
    t({ "", "}" }),
  }),

  s({ trig = ";method" }, {
    t("func ("),
    i(1, "r"),
    t(" *"),
    i(2, "Receiver"),
    t(") "),
    i(3, "MethodName"),
    t("("),
    i(4, ""),
    t(") "),
    i(5, ""),
    t(" {"),
    t({ "", "\t" }),
    i(6, ""),
    t({ "", "}" }),
  }),

  s({ trig = ";struct" }, {
    t("type "),
    i(1, "StructName"),
    t(" struct {"),
    t({ "", "\t" }),
    i(2, "Field string"),
    t({ "", "}" }),
  }),

  s({ trig = ";interface" }, {
    t("type "),
    i(1, "InterfaceName"),
    t(" interface {"),
    t({ "", "\t" }),
    i(2, "Method() error"),
    t({ "", "}" }),
  }),

  s({ trig = ";handler" }, {
    t("func "),
    i(1, "handlerName"),
    t("(w http.ResponseWriter, r *http.Request) {"),
    t({ "", "\t" }),
    i(2, ""),
    t({ "", "}" }),
  }),

  s({ trig = ";json" }, {
    t('w.Header().Set("Content-Type", "application/json")'),
    t({ "", "json.NewEncoder(w).Encode(" }),
    i(1, "data"),
    t(")"),
  }),

  s({ trig = ";decode" }, {
    t("var "),
    i(1, "data"),
    t(" "),
    i(2, "StructType"),
    t({ "", "err := json.NewDecoder(r.Body).Decode(&" }),
    rep(1),
    t(")"),
    t({ "", "if err != nil {" }),
    t({ "", "\thttp.Error(w, err.Error(), http.StatusBadRequest)" }),
    t({ "", "\treturn" }),
    t({ "", "}" }),
  }),

  s({ trig = ";query" }, {
    t("rows, err := db.Query("),
    i(1, '"SELECT * FROM table WHERE id = ?"'),
    t(", "),
    i(2, "id"),
    t(")"),
    t({ "", "if err != nil {" }),
    t({ "", "\treturn err" }),
    t({ "", "}" }),
    t({ "", "defer rows.Close()" }),
  }),

  s({ trig = ";scan" }, {
    t("for rows.Next() {"),
    t("", "\tvar "),
    i(1, "item"),
    t(" "),
    i(2, "StructType"),
    t({ "", "\terr := rows.Scan(" }),
    i(3, "&item.Field"),
    t(")"),
    t({ "", "\tif err != nil {" }),
    t({ "", "\t\treturn err" }),
    t({ "", "\t}" }),
    t({ "", "\t// Process item" }),
    t({ "", "}" }),
  }),

  s({ trig = ";go" }, {
    t("go func() {"),
    t({ "", "\t" }),
    i(1, ""),
    t("", "}()"),
  }),

  s({ trig = ";chan" }, {
    i(1, "ch"),
    t(" := make(chan "),
    i(2, "string"),
    t(")"),
  }),

  s({ trig = ";select" }, {
    t("select {"),
    t({ "", "case " }),
    i(1, "msg"),
    t(" := <-"),
    i(2, "ch"),
    t(":"),
    t({ "", "\t" }),
    i(3, "// handle message"),
    t({ "", "case <-time.After(" }),
    i(4, "5 * time.Second"),
    t("):"),
    t({ "", "\t" }),
    i(5, "// timeout"),
    t({ "", "}" }),
  }),

  s({ trig = ";test" }, {
    t("func Test"),
    i(1, "FunctionName"),
    t("(t *testing.T) {"),
    t({ "", "\t" }),
    i(2, "// Test implementation"),
    t({ "", "}" }),
  }),

  s({ trig = ";table" }, {
    t("tests := []struct {"),
    t({ "", "\tname string" }),
    t({ "", "\t" }),
    i(1, "input string"),
    t({ "", "\t" }),
    i(2, "expected string"),
    t({ "", "}{" }),
    t({ "", "\t{" }),
    t({ "", '\t\tname: "' }),
    i(3, "test case"),
    t('",'),
    t({ "", "\t\t" }),
    rep(1),
    t(': "'),
    i(4, "input"),
    t('",'),
    t({ "", "\t\t" }),
    rep(2),
    t(': "'),
    i(5, "expected"),
    t('",'),
    t({ "", "\t}," }),
    t({ "", "}" }),
    t({ "", "" }),
    t({ "", "for _, tt := range tests {" }),
    t({ "", "\tt.Run(tt.name, func(t *testing.T) {" }),
    t({ "", "\t\t" }),
    i(6, "// Test logic"),
    t({ "", "\t})" }),
    t({ "", "}" }),
  }),

  s({ trig = ";imp" }, {
    t("import ("),
    t({ "", '\t"' }),
    i(1, "fmt"),
    t('"'),
    t({ "", ")" }),
  }),

  s({ trig = ";ctx" }, {
    t("ctx, cancel := context.WithTimeout(context.Background(), "),
    i(1, "10*time.Second"),
    t(")"),
    t({ "", "defer cancel()" }),
  }),

  s({ trig = ";make" }, {
    i(1, "slice"),
    t(" := make([]"),
    i(2, "string"),
    t(", "),
    i(3, "0"),
    t(", "),
    i(4, "10"),
    t(")"),
  }),

  s({ trig = ";range" }, {
    t("for "),
    i(1, "i"),
    t(", "),
    i(2, "v"),
    t(" := range "),
    i(3, "slice"),
    t(" {"),
    t({ "", "\t" }),
    i(4, ""),
    t({ "", "}" }),
  }),

  s({ trig = ";find" }, {
    t('filter := bson.M{"'),
    i(1, "field"),
    t('": '),
    i(2, "value"),
    t("}"),
    t({ "", "cursor, err := collection.Find(ctx, filter)" }),
    t({ "", "if err != nil {" }),
    t({ "", "\treturn err" }),
    t({ "", "}" }),
    t({ "", "defer cursor.Close(ctx)" }),
  }),

  s({ trig = ";insert" }, {
    t("result, err := collection.InsertOne(ctx, "),
    i(1, "document"),
    t(")"),
    t({ "", "if err != nil {" }),
    t({ "", "\treturn err" }),
    t({ "", "}" }),
  }),

  s({ trig = ";gin" }, {
    t("func "),
    i(1, "handlerName"),
    t("(c *gin.Context) {"),
    t({ "", "\t" }),
    i(2, 'c.JSON(http.StatusOK, gin.H{"message": "success"})'),
    t({ "", "}" }),
  }),

  s({ trig = ";bind" }, {
    t("var "),
    i(1, "req"),
    t(" "),
    i(2, "RequestType"),
    t({ "", "if err := c.ShouldBindJSON(&" }),
    rep(1),
    t("); err != nil {"),
    t({ "", '\tc.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})' }),
    t({ "", "\treturn" }),
    t({ "", "}" }),
  }),
}

ls.add_snippets("go", go_snippets)
ls.add_snippets("javascript", react_js_ts_snippets)
ls.add_snippets("javascriptreact", react_js_ts_snippets)
ls.add_snippets("typescript", react_js_ts_snippets)
ls.add_snippets("typescriptreact", react_js_ts_snippets)
ls.add_snippets("python", python_snippets)
