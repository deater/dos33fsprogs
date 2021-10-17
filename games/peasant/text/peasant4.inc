
;====================================
; Outside Mysterious (Ned's) Cottage
;====================================

; + look
.byte "There's a run-of-the-mill",13
.byte "non-burninated",13
.byte "thatched-roof cottage",13
.byte "here. Its stonework looks",13
.byte "a little shoddy.",0

; + look cottage
.byte "A run-of-the-mill,",13
.byte "non-burninated",13
.byte "thatched-roof cottage",13
.byte "here. Its stonework looks a",13
.byte "little shoddy.",0

; + open door
.byte "How? There's no knob.",0

; + open door (after baby opens)
.byte "It's already open. Since this is an adventure game we're gonna proffer you adventure yourself on in there.",0

; + pull door
; + push door
.byte "It doesn't budge, man.",0

; + knock
.byte "You could knock until your",13
.byte "knuckles bleed. Nobody's",13
.byte "home.",0

; + knock until knuckles bleed
.byte "You knock for about 4 hours",13
.byte "until your knuckles are raw",13
.byte "and bloody. That was fun!",0

; + knock until knuckles bleed (again)
.byte "You done that already. A",13
.byte "great time was had by all.",0

; + break door
; + kick door
; + punch door 
.byte "Violence is not the answer.",0

; + look fence
.byte "A standard peasant fence.",13
.byte "Trogdor makes milk's meat",13
.byte "outta these things.",0

; + look hole (before deploying baby)
.byte "You peer into the tiny",13
.byte "opening. The cottage",13
.byte "appears to be empty.",0

; + look hole (after deploying baby)
.byte "There is no baby here, but there's an open door on the other side of the room. If you could only get to it somehow!",0

; + look rock (before removing it)
.byte "There appears to be a loose",13
.byte "stone towards the back of",13
.byte "the cottage.",0

; + look rock (after removing it)
.byte "Some jerk removed a loose stone from the back of the cottage.",0

; + get rock		plays music, increments points
; + move rock
.byte "You slide the stone over to",13
.byte "reveal a little hole. If",13
.byte "only you could cut off your",13
.byte "arms, legs, and head you",13
.byte "might be able to squeeze",13
.byte "through!",0

; + get rock (after moving it)
.byte "You've already moved the",13
.byte "stone out of the way to",13
.byte "reveal a less-than",13
.byte "peasant-sized hole.",0

; cut off arms, legs, and head   (possibly just "cut off arms")
.byte "Very funny. You have",13
.byte "trouble cutting out",13
.byte "coupons in the weekly",13
.byte "'Peasant Penny-Pincher'",13
.byte "circular. I'd like to see",13
.byte "you try.",0

; + try  (Warning: You die.)
.byte "Okay, fine. You try to cut",13
.byte "off your hard-earned",13
.byte "extremities. It doesn't",13
.byte "work. You dead. Thanks for",13
.byte "nothing.",0

; + put baby into the hole
.byte "Deploying Q-Baby...",0
.byte "Way to go, baby! It got the cottage door opened and headed off to a new life. He becomes Valedictorian of his graduating class, goes to Scalding Lake State, gets a degree in Advanced Peasantry and lands a job at Thatch-Pro: building better cottages for a better tomorrow.",0
.byte "You grow apart and the letters from him become fewer and fewer. He develops a severe mead problem and blames you for never being there.",0

; + deploy/drop/use baby (before baby)
.byte "Swell idea, but is you",13
.byte "ain't my baby? I.e. you",13
.byte "ain't got one?",0

; + deploy/drop/use baby (before moving stone)
.byte "Use the baby where? You haven't anywhere inconsiderate to stuff 'm.",0

; + deploy/drop/use baby (after baby left)
.byte "Li'l P.B. has moved on, and the door seems to be open... I can't see why we'd go through this all over again.",0
; + close door (before baby opens)
.byte "Already done. That was",13
.byte "easy!",0

; + close door (after baby opens)
.byte "You can't. That baby really wrenched it open good.",0

;=================
; Wavy Tree (Ned)
;=================
; Ned pops out randomly
; he stays out unless you talk to him?

; + look
.byte "Nothing special here",13
.byte "except for that weird wavy",13
.byte "tree.",0

; + look dude
; + look guy
; + look man
; + look ned (when Naked Ned is peeking out)
.byte "A fairly naked man is",13
.byte "peering out from behind",13
.byte "that tree.",0

; + look tree
.byte "It's weird and wavy.",0

; + climb tree
.byte "You don't climb wavy trees.",0

; + talk (with Naked Ned visible)  (he disappears until you re-enter)
.byte "You startled him and he",13
.byte "disappears!",0

; + talk ned
; + talk Naked Ned (with Naked Ned visible)
.byte "'Never speak of this",13
.byte "meeting!' says the nudie",13
.byte "and he disapperars.",0

; + talk tree
.byte "Trees can't talk but a",13
.byte "breeze picks up and you",13
.byte "swear the leaves whisper",13
.byte "the words 'Naked Ned.'",13
.byte "Weird.",0

;===============================================
; Kerrek Tracks 1/2 (top or bottom footprints?)
;===============================================

.include "kerrek.inc"

;===========================
; Outside Baby Lady Cottage
;===========================

; + look
.byte "There's a ranch-style",13
.byte "thatched roof cottage",13
.byte "here. There are also what",13
.byte "appear to be four crunch",13
.byte "berry bushes but you can't",13
.byte "be sure.",0

; + look cottage
.byte "You had a cottage once. A",13
.byte "lot like this one. *sniff*",13
.byte "Trogdor will pay!",0

; + look door
; (This response repeats whatever your command was back at you. When typing commands, you can put anything you want between the command and the object and it will still work, so here, if you type "look at door" or "look at the ugly brown door" or "lookasdfasdfdoor", it will put that in between the quotes.)
.byte "Listen to you, ",34,"look door",34,13
.byte "What kinda gaming is that?",13
.byte "It's a door and it's closed.",0

; + look berries
.byte "Crunch berries maybe.",13

; + look bushes
.byte "You suspect they might be",13
.byte "crunch berry bushes.",0

; walks to nearest?
; + get berries (first bush) [walks to lower left]
.byte "You reach into the bush to",13
.byte "snag some berries but",13
.byte "they all just squish in",13
.byte "your hand.",0

; + get berries (second bush)	[left]
.byte "Man, nothing in this bush",13
.byte "but squished berries",13
.byte "either.",0

; + get berries (third bush)
.byte "Too bad you don't want any",13
.byte "squished berries, cuz hey:",13
.byte "jackpot!",0

; +2 POINTS
; + get berries (fourth bush)
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
.byte "You already searched that",13
.byte "bush. It was okay. Nothing",13
.byte "to write home about... oh,",13
.byte "wait... you don't have a",13
.byte "home. My b.",0

; + search bush (already found trinket)
; + get berries (already found trinket)
.byte "You've searched your fill",13
.byte "of berry bushes for this",13
.byte "game. If you want to search",13
.byte "more press CTRL-RESET to",13
.byte "reboot the computer.",0
;.byte "more press 'reload' on the browser 

; + knock (walks to door)
.byte 34,"It's open,",34," says a female",13
.byte "voice from inside. Um, it's",13
.byte "NOT open, but you get her",13
.byte "drift.",0

; + knock (after she leaves)
.byte "No one answers. That crazy lady took off. How ever will you get past this closed door now?",0

; + open door
.byte "You open er up and head on",13
.byte "in.",0




;============================
; Burninated Trees / Lantern
;============================

; + look
.byte "A signal lantern of some",13
.byte "kind hangs from a",13
.byte "burninated tree.",0

; + look (night)
.byte "A burning signal lantern hangs from a severely burninated tree. ",0

; + look lantern (unlit)
.byte "It's unlit at the moment.",13
.byte "That fancy pants royal",13
.byte "knight probably lights it",13
.byte "on nights when Troggie's on",13
.byte "the prowl.",0

; + look lantern (lit)
.byte "It's lit! Musta been a Trogdor sighting tonight.",0

; + look stump
.byte "NOT a good place to sit.",0

; + look tree
.byte "Severely burninated. They",13
.byte "could probably use some",13
.byte "salve.",0

; + (walking under candle in burninated trees)
.byte "Whoa! The horse grease on your robe caught fire! You're a for-real peasant now.",0

; + (exiting on fire)
.byte "Man, screens sure get light fast around here.",0

; + light lantern (before lit)
.byte "With what? Your red-hot",13
.byte "intellect?",0

; + light lantern (already lit)
.byte "Already lit, moron.",0
 
; + get fire (at night, before grease)
.byte "You're just not flammable enough.",0

; + get fire (at night, after grease)
.byte "You don't need to get IT. Just let IT get YOU.",0

; + get fire (at night, after getting on fire)
.byte "You're already on fire! What? You want to be MORE on fire?",0

; + get lantern
.byte "Better not. There's an",13
.byte "engraved plaque on it that",13
.byte "says, ",34,"Do Not Remove Under",13
.byte "Penalty Of 'You Die'.",34,0

; + get plague
.byte "Wrong game, Mispeller",13
.byte "Jones. Try the little",13
.byte "button to the left of the",13
.byte "'W'.",0

; + get  plaque
.byte "You have enough of that on",13
.byte "your browning, rotten",13
.byte "peasant teeth already.",0


