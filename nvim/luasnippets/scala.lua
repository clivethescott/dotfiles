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
  s({ trig = "ext", dscr = "Create an extractor" },
    fmt([[
      def unapply({}): {} = {}
    ]], {
      i(1),
      c(2, {
        sn(nil, { t "Option[", i(1), t "]" }),
        sn(nil, { i(1), t "Boolean" }),
      }),
      i(3)
    })
  ),
  s({ trig = "call", dscr = "Call implicit" },
    fmt([[ 
      def apply[{}](implicit {}: {}[{}]): {}[{}] = {}
      {}
    ]], {
      i(1, "A"),
      i(2, "ev"),
      i(3, "TypeClass"),
      rep(1),
      rep(3),
      rep(1),
      rep(2),
      i(0)
    })
  ),
  s({ trig = "enum", dscr = "Create an enumeration" },
    fmt([[ 
      object {} extends Enumeration {{
        type {} = Value
        val {} = Value
      }}
      {}
    ]], {
      i(1),
      rep(1),
      i(2, "val1, value2"),
      i(0)
    })
  ),
  s({ trig = "lib", dscr = "scala-cli script lib" },
    fmt([[ 
      //> using lib "{}::{}:{}"
    ]], {
      i(1, "groupId"),
      i(2, "artifactId"),
      i(3, "version")
    })
  )
}
