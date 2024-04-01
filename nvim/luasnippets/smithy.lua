return {
  s({ trig = "res", dscr = "Create a resource" },
    fmt("resource {}{}", {
      i(1, "ResourceName"),
      sn(nil, { t " {", i(1), t "}", i(0) }),
    })
  ),
  s({ trig = "str", dscr = "Create a string newtype" },
    fmt("string {}", {
      i(1),
    })
  ),
  s({ trig = "stu", dscr = "Create a structure" },
    fmt("structure {}{}", {
      i(1, "StructureName"),
      sn(nil, { t " {", i(1), t "}", i(0) }),
    })
  ),
}
