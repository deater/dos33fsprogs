; The Stone Ship level

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "common_routines.inc"

stoney_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	FULLGR

	;=================
	; set up location
	;=================

	lda	#<locations
	sta	LOCATIONS_L
	lda	#>locations
	sta	LOCATIONS_H


	lda	#0
	sta	DRAW_PAGE
	sta	LEVEL_OVER

	; resets if you leave
	sta	BATTERY_CHARGE

	; init cursor

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	; set up initial location

	jsr	change_location

	lda	#1
	sta	CURSOR_VISIBLE		; visible at first

	lda	#0
	sta	ANIMATE_FRAME

	; FIXME
	; handle gear visibility

game_loop:
	;=================
	; reset things
	;=================

	lda	#0
	sta	IN_SPECIAL
	sta	IN_RIGHT
	sta	IN_LEFT

	;====================================
	; copy background to current page
	;====================================

	jsr	gr_copy_to_current

	;====================================
	; handle special-case forground logic
	;====================================

	lda	LOCATION
	cmp	#STONEY_SHIP_BOOK_OPEN
	beq	animate_stoney_book
	cmp	#STONEY_BOOK_TABLE_OPEN
	beq	animate_mist_book
	cmp	#STONEY_RED_DRESSER_OPEN
	beq	fg_draw_red_page
	cmp	#STONEY_BLUE_ROOM
	beq	fg_draw_blue_page
	cmp	#STONEY_UMBRELLA
	beq	draw_umbrella_light
	cmp	#STONEY_LIGHTHOUSE_UPSTAIRS
	beq	draw_crank_handle
	cmp	#STONEY_LIGHTHOUSE_BATTERY
	beq	draw_battery_level
	cmp	#STONEY_BOOK_TABLE
	beq	animate_magic_table

	jmp	nothing_special

animate_stoney_book:

	jsr	do_animate_stoney_book
	jmp	nothing_special

animate_magic_table:

	jsr	do_animate_magic_table
	jmp	nothing_special

animate_mist_book:
	lda     ANIMATE_FRAME
	cmp	#6
	bcc	mist_book_good			; blt

	lda	#0
	sta	ANIMATE_FRAME

mist_book_good:

	asl
	tay
	lda	mist_movie,Y
	sta	INL
	lda	mist_movie+1,Y
	sta	INH

	lda	#24
	sta	XPOS
	lda	#12
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$f
	bne	done_animate_mist_book

	inc	ANIMATE_FRAME

done_animate_mist_book:
	jmp	nothing_special

fg_draw_red_page:
	jsr	draw_red_page
	jmp	nothing_special

fg_draw_blue_page:
	jsr     draw_blue_page
	jmp     nothing_special

draw_umbrella_light:
	jsr	do_draw_umbrella_light
	jmp	nothing_special

draw_crank_handle:
	jsr	do_draw_crank_handle
	jmp	nothing_special

draw_battery_level:
	jsr	do_draw_battery_level
	jmp	nothing_special


nothing_special:

	;====================================
	; draw pointer
	;====================================

	jsr	draw_pointer

	;====================================
	; page flip
	;====================================

	jsr	page_flip

	;====================================
	; handle keypress/joystick
	;====================================

	jsr	handle_keypress


	;====================================
	; inc frame count
	;====================================

	inc	FRAMEL
	bne	room_frame_no_oflo
	inc	FRAMEH
room_frame_no_oflo:

	;====================================
	; check level over
	;====================================

	lda	LEVEL_OVER
	bne	really_exit
	jmp	game_loop

really_exit:
	jmp	end_level



back_to_mist:

	lda	#$ff
	sta	LEVEL_OVER

	lda     #MIST_ARRIVAL_DOCK		; the dock
	sta	LOCATION
	lda	#DIRECTION_N
	sta	DIRECTION

	lda	#LOAD_MIST
	sta	WHICH_LOAD

	rts


stoney_take_red_page:
	lda	#STONEY_PAGE
	jmp	take_red_page

stoney_take_blue_page:
	lda	#STONEY_PAGE
	jmp	take_blue_page


	;=============================
