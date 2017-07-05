
Red []

htmlize: function [ b d ][
  lifo: copy []
  tree: [
    collect [
      any [
        ['if set getw get-word! [if (select d getw) [into tree] | block!]]
        | ahead [word! block! block!]
        set tag word!
        (insert lifo tag)
        keep (rejoin ["<" tag " "])
        into [any [
          set argname word!
          [
            set argval string! keep (rejoin [argname "=" {"} argval {"} ])
            | set argval get-word! keep (rejoin [argname "=" {"} (select d argval) {"} ])
          ]
          | set argname word!
          'none
          keep (rejoin [argname])
        ]]
        keep (">")
        into tree
        keep (rejoin ["</" (first lifo) ">"])
        (remove lifo)
        | [set tag word!
        (insert lifo tag)
        keep (rejoin ["<" tag ">"])
        into tree
        keep (rejoin ["</" (first lifo) ">"])
        (remove lifo)]
        | [set getw get-word! keep (select d getw)]
        | keep string!
      ]
    ]
  ]
  cleanup: function [str] [
    x: copy str
    replace/all x " >" ">"
    replace/all x "> " ">"
    replace/all x " <" "<"
    return x
  ]
  cleanup rejoin parse b tree
]

html: [
  html [lang "en-US"] [
    head [
      title [ :title ]
    ]
    if :content [
      body [
        div [class "party" id :uniq special none] [:content]
      ]
    ]
  ]
]

print htmlize html [uniq "abc" conten "<hello>Hi</hello>" title "Page Title"]
