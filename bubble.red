
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

bubble: function [
  array
][
  n: length? array
  until [
    i: 2
    swapped: false
    while [ i <= (n) ] [
      if (pick array (i - 1)) > (pick array i) [
        swap-elements array (i - 1) i
        swapped: true
      ]
      i: i + 1
    ]
    not swapped
  ]
]
