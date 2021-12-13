;============
; Cliff Base
;============

; + look 
cliff_base_look_message:
.byte "You're at the base of a",13
.byte "very climbable cliff that",13
.byte "leads to Trogdor's",13
.byte "lair. This cliff is huge -",13
.byte "the kind where rocks start",13
.byte "falling down the minute you",13
.byte "try to climb it.",0

; + climb  (walks to center of cliff)
cliff_base_climb_message:
.byte "With a new determination",13
.byte "you dig your fingers into",13
.byte "the cliff face and begin to",13
.byte "haul yourself up the",13
.byte "mountain like you were in a",13
.byte "sports drink commercial.",0

cliff_base_climb2_message:
.byte "The mountain starts",13
.byte "rumbling and big loose",13
.byte "boulders start tumblin",13
.byte "down. You'd best avoid",13
.byte "thems.",0

;=============
; Cliff
;=============

;    (Hit by rock or pterodactyl when climbing the cliff) 
;    {You fall to the ground and lie in a heap}
.byte "Oops! You climbed real bad.",13
.byte "You knew that you were",13
.byte "AVOIDING the rocks, right?",13
.byte "Not collecting them.",13
.byte "Anyways, nice try. You",13
.byte "dead. Thanks for playing.",0

;===================
; Cliffland Heights
;===================

; arrive
; +3 POINTS (maybe at the top?)

.byte "Nice jorb climbing the",13
.byte "cliff. You have a real way",13
.byte "with those arrow keys.",0

; + look
cliff_heights_look_at_message:
.byte "Wow! It sure gets creepy",13
.byte "fast around here! What with",13
.byte "all the lightning and the",13
.byte "scary cave entrances.",0

; + look bone/skull
cliff_heights_look_bone_message:
.byte "You can't be sure but you",13
.byte "think those are dead person",13
.byte "bones.",0

; + look cave
cliff_heights_look_cave_message:
.byte "The cave entrance beckons",13
.byte "to you like a hot mutton",13
.byte "sandwich might.",0
 
; + look lightning
cliff_heights_look_lightning_message:
.byte "Scary. Like Auntie",13
.byte "Gerelda's crow's feet.",0

; + climb cliff (at top)
cliff_heights_climb_message:
.byte "They don't show how the",13
.byte "sports-drink people get",13
.byte "down from the cliff. You've",13
.byte "no idea how to start.",0

; + get/take/steal bone/skull
cliff_heights_get_bone_message:
.byte "Eww. No. Grody. You're",13
.byte "grody. No. Eww.",0


;======================================
; Trogdor's Outer Sanctum / Outer Cave
;======================================

; note: if you don't have the item, it doesn't give
;       you an option and launches directly into the quiz

; +5 POINTS (give sub or answer question)
; +5 POINTS (give soda or answer question)
; +5 POINTS (give pills or answer question)

; Type any command other than "take the quiz" or "give (requested item)"
; after being apporached by a Keeper
.byte "I think he wants something",13
.byte "from your inventory. Or you",13
.byte "could just tell him ",34,"take",13
.byte "the quiz",34,0

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

;=========================
; First Keeper
;=========================

; + (approached by first keeper)
.byte "Foolish peasant! How dare",13
.byte "you enter this fairly",13
.byte "sacred chamber!",0

.byte "You explain that you're",13
.byte "here to smote Trogdor and",13
.byte "if he doesn't get outta",13
.byte "your way, him too!",0

.byte "You cannot vanquish",13
.byte "Trogdor! Only the Three",13
.byte "Keepers of Trogdor hold the",13
.byte "tools with which to destroy",13
.byte "the Burninator. The",13
.byte "Trog-Shield, the",13
.byte "Trog-Helmet, and the",13
.byte "Trog-Sword.",0

.byte "And the only way we'll give",13
.byte "them up is if you answer",13
.byte "the three Trog-Trivia",13
.byte "questions correctly.",0

.byte "Unless you happen to have",13
.byte "something to eat on ya.",13
.byte "Then we could forego my",13
.byte "question.",0

; can't leave or do anything except take quiz or give sub
;	prints a message saying so

; take quiz

.byte "Your shake off the Keeper of",13
.byte "Trogdor's request.",13
.byte "Seriously - this guy should",13
.byte "get a job.",0

.byte "Okay here goes. What did you win from the Archery game?",13
.byte "A. SuperBow FunTime TM",13
.byte "B. SuperTime FunBow TM",13	; correct
.byte "C. SuperFun BowTime TM",0

.byte "Okay here goes. What does",13
.byte "Mendelev have you tell",13
.byte "Dongolev?",13
.byte "A. Haldo",13			; correct
.byte "B. Hallo",13
.byte "C. Allo",0


.byte "Okay here goes. What is the only creature the Jhonka fears?",13
.byte "A. Poor Gary",13
.byte "B. The Baby",13
.byte "C. The Kerrek",0			; correct

; Response to Correct Answer
.byte 34,"Ah crap! You're right.",13
.byte "Here, take this stupid",13
.byte "Trog-Shield!",0

; Response to Incorrect Answer
.byte "Sorry peasant! You fail! And as punishment, you will be turned into... RON CUMBERDALE!!",0
.byte "You ask who the crap Ron Cumberdale is.",0
.byte "Just this kid from 4th grade that I really hated. But he was a BIG LOSER and HE SMELLED!",0
.byte "Well, you not exactly dead. But there's no way you could defeat Trogdor as Ron Cumberdale. Your quest ends here. Thanks for playing.",0


; + give sub, sandwich
.byte "No way! I was just kidding",13
.byte "but you've really got a",13
.byte "meatball sub. This rules!",13
.byte "Here, you can have the",13
.byte "Trog-Shield.",0

; you now have the shield and can leave if you want

;=========================
; Second Keeper
;=========================

; + (approached by second keeper)
.byte "Hold, peasant! You must",13
.byte "answer the second dreaded",13
.byte "Trog-Trivia question!",0

.byte "Or we could call it even if",13
.byte "I had an ice cold drink",13
.byte "right now.",0

; take quiz
; + get a job again


.byte "Listen careful now. Which one of these letters is the letter C?",13
.byte "A. B",13 
.byte "B. C",13		; correct
.byte "C. A",0

.byte "Listen careful now. How many berry bushes are there in the whole kingdom of Peasantry?",13
.byte "A. 4",13
.byte "B. 5",13
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

; Response to Incorrect Answer
.byte "WRONG! You are hereby cursed to write corny folk songs for the rest of eternity! The kind that only OLD PEOPLE LIKE!!",0
.byte "Well, you not exactly dead. But you certainly can't face Trogdor after writing 'Wheat Grows Sweet, But My Gal's Sweeter'. Your quest ends here. Thanks for playing.",0

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


.byte "Riddle me this. What color are the leaves on the tree that grows by the well?",13
.byte "A. Orange",13
.byte "B. Green",13
.byte "C. Yellow",0


.byte "Riddle me this. Which way does the river that runs through Peasantry flow?",13
.byte "A. West to East",13
.byte "B. Northwest to South",13
.byte "C. Northeast to Southwest",0

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

.byte "YES! I was hoping you'd get mine wrong. No Trog-Sword for you. In fact, no skin for you either!",0
.byte "Wow. You sure dead. You had a good run, though. Thanks for playin.",0

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

; + climb cliff
cave_outer_climb_message:
.byte "Nope. It's too sheer.",0
