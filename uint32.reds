
Red/System []

uint32!: alias struct! [
  b1 [byte!]
  b2 [byte!]
  b3 [byte!]
  b4 [byte!]
]

get-uint32: function [
  src [uint32!]
  return: [integer!]
][
  (as integer! src/b1) or ((as integer! src/b2) << 8) or ((as integer! src/b3) << 16) or ((as integer! src/b4) << 24)
]

set-uint32: function [
  src [uint32!]
  value [integer!]
][
  src/b1: as byte! value and FFh
  src/b2: as byte! value >> 8 and FFh
  src/b3: as byte! value >> 16 and FFh
  src/b4: as byte! value >> 24 and FFh
]

example!: alias struct! [
  uint32-field [uint32! value]
]

example-instance: declare example!
set-uint32 example-instance/uint32-field 256

print ["address: " example-instance/uint32-field newline]
print ["value: " get-uint32 example-instance/uint32-field newline]
print ["b1: " as integer! example-instance/uint32-field/b1 newline]
print ["b2: " as integer! example-instance/uint32-field/b2 newline]
print ["b3: " as integer! example-instance/uint32-field/b3 newline]
print ["b4: " as integer! example-instance/uint32-field/b4 newline]

