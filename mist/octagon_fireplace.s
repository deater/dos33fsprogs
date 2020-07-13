
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
	bcs	grab_green_book

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

grab_green_book:
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


	; if touch window, warp to d'ni
	; otherwise, just speed up the talking
touch_green_book:
	lda	CURSOR_X
	cmp	#21
	bcc	no_dni
	cmp	#32
	bcs	no_dni
	lda	CURSOR_Y
	cmp	#10
	bcc	no_dni
	cmp	#24
	bcs	no_dni

goto_dni:

	lda	#DNI_ARRIVAL
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION

	lda	#LOAD_DNI
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts

	; just speed up talking
no_dni:
	lda	GREEN_BOOK_PROGRESS
	cmp	#8
	beq	no_speedup
	cmp	#10
	beq	no_speedup

	; skip to next
	inc	GREEN_BOOK_PROGRESS
	lda	#0
	sta	FRAMEL
	sta	FRAMEH

no_speedup:
	rts


; talking to atrus

; book, 1st time
	;             1         2         3
	;   0123456789012345678901234567890123456789
atrus_green_book1:
.byte 0,20,"WHO THE DEVIL ARE YOU?",0
.byte 0,21,"D--DON'T COME HERE TO D'NI, NOT YET.",0
.byte 0,22,"I HAVE MANY QUESTIONS FOR YOU, MY FRIEND",0
.byte 0,23,"AS YOU, NO DOUBT, HAVE FOR ME.",0

atrus_green_book2:
.byte 0,20,"PERHAPS MY STORY IS IN ORDER. I AM ATRUS",0
.byte 0,21,"I FEAR YOU HAVE MET MY SONS,",0
.byte 0,22,"SIRRUS & ACHENAR, TRAPPED IN MY LIBRARY",0
.byte 0,23,"ON MYST ISLAND",0

atrus_green_book3:
.byte 0,20,"IT CONTAINS MY WRITINGS, MY BOOKS",0
.byte 0,21,"THAT LINK TO FANTASTIC PLACES, AN ART",0
.byte 0,22,"I LEARNED FROM MY FATHER YEARS AGO.",0
.byte 0,23," ",0

atrus_green_book4:
.byte 0,20,"THE RED & BLUE BOOKS ARE DIFFERENT",0
.byte 0,21,"I WROTE THOSE TO ENTRAP OVER-GREEDY",0
.byte 0,22,"EXPLORERS THAT MIGHT STUMBLE UPON MYST",0
.byte 0,23,"I HAD NO IDEA I'D ENTRAP MY OWN SONS",0

atrus_green_book5:
.byte 0,20,"I HAD NO IDEA THE EXTENT OF THEIR GREED",0
.byte 0,21,"THEY USED THEIR OWN MOTHER, MY CATHERINE",0
.byte 0,22,"TO LURE ME HERE TO D'NI.  THEY REMOVED A",0
.byte 0,23,"PAGE FROM MY MYST BOOK SO I CAN'T RETURN",0

atrus_green_book6:
.byte 0,20,"YOU, MY FRIEND, CAN BRING THE PAGE TO ME",0
.byte 0,21,"I PRAY YOU BELIEVE MY STORY AND NOT THE",0
.byte 0,22,"LIES MY SONS HAVE TOLD. BRING THE PAGE",0
.byte 0,23,"AND BRING JUSTICE TO MY SONS. HURRY.",0

; book, 2nd time
atrus_green_book9:
.byte 0,20,"HAVE YOU FOUND THE MISSING PAGE?",0
.byte 0,21,"OH, COME, COME.  COME ON THEN.",0
.byte 0,22," ",0
.byte 0,23," ",0

atrus_green_nothing:
.byte 0,20," ",0
.byte 0,21," ",0
.byte 0,22," ",0
.byte 0,23," ",0

atrus_green_words:
.word atrus_green_nothing
.word atrus_green_book1,atrus_green_book2,atrus_green_book3
.word atrus_green_book4,atrus_green_book5,atrus_green_book6
.word atrus_green_nothing
.word atrus_green_nothing
.word atrus_green_book9
.word atrus_green_nothing


draw_atrus_book:

	; calc next frame
	lda	FRAMEH
	cmp	#$2
	bne	no_increment

	lda	GREEN_BOOK_PROGRESS
	cmp	#8
	bcs	no_increment
	cmp	#10
	bcs	no_increment

	inc	GREEN_BOOK_PROGRESS

	lda	#0
	sta	FRAMEH
	sta	FRAMEL

no_increment:

	; 0 = writing
	; 1..6 = talking
	; 7 = writing again
	; 8 = writing
	; 9 = talking
	; 10 =  writing

	; put words

	jsr	clear_bottom

	lda	GREEN_BOOK_PROGRESS
	asl
	tay
	lda	atrus_green_words,Y
	sta	OUTL
	lda	atrus_green_words+1,Y
	sta	OUTH

	lda	#$09		; ora
	sta	ps_smc1
	lda	#$80
	sta	ps_smc1+1	; set regular text

	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	lda	#$29		; and
	sta	ps_smc1
	lda	#$3f
	sta	ps_smc1+1	; restore inverse text

	; draw sprite

	lda	#22
	sta	XPOS

	lda	#12
	sta	YPOS

	lda	GREEN_BOOK_PROGRESS
	asl
	tay

	lda	atrus_green_sprites,Y
	sta	INL
	lda	atrus_green_sprites+1,Y
	sta	INH

	jsr	put_sprite_crop

	rts


