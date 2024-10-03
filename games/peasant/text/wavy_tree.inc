
;=================
; Wavy Tree (Ned)
;=================
; Ned pops out randomly
; he stays out unless you talk to him?

; + look
ned_tree_look_at_message:
.byte "Nothing special here",13
.byte "except for that weird wavy",13
.byte "tree.",0

; + look dude
; + look guy
; + look man
; + look ned (when Naked Ned is peeking out)
ned_tree_look_ned_message:
.byte "A fairly naked man is",13
.byte "peering out from behind",13
.byte "that tree.",0

; + look tree
ned_tree_look_at_tree_message:
.byte "It's weird and wavy.",0

; + climb tree
ned_tree_climb_tree_message:
.byte "You don't climb wavy trees.",0

; + talk (with Naked Ned visible)  (he disappears until you re-enter)
ned_tree_talk_none_message:
.byte "You startled him and he",13
.byte "disappears!",0

; + talk ned			(he disappears)
; + talk Naked Ned (with Naked Ned visible)
ned_tree_talk_ned_message:
.byte "'Never speak of this",13
.byte "meeting!' says the nudie",13
.byte "and he disapperars.",0

; + talk tree
ned_tree_talk_tree_message:
.byte "Trees can't talk but a",13
.byte "breeze picks up and you",13
.byte "swear the leaves whisper",13
.byte "the words 'Naked Ned.'",13
.byte "Weird.",0

