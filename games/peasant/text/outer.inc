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
; First Keeper
;=========================

; + (approached by first keeper)
cave_outer_keeper1_message1:
.byte "Foolish peasant! How dare",13
.byte "you enter this fairly",13
.byte "sacred chamber!",0

cave_outer_keeper1_message2:
.byte "You explain that you're",13
.byte "here to smote Trogdor and",13
.byte "if he doesn't get outta",13
.byte "your way, him too!",0

cave_outer_keeper1_message3:
.byte "You cannot vanquish",13
.byte "Trogdor! Only the Three",13
.byte "Keepers of Trogdor hold the",13
.byte "tools with which to destroy",13
.byte "the Burninator. The",13
.byte "Trog-Shield, the",13
.byte "Trog-Helmet, and the",13
.byte "Trog-Sword.",0

cave_outer_keeper1_message4:
.byte "And the only way we'll give",13
.byte "them up is if you answer",13
.byte "the three Trog-Trivia",13
.byte "questions correctly.",0

; only say this if have sub
cave_outer_keeper1_message5:
.byte "Unless you happen to have",13
.byte "something to eat on ya.",13
.byte "Then we could forego my",13
.byte "question.",0

; can't leave or do anything except take quiz or give sub
;	prints a message saying so

; Type any command other than "take the quiz" or "give (requested item)"
; after being apporached by a Keeper
cave_outer_keeper_wants_message:
.byte "I think he wants something",13
.byte "from your inventory. Or you",13
.byte "could just tell him ",34,"take",13
.byte "the quiz",34,0


; take quiz

cave_outer_keeper_take_quiz:
.byte "Your shake off the Keeper of",13
.byte "Trogdor's request.",13
.byte "Seriously - this guy should",13
.byte "get a job.",0

; if you say other than A/B/C then...
;    Peasant fool! Choose A, B,
;    or C!
; followed by repeat of the question

cave_outer_quiz1_1:
.byte "Okay here goes. What did",13
.byte "you win from the Archery",13
.byte "game?",13
.byte "A. SuperBow FunTime TM",13
.byte "B. SuperTime FunBow TM",13	; correct
.byte "C. SuperFun BowTime TM",0

cave_outer_quiz1_1again:
.byte "Peasant fool! Choose A, B,",13
.byte "or C!",13
.byte "What did you win from the",13
.byte "Archery game?",13
.byte "A. SuperBow FunTime TM",13
.byte "B. SuperTime FunBow TM",13	; correct
.byte "C. SuperFun BowTime TM",0

cave_outer_quiz1_2:
.byte "Okay here goes. What does",13
.byte "Mendelev have you tell",13
.byte "Dongolev?",13
.byte "A. Haldo",13			; correct
.byte "B. Hallo",13
.byte "C. Allo",0

cave_outer_quiz1_2again:
.byte "Peasant fool! Choose A, B,",13
.byte "or C!",13
.byte "What does Mendelev have you",13
.byte "tell Dongolev?",13
.byte "A. Haldo",13			; correct
.byte "B. Hallo",13
.byte "C. Allo",0

cave_outer_quiz1_3:
.byte "Okay here goes. What is the",13
.byte "only creature the Jhonka",13
.byte "fears?",13
.byte "A. Poor Gary",13
.byte "B. The Baby",13
.byte "C. The Kerrek",0			; correct

cave_outer_quiz1_3again:
.byte "Peasant fool! Choose A, B,",13
.byte "or C!",13
.byte "What is the only creature",13
.byte "the Jhonka fears?",13
.byte "A. Poor Gary",13
.byte "B. The Baby",13
.byte "C. The Kerrek",0			; correct


; Response to Correct Answer
; makes happy noise, then gives you +5 POINTS
cave_outer_quiz1_correct:
.byte 34,"Ah crap! You're right.",13
.byte "Here, take this stupid",13
.byte "Trog-Shield!",34,0

; Response to Incorrect Answer
;

cave_outer_quiz1_wrong:
.byte "Sorry peasant! You fail!",13
.byte "And as punishment, you will",13
.byte "be turned into... RON ",13
.byte "CUMBERDALE!!",0

cave_outer_quiz1_wrong_part2:
.byte "You ask who the crap Ron",13
.byte "Cumberdale is.",0

cave_outer_quiz1_wrong_part3:
.byte 34,"Just this kid from 4th",13
.byte "grade that I really hated.",13
.byte "But he was a BIG LOSER and",13
.byte "HE SMELLED!",34,0

; wiggles hands, poof of smoke, turn into Ron
; makes twinkly noise as wiggles hand, another noise (blrrp?) as poof of smoke
cave_outer_quiz1_wrong_part4:
.byte "Well, you not exactly dead.",13
.byte "But there's no way you",13
.byte "could defeat Trogdor as Ron",13
.byte "Cumberdale. Your quest",13
.byte "ends here. Thanks for",13
.byte "playing.",0


; + give sub, sandwich
;   slowly backs away, you suddenly have shield
; +5 POINTS
cave_outer_give_sub_message:
cave_outer_give_sandwich_message:
.byte "No way! I was just kidding",13
.byte "but you've really got a",13
.byte "meatball sub. This rules!",13
.byte "Here, you can have the",13
.byte "Trog-Shield.",0

