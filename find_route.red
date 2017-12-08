Red []

graph: [
  [a b]
  [b c]
  [b d]
  [d e]
  [f b]
  [g f]
]

check: [a e]

search: function [
  current
  path
][
  foreach g graph [
    either current = none [
      if g/1 = check/1 [
        search g append copy [] g
      ]
    ][
      if g/1 = current/2 [
        either g/2 = check/2 [
          print [append copy path g]
        ][
          search g append copy path g
        ]
      ]
    ]
  ]
]

search none copy []