return {
  s("iff", {
    t({ "if err != nil {", "\t" }),
    i(1),
    t({ "\t", "}" }),
  }),
  s("gof", fmt([[
  go func() {{
    {}
  }}()
  {}
  ]], { i(1), i(0)}))
}
