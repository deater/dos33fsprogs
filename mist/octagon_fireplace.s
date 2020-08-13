
; button closes/opens fireplace
; code is erased if wrong

; press it when right code, rotates to books

; atrus writing, looks up says something, back down to writing


	;============================
	; in_fireplace
	;============================
	; called when touch inside fireplace
	; if button:
	;	if at shelf, start animate back to entry
	;	if at entry, check puzzle
	;		if puzzle right, start animate to shelf
	;		if puzzle wrong, open door
	;	if not button, do the puzzle

in_fireplace:

	; first check if it's the button

	lda	CURSOR_X
	cmp	#9
	bcs	fireplace_grid

	lda	CURSOR_Y		; if too high, nothing
	cmp	#30
	bcs	done_in_fireplace

	; it's the button

	; check if pattern is right
	; it not, open door
	; if so, animate there

	lda	FIREPLACE_GRID0
	cmp	#$c0
	bne	wrong_combination
	lda	FIREPLACE_GRID1
	cmp	#$68
	bne	wrong_combination
	lda	FIREPLACE_GRID2
	cmp	#$a0
	bne	wrong_combination
	lda	FIREPLACE_GRID3
	cmp	#$90
	bne	wrong_combination
	lda	FIREPLACE_GRID4
	cmp	#$cc
	bne	wrong_combination
	lda	FIREPLACE_GRID5
	cmp	#$f8
	bne	wrong_combination

animate_there:
	lda	#1
	sta	ANIMATE_FRAME
	sta	animate_direction
	lda	#0			; reset frame count
	sta	FRAMEL

done_in_fireplace:
	rts

clear_fireplace:

	; clear it out
	lda	#$0
	sta	FIREPLACE_GRID0
	sta	FIREPLACE_GRID1
	sta	FIREPLACE_GRID2
	sta	FIREPLACE_GRID3
	sta	FIREPLACE_GRID4
	sta	FIREPLACE_GRID5

	rts

wrong_combination:

	jsr	clear_fireplace
	jmp	exit_fireplace


animate_direction:
	.byte $ff


fireplace_grid:
	lda	CURSOR_Y
	sec
	sbc	#22
	lsr
	lsr
	tay			; get Y inded

	ldx	CURSOR_X

	lda	#$80
	cpx	#14
	bcc	done_grid_a

	lda	#$40
	cpx	#17
	bcc	done_grid_a

	lda	#$20
	cpx	#20
	bcc	done_grid_a

	lda	#$10
	cpx	#23
	bcc	done_grid_a

	lda	#$08
	cpx	#26
	bcc	done_grid_a

	lda	#$04
done_grid_a:
	eor	FIREPLACE_GRID0,Y
	sta	FIREPLACE_GRID0,Y

	jsr	click_speaker

	rts

grid_sprite:
	.byte 2,2
	.byte $00,$00
	.byte $50,$50

exit_fireplace:
	lda	#OCTAGON_IN_FIREPLACE
	sta	LOCATION

	jmp	change_location

at_shelf:
	lda	#OCTAGON_FIREPLACE_SHELF
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION

	jsr	clear_fireplace

	jmp	change_location

	;============================
	; draw the fireplace puzzle
	;============================
draw_fireplace_puzzle:

	; draw animated background, if appropriate

	lda	ANIMATE_FRAME
	beq	not_animating_fireplace

	asl
	tay
	lda	fireplace_rotate_sprites,Y
	sta	INL
	lda	fireplace_rotate_sprites+1,Y
	sta	INH

	lda	#13
	sta	XPOS
	lda	#0
	sta	YPOS

	jsr	put_sprite_crop

	; adjust animated background, if appropriate

	lda	FRAMEL
	and	#$f
	bne	not_animating_fireplace

yes_animate:
	; inc/dec frame
	lda	ANIMATE_FRAME
	clc
	adc	animate_direction
	sta	ANIMATE_FRAME

	cmp	#13
	beq	at_shelf

	cmp	#0
	bne	not_animating_fireplace
	lda	animate_direction
	bpl	not_animating_fireplace

	; hit end, open door
	jmp	exit_fireplace

not_animating_fireplace:

	; draw the grid

	lda	#22
	sta	grid_ypos_smc+1
	lda	#FIREPLACE_GRID0
	sta	which_grid_smc+1

grid_loop_y:
	lda	#12
	sta	grid_xpos_smc+1
which_grid_smc:
	lda	FIREPLACE_GRID0
	sta	current_grid_val

grid_loop_x:
	lda	current_grid_val
	bpl	skip_draw_grid

grid_xpos_smc:
	lda	#12
	sta	XPOS
grid_ypos_smc:
	lda	#22
	sta	YPOS

	lda	#<grid_sprite
	sta	INL
	lda	#>grid_sprite
	sta	INH

	jsr	put_sprite_crop

skip_draw_grid:
	asl	current_grid_val	; move to next bit

	lda	grid_xpos_smc+1		; increment x by 3
	clc
	adc	#3
	sta	grid_xpos_smc+1

	cmp	#30			; stop after 6 bytes
	bne	grid_loop_x

	;

	inc	which_grid_smc+1	; point to next grid

	lda	grid_ypos_smc+1		; increment y by 4
	clc
	adc	#4
	sta	grid_ypos_smc+1

	cmp	#46			; stop after 6 bytes
	bne	grid_loop_y

	rts

current_grid_val:	.byte $00

	;============================
	; close_fireplace
	;============================
	; called when we get in and press it to close the door

close_fireplace:

	lda	#OCTAGON_IN_FIREPLACE_CLOSED
	sta	LOCATION

	lda	#DIRECTION_W|DIRECTION_ONLY_POINT
	sta	DIRECTION

	jmp	change_location


	;====================================
	; draw tiny red page if in fireplace
	;====================================

draw_in_fireplace_red_page:

	; only draw if out
	lda	RED_PAGES_TAKEN
	and	#OCTAGON_PAGE
	bne	done_ifrp

	; draw it at 11,22

	lda	DRAW_PAGE
	clc
	adc	#$5
	sta	ifrp_smc+2

	lda	#$bb
ifrp_smc:
	sta	$5a8+11

done_ifrp:
	rts



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

	lda	#$ff
	sta	animate_direction

	lda	#OCTAGON_IN_FIREPLACE_CLOSED
	sta	LOCATION

	lda	#DIRECTION_W
	sta	DIRECTION

	jsr	change_location

	; has to be after as change_location zeros it

	lda	#11
	sta	ANIMATE_FRAME

	rts

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
.byte 9,20,"WHO THE DEVIL ARE YOU?",0
.byte 2,21,"D--DON'T COME HERE TO D'NI, NOT YET.",0
.byte 0,22,"I HAVE MANY QUESTIONS FOR YOU, MY FRIEND",0
.byte 6,23,"AS YOU, NO DOUBT, HAVE FOR ME.",0

atrus_green_book2:
.byte 6,20,"PERHAPS MY STORY IS IN ORDER.",0
.byte 0,21,"I AM ATRUS; I FEAR YOU HAVE MET MY SONS,",0
.byte 11,22,"SIRRUS & ACHENAR,",0
.byte 2,23,"TRAPPED IN MY LIBRARY ON MYST ISLAND.",0

	;             1         2         3
	;   0123456789012345678901234567890123456789
atrus_green_book3:
.byte 4,20,"THAT LIBRARY CONTAINS MY WRITINGS,",0
.byte 0,21,"MY BOOKS THAT LINK TO FANTASTIC PLACES,",0
.byte 4,22,"AN ART I LEARNED FROM MY FATHER",0
.byte 15,23,"YEARS AGO.",0

atrus_green_book4:
.byte 3,20,"THE RED & BLUE BOOKS ARE DIFFERENT",0
.byte 3,21,"I WROTE THOSE TO ENTRAP OVER-GREEDY",0
.byte 1,22,"EXPLORERS THAT MIGHT STUMBLE UPON MYST",0
.byte 2,23,"I HAD NO IDEA I'D ENTRAP MY OWN SONS",0

	;             1         2         3
	;   0123456789012345678901234567890123456789
atrus_green_book5:
.byte 0,20,"I HAD NO IDEA THE EXTENT OF THEIR GREED",0
.byte 0,21,"THEY USED THEIR OWN MOTHER, MY CATHERINE",0
.byte 0,22,"TO LURE ME HERE TO D'NI.  THEY REMOVED A",0
.byte 0,23,"PAGE FROM MY MYST BOOK SO I CAN'T RETURN",0

