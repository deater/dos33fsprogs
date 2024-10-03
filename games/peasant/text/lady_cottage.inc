;===========================
; Outside Baby Lady Cottage
;===========================

; + look
lady_cottage_look_at_message:
.byte "There's a ranch-style",13
.byte "thatched roof cottage",13
.byte "here. There are also what",13
.byte "appear to be four crunch",13
.byte "berry bushes but you can't",13
.byte "be sure.",0

; + look cottage
lady_cottage_look_at_cottage_message:
.byte "You had a cottage once. A",13
.byte "lot like this one. *sniff*",13
.byte "Trogdor will pay!",0

; + look door
; (This response repeats whatever your command was back at you. When typing commands, you can put anything you want between the command and the object and it will still work, so here, if you type "look at door" or "look at the ugly brown door" or "lookasdfasdfdoor", it will put that in between the quotes.)
lady_cottage_look_at_door_message:
.byte "Listen to you, ",34,"look door",34,13
.byte "What kinda gaming is that?",13
.byte "It's a door and it's closed.",0

; + look berries
lady_cottage_look_at_berries_message:
.byte "Crunch berries maybe.",13

; + look bushes
lady_cottage_look_at_bushes_message:
.byte "You suspect they might be",13
.byte "crunch berry bushes.",0

; walks to nearest?
; + get berries (first bush) [walks to lower left]
lady_cottage_searched_1_bush_message:
.byte "You reach into the bush to",13
.byte "snag some berries but",13
.byte "they all just squish in",13
.byte "your hand.",0

; + get berries (second bush)	[left]
lady_cottage_searched_2_bushes_message:
.byte "Man, nothing in this bush",13
.byte "but squished berries",13
.byte "either.",0

; + get berries (third bush)
lady_cottage_searched_3_bushes_message:
.byte "Too bad you don't want any",13
.byte "squished berries, cuz hey:",13
.byte "jackpot!",0

; +2 POINTS
; + get berries (fourth bush)
lady_cottage_searched_4_bushes_message:
.byte "You reach into the bush to",13
.byte "snag you some berries but",13
.byte "instead find a Super",13
.byte "Trinket! These things are",13
.byte "awesome! You have a",13
.byte "sneaking suspicion that",13
.byte "SOMEONE in this game will",13
.byte "need this thing.",0

; + get berries (same twice)
; + search bush (same twice)
lady_cottage_already_searched_message:
.byte "You already searched that",13
.byte "bush. It was okay. Nothing",13
.byte "to write home about... oh,",13
.byte "wait... you don't have a",13
.byte "home. My b.",0

; + search bush (already found trinket)
; + get berries (already found trinket)
lady_cottage_already_trinket_message:
.byte "You've searched your fill",13
.byte "of berry bushes for this",13
.byte "game. If you want to search",13
.byte "more press CTRL-RESET to",13
.byte "reboot the computer.",0
;.byte "more press 'reload' on the browser 

; + knock (walks to door)
lady_cottage_knock_door_message:
.byte 34,"It's open,",34," says a female",13
.byte "voice from inside. Um, it's",13
.byte "NOT open, but you get her",13
.byte "drift.",0

; + knock (after she leaves)
lady_cottage_knock_door_gone_message:
.byte "No one answers. That crazy",13
.byte "lady took off. How ever",13
.byte "will you get past this",13
.byte "closed door now?",0

; + open door
lady_cottage_open_door_message:
.byte "You open er up and head on",13
.byte "in.",0

