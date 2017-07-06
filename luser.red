Red []

luser: function [
  "Serialize block to Lua table."
  b [block!] "The block"
][
  concat: function [b] [
    a: copy []
    foreach el b [
      either string? el [
        append a el
      ] [
        append a (concat el)
      ]
    ]
    return rejoin a
  ]
  pattern: [
    collect [
      any [
        set SPECIAL ['true | 'false | 'nil] keep (to-string SPECIAL)
        | ahead [word!] set KEY word! keep (rejoin [{["} KEY {"] = }]) pattern
        | set STRING string! keep (rejoin [{"} STRING {",}])
        | ahead [block!] keep ("{")  into pattern keep ("},")
        | set NUMBER number! keep (rejoin [NUMBER ","])
      ]
    ]
  ]
  c: concat (parse b pattern)
  rejoin ["{" c "}"]
]

print luser [
  1 2 3 4 5
  abc [
    [greeting "Hello" "Hi" 5.5]
  ]
  cde [ "Bye" z false ]
  true
]
