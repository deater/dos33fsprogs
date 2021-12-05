peasant4_dialog_start:

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

;=================
; Wavy Tree (Ned)
;=================
; Ned pops out randomly
; he stays out unless you talk to him?

; + look
ned_tree_look_at_message:
.byte "Nothing special here",13
.byte "except for that weird wavy",13
.byte "tree.",0

; + look dude
; + look guy
; + look man
; + look ned (when Naked Ned is peeking out)
ned_tree_look_ned_message:
.byte "A fairly naked man is",13
.byte "peering out from behind",13
.byte "that tree.",0

; + look tree
ned_tree_look_at_tree_message:
.byte "It's weird and wavy.",0

; + climb tree
ned_tree_climb_tree_message:
.byte "You don't climb wavy trees.",0

; + talk (with Naked Ned visible)  (he disappears until you re-enter)
ned_tree_talk_none_message:
.byte "You startled him and he",13
.byte "disappears!",0

; + talk ned			(he disappears)
; + talk Naked Ned (with Naked Ned visible)
ned_tree_talk_ned_message:
.byte "'Never speak of this",13
.byte "meeting!' says the nudie",13
.byte "and he disapperars.",0

; + talk tree
ned_tree_talk_tree_message:
.byte "Trees can't talk but a",13
.byte "breeze picks up and you",13
.byte "swear the leaves whisper",13
.byte "the words 'Naked Ned.'",13
.byte "Weird.",0

;===============================================
; Kerrek Tracks 1/2 (top or bottom footprints?)
;===============================================

.include "kerrek.inc.lookup"

;===========================
; Outside Baby Lady Cottage
;===========================

; + look
lady_cottage_look_at_message:
.byte "There's a ranch-style",13
.byte "thatched roof cottage",13
.byte "here. There are also what",13
.byte "appear to be four crunch",13
.byte "berry bushes but you can't",13
.byte "be sure.",0

; + look cottage
lady_cottage_look_at_cottage_message:
.byte "You had a cottage once. A",13
.byte "lot like this one. *sniff*",13
.byte "Trogdor will pay!",0

; + look door
; (This response repeats whatever your command was back at you. When typing commands, you can put anything you want between the command and the object and it will still work, so here, if you type "look at door" or "look at the ugly brown door" or "lookasdfasdfdoor", it will put that in between the quotes.)
lady_cottage_look_at_door_message:
.byte "Listen to you, ",34,"look door",34,13
.byte "What kinda gaming is that?",13
.byte "It's a door and it's closed.",0

; + look berries
lady_cottage_look_at_berries_message:
.byte "Crunch berries maybe.",13

; + look bushes
lady_cottage_look_at_bushes_message:
.byte "You suspect they might be",13
.byte "crunch berry bushes.",0

; walks to nearest?
; + get berries (first bush) [walks to lower left]
lady_cottage_searched_1_bush_message:
.byte "You reach into the bush to",13
.byte "snag some berries but",13
.byte "they all just squish in",13
.byte "your hand.",0

; + get berries (second bush)	[left]
lady_cottage_searched_2_bushes_message:
.byte "Man, nothing in this bush",13
.byte "but squished berries",13
.byte "either.",0

; + get berries (third bush)
lady_cottage_searched_3_bushes_message:
.byte "Too bad you don't want any",13
.byte "squished berries, cuz hey:",13
.byte "jackpot!",0

; +2 POINTS
; + get berries (fourth bush)
lady_cottage_searched_4_bushes_message:
.byte "You reach into the bush to",13
.byte "snag you some berries but",13
.byte "instead find a Super",13
.byte "Trinket! These things are",13
.byte "awesome! You have a",13
.byte "sneaking suspicion that",13
.byte "SOMEONE in this game will",13
.byte "need this thing.",0

