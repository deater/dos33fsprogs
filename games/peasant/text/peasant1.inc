;===================
; Poor Gary's Glen
;===================

; + look
.byte "Hey! There's a rotten ol' horse over there!",0

; + look fence (before scaring him)
.byte "A particularly rickety peasant-issue fence. Trogdor uses bits of these as toothpicks.",0

; + look fence (after scaring him)
.byte "It's got a big ol' hole in it. For walking through.",0

; + look flies (before scaring him)
.byte "A cloud of buttflies fly around the horse's butt.",0

; + look horse (before scaring him)
.byte "This bag o' bones looks like he's headed for the glue factory. He's got the name 'Poor Gary' branded onto his hide.",0

; + look stump
.byte "You run out of ideas as to what to do next, and stare at the stump.",0

; +2 POINTS
; + wear mask
.byte "You slip on the hideous monster maskus.",0
.byte "You scared the crap outta Poor Gary! He broke on through to the other side!",0

; + wear mask (after scaring him)
; + kick/kill/punch poor gary (after scaring)
.byte "Gary's gone now. Let go. Just let go./Let go!",0

; + break stump / sit on stump
.byte "Are you THAT bored? Do some questing already!",0

; + feed horse (before he's gone)
.byte "There's a good chance that horse has NEVER eaten. I doubt he'll start now.",0

; + ride horse/poor gary (before he's gone)
.byte "Naw, snapping horse spines just doesn't seem as cool as it did in high school.",0

; + pet horse/poor gary (before he's gone)
.byte "Aww, that's sweet. Poor Gary tries in vain to bite your arm off.",0

; + scare horse (before getting the mask)
.byte "You tell Gary the THE CALLS ARE COMING FROM INSIDE THE HOUSE!! one but he doesn't act very scared. He's probably heard it before. or: You tell Gary about how much cholesterol is in hay and how his arteries are probably all black and clogged. He shrugs it off. or: You tell Gary the story about the kid who pops this big zit he has and all these baby spiders come out. It doesn't phase him.",0

; + kick/kill/punch poor gary (before scaring) (Warning: Needless to say, this kills you.)
.byte "You attempt to cause Poor Gary harm for no good reason other than you kinda suck at this game. {Poor Gary kicks you} WOW! For a decrepit old horse, Poor Gary still packs a mean whallop. You dead. Thanks for playing.",0

; + kill flies (before scaring him)
.byte "Those flies and that horse's butt have a symbiotic relationship. You have no right to disrupt that.",0

; + climb/jump fence before scaring)
.byte "No, you have business to attend to here in Peasantry.",0

; + climb/jump fence after scaring)
.byte "More like you should walk through that gaping hole in it. Just an idea.",0

; + get flies (before scaring him)
.byte "You nasty. Besides, they wouldn't survive a minute away from that horse's butt.",0

; + talk gary (when he's there)
.byte "Your attempts at conversation are met with horse grunts and tail flaps. Which is better than you do at conversation with most people.",0


;================================================
; Kerrek Tracks 1/2 (top or bottom footprints?)
;================================================

.include "kerrek.inc"

;=========================
; Old Well / Wishing Well
;=========================

; (Leave the screen after putting the baby in the bucket)
.byte "ice try. Ditch the baby at the bottom of the well, eh? Thought you'd be able to just walk away and it's nothing by mead and wenches from now on, huh? Well guess what? You dead. Thanks for playing.",0

; + look
.byte "There's a really generic well here. Oh, and apparently it's autumn on this screen.",0

; + look well
.byte "Pretty average. You're not a big well person. You're more into bridges. It does have a cute little bucket though. Your dad liked buckets. Oh, and there's a metal crank too. Meemaw loved cranks.",0

; + look crank (before putting pebbles in the bucket)
.byte "It looks rusted in place.",0

; + look crank (after putting pebbles in the bucket)
.byte "That is a bonafide crank. It seems to work now.",0

; + look in well
.byte "It's dark and welly in there. Smell like stank too.",0

; + look tree
.byte "That's one orange tree alright.",0

; +2 POINTS
; + put pebbles in bucket
.byte "You plunk all your pebbles into the bucket. The weight causes it to descend to the bottom of the well with a quickness!",0

; + turn crank (before pebbles, far away)
.byte "You can't reach from there.",0

; + turn crank (before pebbles, close)
.byte "It won't budge. Maybe if there was something heavy in that bucket...",0

; + turn crank (pebbles)
.byte "The crank seems to have loosened and you haul the bucket back up. What's this? Why there's a monster maskus in there! No doubt leftover from some pagan ritual. Silly pagans.",0
.byte "You grab up the scary moster maskus. Man, this thing could scare a horse!",0

; + turn crank (after mask, far away)
.byte "You got a short reach to match your short pants. Try standing closer to that crank.",0

; + turn crank (after mask, close, first time)
.byte "Down she goes! You could do this all day!",0

; + turn crank (after mask, close, second time)
.byte "The drama grips you, but the bucket is empty. On the bright side, you're getting a pretty sweet workout for your Deltoidus Rex muscles.",0
 
; + turn crank (baby)
.byte "You haul the bucket back up. Lucky for you, the baby is still in it and appears to be unscathed. As a bonus, it looks like he found a Meatball sub down there. Score! You take the sub.",0
.byte "Oh, and the baby. You take the baby.",0

; + put baby in bucket
.byte "Okay, Father of the Year. You put a baby in a bucket and it quickly descends deep into the well. Yours is a black, black heart.",0

; + use pebbles
.byte "What do you propose to do with them? Discuss.",0
 
; + make wish
.byte "This isn't that kind of well. This is a plaguewater well.",0

; + deploy/drop/use baby
.byte "Like where?",0

; + climb in bucket
.byte "Your butt is too big.",0

; + climb in well
.byte "No go. Your insurance doesn't cover that.",0

; + get/take/steal bucket
.byte "You can't, it's tied to a rope and you're terrible with knots.",0

; + throw baby
.byte "Throw it where?",0

; + put baby
.byte "Where you wanna toss em?",0

; + put baby in bucket/well (before baby/after baby)
.byte "Hmmmm... A baby, eh? You check your sundial. Babies-R-Us is probably closed by now.",0

; + put baby in bucket (too far)
.byte "You're not that keen a shot. Try standing a little closer.",0

; + put baby in bucket (after sub)
.byte "Li'l tyke seems to enjoy the ride, but -- thin or not -- we've got a plot to advance here.",0

; + put (anything else) in bucket
.byte "That's not heavy enough to weigh down the bucket.",0

; + put baby in well
.byte "Jeez man! At least put the poor little guy in the bucket! Give him a fighting chance!",0

; + put pebbles
.byte "Where you wanna toss em?",0

; + put pebbles/rocks in bucket (don't have them)
.byte "Find some pebbles first and you might have the makings of a good idea. About time.",0

; + put pebbles/rocks in bucket (after mask)
.byte "We've already been through this exercise and it went pretty well, ya?",0

; + put pebbles/rocks in well (you have them)
.byte "Then it'd be tough to get them back. You never go ANYWHERE without your rocks",0

; + put pebbles/rocks in well (don't have them/already mask)
.byte "Riiight, right. Which ones?",0

; + talk well
.byte "You yell into the well and enjoy the echo. Keep in mind there are no stereos yet.",0


;=============
; Yellow Tree
;=============

; + look
.byte "Rushing river b/w yellow",13
.byte "tree.",0

; + look tree
.byte "You're really hurtin' for",13
.byte "puzzle solutions, huh?",0

; + look cottage
.byte "You see a cottage in the",13
.byte "distance. You hold your",13
.byte "fingers up to one eye and",13
.byte "pretend to squash it.",0


;===========
; Waterfall
;===========

; + look
.byte "There's a beautiful,",13
.byte "magical waterfall",13
.byte "cascading down the cliff",13
.byte "side.",0

; + look tree
.byte "You see some trees in the",13
.byte "distance. You hold your",13
.byte "fingers up to one eye and",13
.byte "pretend to squash it.",0

; + look waterfall
.byte "Upon closer inspection,",13
.byte "you discover it's not",13
.byte "magical. That's just mist,",13
.byte "not magic sparkles or",13
.byte "anything.",0

; + swim
.byte "That waterfall would",13
.byte "probably churn you into one",13
.byte "of those weight-gain",13
.byte "protein smoothies.",0

