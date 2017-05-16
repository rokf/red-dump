
Red []

swap-elements: function [
  a
  x
  y
][
  e1: pick a x
  e2: pick a y
  poke a x e2
  poke a y e1
]

insertion-sort: function [
  array
][
  len: length? array
  i: 2
  while [ i <= len ] [
    j: i
    while [1 < j] [
      if (pick array (j - 1)) > (pick array j) [
        swap-elements array j (j - 1)
      ]
      j: j - 1
    ]
    i: i + 1
  ]
  array
]
