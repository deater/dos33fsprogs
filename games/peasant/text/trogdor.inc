;===================================
; Trogdor's Posh Lair / Inner Cave
;===================================

; (Walk too close to Trogdor while he's asleep)
; {Trogdor burninates you without waking up}
; also somehow if you try to walk after waking
.byte "Yow. Looks like you got a",13
.byte "little too close. You dead.",13
.byte "Maybe next time don't get",13
.byte "too close.",0

; + (enter Trogdor's cave)
trogdor_entry_message:
.byte "The beaded curtain slams",13
.byte "shut behind you. There's no",13
.byte "turning back now.",0


; + look
trogdor_look_message:
.byte "You're in a giant cavern",13
.byte "which houses a giant",13
.byte "dragon. You didn't shrink",13
.byte "or anything.",0

; + look dragon/trogdor (while he's asleep)
trogdor_look_trogdor_message:
.byte "Holy crap! Trogdor's way",13
.byte "bigger in person than he",13
.byte "looks in most tapestries",13
.byte "you've seen. All of the",13
.byte "sudden, losing your",13
.byte "cottage doesn't seem so bad",13
.byte "anymore.",0

; + wake up trogdor
trogdor_wake_message:
.byte 34,"Troggie...",34,", you murmur.",13
.byte 34,"Troggie, wake up it's time",13
.byte "for Burnination school.",34,13
.byte "He's not budging.",0

; + attack trogdor (when he's asleep)
; + kill / slay trogdor (while Trogdor's asleep, in his lair)
trogdor_attack_message:
.byte "Like how?",0

; + talk trogdor (while he's asleep)
trogdor_talk_message:
.byte "You yell some choice",13
.byte "expletives at Trogdor but",13
.byte "he doesn't wake up. There's",13
.byte "a cool echo, though.",0


; +7 POINTS
; + throw sword
trogdor_throw_sword_message:
.byte "This is it! You hurl the",13
.byte "Trog-Sword with all your",13
.byte "might at the sleeping",13
.byte "Burninator.",0

; walks over, throws, animation

trogdor_throw_sword_message2:
.byte "Now you've done it!",13
.byte "Trogdor's awake and the",13
.byte "Trog-Sword doesn't seem to",13
.byte "be doing a whole lot.",0

trogdor_throw_sword_message3:
.byte "Your legs lock in fear,",13
.byte "your eyes glaze over and",13
.byte "you wish for some Depeasant",13
.byte "adult undergarments. But",13
.byte "you think you hear Trogdor",13
.byte "whimpering!",0

trogdor_throw_sword_message4:
.byte "Aw crap, that's you",13
.byte "whimpering. At least your",13
.byte "voice still works, I guess.",0

;======================================
;======================================
; After he wakes up;
;======================================
;======================================

; Type any command other than "Talk" or "Talk Trogdor" after Trogdor wakes up
.byte "Trogdor is awake and a",13
.byte "couple seconds from a",13
.byte "Rather Dashing BBQ. Might",13
.byte "as well say your peace with",13
.byte "him.",0

; + look dragon/trogdor (when he's awake)
.byte "Trogdor is looming",13
.byte "menacingly over you with a",13
.byte "tiny wee sword stuck in his",13
.byte "belly. He looks like he's",13
.byte "gonna kill you really soon.",0

; +10 POINTS
; + talk trogdor
.byte "You scream that your name",13
.byte "is Rather Dashing and that",13
.byte "Trogdor burninated your",13
.byte "cottage and you're here for",13
.byte "revenge!",0

.byte 34,"Sup, mortal,",34," booms",13
.byte "Trogdor. ",34,"I really",13
.byte "appreciate you making the",13
.byte "effort to come all the way",13
.byte "up here and vanquish me and",13
.byte "all. But, I'm kinda",13
.byte "indestructible.",34,0

.byte 34,"Yeah, I can't be killed.",13
.byte "I'm surprised nobody",13
.byte "mentioned that to you. I'll",13
.byte "admit though, you've",13
.byte "gotten farther than",13
.byte "anybody else ever has. I",13
.byte "bet they'll make a statue",13
.byte "or something in honor of",13
.byte "you somewheres.",0			; [sic] no end quote	

trogdor_honestly_message:
.byte 34,"I can honestly say it'll",13
.byte "be a pleasure and an honor",13
.byte "to burninate you, Rather",13
.byte "Dashing.",34,0

trogdor_honestly_message2:
.byte "Aw that sure was nice of",13
.byte "him!",0

trogdor_honestly_message3:
.byte "Congratulations! You've",13
.byte "won! No one can kill",13
.byte "Trogdor but you came closer",13
.byte "than anybody ever! Way to",13
.byte "go!",0