; you now have the shield and can leave if you want
; whole new walking animation

;=========================
; Second Keeper
;=========================

; + (approached by second keeper)
;	comes out and waggles his hands

.byte "Hold, peasant! You must",13
.byte "answer the second dreaded",13
.byte "Trog-Trivia question!",0

.byte "Or we could call it even if",13
.byte "I had an ice cold drink",13
.byte "right now.",0

; take quiz
; + get a job again


.byte "Listen careful now. Which",13
.byte "one of these letters is the",13
.byte "letter C?",13
.byte "A. B",13 
.byte "B. C",13		; correct
.byte "C. A",0

.byte "Listen careful now. How",13
.byte "many berry bushes are there",13
.byte "in the whole kingdom of",13
.byte "Peasantry?",13
.byte "A. 4",13
.byte "B. 5",13		; [sic] correct?
.byte "C. 6 ",0

.byte "Listen careful now. What",13
.byte "was the Innkeeper's pantry",13
.byte "full of?",13 
.byte "A. Epsom Salts",13
.byte "B. Epson Printers",13 
.byte "C. Old Man Rub",0		; correct

; Response to Correct Answer
.byte 34,"That's right. Oh. This",13
.byte "sucks. Guess I have to give",13
.byte "you this Trog-Helmet.",13
.byte "Dang.",0
; backs out, you now have helm on, can leave

; Response to Incorrect Answer
.byte 34,"WRONG! You are hereby",13
.byte "cursed to write corny folk",13
.byte "songs for the rest of",13
.byte "eternity! The kind that",13
.byte "only OLD PEOPLE LIKE!!",34,0

; waggles arms
; you face forward, then play the guitar for like 5 seconds

.byte "Well, you not exactly dead.",13
.byte "But you certainly can't",13
.byte "face Trogdor after writing",13
.byte "'Wheat Grows Sweet, But My",13
.byte "Gal's Sweeter'. Your quest",13
.byte "ends here. Thanks for",13
.byte "playing.",0

; + give soda
.byte "Sweet deal, peasant. I",13
.byte "underestimated you. Wear",13
.byte "this Trog-Helmet with",13
.byte "style.",0

;=========================
; Third Keeper
;=========================

; + (approached by third keeper)
.byte "Think you're pretty hot",13
.byte "stuff, eh? Let's see you",13
.byte "answer the deadly and",13
.byte "pretty impossible THIRD",13
.byte "TROG-TRIVIA QUESTION!",0

.byte "That is, unless you've got",13
.byte "something for my lower",13
.byte "back. Man, it's killin me!",0

; .take quiz
; + get a job again

.byte "Riddle me this. To whom",13
.byte "did the robe you're wearing",13
.byte "originally belong?",13
.byte "A. Nobleman Nicholas",13
.byte "B. Nina Neverawesome",13
.byte "C. Naked Ned",0		; correct


.byte "Riddle me this. What color",13
.byte "are the leaves on the tree",13
.byte "that grows by the well?",13
.byte "A. Orange",13		; correct
.byte "B. Green",13
.byte "C. Yellow",0


.byte "Riddle me this. Which way",13
.byte "does the river that runs",13
.byte "through Peasantry flow?",13
.byte "A. West to East",13
.byte "B. Northwest to South",13
.byte "C. Northeast to Southwest",0	; correct

; Response to Correct Answer

.byte "Uh oh. You got it right.",13
.byte "Trogdor's gonna kill me.",13
.byte "Okay, you can have the",13
.byte "Trog-Sword. Just promise",13
.byte "not to kill any Trogdor's",13	; [sic]
.byte "with it, kay?",0

.byte "You just stare at the",13
.byte "Keeper blankly.",0

.byte 34,"Okay fine! You can have",13
.byte "the dumb thing anyways.",13
.byte "Trogdor's through the",13
.byte "beaded curtain over there.",34,0

; now print "fabled Trog-sword" below

; Response to Incorrect Answer

.byte "YES! I was hoping you'd get",13
.byte "mine wrong. No Trog-Sword",13
.byte "for you. In fact, no skin",13
.byte "for you either!",0

; turns you into a skeleton
.byte "Wow. You sure dead. You had",13
.byte "a good run, though. Thanks",13
.byte "for playin.",0

; Response if not A, B, or C
; then print following followed by repeat of question
.byte "Peasant fool! Choose A, B,",13
.byte "or C!",0



; + give pills
.byte "Whoa! Where'd you find this",13
.byte "stuff? I don't think this",13
.byte "is even legal anymore.",13
.byte "These babies'll definitely",13
.byte "smote LUMBAGO the, um,",13
.byte "LOWER BACKINATOR!!",0

; lift sword and it gleams
; bead curtain parts

.byte "The fabled Trog-Sword is",13
.byte "yours. You now have the",13
.byte "means to strike down",13
.byte "Trogdor. Good luck,",13
.byte "peasant.",0

; backs out, you raise the sword in the air animation

; + climb cliff
cave_outer_climb_message:
.byte "Nope. It's too sheer.",0
