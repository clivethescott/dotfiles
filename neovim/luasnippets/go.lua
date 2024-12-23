return {
  s("iff", {
    t({ "if err != nil {", "\t" }),
    i(1),
    t({ "\t", "}" }),
  }
  ),
  s({ trig = 'gof', dscr = 'Runs func in a goroutine' }, fmt([[
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
  s({ trig = 'testf', dscr = 'Create a fuzz test' }, fmt([[
    func Fuzz{}(f *testing.F) {{
      cases := []{}
      for _, tc := range cases {{
        f.Add(tc)
      }}
      {}
    }}
  ]], { i(1, "Method"), i(2, "string{}"), i(0) })
  ),
  s({ trig = 'test', dscr = 'Create a regular test' }, fmt([[
    func Test{}(t *testing.T) {{
      {}
    }}
  ]], { i(1), i(0) })
  ),
  s({ trig = 'tt', dscr = 'Create a table test' }, fmt([[
    cases := []struct {{
      in, want {}
    }}{{
      {{ {} }},
    }}

    for _, tc := range {} {{
      {}
    }}
  ]], { i(1, "string"), i(2, "case"), rep(1), i(3, "expectations") })
  ),
  s({ trig = 'subf', dscr = 'Run a sub fuzz test' }, fmt([[
    f.Fuzz(func(t *testing.T, in {}) {{
      {}
    }})
  ]], { i(1, "string"), i(2) })
  ),
  s({ trig = 'subt', dscr = 'Run a sub test' }, fmt([[
    t.Run("{}", func(t *testing.T) {{
      {}
    }})
  ]], { i(1), i(0) })
  ),
  s({ trig = 'main', dscr = 'Create a main function' }, fmt([[
    func main() {{
      {}
    }}
  ]], { i(0) })
  ),
  s({ trig = 'pmain', dscr = 'Setup a new main.go' }, fmt([[
    package main

    func main() {{
      {}
    }}
  ]], { i(0) })
  ),
}
