
Red/System []

uint16!: alias struct! [
  lsb [byte!]
  msb [byte!]
]

get-uint16: function [
  src [uint16!]
  return: [integer!]
][
  (as integer! src/lsb) or ((as integer! src/msb) << 8)
]

set-uint16: function [
  src [uint16!]
  value [integer!]
][
  src/lsb: as byte! value and FFh
  src/msb: as byte! value >> 8 and FFh
]

xpos!: alias struct! [ ; example struct wrapper
  x [uint16! value] ; so that the struct is inlined properly instead of a pointer to the struct
]

coord: declare xpos!
set-uint16 coord/x 10 ; set a value

print ["x address: " coord/x newline] ; address
print ["x: " get-uint16 coord/x newline] ; value
print ["x lsb: " as integer! coord/x/lsb newline] ; least significant byte
print ["x msb: " as integer! coord/x/msb newline] ; most significant byte
