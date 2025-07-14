;======================================
; Trogdor's Outer Sanctum / Outer Cave
;======================================

; note: if you don't have the item, it doesn't give
;       you an option and launches directly into the quiz

; +5 POINTS (give sub or answer question)
; +5 POINTS (give soda or answer question)
; +5 POINTS (give pills or answer question)

; walk in, you can walk out again.  once the keeper appears
;	you are stuck and have to talk
; will only say the "I think he wants... text

; + climb cliff
cave_outer_climb_message:
.byte "Nope. It's too sheer.",0


; + look
cave_outer_look_message:
.byte "There are 3 openings with a",13
.byte "little cliff in front of",13
.byte "each. A beaded curtain",13
.byte "hangs in a doorway on the",13
.byte "far wall.",0

; + look curtain/beads
cave_outer_look_curtain_message:
.byte "That thing's awesome. You",13
.byte "always wanted one for your",13
.byte "dorm room but your roommate",13
.byte "was a total drag and said",13
.byte "no.",0

; + look door
cave_outer_look_door_message:
.byte "A wicked beaded curtain",13
.byte "hangs in the doorway.",0

; + look openings
cave_outer_look_openings_message:
.byte "They're mysterious and out",13
.byte "of reach. Like girls were",13
.byte "to you in high school.",0

; + look skeleton
cave_outer_look_skeleton_message:
.byte "You can't be sure but you",13
.byte "think those are dead person",13
.byte "bones.",0

; + get bones
cave_outer_get_bones_message:
.byte "Eww. No. Grody. You're",13
.byte "grody. No. Eww.",0


;=========================
; Third Keeper
;=========================

; + (approached by third keeper)
cave_outer_keeper3_message1:
.byte "Think you're pretty hot",13
.byte "stuff, eh? Let's see you",13
.byte "answer the deadly and",13
.byte "pretty impossible THIRD",13
.byte "TROG-TRIVIA QUESTION!",0

; only if have it
cave_outer_keeper3_message2:
.byte "That is, unless you've got",13
.byte "something for my lower",13
.byte "back. Man, it's killin me!",0

; .take quiz
; + get a job again

cave_outer_quiz3_1:
.byte "Riddle me this. To whom",13
.byte "did the robe you're wearing",13
.byte "originally belong?",13
.byte "A. Nobleman Nicholas",13
.byte "B. Nina Neverawesome",13
.byte "C. Naked Ned",0		; correct

cave_outer_quiz3_1again:
.byte "Peasant fool! Choose A, B,",13
.byte "or C!",13
.byte "To whom did the robe you're",13
.byte "wearing originally belong?",13
.byte "A. Nobleman Nicholas",13
.byte "B. Nina Neverawesome",13
.byte "C. Naked Ned",0		; correct

cave_outer_quiz3_2:
.byte "Riddle me this. What color",13
.byte "are the leaves on the tree",13
.byte "that grows by the well?",13
.byte "A. Orange",13		; correct
.byte "B. Green",13
.byte "C. Yellow",0

cave_outer_quiz3_2_again:
.byte "Peasant fool! Choose A, B,",13
.byte "or C!",13
.byte "What color are the leaves on",13
.byte "the tree that grows by the",13
.byte "well?",13
.byte "A. Orange",13		; correct
.byte "B. Green",13
.byte "C. Yellow",0

cave_outer_quiz3_3:
.byte "Riddle me this. Which way",13
.byte "does the river that runs",13
.byte "through Peasantry flow?",13
.byte "A. West to East",13
.byte "B. Northwest to South",13
.byte "C. Northeast to Southwest",0	; correct

cave_outer_quiz3_3again:
.byte "Peasant fool! Choose A, B,",13
.byte "or C!",13
.byte "Which way does the river",13
.byte "that runs through",13
.byte "Peasantry flow?",13
.byte "A. West to East",13
.byte "B. Northwest to South",13
.byte "C. Northeast to Southwest",0	; correct


; Response to Correct Answer
cave_outer_quiz3_correct:
.byte "Uh oh. You got it right.",13
.byte "Trogdor's gonna kill me.",13
.byte "Okay, you can have the",13
.byte "Trog-Sword. Just promise",13
.byte "not to kill any Trogdor's",13	; [sic]
.byte "with it, kay?",0

cave_outer_quiz3_correct_part2:
.byte "You just stare at the",13
.byte "Keeper blankly.",0

cave_outer_quiz3_correct_part3:
.byte 34,"Okay fine! You can have",13
.byte "the dumb thing anyways.",13
.byte "Trogdor's through the",13
.byte "beaded curtain over there.",34,0

; now print "fabled Trog-sword" below

; lift sword and it gleams
; bead curtain parts

cave_outer_quiz3_correct_part4:
.byte "The fabled Trog-Sword is",13
.byte "yours. You now have the",13
.byte "means to strike down",13
.byte "Trogdor. Good luck,",13
.byte "peasant.",0

; backs out, you raise the sword in the air animation



; Response to Incorrect Answer

cave_outer_quiz3_wrong:
.byte "YES! I was hoping you'd get",13
.byte "mine wrong. No Trog-Sword",13
.byte "for you. In fact, no skin",13
.byte "for you either!",0

; turns you into a skeleton
cave_outer_quiz3_wrong_part2:
.byte "Wow. You sure dead. You had",13
.byte "a good run, though. Thanks",13
.byte "for playin.",0

; Response if not A, B, or C
; then print following followed by repeat of question
;.byte "Peasant fool! Choose A, B,",13
;.byte "or C!",0



; + give pills
cave_outer_give_pills_message:
.byte "Whoa! Where'd you find this",13
.byte "stuff? I don't think this",13
.byte "is even legal anymore.",13
.byte "These babies'll definitely",13
.byte "smote LUMBAGO the, um,",13
.byte "LOWER BACKINATOR!!",0


