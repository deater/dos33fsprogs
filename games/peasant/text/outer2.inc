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

; Type any command other than "take the quiz" or "give (requested item)"
; after being apporached by a Keeper
cave_outer_keeper_wants_message:
.byte "I think he wants something",13
.byte "from your inventory. Or you",13
.byte "could just tell him ",34,"take",13
.byte "the quiz",34,0



;=========================
; Second Keeper
;=========================

; + (approached by second keeper)
;	comes out and waggles his hands

cave_outer_keeper2_message1:
.byte "Hold, peasant! You must",13
.byte "answer the second dreaded",13
.byte "Trog-Trivia question!",0

; only say this if you have the soda (?)
cave_outer_keeper2_message2:
.byte "Or we could call it even if",13
.byte "I had an ice cold drink",13
.byte "right now.",0

; take quiz
; + get a job again
; meaning, say cave_outer_keeper_take_quiz

cave_outer_quiz2_1:
.byte "Listen careful now. Which",13
.byte "one of these letters is the",13
.byte "letter C?",13
.byte "A. B",13 
.byte "B. C",13		; correct
.byte "C. A",0

cave_outer_quiz2_1again:
.byte "Peasant fool! Choose A, B,",13
.byte "or C!",13
.byte "Which one of these letters",13
.byte "is the letter C?",13
.byte "A. B",13 
.byte "B. C",13		; correct
.byte "C. A",0

cave_outer_quiz2_2:
.byte "Listen careful now. How",13
.byte "many berry bushes are there",13
.byte "in the whole kingdom of",13
.byte "Peasantry?",13
.byte "A. 4",13
.byte "B. 5",13		; [sic] correct?
.byte "C. 6 ",0

cave_outer_quiz2_2again:
.byte "Peasant fool! Choose A, B,",13
.byte "or C!",13
.byte "How many berry bushes are",13
.byte "there in the whole kingdom",13
.byte "of Peasantry?",13
.byte "A. 4",13
.byte "B. 5",13		; [sic] correct?
.byte "C. 6 ",0


cave_outer_quiz2_3:
.byte "Listen careful now. What",13
.byte "was the Innkeeper's pantry",13
.byte "full of?",13 
.byte "A. Epsom Salts",13
.byte "B. Epson Printers",13 
.byte "C. Old Man Rub",0		; correct

cave_outer_quiz2_3again:
.byte "Peasant fool! Choose A, B,",13
.byte "or C!",13
.byte "What was the Innkeeper's",13
.byte "pantry full of?",13 
.byte "A. Epsom Salts",13
.byte "B. Epson Printers",13 
.byte "C. Old Man Rub",0		; correct


; Response to Correct Answer
cave_outer_quiz2_correct:
.byte 34,"That's right. Oh. This",13
.byte "sucks. Guess I have to give",13
.byte "you this Trog-Helmet.",13
.byte "Dang.",0
; backs out, you now have helm on, can leave

; Response to Incorrect Answer
cave_outer_quiz2_wrong:
.byte 34,"WRONG! You are hereby",13
.byte "cursed to write corny folk",13
.byte "songs for the rest of",13
.byte "eternity! The kind that",13
.byte "only OLD PEOPLE LIKE!!",34,0

; waggles arms
; you face forward, then play the guitar for like 5 seconds

cave_outer_quiz2_wrong_part2:
.byte "Well, you not exactly dead.",13
.byte "But you certainly can't",13
.byte "face Trogdor after writing",13
.byte "'Wheat Grows Sweet, But My",13
.byte "Gal's Sweeter'. Your quest",13
.byte "ends here. Thanks for",13
.byte "playing.",0

; + give soda
cave_outer_give_soda_message:
.byte "Sweet deal, peasant. I",13
.byte "underestimated you. Wear",13
.byte "this Trog-Helmet with",13
.byte "style.",0





