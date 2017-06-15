
Red []

d: 256

rk-hash: function [
  string
  limit
  prime
][
  i: 1
  hash: 0
  while [i <= limit] [
    hash: mod ((d * hash) + to-integer pick string i) prime
    i: i + 1
  ]
  hash
]

rk-search: function [
  text
  pattern
  prime
][
  h: mod power d ((length? pattern) - 1) prime
  p: rk-hash pattern length? pattern prime
  t: rk-hash text length? pattern prime
  i: 1
  while [i <= ((length? text) - (length? pattern) + 1)] [
    if p == t [
      j: 0 same: true
      while [j < length? pattern] [
        if (pick text (i + j)) <> (pick pattern (j + 1)) [ same: false break ]
        j: j + 1
      ]
      if same [ print [ "Pattern matching at index " i ] ]
    ]
    if i <= ((length? text) - (length? pattern)) [
      t: mod ((d * (t - ((to-integer  pick text i) * h))) + (to-integer pick text (i + (length? pattern)))) prime
      if t < 0 [ t: t + q ]
    ]
    i: i + 1
  ]
]

text: "roses are red, violets are red, everything is red, red red red"
pattern: "red"
rk-search text pattern 13
