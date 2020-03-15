; Selenitic (selena) island

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


selena_start:
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

	; init cursor

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	;=================
	; init vars
	;	FIXME: we could be re-called from other books
	;	so don't set location here

	lda	#0
	sta	LOCATION
	lda	#DIRECTION_E
	sta	DIRECTION


	lda	LOCATION
	bne	not_first_time

not_first_time:


	; set up initial location

	jsr	change_location

	lda	#1
	sta	CURSOR_VISIBLE		; visible at first

	lda	#0
	sta	ANIMATE_FRAME


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
	cmp	#1
	bne	nothing_special

	; draw the buttons
	jsr	spaceship_draw_buttons

	; handle animated linking book

	lda	ANIMATE_FRAME
	beq	nothing_special

	asl
	tay
	lda	selena_movie,Y
	sta	INL
	lda	selena_movie+1,Y
	sta	INH

	lda	#17
	sta	XPOS
	lda	#4
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$f
	bne	done_animate_book

	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME

animate_check_high:
	cmp	#23
	bne	animate_check_low
	lda	#13
	sta	ANIMATE_FRAME
	bne	done_animate_book		; bra

animate_check_low:
	cmp	#13
	bne	done_animate_book
	lda	#9
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

	jmp	game_loop


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

	.include	"audio.s"

	.include	"graphics_selena/selena_graphics.inc"


	; puzzles
	.include	"organ_puzzle.s"


	; linking books

	.include	"link_book_selena.s"

	.include	"common_sprites.inc"

	.include	"leveldata_selena.inc"

	.include	"speaker_beeps.s"



;.align $100
audio_link_noise:
.incbin "audio/link_noise.btc"


