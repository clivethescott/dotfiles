return {
  s({ trig = "printone", dscr = "println for one item" },
    fmt('println!("{{}}", {});', {
      i(0)
    })
  ),
  s({ trig = "printd", dscr = "println debug for one item" },
    fmt('println!("{{:?}}", {});', {
      i(0)
    })
  ),
  s({ trig = "<", dscr = "Type parameters" },
    fmt('<{}: {}>', {
      i(1, 'T'),
      i(0),
    })
  ),
}
