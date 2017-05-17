
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

selection-sort: function [
  array
][
  i: 1
  len: length? array
  while [ i < len ] [
    min-index: i
    j: i + 1
    while [ j <= len ] [
      if (pick array j) < (pick array min-index) [ min-index: j ]
      j: j + 1
    ]
    swap-elements array min-index i
    i: i + 1
  ]
  array
]

x: [1 5 3 -5 2 -100 22 15 17 3 9]

print selection-sort x
