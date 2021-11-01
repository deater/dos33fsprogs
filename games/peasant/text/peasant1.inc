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
gary_look_fence_after_scare_message:
.byte "It's got a big ol' hole in",13
.byte "it. For walking through.",0

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

; + scare gary/horse (before getting the mask)
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

; +2 POINTS
; + wear mask / scare horse
gary_scare_message:
.byte "You slip on the hideous",13
.byte "monster maskus.",0

; TODO: mask on face, gary turns and runs through fence

gary_scare_message2:
.byte "You scared the crap outta",13
.byte "Poor Gary! He broke on",13
.byte "through to the other side!",0

; + wear mask (after scaring him)
; + kick/kill/punch poor gary (after scaring)
gary_gone_message:
.byte "Gary's gone now. Let go.",13
.byte "Just let go.",0
gary_gone_message2:
.byte "Let go!",0

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

; + kick/kill/punch poor gary (before scaring)
; (Warning: Needless to say, this kills you.)
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
gary_climb_fence_gone_message:
.byte "More like you should walk",13
.byte "through that gaping hole in",13
.byte "it. Just an idea.",0

; + break/kick stump
; + sit stump
; + talk stump
gary_kick_stump_message:
.byte "Are you THAT bored? Do some",13
.byte "questing already!",0

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
well_leave_baby_in_well_message:
.byte "Nice try. Ditch the baby at",13
.byte "the bottom of the well, eh?",13
.byte "Thought you'd be able to",13
.byte "just walk away and it's",13
.byte "nothing by mead and",13
.byte "wenches from now on, huh?",13
.byte "Well guess what? You dead.",13
.byte "Thanks for playing.",0

; + look
well_look_at_message:
.byte "There's a really generic",13
.byte "well here. Oh, and",13
.byte "apparently it's autumn on",13
.byte "this screen.",0

; + look well
well_look_at_well_message:
.byte "Pretty average. You're not",13
.byte "a big well person. You're",13
.byte "more into bridges. It does",13
.byte "have a cute little bucket",13
.byte "though. Your dad liked",13
.byte "buckets. Oh, and there's a",13
.byte "metal crank too. Meemaw",13
.byte "loved cranks.",0

; if not gotten mask
well_look_at_well_message2:
.byte "You can just make out",13
.byte "something floating in the",13
.byte "water down there.",0

; + look crank (before putting pebbles in the bucket)
well_look_at_crank_message:
.byte "It looks rusted in place.",0

; + look crank (after putting pebbles in the bucket)
well_look_at_crank_pebbles_message:
.byte "That is a bonafide crank.",13
.byte "It seems to work now.",0

; + look in well (after mask)
well_look_in_well_message2:
.byte "It's dark and welly in",13
.byte "there. Smell like stank",13
.byte "too.",0

; + look in well (before mask)
well_look_in_well_message:
.byte "It's dark and welly in",13
.byte "there. Smell like stank",13
.byte "too. You can just make out",13
.byte "something floating in the",13
.byte "water down there.",0

; + look tree
well_look_at_tree_message:
.byte "That's one orange tree",13
.byte "alright.",0

; + look bucket (NOT IN WIKI?)
well_look_at_bucket_message:
.byte "An empty wooden bucket",13
.byte "hangs on a rope in the well.",0

;========
; put


; + put pebbles
well_put_pebbles_message:
.byte "Where you wanna toss em?",0

;=======================
; put pebbles in bucket

; +2 POINTS
; + put pebbles in bucket
well_put_pebbles_in_bucket_message:
.byte "You plunk all your pebbles",13
.byte "into the bucket. The weight",13
.byte "causes it to descend to the",13
.byte "bottom of the well with a",13
.byte "quickness!",0

