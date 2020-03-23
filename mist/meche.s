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

	jsr	check_puzzle_solved

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
	beq	animate_meche_book
	cmp	#MECHE_ELEVATOR_ROTATE
	beq	animate_elevator_rotate
	cmp	#MECHE_ROTATE_CONTROLS
	beq	animate_rotate_controls
	cmp	#MECHE_EXIT_PUZZLE
	beq	animate_meche_puzzle
	cmp	#MECHE_MIST_OPEN
	beq	animate_mist_book

	jmp	nothing_special
animate_meche_book:

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
	jmp	nothing_special


animate_elevator_rotate:
	jsr	draw_elevator_panel
	jmp	nothing_special

animate_rotate_controls:
	jsr	draw_rotation_controls
	jmp	nothing_special

animate_meche_puzzle:
	jsr	draw_exit_puzzle_sprites
	jmp	nothing_special

animate_mist_book:
	lda	ANIMATE_FRAME
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

	.include	"meche_rotation.s"

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


