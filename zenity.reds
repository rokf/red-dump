
Red/System []

#define int-pointer! [pointer! [integer!]]

file!: alias struct! [
  ptr [c-string!]
  cnt [integer!]
  base [c-string!]
  flag [integer!]
  file [integer!]
  charbuf [integer!]
  bufsiz [integer!]
  tmpfname [c-string!]
]
#import [
  "libc.so.6" cdecl [
    malloc: "malloc" [
      size [integer!]
      return: [c-string!]
    ]
    release: "free" [
      block [c-string!]
    ]
    popen: "popen" [
      command [c-string!]
      type [c-string!]
      return: [file!]
    ]
    pclose: "pclose" [
      stream [file!]
      return: [integer!]
    ]
    fread: "fread" [
      ptr [c-string!]
      size [int-pointer!]
      nmemb [int-pointer!]
      stream [file!]
      return: [int-pointer!]
    ]
  ]
]

to-intptr: function [num [integer!] return: [int-pointer!]] [ as int-pointer! num ]

zenity-version: function [
  /local fp answer fread-resp
] [
  fp: popen "zenity --version" "r"
  answer: malloc 128
  fread-resp: fread answer to-intptr 1 to-intptr 128 fp
  probe [answer newline]
  release answer
  pclose fp
]

zenity-open: function [
  title [c-string!]
  ; filters [c-string!]
  buf [c-string!]
  /local fp fread-resp
][
  fp: popen {zenity --file-selection --title="Open File" --file-filter="All Files | *"} "r"
  fread-resp: fread buf to-intptr 1 to-intptr 128 fp
  pclose fp
]

zenity-save: function [
  title [c-string!]
  buf [c-string!]
  /local fp fread-resp
][
  fp: popen {zenity --file-selection --save --confirm-overwrite --title="Save File" --file-filter="All Files | *"} "r"
  fread-resp: fread buf to-intptr 1 to-intptr 128 fp
  pclose fp
]

; usage example
zenity-version
answer: malloc 128
zenity-open "Open" answer
print answer
answer: malloc 128
zenity-save "Save" answer
print answer
release answer
