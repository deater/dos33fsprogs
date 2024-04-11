; Keen MARS main map
;
; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"


; or are there?
NUM_ENEMIES = 0
TILE_COLS = 20		; define this elsewhere?

mars_start:
	;===================
	; init screen
;	jsr	TEXT
;	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE1
	bit	LORES
	bit	FULLGR

	jsr	clear_all	; avoid grey stripes at load

	lda	KEENS
	bpl	plenty_of_keens

	jmp	return_to_title

plenty_of_keens:

	;=====================
	; init vars
	;=====================

	lda	#0
	sta	ANIMATE_FRAME
	sta	FRAMEL
	sta	FRAMEH

	sta	KEEN_WALKING
	sta	KEEN_JUMPING
;	sta	LEVEL_OVER
	sta	LASER_OUT
	sta	KEEN_XL
	sta	KEEN_FALLING
	sta	KEEN_SHOOTING


	lda	#4
	sta	DRAW_PAGE

;	lda	#18
;	sta	KEEN_X
;	lda	#11
;	sta	KEEN_Y

	; see if returning and it game over

	lda	LEVEL_OVER
	cmp	#GAME_OVER
	beq	return_to_title


	; TODO: set this in title, don't over-write

	lda	#1
	sta	MARS_TILEX
	lda	#6
	sta	MARS_TILEY

	lda	#0
	sta	MARS_X
	sta	MARS_Y

	;====================================
	; load mars tilemap
	;====================================

	lda	#<mars_data_zx02
	sta	ZX0_src
	lda	#>mars_data_zx02
	sta	ZX0_src+1
	lda	#$90			; load to page $9000
	jsr	full_decomp


	;====================================
	; copy in tilemap subset
	;====================================
	; FIXME: start values
	;	center around MARS_TILEX, MARS_TILEY

	lda	MARS_TILEX
	sta	TILEMAP_X
	lda	MARS_TILEY
	sta	TILEMAP_Y

	jsr	copy_tilemap_subset




	lda	#1
	sta	INITIAL_SOUND

	jsr	fade_in

	lda	#0
	sta	LEVEL_OVER

	;====================================
	;====================================
	; Main loop
	;====================================
	;====================================

mars_loop:
	; draw tilemap

	jsr	draw_tilemap

	; draw keen

	jsr	draw_keen

	jsr	page_flip

	jsr	handle_keypress

;	jsr	move_keen

	;========================
	; increment frame count
	;========================

	inc	FRAMEL
	bne	no_frame_oflo
	inc	FRAMEH
no_frame_oflo:

	lda	FRAMEL
	lsr
	lsr
	lsr
	and	#$7
	tay
	lda	star_colors,Y
	sta	$F28			; 0,28

	;===========================
	; check end of level
	;===========================

	lda	LEVEL_OVER
	bne	done_with_keen


do_mars_loop:

	;=====================
	; sound effect
	;=====================

	lda	INITIAL_SOUND
	beq	skip_initial_sound

	ldy	#SFX_KEENSLEFT
	jsr	play_sfx
	dec	INITIAL_SOUND

skip_initial_sound:

	; delay
;	lda	#200
;	jsr	WAIT

	jmp	mars_loop


done_with_keen:
	cmp	#GAME_OVER
	beq	return_to_title

	; else, start level

	bit	KEYRESET	; clear keypress

	; sound effect

	ldy	#SFX_WLDENTRSND
	jsr	play_sfx

	jsr	fade_out

        lda     #LOAD_KEEN1
        sta     WHICH_LOAD

	rts			; exit back


return_to_title:

	jsr	game_over

;	ldy	#SFX_GAMEOVERSND
;	jsr	play_sfx



	lda	#LOAD_TITLE
	sta	WHICH_LOAD

	rts





	;=========================
	; draw keen
	;=========================
	; D32
draw_keen:

	lda	MARS_Y
	and	#1
	beq	draw_keen_even

draw_keen_odd:

	; calculate address of MARS_Y/2

	lda	MARS_Y
	and	#$FE
	tay
	lda	gr_offsets,Y
	sta	OUTL
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH

	ldy	MARS_X

	lda	(OUTL),Y
	and	#$0f
	ora	#$D0
	sta	(OUTL),Y

	lda	MARS_Y
	clc
	adc	#2

	and	#$FE
	tay
	lda	gr_offsets,Y
	sta	OUTL
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH

	ldy	MARS_X

	lda	#$23
	sta	(OUTL),Y

	rts