atrus_book_sprites:


atrus_book_writing_sprite:
.byte	9,6
.byte	$00,$00,$00,$55,$88,$88,$88,$55,$00
.byte	$55,$00,$55,$88,$88,$88,$88,$55,$00
.byte	$55,$00,$55,$bb,$0b,$38,$38,$55,$00
.byte	$55,$f0,$ff,$bb,$33,$b0,$83,$dd,$d0
.byte	$ff,$df,$dd,$88,$38,$88,$88,$dd,$dd
.byte	$ff,$dd,$dd,$d8,$08,$08,$d0,$dd,$dd

atrus_book_talking_sprite:
.byte	9,6
.byte	$00,$00,$b8,$b8,$88,$55,$55,$55,$00
.byte	$55,$00,$bb,$bb,$bb,$55,$55,$55,$00
.byte	$55,$00,$b0,$33,$b0,$55,$55,$55,$00
.byte	$55,$f0,$8b,$38,$88,$dd,$dd,$d5,$00
.byte	$ff,$df,$08,$b8,$08,$dd,$dd,$dd,$dd
.byte	$ff,$dd,$d0,$d0,$d0,$dd,$dd,$dd,$dd

atrus_book_wait_sprite:
.byte	9,6
.byte	$00,$00,$b8,$b8,$88,$55,$55,$55,$00
.byte	$55,$00,$bb,$bb,$bb,$55,$55,$55,$00
.byte	$55,$00,$b0,$33,$b0,$55,$b5,$b5,$00
.byte	$55,$f0,$8b,$38,$88,$dd,$bb,$bb,$00
.byte	$ff,$df,$08,$b8,$08,$dd,$ff,$ff,$dd
.byte	$ff,$dd,$d0,$d0,$d0,$dd,$dd,$ff,$ff

atrus_book_glasses_sprite:
.byte	9,6
.byte	$00,$00,$80,$85,$85,$55,$55,$55,$00
.byte	$55,$00,$bb,$bb,$b8,$55,$55,$55,$00
.byte	$55,$00,$0b,$3b,$0b,$bb,$55,$55,$00
.byte	$55,$f0,$bb,$83,$8b,$bb,$bb,$f5,$00
.byte	$ff,$df,$88,$83,$88,$dd,$f8,$ff,$ff
.byte	$ff,$dd,$00,$0b,$00,$dd,$dd,$dd,$ff

atrus_book_gesturing_sprite:
.byte	9,6
.byte	$00,$00,$b8,$b8,$88,$55,$55,$55,$00
.byte	$55,$00,$bb,$bb,$bb,$55,$55,$55,$00
.byte	$55,$00,$b0,$33,$b0,$55,$55,$55,$00
.byte	$55,$f0,$8b,$38,$88,$dd,$dd,$d5,$00
.byte	$ff,$df,$08,$b8,$08,$bb,$bb,$ff,$ff
.byte	$ff,$dd,$d0,$d0,$db,$dd,$dd,$df,$df

atrus_green_sprites:
.word atrus_book_writing_sprite
.word atrus_book_wait_sprite
.word atrus_book_talking_sprite,atrus_book_glasses_sprite
.word atrus_book_talking_sprite,atrus_book_glasses_sprite
.word atrus_book_talking_sprite
.word atrus_book_writing_sprite
.word atrus_book_writing_sprite
.word atrus_book_gesturing_sprite
.word atrus_book_writing_sprite

	;==========================
	; open green book
	;    mostly has to do with getting dialog right

open_green_book:
	; start part-way through pause
	lda	#1
	sta	FRAMEH
	lda	#$80
	sta	FRAMEL		; want consistent timers


	; see if it's the first time we've opened book
	lda	GREEN_BOOK_PROGRESS
	beq	actually_open_book

	; skip to second speech if not
	lda	#8
	sta	GREEN_BOOK_PROGRESS

actually_open_book:

	lda	#DIRECTION_E|DIRECTION_SPLIT
	sta	DIRECTION

	lda	#OCTAGON_GREEN_BOOK_OPEN
	sta	LOCATION
	jmp	change_location



update_game_over:

	lda	GAME_COMPLETE
	beq	done_update

	; update background for red
	; update background for blue

	; update exit of red
	; update exit of blue

	; clear red pages
	lda	#$ff
	sta	RED_PAGES_TAKEN
	sta	BLUE_PAGES_TAKEN

	; clear blue pages

	; update green book so atrus doesn't talk
	lda	#8
	sta	GREEN_BOOK_PROGRESS

done_update:
	rts
