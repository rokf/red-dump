
Red []

; hamming distance and validation

validate: function [
  strand
][
  allowed: charset "CGAT"
  parse strand [some allowed]
]

hamming: function [
  strand1
  strand2
][
  if not all [(validate strand1) (validate strand2)] [return none]

  l1: length? strand1
  l2: length? strand2
  c: 1
  dc: 0
  either l1 == l2 [
    while [ c <= l1 ] [
      if (pick strand1 c) <> (pick strand2 c) [ dc: dc + 1 ]
      c: c + 1
    ]
    dc
  ][
    none
  ]
]
