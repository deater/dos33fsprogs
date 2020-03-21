; Mechanical Engineer (meche) island

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

meche_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	FULLGR

	lda	#0
	sta	DRAW_PAGE
	sta	LEVEL_OVER

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

	jsr	adjust_basement_door

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
	cmp	#MECHE_OPEN_BOOK
	bne	nothing_special

	; handle animated linking book

	lda	ANIMATE_FRAME
	asl
	tay
	lda	meche_movie,Y
	sta	INL
	lda	meche_movie+1,Y
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
	cmp	#11
	bne	done_animate_book
	lda	#0
	sta	ANIMATE_FRAME

done_animate_book:

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


	;==================================
	; elevator stuff
	;==================================

basement_button:

	; flip switch

	lda	#$80
	eor	MECHE_ELEVATOR
	sta	MECHE_ELEVATOR

	jsr	adjust_basement_door

	jsr	change_location

	rts


adjust_basement_door:

	lda	MECHE_ELEVATOR
	bmi	floor_open


floor_closed:
	jmp	floor_closed_elevator_off

floor_open:
	jmp	floor_open_elevator_off

floor_open_elevator_on:

floor_open_elevator_off:

	ldy	#LOCATION_WEST_EXIT
	lda	#MECHE_BASEMENT
	sta	location18,Y

	ldy	#LOCATION_WEST_BG

	lda	#<red_button_of_ce_w_lzsa
	sta	location18,Y
	lda	#>red_button_of_ce_w_lzsa
	jmp	adjust_basement_door_done

floor_closed_elevator_on:

floor_closed_elevator_off:

	ldy	#LOCATION_WEST_EXIT
	lda	#$ff
	sta	location18,Y

	ldy	#LOCATION_WEST_BG

	lda	#<red_button_cf_ce_w_lzsa
	sta	location18,Y
	lda	#>red_button_cf_ce_w_lzsa
	jmp	adjust_basement_door_done


adjust_basement_door_done:
	sta	location18+1,Y
	rts

adjust_fortress_rotation:

	rts



	;==========================
	; includes
	;==========================

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

	.include	"graphics_meche/meche_graphics.inc"


	; puzzles

	; linking books

	.include	"link_book_meche.s"
	.include	"link_book_mist.s"

	.include	"common_sprites.inc"

	.include	"leveldata_meche.inc"





;.align $100
;audio_link_noise:
;.incbin "audio/link_noise.btc"


