;================================================
; Kerrek Tracks 1/2 (top or bottom footprints?)
;================================================

; (Walk too close to the Kerrek) — {The Kerrek pounds your head into the ground}
.byte "Your mom always told you not to take head poundings from strange Kerreks. And NOW looks what's happened. You dead. Thanks for playing.",0

; + 5 POINTS
; + shoot Kerrek with bow
.byte "Here goes nothin', Kid Icarus",0
.byte "ARROWED!! Nice shot. You smote the Kerrek! He lay there stinking.",0
.byte "A light rain heralds the washing free of the Kerrek's grip on the land. You're feeling pretty good, though, so the artless symbolism doesn't bug you.",0

; + 10 POINTS
; + get belt
.byte "You strap the Kerrek's belt buckle around your waist. Oh boy. You sure stink now.",0

; + look
kerrek_look_at_message:
.byte "There are large hoof prints in the grass here.",0

; + look (no Kerrek)
.byte "There are large hoof prints in the the grass here. And it smells like a public latrine.",0

; + look (living Kerrek)
; + look footprints/tracks (living Kerrek) 
.byte "It's the Kerrek, you moron!",13
.byte "Get outta here!",0

; + look footprints/tracks (Kerrek not present)
.byte "If you weren't a simpleton you might think these were Kerrek prints. But since you are a simpleton, you just go, 'Yay! Piggies!' ",0

; + look (dead Kerrek)
.byte "There are large hoof prints in the grass here. There is a large Kerrek-shaped mound on the grass.",0

; + look (rotting Kerrek)
.byte "There are large hoof prints in the grass here. Part of the ground looks just like a rotting kerrek.",0

; + look (skeletal Kerrek)
.byte "There are large hoof prints in the grass here. Looks like someone left their spare bones here.",0

; + buy kerrek a cold one (in the Kerrek's domain while he's still alive)
;   (Warning: This speeds the Kerrek up, so be careful.) 
.byte "The kerrek is a teetotaller",13
.byte "and is offended by your",13
.byte "offer. You've really",13
.byte "cheesed him off now.",0

; + make friends with kerrek
.byte "Look, it didn't work for",13
.byte "Strongbad and it's not",13
.byte "gonna work for you either.",0

; + load / save (while he's still alive)
.byte "You can't be fumbling with",13
.byte "a floppy while the Kerrek",13
.byte "is bearing down on you.",0

; + kill kerrek (he is there, no bow or arrow)
.byte "With what?! You got no",13
.byte "weapons except your",13
.byte "butter-knife wit.",0

; + kill kerrek (he is there, you have arrow but not bow)
.byte "With what?! You gonna throw that arrow at him?",0

; + kill kerrek (he is there, you have bow, not arrow
.byte "With what?! You got no arrow, fool!",0

; + kill kerrek (he is dead)
.byte "Yeah. You smote the Kerrek. You deserve a trophy full of Mutton-ums.",0

; + kill kerrek (he is not there)
.byte "Good idea. But you kinda need the actual Kerrek to be here for that to work.",0

; + get arrow (after killing)
.byte "Eww! No way. That thing's got some serious Kerrek-Brand kooties on it now.",0

; + get kerrek
.byte "Well, he does smell real",13
.byte "bad. But he's a bit too big",13
.byte "to fit in your pocket.",0

; + look belt (still alive)
.byte "Yecch. I wouldn't touch",13
.byte "that unless it was, like,",13
.byte "an important quest item or",13
.byte "something.",0

; + look kerrek (immediately after killing him)
.byte "He dead. And the only thing of value on him is his stinky belt buckle.",0

; + look kerrek (immediately after taking the belt)
.byte "He dead.",0

; + look kerrek (while he's decomposing)
.byte "He dead. You didn't think he could have smelled any worse? Well, guess what: He smells worse.",0

; + look kerrek (when he's all bones)
.byte "He dead. He wasn't fat, he was just big boned! Poor pig-man.",0
 
; + talk kerrek (while he is alive)
.byte 34,"Me llamo Julio,",34," you",13
.byte "begin... It seems only to",13
.byte "further anger the already",13
.byte "tempramental Kerrek. That",13
.byte "stupid ",34,"Learn Kerrek in 3",13
.byte "Weeks",34," cassette did",13
.byte "nothing for you!",0



