;===================
; Poor Gary's Glen
;===================

; + look
gary_look_message:
.byte "Hey! There's a rotten ol'",13
.byte "horse over there!",0

; + look fence (before scaring him)
gary_look_fence_message:
.byte "A particularly rickety",13
.byte "peasant-issue fence.",13
.byte "Trogdor uses bits of these",13
.byte "as toothpicks.",0

; + look fence (after scaring him)
.byte "It's got a big ol' hole in it. For walking through.",0

; + look flies (before scaring him)
gary_look_flies_message:
.byte "A cloud of buttflies fly",13
.byte "around the horse's butt.",0

; + look gary/horse (before scaring him)
gary_look_horse_message:
.byte "This bag o' bones looks",13
.byte "like he's headed for the",13
.byte "glue factory. He's got the",13
.byte "name 'Poor Gary' branded",13
.byte "onto his hide.",0

; + look stump
gary_look_stump_message:
.byte "You run out of ideas as to",13
.byte "what to do next, and stare",13
.byte "at the stump.",0

; +2 POINTS
; + wear mask
.byte "You slip on the hideous monster maskus.",0
.byte "You scared the crap outta Poor Gary! He broke on through to the other side!",0

; + wear mask (after scaring him)
; + kick/kill/punch poor gary (after scaring)
.byte "Gary's gone now. Let go. Just let go./Let go!",0

; + break/kick stump / sit on stump
gary_kick_stump_message:
.byte "Are you THAT bored? Do some",13
.byte "questing already!",0

; + feed horse (before he's gone)
gary_feed_horse_message:
.byte "There's a good chance that",13
.byte "horse has NEVER eaten. I",13
.byte "doubt he'll start now.",0

; + ride horse/poor gary (before he's gone)
gary_ride_horse_message:
.byte "Naw, snapping horse spines",13
.byte "just doesn't seem as cool",13
.byte "as it did in high school.",0

; + pet horse/poor gary (before he's gone)
gary_pet_horse_message:
.byte "Aww, that's sweet. Poor",13
.byte "Gary tries in vain to bite",13
.byte "your arm off.",0

; + scare horse (before getting the mask)
gary_scare_horse_message1:
.byte "You tell Gary the THE",13
.byte "CALLS ARE COMING FROM",13
.byte "INSIDE THE HOUSE!! one but",13
.byte "he doesn't act very scared.",13
.byte "He's probably heard it",13
.byte "before.",0

gary_scare_horse_message2:
.byte "You tell Gary about how",13
.byte "much cholesterol is in hay",13
.byte "and how his arteries are",13
.byte "probably all black and",13
.byte "clogged. He shrugs it off.",0

gary_scare_horse_message3:
.byte "You tell Gary the story",13
.byte "about the kid who pops this",13
.byte "big zit he has and all",13
.byte "these baby spiders come",13
.byte "out. It doesn't phase him.",0

; + kick/kill/punch poor gary (before scaring) (Warning: Needless to say, this kills you.)
gary_kick_horse_message:
.byte "You attempt to cause Poor",13
.byte "Gary harm for no good",13
.byte "reason other than you kinda",13
.byte "suck at this game.",0
; {Poor Gary kicks you} rears on hind legs, you fall flat
;
gary_kick_horse_message2:
.byte "WOW! For a decrepit old",13
.byte "horse, Poor Gary still",13
.byte "packs a mean whallop. You",13
.byte "dead. Thanks for playing.",0
; game over screen
; + kick/kill/punch flies (before scaring him)
gary_kick_flies_message:
.byte "Those flies and that",13
.byte "horse's butt have a",13
.byte "symbiotic relationship.",13
.byte "You have no right to",13
.byte "disrupt that.",0

; + climb/jump fence before scaring)
gary_climb_fence_message:
.byte "No, you have business to",13
.byte "attend to here in",13
.byte "Peasantry.",0

; + climb/jump fence after scaring)
.byte "More like you should walk through that gaping hole in it. Just an idea.",0

; + get flies (before scaring him)
gary_get_flies_message:
.byte "You nasty. Besides, they",13
.byte "wouldn't survive a minute",13
.byte "away from that horse's",13
.byte "butt.",0

; + talk gary (when he's there)
gary_talk_message:
.byte "Your attempts at",13
.byte "conversation are met with",13
.byte "horse grunts and tail",13
.byte "flaps. Which is better than",13
.byte "you do at conversation with",13
.byte "most people.",0


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
 
; + 2 POINTS
; + turn crank (baby)
.byte "You haul the bucket back up. Lucky for you, the baby is still in it and appears to be unscathed. As a bonus, it looks like he found a Meatball sub down there. Score! You take the sub.",0
.byte "Oh, and the baby. You take the baby.",0

; + 3 POINTS
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
yellow_tree_look_message:
.byte "Rushing river b/w yellow",13
.byte "tree.",0

; + look tree
yellow_tree_look_tree_message:
.byte "You're really hurtin' for",13
.byte "puzzle solutions, huh?",0

; + look cottage
yellow_tree_look_cottage_message:
.byte "You see a cottage in the",13
.byte "distance. You hold your",13
.byte "fingers up to one eye and",13
.byte "pretend to squash it.",0


;===========
; Waterfall
;===========

; + look
waterfall_look_at_message:
.byte "There's a beautiful,",13
.byte "magical waterfall",13
.byte "cascading down the cliff",13
.byte "side.",0

; + look tree
waterfall_look_tree_message:
.byte "You see some trees in the",13
.byte "distance. You hold your",13
.byte "fingers up to one eye and",13
.byte "pretend to squash it.",0

; + look waterfall
waterfall_look_waterfall_message:
.byte "Upon closer inspection,",13
.byte "you discover it's not",13
.byte "magical. That's just mist,",13
.byte "not magic sparkles or",13
.byte "anything.",0

; + swim
waterfall_swim_message:
.byte "That waterfall would",13
.byte "probably churn you into one",13
.byte "of those weight-gain",13
.byte "protein smoothies.",0