atrus_green_book6:
.byte 0,20,"YOU, MY FRIEND, CAN BRING THE PAGE TO ME",0
.byte 0,21,"I PRAY YOU BELIEVE MY STORY AND NOT THE",0
.byte 1,22,"LIES MY SONS HAVE TOLD. BRING THE PAGE",0
.byte 2,23,"AND BRING JUSTICE TO MY SONS. HURRY.",0

	;             1         2         3
	;   0123456789012345678901234567890123456789

; book, 2nd time
atrus_green_book9:
.byte 4,20,"HAVE YOU FOUND THE MISSING PAGE?",0
.byte 5,21,"OH, COME, COME.  COME ON THEN.",0
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
	ldy	#LOCATION_WEST_BG

	lda	#<temple_center_exploded_w_lzsa
	sta	location1,Y				; OCTAGON_TEMPLE_CENTER
	lda	#>temple_center_exploded_w_lzsa
	sta	location1+1,Y				; OCTAGON_TEMPLE_CENTER

	lda	#<in_fireplace_exploded_w_lzsa
	sta	location4,Y				; OCTAGON_IN_FIREPLACE
	lda	#>in_fireplace_exploded_w_lzsa
	sta	location4+1,Y				; OCTAGON_IN_FIREPLACE

	lda	#<red_book_shelf_exploded_lzsa
	sta	location2,Y				; OCTAGON_RED_BOOK_SHELF
	lda	#>red_book_shelf_exploded_lzsa
	sta	location2+1,Y				; OCTAGON_RED_BOOK_SHELF


	; update background for blue
	ldy	#LOCATION_EAST_BG

	lda	#<temple_center_exploded_e_lzsa
	sta	location1,Y				; OCTAGON_TEMPLE_CENTER
	lda	#>temple_center_exploded_e_lzsa
	sta	location1+1,Y				; OCTAGON_TEMPLE_CENTER

	lda	#<blue_book_shelf_exploded_lzsa
	sta	location10,Y				; OCTAGON_BLUE_BOOKSHELF
	lda	#>blue_book_shelf_exploded_lzsa
	sta	location10+1,Y				; OCTAGON_BLUE_BOOKSHELF

	; disable touching red book
	; disable touching blue book

	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location2,Y				; OCTAGON_RED_BOOK_SHELF
	sta	location10,Y				; OCTAGON_BLUE_BOOKSHELF

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


fireplace_rotate_sprites:
	.word	rotate0_sprite
	.word	rotate0_sprite
	.word	rotate1_sprite
	.word	rotate2_sprite
	.word	rotate3_sprite
	.word	rotate4_sprite
	.word	rotate5_sprite
	.word	rotate6_sprite
	.word	rotate7_sprite
	.word	rotate8_sprite
	.word	rotate9_sprite
	.word	rotate10_sprite
	.word	rotate11_sprite


rotate0_sprite:
	.byte 1,1
	.byte $AA

rotate1_sprite:
	.byte 15,8
	.byte $05,$05,$05,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $80,$80,$00,$00,$88,$00,$00,$00,$00,$df,$88,$00,$df,$00,$00
	.byte $00,$00,$08,$08,$88,$00,$00,$00,$00,$00,$88,$0d,$00,$00,$80
	.byte $00,$00,$00,$00,$88,$08,$08,$08,$08,$08,$88,$08,$08,$08,$00
	.byte $00,$00,$0f,$00,$88,$80,$80,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $08,$08,$08,$08,$88,$88,$88,$00,$00,$80,$88,$80,$80,$80,$80
	.byte $99,$99,$99,$00,$88,$88,$88,$88,$08,$90,$88,$99,$90,$08,$88

rotate2_sprite:
	.byte 15,8
	.byte $00,$00,$00,$00,$88,$50,$50,$50,$50,$00,$88,$00,$00,$00,$00
	.byte $50,$50,$05,$05,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$0f
	.byte $00,$00,$00,$00,$88,$08,$08,$08,$80,$80,$88,$00,$00,$00,$80
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$08,$08,$08,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$0f,$00,$88,$00,$80,$00,$00
	.byte $00,$00,$00,$00,$88,$88,$88,$08,$08,$88,$88,$00,$88,$00,$80
	.byte $00,$00,$00,$00,$88,$00,$90,$99,$90,$00,$88,$88,$88,$88,$90

