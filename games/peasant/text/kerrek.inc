;================================================
; Kerrek Tracks 1/2 (top or bottom footprints?)
;================================================

; (Walk too close to the Kerrek)
; {The Kerrek pounds your head into the ground}
; then prints message
kerrek_pound_message:
.byte "Your mom always told you",13
.byte "not to take head poundings",13
.byte "from strange Kerreks. And",13
.byte "NOW look what's happened.",13	; wrong in Wiki
.byte "You dead. Thanks for",13
.byte "playing.",0


; + 5 POINTS
; + kill kerrek
; + shoot Kerrek with bow
kerrek_kill_message:
.byte "Here goes nothin', Kid",13
.byte "Icarus",0

; animation of shooting him, him falling

kerrek_kill_message2:
.byte "ARROWED!! Nice shot. You",13
.byte "smote the Kerrek! He lay",13
.byte "there stinking.",0

; pause
kerrek_kill_message3:
.byte "A light rain heralds the",13
.byte "washing free of the",13
.byte "Kerrek's grip on the land.",13
.byte "You're feeling pretty",13
.byte "good, though, so the",13
.byte "artless symbolism doesn't",13
.byte "bug you.",0

; + kill kerrek (he is there, no bow or arrow)
kerrek_kill_no_bow_no_arrow_message:
.byte "With what?! You got no",13
.byte "weapons except your",13
.byte "butter-knife wit.",0

; + kill kerrek (he is there, you have arrow but not bow)
kerrek_kill_only_arrow_message:
.byte "With what?! You gonna throw",13
.byte "that arrow at him?",0

; + kill kerrek (he is there, you have bow, not arrow
kerrek_kill_only_bow_message:
.byte "With what?! You got no",13
.byte "arrow, fool!",0

; + kill kerrek (he is dead)
;  even if not on screen with dead body
kerrek_kill_kerrek_dead_message:
.byte "Yeah. You smote the Kerrek.",13
.byte "You deserve a trophy full",13
.byte "of Mutton-ums.",0

; + kill kerrek (he is not there)
kerrek_kill_kerrek_not_there_message:
.byte "Good idea. But you kinda",13
.byte "need the actual Kerrek to",13
.byte "be here for that to work.",0

;=====================
; get
;=====================


; + 10 POINTS
; + get belt
kerrek_get_belt_message:
.byte "You strap the Kerrek's belt",13
.byte "buckle around your waist.",13
.byte "Oh boy. You sure stink now.",0

; + get belt (after already have it)  ; not in wiki
kerrek_get_belt_already_message:
.byte "You totally got the belt",13
.byte "already, as evidenced by",13
.byte "the rancid cloud of odor",13
.byte "that follows you like a",13
.byte "shadow.",0

; + get arrow (after killing)
kerrek_get_arrow_message:
.byte "Eww! No way. That thing's",13
.byte "got some serious",13
.byte "Kerrek-Brand kooties on it",13
.byte "now.",0

; + get kerrek
kerrek_get_kerrek_message:
.byte "Well, he does smell real",13
.byte "bad. But he's a bit too big",13
.byte "to fit in your pocket.",0


;==================
; look
;==================

; + look (no Kerrek)
kerrek_look_no_kerrek_message:
.byte "There are large hoof prints",13
.byte "in the the grass here. And",13
.byte "it smells like a public",13
.byte "latrine.",0

; + look (no Kerrek, kerrek dead)
kerrek_look_no_dead_kerrek_message:
.byte "There are large hoof prints",13
.byte "in the the grass here.",0

; + look footprints/tracks (no Kerrek)
kerrek_look_footprints_message:
.byte "If you weren't a simpleton",13
.byte "you might think these were",13
.byte "Kerrek prints. But since",13
.byte "you are a simpleton, you",13
.byte "just go, ",34,"Yay! Piggies!",34,0





;==========================
; alive
;==========================

; + look [anything] (living Kerrek there) kerrek_there && alive
; + look footprints/tracks (living Kerrek there) 
kerrek_look_kerrek_message:
.byte "It's the Kerrek, you moron!",13
.byte "Get outta here!",0

; + look belt (still alive)
kerrek_look_belt_alive_message:
.byte "Yecch. I wouldn't touch",13
.byte "that unless it was, like,",13
.byte "an important quest item or",13
.byte "something.",0

;==========================
; dead form but belt there
;==========================

; + look (dead Kerrek)
kerrek_look_dead_message:
.byte "There are large hoof prints",13
.byte "in the grass here.",13
.byte "There is a large",13
.byte "Kerrek-shaped mound on the",13
.byte "grass.",0

; + look kerrek (immediately after killing him)
kerrek_look_kerrek_dead_message:
.byte "He dead. And the only thing",13
.byte "of value on him is his",13
.byte "stinky belt buckle.",0

;==========================
; dead form but belt taken
;==========================

; + look (see above)

; + look kerrek (immediately after taking the belt)
kerrek_look_kerrek_dead_nobelt_message:
.byte "He dead.",0


;==================
; decomposing form
;==================

; + look (rotting Kerrek)
kerrek_look_decomposing_message:
.byte "There are large hoof prints",13
.byte "in the grass here. Part",13
.byte "of the ground looks just",13
.byte "like a rotting kerrek.",0

; + look kerrek (while he's decomposing)
kerrek_look_kerrek_decomposing_message:
.byte "He dead. You didn't think",13
.byte "he could have smelled any",13
.byte "worse? Well, guess what: He",13
.byte "smells worse.",0

;==================
; skeleton form
;==================

; + look (skeletal Kerrek)
kerrek_look_kerrek_bones_message:
.byte "There are large hoof prints",13
.byte "in the grass here.",13
.byte "Looks like someone left",13
.byte "their spare bones here.",0

; + look kerrek (when he's all bones)
kerrek_look_bones_kerrek_message:
.byte "He dead. He wasn't fat, he",13
.byte "was just big boned! Poor",13
.byte "pig-man.",0

; + look bones (skips the "he dead." part?)
kerrek_look_bones_message:
.byte "He wasn't fat, he was just",13
.byte "big boned! Poor pig-man.",0


;===============
; buy
;===============

; + buy kerrek a cold one (in the Kerrek's domain while he's still alive)
;   (Warning: This speeds the Kerrek up, so be careful.) 
kerrek_buy_cold_one_message:
.byte "The kerrek is a teetotaller",13
.byte "and is offended by your",13
.byte "offer. You've really",13
.byte "cheesed him off now.",0

; + make friends with kerrek
kerrek_make_friends_message:
.byte "Look, it didn't work for",13
.byte "Strongbad and it's not",13
.byte "gonna work for you either.",0

; + load / save (while he's still alive)
kerrek_load_save_message:
.byte "You can't be fumbling with",13
.byte "a floppy while the Kerrek",13
.byte "is bearing down on you.",0


; + talk kerrek (while he is alive)
kerrek_talk_message:
.byte 34,"Me llamo Julio,",34," you",13
.byte "begin... It seems only to",13
.byte "further anger the already",13
.byte "tempramental Kerrek. That",13
.byte "stupid ",34,"Learn Kerrek in 3",13
.byte "Weeks",34," cassette did",13
.byte "nothing for you!",0


; rain stops after 5?
; on/off screen X times to rotting? or is it time?
