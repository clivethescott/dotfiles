return {
  -- case class Person(name: String) {}
  -- case class Person(name: String) extends A
  -- case class Person(name: String) extends C
  -- case class Person(name: String) extends C with D
  -- case class Person(name: String) extends C with D {}
  s({ trig = "cc", dscr = "Create a case class" },
    fmt("case class {}({}){}", {
      i(1, "class name"), i(2, "params"),
      c(3, {
        t "",
        sn(nil, { t " {", i(1), t "}", i(0) }),
        -- sn(nil, { t " extends ", i(1), "{}" }),
      })
    })
  ),
  s({ trig = "iclass", dscr = "Create an implicit definition" },
    fmt([[
      implicit class {}({}) {{
        {}
      }}
      ]], {
      i(1, "class name"), i(2, "params"), i(0)
    })
  ),
  s({ trig = "ex", dscr = "Extends" },
    fmt("extends {}", {
      i(0)
    })
  ),
  s({ trig = "test", dscr = "Create an AnyFunSuite Test" },
    fmt([[
      test("{}") {{
        {}
      }}
    ]], {
      i(1), i(0)
    })
  ),
}