draw_red_page:

	lda     RED_PAGES_TAKEN
	and	#STONEY_PAGE
	bne	no_draw_page

	lda	#14
	sta	XPOS
	lda	#36
	sta	YPOS

	lda	#<red_page_sprite
	sta	INL
	lda	#>red_page_sprite
	sta	INH

	jmp	put_sprite_crop		; tail call

draw_blue_page:

	lda	DIRECTION
	cmp	#DIRECTION_W
	bne	no_draw_page

	lda	BLUE_PAGES_TAKEN
	and	#STONEY_PAGE
	bne	no_draw_page

	lda	#18
	sta	XPOS
	lda	#30
	sta	YPOS

	lda	#<blue_page_sprite
	sta	INL
	lda	#>blue_page_sprite
	sta	INH

	jmp	put_sprite_crop         ; tail call

no_draw_page:
	rts

	;======================
	; handle half message
stoney_half_message:

	lda	#STONEY_BLUE_HALFMESSAGE
	sta	LOCATION

	jsr	change_location

	bit	SET_TEXT		; set text mode

	rts

	;======================
	; handle umbrella pump buttons

umbrella_buttons:

	lda	CURSOR_X
	cmp	#15
	bcc	left_button_pressed
	cmp	#19
	bcc	center_button_pressed

right_button_pressed:
	; drain lighthouse

	lda	#2
	bne	done_umbrella
left_button_pressed:
	; drain mist tunnel
	lda	#0
	beq	done_umbrella

center_button_pressed:
	; drain room tunnels
	lda	#1

done_umbrella:
	sta	PUMP_STATE
	rts


	;========================
	; handle generator crank
handle_crank:

	inc	CRANK_ANGLE
	lda	CRANK_ANGLE
	and	#$3
	sta	CRANK_ANGLE

	lda	BATTERY_CHARGE
	cmp	#7
	beq	skip_charge

	inc	BATTERY_CHARGE
skip_charge:

	rts


do_draw_umbrella_light:
	lda	DIRECTION
	cmp	#DIRECTION_W
	bne	done_draw_umbrella

	lda	PUMP_STATE
	asl
	asl		; *4
	tay

	lda	#$99	; orange

	sta	$528+15,Y	; page 0
	sta	$928+15,Y	; page 1
			; 15,20
			; 19,20
			; 23,20
done_draw_umbrella:
	rts


do_draw_crank_handle:

	lda	DIRECTION
	cmp	#DIRECTION_W
	bne	done_draw_it

	lda	CRANK_ANGLE
	asl
	tay
	lda	crank_sprites,Y
	sta	INL
	lda	crank_sprites+1,Y
	sta	INH

	lda	#17
	sta	XPOS
	lda	#32
	bne	draw_it

do_draw_battery_level:

	lda	BATTERY_CHARGE
	and	#7
	asl
	tay
	lda	battery_sprites,Y
	sta	INL
	lda	battery_sprites+1,Y
	sta	INH

	lda	#16
	sta	XPOS
	lda	#20
;	bne	draw_it

draw_it:
	sta	YPOS
	jsr	put_sprite_crop
done_draw_it:
	rts


do_animate_stoney_book:

	; handle animated linking book

	lda	ANIMATE_FRAME
	asl
	tay
	lda	stoney_movie,Y
	sta	INL
	lda	stoney_movie+1,Y
	sta	INH

	lda	#22
	sta	XPOS
	lda	#12
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$f
	bne	done_animate_book

	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME
	cmp	#16
	bne	done_animate_book
	lda	#0
	sta	ANIMATE_FRAME
done_animate_book:
	rts



do_animate_magic_table:

	; handle book rising from table

	lda	ANIMATE_FRAME
	asl
	tay
	lda	table_movie,Y
	sta	INL
	lda	table_movie+1,Y
	sta	INH

	lda	#18
	sta	XPOS
	lda	#14
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$1f
	bne	done_animate_table

	lda	ANIMATE_FRAME
	cmp	#4
	beq	done_animate_table

	inc	ANIMATE_FRAME
done_animate_table:
	rts




crank_sprites:
	.word crank_sprite0,crank_sprite1,crank_sprite2,crank_sprite3