; + get berries (same twice)
; + search bush (same twice)
lady_cottage_already_searched_message:
.byte "You already searched that",13
.byte "bush. It was okay. Nothing",13
.byte "to write home about... oh,",13
.byte "wait... you don't have a",13
.byte "home. My b.",0

; + search bush (already found trinket)
; + get berries (already found trinket)
lady_cottage_already_trinket_message:
.byte "You've searched your fill",13
.byte "of berry bushes for this",13
.byte "game. If you want to search",13
.byte "more press CTRL-RESET to",13
.byte "reboot the computer.",0
;.byte "more press 'reload' on the browser 

; + knock (walks to door)
lady_cottage_knock_door_message:
.byte 34,"It's open,",34," says a female",13
.byte "voice from inside. Um, it's",13
.byte "NOT open, but you get her",13
.byte "drift.",0

; + knock (after she leaves)
lady_cottage_knock_door_gone_message:
.byte "No one answers. That crazy",13
.byte "lady took off. How ever",13
.byte "will you get past this",13
.byte "closed door now?",0

; + open door
lady_cottage_open_door_message:
.byte "You open er up and head on",13
.byte "in.",0




;============================
; Burninated Trees / Lantern
;============================

; after you've walked through (???) screens?
; unclear how this works
.byte "Man, screens sure get light",13
.byte "fast around here.",0


; + look
crooked_look_day_message:
.byte "A signal lantern of some",13
.byte "kind hangs from a",13
.byte "burninated tree.",0

; + look (night)
crooked_look_night_message:
.byte "A burning signal lantern",13
.byte "hangs from a severely",13
.byte "burninated tree. ",0

; + look lantern (day)
crooked_look_lantern_day_message:
.byte "It's unlit at the moment.",13
.byte "That fancy pants royal",13
.byte "knight probably lights it",13
.byte "on nights when Troggie's on",13
.byte "the prowl.",0

; + look lantern (night)
crooked_look_lantern_night_message:
.byte "It's lit! Musta been a",13
.byte "Trogdor sighting tonight.",0

; + look stump
crooked_look_stump_message:
.byte "NOT a good place to sit.",0

; + look tree
crooked_look_tree_message:
.byte "Severely burninated. They",13
.byte "could probably use some",13
.byte "salve.",0

; +10 POINTS
; + (walking under candle in burninated trees)
crooked_catch_fire_message:
.byte "Whoa! The horse grease on",13
.byte "your robe caught fire!",13
.byte "You're a for-real peasant",13
.byte "now.",0

; + light lantern (day)
crooked_tree_light_lantern_day_message:
.byte "With what? Your red-hot",13
.byte "intellect?",0

; + light lantern (night)
crooked_tree_light_lantern_night_message:
.byte "Already lit, moron.",0
 
; + get fire (at night, before grease)
crooked_tree_get_fire_not_greased_message:
.byte "You're just not flammable",13
.byte "enough.",0

; + get fire (at night, after grease)
crooked_tree_get_fire_greased_message:
.byte "You don't need to get IT.",13
.byte "Just let IT get YOU.",0

; + get fire (at night, after getting on fire)
crooked_tree_get_fire_already_message:
.byte "You're already on fire!",13
.byte "What? You want to be MORE",13
.byte "on fire?",0

; + get lantern
crooked_tree_get_lantern_message:
.byte "Better not. There's an",13
.byte "engraved plaque on it that",13
.byte "says, ",34,"Do Not Remove Under",13
.byte "Penalty Of 'You Die'.",34,0

; + get plague
crooked_tree_get_plague_message:
.byte "Wrong game, Mispeller",13
.byte "Jones. Try the little",13
.byte "button to the left of the",13
.byte "'W'.",0

; + get plaque
crooked_tree_get_plaque_message:
.byte "You have enough of that on",13
.byte "your browning, rotten",13
.byte "peasant teeth already.",0

peasant4_dialog_end:

.assert (>peasant4_dialog_end - >peasant4_dialog_start) < $1E , error, "peasant4 dialog too big"
