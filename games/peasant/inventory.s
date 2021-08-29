; note this is around 2k

	;=====================
	; show inventory
	;=====================
show_inventory:



	rts

;======================
; text
;======================
;
; Note, greyed out could maybe print ---- for strikethrough

; printed after description
.byte	"You no longer has this item.",0
.byte	"Hit return to go back to list",0

; first is only printed if have in inventory, though still can
.byte	"Press return for description",0
.byte	"Press ESC or Backspace to exit",0

;====================
; Inventory Strings
;====================

.byte	"????",0
.byte	"arrow",0
.byte	"baby",0
.byte	"kerrek belt",0
.byte	"chicken feed",0
.byte	"SuperTime FunBow TM",0
.byte	"monster maskus",0
.byte	"pebbles",0
.byte	"pills",0
.byte	"riches",0
.byte	"robe",0
.byte	"soda",0
.byte	"meatball sub",0
.byte	"super trinket",0
.byte	"TrogHelmet",0
.byte	"TrogShield",0
.byte	"TrogSword",0
;.byte	"???",0
.byte	"shirt",0

; arrow
.byte "Boy, you sure know how to pick",13
.byte "em! This arrow's kinda pointy even!!",0

; baby
.byte "Awww! Peasant babies are",13
.byte "adorable. No wonder they fetch",13
.byte "such a pretty penny on the black",13
.byte "market.",0

; kerrek belt
.byte "Phew! This thing stinks like all",13
.byte "getout. Why couldn't the Kerrek",13
.byte "have kidnapped a hot wench or",13
.byte "something that you coulda saved?",0

; chicken feed
.byte "Woah! Gold nuggets! Oh",13
.byte "wait...This is just chicken",13
.byte "feed. Crap.",0

; SuperTime FunBow TM
.byte "This is a pretty fancy bow.",13
.byte "You're suprised those shady",13
.byte "archers give away such decent",13
.byte "prizes. You half-expected gold",13
.byte "fish in a bag.",0

; monster maskus
.byte "Man, those pagans sure can make",13
.byte "a freaky lookin mask when they",13
.byte "want to.  It's like those theatre",13
.byte "masks' evil uncle or something",0

; pebbles
.byte "Woah! Gray chicken feed! Oh",13
.byte "wait... those are just pebbles.",13
.byte "Heavier than they look, though.",0

; pills
.byte "The innkeeper's medication says",13
.byte "it's supposed to tread ",34,"general",13
.byte "oldness.  May cause checkers",13
.byte "playing, hiked-up pants, and",13
.byte "overall pee smell.",34,0

; riches
.byte "Riches, dude. Riches. That",13
.byte "peasant lady totally has to",13
.byte "share some of this with you,",13
.byte "right? At least that shiny,",13
.byte "clawed sceptre thing.",0

; robe
.byte "A propa peasant robe. It smells",13
.byte "freshly washed and has the",13
.byte "initials 'N.N' sewn onto the",13
.byte "tag.",0

; soda
.byte "A full bottle of popular soda.",0

; meatball sub
.byte "A piping hot meatball sub fresh",13
.byte "from the bottom of a dingy old",13
.byte "well.  All you need is a bag of",13
.byte "chips and you've got a combo",13
.byte "meal!",0

; super trinket
.byte "This super trinket is weird. It",13
.byte "looks like it could either kill",13
.byte "you or make you the hit of your",13
.byte "Christmas party.",0

; TrogHelmet
.byte "The TrogHelmet is not screwing",13
.byte "around.  It's a serious helmet.",13
.byte "It also protects against",13
.byte "harmful UV rays.",0

; TrogShield
.byte "Behold the TrogSheild! No",13
.byte "seriously, behold it.  There's",13
.byte "no way Trogdor's fire breath can",13
.byte "penetrate this thing.",0

; TrogSword
.byte "The TrogSword is for real.",13
.byte "Hands-down the coolest item in",13
.byte "this whole game. You can't wait",13
.byte "to lop off that beefy arm of",13
.byte "Trogdor's with this guy.",0

; ???

; t-shirt
.byte "This has got to be your favorite",13
.byte "T-Shirt ever. Oh, the times you",13
.byte "had at Scalding Lake. Canoeing,",13
.byte "fishing, stoning heathens. What",13
.byte "a Blast!",0

