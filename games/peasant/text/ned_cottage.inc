;====================================
; Outside Mysterious (Ned's) Cottage
;====================================

; + look
ned_cottage_look_message:
.byte "There's a run-of-the-mill",13
.byte "non-burninated",13
.byte "thatched-roof cottage",13
.byte "here. Its stonework looks",13
.byte "a little shoddy.",0

; + look cottage
ned_cottage_look_cottage_message:
.byte "A run-of-the-mill,",13
.byte "non-burninated",13
.byte "thatched-roof cottage",13
.byte "here. Its stonework looks a",13
.byte "little shoddy.",0

; + open door
ned_cottage_open_door_message:
.byte "How? There's no knob.",0

; + open door (after baby opens)
ned_cottage_open_door_after_baby_message:
.byte "It's already open. Since",13
.byte "this is an adventure game",13
.byte "we're gonna proffer you",13
.byte "adventure yourself on in",13
.byte "there.",0

; + pull door
; + push door
;	same even when open
ned_cottage_push_door_message:
.byte "It doesn't budge, man.",0

; + knock
;	same even when open
ned_cottage_knock_door_message:
.byte "You could knock until your",13
.byte "knuckles bleed. Nobody's",13
.byte "home.",0

; + knock until knuckles bleed
ned_cottage_knock_door_bleed_message:
.byte "You knock for about 4 hours",13
.byte "until your knuckles are raw",13
.byte "and bloody. That was fun!",0

; + knock until knuckles bleed (again)
ned_cottage_knock_door_bleed_message2:
.byte "You done that already. A",13
.byte "great time was had by all.",0

; + break door
; + kick door
; + punch door
ned_cottage_break_door_message:
.byte "Violence is not the answer.",0

; + look fence
ned_cottage_look_fence_message:
.byte "A standard peasant fence.",13
.byte "Trogdor makes milk's meat",13
.byte "outta these things.",0

; + climb/jump fence
ned_cottage_climb_fence_message:
.byte "No, you have business to",13
.byte "attend to here in",13
.byte "Peasantry.",0

; + look hole (before deploying baby) (even if rock not moved yet)
ned_cottage_look_hole_message:
.byte "You peer into the tiny",13
.byte "opening. The cottage",13
.byte "appears to be empty.",0

; + look hole (after deploying baby)
ned_cottage_look_hole_after_message:
.byte "There is no baby here, but",13
.byte "there's an open door on the",13
.byte "other side of the room. If",13
.byte "you could only get to it",13
.byte "somehow!",0

; + look rock (before removing it)
ned_cottage_look_rock_message:
.byte "There appears to be a loose",13
.byte "stone towards the back of",13
.byte "the cottage.",0

; + look rock (after removing it)
ned_cottage_look_rock_moved_message:
.byte "Some jerk removed a loose",13
.byte "stone from the back of the",13
.byte "cottage.",0

; + get rock	+2 POINTS
; + move rock
ned_cottage_get_rock_message:
.byte "You slide the stone over to",13
.byte "reveal a little hole. If",13
.byte "only you could cut off your",13
.byte "arms, legs, and head you",13
.byte "might be able to squeeze",13
.byte "through!",0

; + get rock (after moving it)
ned_cottage_get_rock_already_message:
.byte "You've already moved the",13
.byte "stone out of the way to",13
.byte "reveal a less-than",13
.byte "peasant-sized hole.",0

; cut off arms, legs, and head   (possibly just "cut off arms")
ned_cottage_cut_arms_message:
.byte "Very funny. You have",13
.byte "trouble cutting out",13
.byte "coupons in the weekly",13
.byte "'Peasant Penny-Pincher'",13
.byte "circular. I'd like to see",13
.byte "you try.",0

; + try  (Warning: You die.)
ned_cottage_try_message:
.byte "Okay, fine. You try to cut",13
.byte "off your hard-earned",13
.byte "extremities. It doesn't",13
.byte "work. You dead. Thanks for",13
.byte "nothing.",0

;+5 POINTS
; + deploy baby
; + put baby into the hole
ned_cottage_deploy_baby_message:
.byte "Deploying Q-Baby...",0

; animation
ned_cottage_deploy_baby_message2:
.byte "Way to go, baby! It got the",13
.byte "cottage door opened and",13
.byte "headed off to a new life.",13
.byte "He becomes Valedictorian",13
.byte "of his graduating class,",13
.byte "goes to Scalding Lake",13
.byte "State, gets a degree in",13
.byte "Advanced Peasantry and",13
.byte "lands a job at Thatch-Pro:",13
.byte "building better cottages",13
.byte "for a better tomorrow.",0

ned_cottage_deploy_baby_message3:
.byte "You grow apart and the",13
.byte "letters from him become",13
.byte "fewer and fewer. He",13
.byte "develops a severe mead",13
.byte "problem and blames you for",13
.byte "never being there.",0

; + deploy/drop/use baby (before baby)
ned_cottage_baby_nobaby_message:
.byte "Swell idea, but is you",13
.byte "ain't my baby? I.e. you",13
.byte "ain't got one?",0

; + deploy/drop/use baby (before moving stone)
ned_cottage_baby_before_message:
.byte "Use the baby where? You",13
.byte "haven't anywhere",13
.byte "inconsiderate to stuff'm.",0

; + deploy/drop/use baby (after baby left)
ned_cottage_baby_gone_message:
.byte "Li'l P.B. has moved on, and",13
.byte "the door seems to be",13
.byte "open... I can't see why",13
.byte "we'd go through this all",13
.byte "over again.",0

; + close door (before baby opens)
ned_cottage_close_door_before_message:
.byte "Already done. That was",13
.byte "easy!",0

; + close door (after baby opens)
ned_cottage_close_door_after_message:
.byte "You can't. That baby really",13
.byte "wrenched it open good.",0

