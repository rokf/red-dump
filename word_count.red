
Red []

count-words: function [
  str
][
  strl: lowercase str
  valid: charset [#"a" - #"z"]
  words: parse strl [
    collect [
      any [ keep some valid | skip ]
    ]
  ]
  words: sort words
  counts: copy []
  c: 0
  cw: pick words 1
  foreach w words [
    either all [
      cw == w
    ][
      ; true
      c: c + 1
    ][
      ; false
      append counts reduce [cw c]
      cw: w
      c: 1
    ]
  ]
  append counts reduce [cw c]
  counts ; return counted words
]