battery_sprites:
	.word battery_sprite0,battery_sprite1,battery_sprite2,battery_sprite3
	.word battery_sprite4,battery_sprite5,battery_sprite6,battery_sprite7

table_movie:
	.word	table_frame0,table_frame1,table_frame2,table_frame3
	.word	table_frame4

table_frame0:
	.byte 5,5
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$dA,$dA,$dA,$dA

table_frame1:
	.byte 5,5
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $dA,$Ad,$dA,$dA,$dA
	.byte $dd,$Ad,$Ad,$Ad,$Ad

table_frame2:
	.byte 5,5
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $Ad,$dd,$dd,$dd,$dd
	.byte $da,$dd,$77,$7d,$da
	.byte $dd,$dd,$77,$dd,$Ad

table_frame3:
	.byte 5,5
	.byte $AA,$dA,$dA,$da,$da
	.byte $AA,$dd,$dd,$dd,$dd
	.byte $AA,$dd,$dd,$dd,$dd
	.byte $AA,$dd,$dd,$dd,$dd
	.byte $AA,$dd,$dd,$dd,$dd

table_frame4:
	.byte 5,5
	.byte $AA,$07,$d7,$d7,$07
	.byte $AA,$00,$dd,$dd,$dd
	.byte $AA,$00,$d5,$d5,$dd
	.byte $AA,$00,$dd,$dd,$dd
	.byte $AA,$00,$dd,$dd,$0d



crank_sprite0:
	.byte 5,5
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$dd,$AA,$AA
	.byte $AA,$AA,$dd,$AA,$AA
	.byte $AA,$11,$AA,$AA,$AA

crank_sprite1:
	.byte 5,5
	.byte $1A,$AA,$AA,$AA,$AA
	.byte $A1,$dA,$dA,$AA,$AA
	.byte $AA,$AA,$ad,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA

crank_sprite2:
	.byte 5,5
	.byte $AA,$AA,$AA,$dA,$11
	.byte $AA,$AA,$dA,$AA,$AA
	.byte $AA,$AA,$Ad,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA

crank_sprite3:
	.byte 5,5
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$Ad,$AA,$AA
	.byte $AA,$AA,$AA,$dA,$1d
	.byte $AA,$AA,$AA,$A1,$AA

battery_sprite0:
	.byte 1,7
	.byte $51,$AA,$AA,$AA,$AA,$AA,$AA

battery_sprite1:
	.byte 1,7
	.byte $51,$AA,$AA,$AA,$AA,$AA,$FF

battery_sprite2:
	.byte 1,7
	.byte $51,$AA,$AA,$AA,$AA,$FF,$FF

battery_sprite3:
	.byte 1,7
	.byte $51,$AA,$AA,$AA,$FF,$FF,$FF

battery_sprite4:
	.byte 1,7
	.byte $51,$AA,$AA,$FF,$FF,$FF,$FF

battery_sprite5:
	.byte 1,7
	.byte $51,$AA,$FF,$FF,$FF,$FF,$FF

battery_sprite6:
	.byte 1,7
	.byte $51,$FF,$FF,$FF,$FF,$FF,$FF

battery_sprite7:
	.byte 1,7
	.byte $5c,$FF,$FF,$FF,$FF,$FF,$FF



	;==========================
	; includes
	;==========================
.if 0
	.include	"gr_copy.s"
	.include	"gr_offsets.s"
	.include	"gr_pageflip.s"
	.include	"gr_putsprite_crop.s"
	.include	"text_print.s"
	.include	"gr_fast_clear.s"
	.include	"decompress_fast_v2.s"
	.include	"keyboard.s"
	.include	"draw_pointer.s"
	.include	"end_level.s"
	.include	"audio.s"
	.include	"common_sprites.inc"
	.include	"page_sprites.inc"

.endif

	; level graphics
	.include	"graphics_stoney/stoney_graphics.inc"

	; linking books
	.include	"link_book_stoney.s"
	.include	"link_book_mist.s"

	; puzzles
	.include	"handle_pages.s"

	; level data
	.include	"leveldata_stoney.inc"
