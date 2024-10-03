;===================================
; Inside Mysterious (Ned's) Cottage
;===================================

;=========
; look

; + look
inside_nn_look_at_message:
.byte "This place could use some",13
.byte "serious sprucing of the",13
.byte "'up' variety. There's a",13
.byte "dresser over there and a",13
.byte "broom kind of silhouetted",13
.byte "all mysterious like.",0

; + look broom
inside_nn_look_brook_message:
.byte "The broom is all black and",13
.byte "artistic, implying perhaps",13
.byte "that it is closer to the",13
.byte "viewer's eye but unlit to",13
.byte "avoid emphasis.",0

; + look drawer/dresser (closed)
inside_nn_look_closed_drawer_message:
.byte "This dresser needs a good",13
.byte "wipe down with new",13
.byte "Indenture(tm), the dust",13
.byte "busting miracle spray.",13
.byte "There is an especially",13
.byte "enticing top drawer that is",13
.byte "currently closed.",0

; + look drawer/dresser (open)
inside_nn_look_open_drawer_message:
.byte "This dresser needs a good",13
.byte "wipe down with new",13
.byte "Indenture(tm), the dust",13
.byte "busting miracle spray.",13
.byte "There is a drawer open and",13	; actual game "openand"
.byte "there are some brown lumpy",13
.byte "clothes in it.",0

; + look drawer/dresser (open, after robe taken)
inside_nn_look_norobe_drawer_message:
.byte "This dresser needs a good",13
.byte "wipe down with new",13
.byte "Indenture(tm), the dust",13
.byte "busting miracle spray.",13
.byte "There is a drawer open, but",13
.byte "it's empty.",0

;======
; open

; + open drawer (it's closed, not taken)
inside_nn_open_closed_drawer_message:
.byte "There's a vintage peasant",13
.byte "robe in there! Just like",13
.byte "grampa used to wear.",0

; + open drawer (it's open)
inside_nn_open_open_drawer_message:
.byte "Yeah, totally! Except it's",13
.byte "already open you moron.",0

; + open drawer (after getting robe and closing)
inside_nn_open_empty_drawer_message:
.byte "You already closed it,",13
.byte "which was nice, and so we",13
.byte "gave you some points. Let",13
.byte "sleeping drawers lie.",0

;=========
; close

;+1 POINT
; + close drawer
inside_nn_close_empty_drawer_message:
.byte "Aww, how thoughtful and",13
.byte "boring of you. Break into",13
.byte "this peasant's home, steal",13
.byte "his clothes, but remember",13
.byte "to tidy up after yourself.",13
.byte "You're a real saint.",0

; + close drawer (w/o taking robe)
inside_nn_close_full_drawer_message:
.byte "Right, right. Wouldn't",13
.byte "want to leave the robes out",13
.byte "where any old guy trying to",13
.byte "beat an adventure game",13
.byte "could take them.",0

; + close drawer (already closed)
inside_nn_close_closed_drawer_message:
.byte "A riddle: What can be",13
.byte "closed that is already",13
.byte "closed? (hint: not this",13
.byte "drawer)",0

;============
; get

; +10 points
; + get/take robe (drawer must be open)
inside_nn_get_robe_message:
.byte "Yeah! Get that robe!",0

; + get/take robe (after you've gotten it)
inside_nn_get_robe_already_message:
.byte "You still remember the time",13
.byte "when you took them. Oh, the",13
.byte "times have changed ... but",13
.byte "the robes?",0

; + get/take robe (drawer closed, whether you have it or not)
inside_nn_get_robe_drawer_closed_message:
.byte "You reach into the closed",13
.byte "drawer and nearly break",13
.byte "your hand slamming it. Just",13
.byte "like a bird on a pane of",13
.byte "glass minus the",13
.byte "blamelessness.",0

; + get/take drawer/dresser
inside_nn_get_dresser_message:
.byte "You get a hernia from",13
.byte "lifting it. -2 Movement",13
.byte "points, -10 Constitution.",13
.byte "Don't do that again.",0

; + get/take broom
inside_nn_get_broom_message:
.byte "No, no. The broom is in the",13
.byte "foreground and you can't",13
.byte "take things from the",13
.byte "foreground. You don't see",13
.byte "me all typing ",34,"get",13
.byte "computer monitor",34,", do you?",0
