
Red []

htmlize: function [ b d ][
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
  lifo: copy []
  argpat: [
    any [
      set argname word!
      [set argval string! keep (rejoin [" " argname "=" {"} argval {"} ])
      | set argval get-word! keep (rejoin [" " argname "=" {"} (select d argval) {"} ])]
      | set argname word! 'none keep (rejoin [" " argname])
    ]
  ]
  tree: [
    collect [
      any [
        ['if set getw get-word! [if (select d getw) [into tree] | block!]]
        | ahead [lit-word! block!] ; only open tag and attributes
        set tag lit-word!
        keep (rejoin ["<" tag])
        into argpat
        keep (">")
        | ahead [word! block! block!] ; full with attributes
        set tag word!
        (insert lifo tag)
        keep (rejoin ["<" tag])
        into argpat
        keep (">")
        into tree
        keep (rejoin ["</" (first lifo) ">"])
        (remove lifo)
        | ahead [word! block!] ; full without attributes
        [set tag word!
        (insert lifo tag)
        keep (rejoin ["<" tag ">"])
        into tree
        keep (rejoin ["</" (first lifo) ">"])
        (remove lifo)]
        | [set getw get-word! keep (select d getw)] ; get-word replaced with variable from outside
        | keep string! ; normal string
      ]
    ]
  ]
  concat (parse b tree)
]

html: [
  html [lang "en-US"] [
    head [
      title [ :title ]
    ]
    if :content [
      body [
        div [class "party" id :uniq special none] [
          'img [src "image.png"]
          :content
        ]
        div [
          h1 [ "Header" ] p [ "This paragraph" :cnt "a break:" 'br [] ]
        ]
      ]
    ]
  ]
]

print htmlize html [uniq "abc" content "<hello>Hi</hello>" title "Page Title" cnt "contains"]