rotate3_sprite:
	.byte 15,8
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$50,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$50,$50,$05,$05,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$f0,$00,$00,$00,$88,$00,$08,$08,$08
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$08,$08,$08,$08
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$0f
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$88,$08,$08,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$88,$90,$99,$90

; *
rotate4_sprite:
	.byte 15,8
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$50
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$05,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$50,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00

rotate5_sprite:
	.byte 15,8
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00

rotate6_sprite:
	.byte 15,8
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $80,$80,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00

rotate7_sprite:
	.byte 15,8
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $88,$80,$80,$00,$88,$00,$00,$80,$80,$00,$88,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00

rotate8_sprite:
	.byte 15,8
	.byte $90,$90,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $99,$99,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $99,$99,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $99,$99,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $99,$99,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $99,$99,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $99,$99,$00,$00,$88,$00,$88,$80,$80,$00,$88,$00,$00,$80,$80
	.byte $00,$00,$00,$00,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00

rotate9_sprite:
	.byte 15,8
	.byte $50,$50,$50,$00,$88,$00,$90,$99,$00,$00,$88,$00,$00,$00,$00
	.byte $22,$55,$22,$25,$88,$50,$99,$99,$00,$00,$88,$00,$00,$00,$00
	.byte $22,$55,$22,$22,$88,$22,$99,$99,$00,$00,$88,$00,$00,$00,$00
	.byte $25,$25,$25,$52,$88,$22,$99,$99,$00,$00,$88,$00,$00,$00,$00
	.byte $44,$44,$44,$00,$88,$25,$99,$99,$00,$00,$88,$00,$00,$00,$00
	.byte $44,$44,$44,$44,$88,$22,$99,$99,$00,$00,$88,$00,$00,$00,$00
	.byte $44,$44,$44,$44,$88,$52,$99,$99,$00,$00,$88,$00,$00,$00,$00
	.byte $44,$44,$44,$44,$88,$22,$99,$99,$00,$00,$88,$00,$88,$80,$80

rotate10_sprite:
	.byte 15,8
	.byte $50,$50,$50,$50,$88,$00,$00,$00,$00,$00,$88,$00,$00,$00,$00
	.byte $22,$22,$22,$22,$88,$25,$25,$25,$25,$25,$88,$00,$00,$00,$00
	.byte $22,$22,$22,$22,$88,$22,$22,$22,$22,$22,$88,$00,$00,$00,$00
	.byte $25,$55,$25,$25,$88,$52,$52,$52,$52,$52,$88,$00,$00,$00,$00
	.byte $22,$55,$00,$44,$88,$44,$44,$00,$22,$22,$88,$00,$00,$00,$00
	.byte $52,$55,$00,$44,$88,$44,$44,$44,$22,$22,$88,$00,$00,$00,$00
	.byte $02,$02,$00,$44,$88,$44,$44,$44,$25,$25,$88,$00,$00,$00,$50
	.byte $00,$00,$00,$44,$88,$44,$44,$44,$22,$22,$88,$00,$00,$50,$55

rotate11_sprite:
	.byte 15,8
	.byte $00,$00,$88,$00,$88,$00,$00,$00,$00,$00,$88,$00,$88,$00,$00
	.byte $00,$00,$88,$25,$88,$25,$25,$22,$25,$25,$88,$25,$88,$00,$00
	.byte $00,$00,$88,$22,$88,$22,$22,$22,$22,$22,$88,$22,$88,$00,$00
	.byte $00,$00,$88,$52,$88,$52,$52,$22,$52,$52,$88,$52,$88,$00,$00
	.byte $00,$00,$88,$22,$88,$00,$44,$44,$44,$40,$88,$22,$88,$00,$00
	.byte $00,$00,$88,$22,$88,$00,$44,$44,$44,$44,$88,$22,$88,$00,$00
	.byte $80,$00,$88,$25,$88,$00,$44,$44,$44,$44,$88,$25,$88,$00,$80
	.byte $88,$00,$88,$22,$88,$00,$44,$44,$44,$44,$88,$22,$88,$00,$88