; + put pebbles/rocks in bucket (don't have them)
well_put_pebbles_in_bucket_before_message:
.byte "Find some pebbles first and",13
.byte "you might have the makings",13
.byte "of a good idea. About time.",0

; + put pebbles/rocks in bucket (after mask)
well_put_pebbles_in_bucket_gone_message:
.byte "We've already been through",13
.byte "this exercise and it went",13
.byte "pretty well, ya?",0

;=====================
; put pebbles in well
; + put pebbles/rocks in well (you have them)
well_put_pebbles_in_well_message:
.byte "Then it'd be tough to get",13
.byte "them back. You never go",13
.byte "ANYwhere without your rocks",0 ; [sic]

; + put pebbles/rocks in well (don't have them/already mask)
well_put_pebbles_in_well_gone_message:
.byte "Riiight, right. Which",13
.byte "ones?",0

;=====================
; put baby in bucket

; + put baby (if you have it)
well_put_baby_message:
.byte "Where you wanna toss em?",0

; + 3 POINTS
; + put baby in bucket
well_put_baby_in_bucket_message:
.byte "Okay, Father of the Year.",13
.byte "You put a baby in a bucket",13
.byte "and it quickly descends",13
.byte "deep into the well. Yours",13
.byte "is a black, black heart.",0

; + put baby in bucket (too far)
well_put_baby_in_bucket_too_far_message:
.byte "You're not that keen",13
.byte "a shot. Try standing a little",13
.byte "closer.",0

; + put baby in bucket (after sub)
well_put_baby_in_bucket_already_done_message:
.byte "Li'l tyke seems to enjoy",13
.byte "the ride, but - thin or not",13
.byte "- we've got a plot to",13
.byte "advance here.",0

;=====================
; put baby in well

; + put baby in well
well_put_baby_in_well_message:
.byte "Jeez man! At least put the",13
.byte "poor little guy in the",13
.byte "bucket! Give him a fighting",13
.byte "chance!",0

; + put baby in well (don't have, see put pebbles in well don't have)

; + put (anything else) in bucket
well_put_anything_message:
.byte "That's not heavy enough to",13
.byte "weigh down the bucket.",0


;========
; turn

; + turn crank (before pebbles, far away)
well_turn_crank_too_far_message:
.byte "You can't reach from there.",0

; + turn crank (before pebbles in, close)
well_turn_crank_no_pebbles_message:
.byte "It won't budge. Maybe if",13
.byte "there was something heavy",13
.byte "in that bucket...",0

; TODO: animation, bucket up with mask
; + turn crank (pebbles)
well_turn_crank_pebbles_message:
.byte "The crank seems to have",13
.byte "loosened and you haul the ",13
.byte "bucket back up. What's",13
.byte "this? Why there's a monster",13
.byte "maskus in there! No doubt",13
.byte "leftover from some pagan",13
.byte "ritual. Silly pagans.",0

well_turn_crank_pebbles2_message:
.byte "You grab up the scary",13
.byte "moster maskus. Man, this",13
.byte "thing could scare a horse!",0

; like edge of screen far
; + turn crank (after mask, far away)
well_turn_crank_too_far_after_message:
.byte "You got a short reach to",13
.byte "match your short pants. Try",13
.byte "standing closer to that",13
.byte "crank.",0

; + turn crank (after hmask, close, first time)
well_bucket_down_message:
.byte "Down she goes! You could",13
.byte "do this all day!",0

; + turn crank (after mask, close, second time)
well_bucket_up_message:
.byte "The drama grips you, but",13
.byte "the bucket is empty. On the",13
.byte "bright side, you're",13
.byte "getting a pretty sweet",13
.byte "workout for your Deltoidus",13
.byte "Rex muscles.",0
 
; + 2 POINTS
; + turn crank (baby)
well_turn_crank_baby_message:
.byte "You haul the bucket back",13
.byte "up. Lucky for you, the baby",13
.byte "is still in it and appears",13
.byte "to be unscathed. As a",13
.byte "bonus, it looks like he",13
.byte "found a Meatball sub down",13
.byte "there. Score! You take the",13
.byte "sub.",0

well_turn_crank_baby2_message:
.byte "Oh, and the baby. You take",13
.byte "the baby.",0

;================
; use

; + use pebbles
well_use_pebbles_message:
.byte "What do you propose to do",13
.byte "with them? Discuss.",0

; + deploy/drop/use baby (if you have it)
well_use_baby_message:
.byte "Like where?",0
 
;=========
; make

; + make wish
well_make_wish_message:
.byte "This isn't that kind of",13
.byte "well. This is a plaguewater",13
.byte "well.",0

;==========
; climb

; + climb in bucket
well_climb_bucket_message:
.byte "Your butt is too big.",0

; + climb in well/well
well_climb_well_message:
.byte "No go. Your insurance",13
.byte "doesn't cover that.",0

;=========
; get

; + get/take/steal bucket
well_get_bucket_message:
.byte "You can't, it's tied to a",13
.byte "rope and you're terrible",13
.byte "with knots.",0

;===========
; throw

; + throw baby (if you have it)
.byte "Throw it where?",0

; + throw baby
; + put baby in bucket/well (before baby/after baby)
well_throw_baby_message:
well_put_baby_none_message:
.byte "Hmmmm... A baby, eh? You",13
.byte "check your sundial.",13
.byte "Babies-R-Us is probably",13
.byte "closed by now.",0

;==============
; talk

; + talk well
well_talk_message:
.byte "You yell into the well and",13
.byte "enjoy the echo. Keep in",13
.byte "mind there are no stereos",13
.byte "yet.",0


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

