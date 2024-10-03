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

