
Red []

htmlize: function [
  "Generates a HTML string from a parse block DSL."
  b [block!] "html block"
  d [block!] "data block"
] [
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
  render-foreach: function [bl db fw d] [
    cb: copy []
    foreach x db [
      insert d (reduce [fw x])
      html: (htmlize bl d)
      append cb html
      remove/part d 2
      probe d
    ]
    return (concat cb)
  ]
  render-foreach-pair: function [bl db fw1 fw2 d] [
    cb: copy []
    foreach [x y] db [
      insert d (reduce [fw1 x fw2 y])
      html: (htmlize bl d)
      append cb html
      remove/part d 4
      probe d
    ]
    return (concat cb)
  ]
  tree: [
    collect [
      any [
        ['foreach set forw1 word! set forw2 word! set datab get-word! set forb block! keep (render-foreach-pair forb (select d datab) forw1 forw2 d) ]
        | ['foreach set forw word! set datab get-word! set forb block! keep (render-foreach forb (select d datab) forw d) ]
        | ['if set getw get-word! [if (select d getw) [into tree] | block!]]
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

; example

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
