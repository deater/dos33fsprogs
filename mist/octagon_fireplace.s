
; button closes/opens fireplace
; code is erased if wrong

; press it when right code, rotates to books

; atrus writing, looks up says something, back down to writing

open_fireplace:

	lda	#OCTAGON_IN_FIREPLACE
	sta	LOCATION

	jmp	change_location

close_fireplace:

	lda	#OCTAGON_IN_FIREPLACE_CLOSED
	sta	LOCATION

	jmp	change_location


fireplace_shelf_action:

	; see if button
fireplace_check_button:
	lda	CURSOR_X
	cmp	#9
	bcs	fireplace_check_book

	lda	CURSOR_Y
	cmp	#32
	bcs	fireplace_nil
	cmp	#20
	bcc	fireplace_nil
	bcs	return_fireplace

	; see if green book
fireplace_check_book:
	lda	CURSOR_Y
	cmp	#26
	bcs	fireplace_check_blue_page
	lda	CURSOR_X
	cmp	#17
	bcc	fireplace_nil
	bcs	open_green_book

	; see if blue page
fireplace_check_blue_page:
	lda	CURSOR_X
	cmp	#14
	bcc	fireplace_nil
	cmp	#20
	bcs	fireplace_check_red_page
	bcc	fireplace_grab_blue_page

	; see if red page
fireplace_check_red_page:
	jmp	fireplace_grab_red_page

	; otherwise, do nothing
fireplace_nil:
	rts

return_fireplace:
	lda	#OCTAGON_IN_FIREPLACE
	sta	LOCATION

	lda	#DIRECTION_W
	sta	DIRECTION

	jmp	change_location

open_green_book:
	lda	#OCTAGON_GREEN_BOOK
	sta	LOCATION
	jmp	change_location

fireplace_grab_red_page:
	lda	RED_PAGES_TAKEN
	and	#FINAL_PAGE
	bne	missing_page

	lda	#FINAL_PAGE
	jmp	take_red_page

missing_page:
        rts

fireplace_grab_blue_page:
	lda	BLUE_PAGES_TAKEN
	and	#FINAL_PAGE
	bne	missing_page

	lda	#FINAL_PAGE
	jmp	take_blue_page


goto_dni:
	lda	#OCTAGON_DNI
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION

	jmp	change_location


; talking to atrus

; book, 1st time
	;             1         2         3
	;   0123456789012345678901234567890123456789
.byte 21,0,"WHO THE DEVIL ARE YOU?",0
.byte 22,0,"D--DON'T COME HERE TO D'NI, NOT YET.",0
.byte 23,0,"I HAVE MANY QUESTIONS FOR YOU, MY FRIEND",0
.byte 23,0,"AS YOU, NO DOUBT, HAVE FOR ME.",0

.byte 21,0,"PERHAPS MY STORY IS IN ORDER. I AM ATRUS",0
.byte 22,0,"I FEAR YOU HAVE MET MY SONS,",0
.byte 23,0,"SIRRUS & ACHENAR, TRAPPED IN MY LIBRARY",0
.byte 24,0,"ON MYST ISLAND",0

.byte 21,0,"IT CONTAINS MY WRITINGS, MY BOOKS",0
.byte 22,0,"THAT LINK TO FANTASTIC PLACES, AN ART",0
.byte 23,0,"I LEARNED FROM MY FATHER YEARS AGO.",0

.byte 21,0,"THE RED & BLUE BOOKS ARE DIFFERENT",0
.byte 22,0,"I WROTE THOSE TO ENTRAP OVER-GREEDY",0
.byte 23,0,"EXPLORERS THAT MIGHT STUMBLE UPON MYST",0
.byte 24,0,"I HAD NO IDEA I'D ENTRAP MY OWN SONS",0

.byte 21,0,"I HAD NO IDEA THE EXTENT OF THEIR GREED",0
.byte 22,0,"THEY USED THEIR OWN MOTHER, MY CATHERINE",0
.byte 23,0,"TO LURE ME HERE TO D'NI.  THEY REMOVED A",0
.byte 24,0,"PAGE FROM MY MYST BOOK SO I CAN'T RETURN",0

.byte 21,0,"YOU, MY FRIEND, CAN BRING THE PAGE TO ME",0
.byte 22,0,"I PRAY YOU BELIEVE MY STORY AND NOT THE",0
.byte 23,0,"LIES MY SONS HAVE TOLD. BRING THE PAGE",0
.byte 24,0,"AND BRING JUSTICE TO MY SONS. HURRY.",0

; book, 2nd time

.byte 21,0,"HAVE YOU FOUND THE MISSING PAGE?",0
.byte 22,0,"OH, COME, COME.  COME ON THEN.",0

; ending, both
;

.byte 21,0,"AH, MY FRIEND.  YOU'VE RETURNED.",0
.byte 22,0,"WE MEET FACE-TO-FACE.",0
.byte 23,0,"AND THE PAGE, DID YOU BRING THE PAGE?",0

; ending, no white page
;

.byte 21,0,"YOU DIDN'T BRING THE PAGE.",0
.byte 22,0,"YOU DIDN'T BRING THE PAGE!",0
.byte 23,0,"WHAT KIND OF FOOL ARE YOU?!",0
.byte 24,0,"DID YOU NOT TAKE MY WARNING SERIOUSLY?",0

.byte 21,0,"*SIGH*",0
.byte 22,0,"WELCOME TO D'NI",0
.byte 23,0,"YOU AND I WILL LIVE HERE... FOREVER.",0

; ending, with white page

.byte 21,0,"GIVE IT TO ME... GIVE ME THE PAGE",0
.byte 22,0,"PLEASE GIVE THE PAGE...",0

.byte 21,0,"YOU'VE DONE THE RIGHT THING.",0
.byte 22,0,"I HAVE A DIFFICULT CHOIC TO MAKE",0
.byte 23,0,"MY SONS BETRAYED ME, I KNOW",0
.byte 24,0,"WHAT I MUST DO.  I SHALL RETURN SHORTLY",0

; [links away]

; [links in]

.byte 21,0,"IT IS DONE.  I HAVE MANY QUESTIONS,",0
.byte 23,0,"BUT MY WRITING CANNOT WAIT.  MY DELAY",0
.byte 24,0,"MAY HAVE HAD A CATASTROPHIC IMPACT ON",0
.byte 24,0,"THE WORLD WHERE MY WIFE IS HELD HOSTAGE",0

.byte 21,0,"A REWARD? I'M SORRY BUT ALL I HAVE TO",0
.byte 22,0,"OFFER IS THE LIBRARY ON MYST AND THE",0
.byte 23,0,"BOOKS CONTAINED THERE.  FEEL FREE TO",0
.byte 24,0,"EXPLORE AT YOUR LEISURE.",0

.byte 21,0,"ALSO, I AM FIGHTING A FOE MUCH",0
.byte 22,0,"GREATER THAN MY SONS CAN IMAGINE.",0
.byte 23,0,"I MIGHT REQUEST YOUR ASSISTANCE.",0
.byte 24,0,"UNTIL THEN, HAVE FUN ON MYST",0

