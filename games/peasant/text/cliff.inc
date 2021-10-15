;============
; Cliff Base
;============

; + look 
.byte "You're at the base of a",13
.byte "very climbable cliff that",13
.byte "leads to Trogdor's",13
.byte "lair. This cliff is huge -",13
.byte "the kind where rocks start",13
.byte "falling down the minute you",13
.byte "try to climb it.",0

; + climb  (walks to center of cliff)
.byte "With a new determination",13
.byte "you dig your fingers into",13
.byte "the cliff face and begin to",13
.byte "haul yourself up the",13
.byte "mountain like you were in a",13
.byte "sports drink commercial.",0

.byte "The mountain starts",13
.byte "rumbling and big loose",13
.byte "boulders start tumblin",13
.byte "down. You'd best avoid",13
.byte "thems.",0

;=============
; Cliff
;=============

;    (Hit by rock or pterodactyl when climbing the cliff) — {You fall to the ground and lie in a heap}
.byte "Oops! You climbed real bad. You knew that you were AVOIDING the rocks, right? Not collecting them. Anyways, nice try. You dead. Thanks for playing.",0

;===================
; Cliffland Heights
;===================

; arrive
.byte "Nice jorb climbing the",13
.byte "cliff. You have a real way",13
.byte "with those arrow keys.",0

; + look
.byte "Wow! It sure gets creepy",13
.byte "fast around here! What with",13
.byte "all the lightning and the",13
.byte "scary cave entrances.",0

; + look bone/skull
.byte "You can't be sure but you",13
.byte "think those are dead person",13
.byte "bones.",0

; + look cave
.byte "The cave entrance beckons",13
.byte "to you like a hot mutton",13
.byte "sandwich might.",0
 
; + look lightning
.byte "Scary. Like Auntie",13
.byte "Gerelda's crow's feet.",0

; + climb cliff (at top)
.byte "They don't show how the",13
.byte "sports-drink people get",13
.byte "down from the cliff. You've",13
.byte "no idea how to start.",0

; + get/take/steal bone/skull
.byte "Eww. No. Grody. You're",13
.byte "grody. No. Eww.",0


;======================================
; Trogdor's Outer Sanctum / Outer Cave
;======================================

; Type any command other than "take the quiz" or "give (requested item)"
; after being apporached by a Keeper
.byte "I think he wants something from your inventory. Or you could just tell him ",34,"take the quiz",34,0

; + look
.byte "There are 3 openings with a",13
.byte "little cliff in front of",13
.byte "each. A beaded curtain",13
.byte "hangs in a doorway on the",13
.byte "far wall.",0

; + look curtain/beads
.byte "That thing's awesome. You",13
.byte "always wanted one for your",13
.byte "dorm room but your roommate",13
.byte "was a total drag and said",13
.byte "no.",0

; + look door
.byte "A wicked beaded curtain",13
.byte "hangs in the doorway.",0

; + look openings
.byte "They're mysterious and out",13
.byte "of reach. Like girls were",13
.byte "to you in high school.",0

; + look skeleton
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
.byte "Nope. It's too sheer.",0


;===================================
; Trogdor's Posh Lair / Inner Cave
;===================================

; Type any command other than "Talk" or "Talk Trogdor" after Trogdor wakes up
.byte "Trogdor is awake and a couple seconds from a Rather Dashing BBQ. Might as well say your peace with him.",0

; (Walk too close to Trogdor while he's asleep)
; {Trogdor burninates you without waking up}
.byte "Yow. Looks like you got a little too close. You dead. Maybe next time don't get too close.",0

; + look
.byte "You're in a giant cavern which houses a giant dragon. You didn't shrink or anything.",0

; + look trogdor (while he's asleep)
.byte "Holy crap! Trogdor's way bigger in person than he looks in most tapestries you've seen. All of the sudden, losing your cottage doesn't seem so bad anymore.",0

; + look trogdor (when he's awake)
.byte "Trogdor is looming menacingly over you with a tiny wee sword stuck in his belly. He looks like he's gonna kill you really soon.",0

; + (enter Trogdor's cave)
.byte "the beaded curtain slams shut behind you. There's no turning back now.",0

; + throw sword
.byte "This is it! You hurl the Trog-Sword with all your might at the sleeping Burninator.",0
.byte "Now you've done it! Trogdor's awake and the Trog-Sword doesn't seem to be doing a whole lot.",0
.byte "Your legs lock in fear, your eyes glaze over and you wish for some Depeasant adult undergarments. But you think you hear Trogdor whimpering!",0
.byte "Aw crap, that's you whimpering. At least your voice still works, I guess.",0

; + talk trogdor
.byte "You scream that your name is Rather Dashing and that Trogdor burninated your cottage and you're here for revenge!",0
.byte 34,"Sup, mortal,",34," booms Trogdor. ",34,"I really appreciate you making the effort to come all the way up here and vanquish me and all. But, I'm kinda indestructible.",34,0
.byte 34,"Yeah, I can't be killed. I'm surprised nobody mentioned that to you. I'll admit though, you've gotten farther than anybody else ever has. I bet they'll make a statue or something in honor of you somewheres.",34,0
.byte 34,"I can honestly say it'll be a pleasure and an honor to burninate you, Rather Dashing.",34,0
.byte "Aw that sure was nice of him!",0
.byte "Congratulations! You've won! No one can kill Trogdor but you came closer than anybody ever! Way to go!",0

; + wake up trogdor
.byte "'Troggie...', you murmur. 'Troggie, wake up it's time for Burnination school.' He's not budging.",0

; + attack trogdor (when he's asleep)
; + kill / slay trogdor (while Trogdor's asleep, in his lair)
.byte "Like how?",0

; + talk trogdor (while he's asleep)
.byte "You yell some choice expletives at Trogdor but he doesn't wake up. There's a cool echo, though.",0

