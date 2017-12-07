Red []

vertices: [a b c d]

graph: [
  [a b 2]
  [a c 3]
  [a d 2]
  [b c 1]
  [b d 5]
  [c d 3]
]

chain_v: append copy[] random/only copy vertices
chain: copy []

while [(length? chain_v) < (length? vertices)] [
  closest: none closest_d: none closest_v: none
  foreach g graph [
    foreach v chain_v [
      if find g v [
        e1: g/1 e2: g/2 e3: g/3
        either closest_d = none [
          closest: copy g
          closest_d: e3
          closest_v: v
        ] [
          if closest_d > e3 [
            closest: copy g
            closest_d: e3
            closest_v: v
          ]
        ]
      ]
    ]
  ]
  chain: append chain closest
  chain_v: append chain_v pick difference closest append copy [] closest_v 1
  graph: head remove find/only graph closest
]

print [chain_v]
print [chain]