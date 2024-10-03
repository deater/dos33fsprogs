;=========================
; Old Well / Wishing Well
;=========================

; (Leave the screen after putting the baby in the bucket)
well_leave_baby_in_well_message:
.byte "Nice try. Ditch the baby at",13
.byte "the bottom of the well, eh?",13
.byte "Thought you'd be able to",13
.byte "just walk away and it's",13
.byte "nothing but mead and",13
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
;   [note, if you do this when baby already
;			at bottom, it will just do it again
;			also, baby stays in inventory all along.

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
well_throw_baby_have_message:
.byte "Throw it where?",0

; + throw baby
; + put baby in bucket/well (before baby/after baby)
well_throw_baby_none_message:
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
