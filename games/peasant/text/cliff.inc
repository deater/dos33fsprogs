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

; +3 POINTS (maybe at the top?)
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
.byte "Oops! You climbed real bad. You knew that you were AVOIDING the rocks, right? Not collecting them. Anyways, nice try. You dead. Thanks for playing.",0

;===================
; Cliffland Heights
;===================

; arrive
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

; +5 POINTS (give sub or answer question)
; +5 POINTS (give soda or answer question)
; +5 POINTS (give pills or answer question)

; Type any command other than "take the quiz" or "give (requested item)"
; after being apporached by a Keeper
.byte "I think he wants something from your inventory. Or you could just tell him ",34,"take the quiz",34,0

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

; + (approached by first keeper)
.byte "Foolish peasant! How dare you enter this fairly sacred chamber!",0
.byte "You explain that you're here to smote Trogdor and if he doesn't get outta your way, him too!",0
.byte "You cannot vanquish Trogdor! Only the Three Keepers of Trogdor hold the tools with which to destroy the Burninator. The Trog-Shield, the Trog-Helmet, and the Trog-Sword.",0
.byte "And the only way we'll give them up is if you answer the three Trog-Trivia questions correctly.",0
.byte "Unless you happen to have something to eat on ya. Then we could forego my question.",0

; + give sandwich
.byte "No way! I was just kidding but you've really got a meatball sub. This rules! Here, you can have the Trog-Shield.",0

; + (approached by second keeper)
.byte "Hold, peasant! You must answer the second dreaded Trog-Trivia question!",0
.byte "Or we could call it even if I had an ice cold drink right now.",0

; + give soda
.byte "Sweet deal, peasant. I underestimated you. Wear this Trog-Helmet with style.",0

; + (approached by third keeper)
.byte "Think you're pretty hot stuff, eh? Let's see you answer the deadly and pretty impossible THIRD TROG-TRIVIA QUESTION!",0
.byte "That is, unless you've got something for my lower back. Man, it's killin me!",0

; + give pills
.byte "Whoa! Where'd you find this stuff? I don't think this is even legal anymore. These babies'll definitely smote LUMBAGO the, um, LOWER BACKINATOR!!",0
.byte "The fabled Trog-Sword is yours. You now have the means to strike down Trogdor. Good luck, peasant.",0

; + climb cliff
cave_outer_climb_message:
.byte "Nope. It's too sheer.",0


