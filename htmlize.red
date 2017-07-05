
Red []

htmlize: function [ b ][
  lifo: copy []
  tree: [
    collect [
      any [
        ahead [word! block! block!]
        set tag word!
        (insert lifo tag)
        keep (rejoin ["<" tag " "])
        into [any [
          set argname word!
          set argval string!
          keep (rejoin [argname "=" {"} argval {"} ])
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
      title [ "Page Title" ]
    ]
    body [
      div [class "party" id "unique" special none] ["Hello"]
    ]
  ]
]

print htmlize html
