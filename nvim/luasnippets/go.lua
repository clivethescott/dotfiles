return {
  s("iff", {
    t({ "if err != nil {", "\t" }),
    i(1),
    t({ "\t", "}" }),
  }
  ),
  s({trig='gof', dscr = 'Runs func in a goroutine'}, fmt([[
    go func() {{
      {}
    }}()
    {}
  ]], { i(1), i(0) })
  ),
  s("ifg", fmt([[
    if got != want {{
      t.Errorf("got %{}, want %{}", got, want)
    }}
    {}
  ]], { c(1, { t "v", t "q", t "s", t "d" }), rep(1), i(0) })
  ),
  s({trig='subt', dscr='Create a sub test'}, fmt([[
    t.Run("{}", func(t *testing.T) {{
      {}
    }})
  ]], { i(1), i(0)})
  ),
}

