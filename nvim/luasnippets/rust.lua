return {
  s({ trig = "printone", dscr = "println macro for one item" },
    fmt('println!("{{}}", {});', {
      i(0)
    })
  ),
}
