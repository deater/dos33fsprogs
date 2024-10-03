;=============
; Mud Puddle
;=============

; note, puddle goes dry after you get riches

; +2 POINTS
; + (walk into puddle when raining)
puddle_walk_in_message:
.byte "Now you've done it! You're",13
.byte "covered in sticky, albeit",13
.byte "fine smelling, mud. Your",13
.byte 34,"Scalding Lake",34," T-shirt is",13
.byte "all soiled, too. You just",13
.byte "washed it last harvest!",0

; + look (dry)
puddle_look_at_dry_message:
.byte "There's a dried out mud",13
.byte "puddle. It's all caked and",13
.byte "cracked like the kind",13
.byte "rock stars are always",13
.byte "standing on.",0

; + look (wet)
puddle_look_at_wet_message:
.byte "Not much to see. 'Sides",13
.byte "that big mud puddle.",0

; + look mud / puddle	(dry)			; NOT IN WIKI?
puddle_look_mud_dry_message:
.byte "The bone-dry mud puddle is",13
.byte "cracked and caked.",0

; + look mud / puddle	(wet)			; NOT IN WIKI?
puddle_look_mud_wet_message:
.byte "It's that sticky mud.",13
.byte "Y'know, the kind pigs like.",0

; + get / look rock
puddle_get_rock_message:
.byte "That rock's not doin' a",13
.byte "whole lot for me.",0

; + get mud (when it's wet, before you fall in)
puddle_get_mud_wet_clean_message:
.byte "You can't get the mud so",13
.byte "much. More like the mud'll",13
.byte "get you.",0

; + get mud (when it's wet, after you fall in)
puddle_get_mud_wet_dirty_message:
.byte "You've already gotten an",13
.byte "heapin' helpin' all up on",13
.byte "yo'self.",0


