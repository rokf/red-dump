
Red []

binary-search: function [
  list
  element
  l
  r
][
  mid: (round l + ((r - l) / 2))
  if any [
    (mid < 1)
    (mid > (length? list))
    l > r
  ][ return none ]
  if (pick list mid) = element [ return mid ]
  if (pick list mid) > element [ return binary-search list element l (mid - 1)]
  return binary-search list element (mid + 1) r
  return none
]

x: [1 5 17 20] ; has to be sorted
el: 1
binary-search x el 1 length? x
