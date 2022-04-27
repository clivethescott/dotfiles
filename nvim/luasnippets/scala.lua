return {
  -- case class Person(name: String) {}
  -- case class Person(name: String) extends A
  -- case class Person(name: String) extends C
  -- case class Person(name: String) extends C with D
  -- case class Person(name: String) extends C with D {}
  s("cc",
    fmt("case class {}({}){}", {
      i(1, "class name"), i(2, "params"),
      c(3, {
        t "",
        sn(nil, { t " {", i(1), t "}", i(0) }),
        -- sn(nil, { t " extends ", i(1), "{}" }),
      })
    })
  )
}