draw_keen_even:

	lda	MARS_Y
;	and	#$FE		; no need to mask, know bottom bit is 0
	tay
	lda	gr_offsets,Y
	sta	OUTL
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH
	ldy	MARS_X		; adjust with Xpos

	lda	#$3D
	sta	(OUTL),Y

	lda	MARS_Y
	clc
	adc	#2
;	and	#$FE		; no need to mask
	tay
	lda	gr_offsets,Y
	sta	OUTL
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH
	ldy	MARS_X		; adjust with Xpos

	lda	(OUTL),Y
	and	#$F0
	ora	#$02
	sta	(OUTL),Y

	rts


	;=================================
	;=================================
	; check valid feet
	;=================================
	;=================================
	; essentially if SCRN(Y,X+2)=9
check_valid_feet:
	txa
	ror
	bcc	feet_mask_odd
feet_mask_even:
	lda	#$F0
	bne	feet_mask_done		; bra
feet_mask_odd:
	lda	#$0F
feet_mask_done:
	sta	feet_mask_smc+1

	txa
	clc
	adc	#2
	and	#$FE
	tax
	lda	gr_offsets,X
	sta	OUTL
	lda	gr_offsets+1,X
	clc
	adc	#$8		; into $C00 page (bg lives here)
	sta	OUTH

	lda	(OUTL),Y
	eor	#$99
feet_mask_smc:
	and	#$F0
	beq	feet_valid
	bne	feet_invalid

feet_valid:
	sec
	rts
feet_invalid:
;	clc
	sec
	rts





	;====================================
	;====================================
	; show parts screen
	;====================================
	;====================================
	; TODO: color in if found
do_parts:
	lda	#<parts_zx02
	sta	ZX0_src
	lda	#>parts_zx02
	sta	ZX0_src+1

	lda	#$c    ; load to page $c00

	jsr	full_decomp

	jsr	gr_copy_to_current

	jsr	page_flip

	bit	TEXTGR

	bit	KEYRESET
parts_loop:
	lda	KEYPRESS
	bpl	parts_loop

done_parts:
	bit	KEYRESET

	bit	FULLGR

;	lda	#<mars_zx02
;	sta	ZX0_src
;	lda	#>mars_zx02
;	sta	ZX0_src+1

;	lda	#$c    ; load to page $c00

;	jsr	full_decomp	; tail call

	rts

	;====================================
	;====================================
	; Mars action
	;====================================
	;====================================
	; if enter pressed on map
do_action:

	lda	MARS_X
	cmp	#15
	bcc	do_nothing	; blt

	cmp	#20
	bcc	maybe_ship

	cmp	#35
	bcs	maybe_exit

do_nothing:
	; TODO: make sound?
	rts

maybe_ship:


	lda	MARS_Y
	cmp	#16
	bcc	do_nothing
	cmp	#24
	bcs	do_nothing

	jmp	do_parts	; tail call

maybe_exit:

	inc	LEVEL_OVER

	rts



star_colors:
	.byte $05,$07,$07,$0f
	.byte $0f,$07,$05,$0a




	;==========================
	; includes
	;==========================

	; level graphics

mars_zx02:
	.incbin	"maps/mars_map.gr.zx02"
parts_zx02:
	.incbin	"graphics/parts.gr.zx02"

	.include	"text_print.s"
	.include	"gr_offsets.s"
	.include	"gr_fast_clear.s"
	.include	"gr_copy.s"
	.include	"gr_pageflip.s"
;	.include	"gr_putsprite_crop.s"
	.include	"zx02_optim.s"
	.include	"gr_fade.s"

	.include	"joystick.s"

	.include	"text_drawbox.s"
	.include	"text_help.s"
	.include	"text_quit_yn.s"
	.include	"game_over.s"
	.include	"mars_keyboard.s"
	.include	"draw_tilemap.s"

	.include	"mars_sfx.s"
	.include	"longer_sound.s"


mars_data_zx02:
	.incbin	"maps/mars_new.zx02"

	; dummy
enemy_data_out:
enemy_data_tilex:
