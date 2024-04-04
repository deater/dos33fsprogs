; Keen MARS main map

; TODO: should make it scrollable, etc / tilemap
; TODO: fade in effect (from mode7 demo)

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

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
	bmi	return_to_title

	;=====================
	; init vars
	;=====================

	lda	#0
	sta	ANIMATE_FRAME
	sta	FRAMEL
	sta	FRAMEH

	sta	KEEN_WALKING
	sta	KEEN_JUMPING
	sta	LEVEL_OVER
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

	;====================================
	; load mars background
	;====================================

	lda	#<mars_zx02
	sta	ZX0_src
	lda	#>mars_zx02
	sta	ZX0_src+1

	lda	#$c    ; load to page $c00

	jsr	full_decomp


	lda	#1
	sta	INITIAL_SOUND

	jsr	fade_in

	;====================================
	;====================================
	; Main loop
	;====================================
	;====================================

keen_loop:

	; copy over background

	jsr	gr_copy_to_current

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


do_keen_loop:

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

	jmp	keen_loop


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

	lda	#LOAD_TITLE
	sta	WHICH_LOAD

	rts




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


	.include	"mars_sfx.s"
	.include	"longer_sound.s"



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




	;==============================
	; Handle Keypress
	;==============================
handle_keypress:

	; first handle joystick
	lda	JOYSTICK_ENABLED
	beq	actually_handle_keypress

	; only check joystick every-other frame
	lda	FRAMEL
	and	#$1
	beq	actually_handle_keypress

check_button:
        lda     PADDLE_BUTTON0
        bpl     button_clear

        lda     JS_BUTTON_STATE
        bne     js_check

        lda     #1
        sta     JS_BUTTON_STATE
        lda     #' '
        jmp     check_sound

button_clear:
        lda     #0
        sta     JS_BUTTON_STATE

js_check:
        jsr     handle_joystick

js_check_left:
        lda     value0
        cmp     #$20
        bcs     js_check_right  ; if less than 32, left
        lda     #'A'
        bne     check_sound

js_check_right:
        cmp     #$40
        bcc     js_check_up
        lda     #'D'
        bne     check_sound

js_check_up:
        lda     value1
        cmp     #$20
        bcs     js_check_down
        lda     #'W'

        bne     check_sound

js_check_down:
        cmp     #$40
        bcc     done_joystick
        lda     #'S'
        bne     check_sound


done_joystick:



actually_handle_keypress:
	lda	KEYPRESS
	bmi	keypress

	jmp	no_keypress

keypress:
	and	#$7f			; clear high bit
	cmp	#' '
	beq	check_sound		; make sure not to lose space
	and	#$df			; convert uppercase to lower case

check_sound:
	cmp	#$14			; control-T
	bne	check_help

	lda	SOUND_STATUS
	eor	#SOUND_DISABLED
	sta	SOUND_STATUS
	jmp	done_keypress

check_help:
	cmp	#'H'			; H (^H is same as left)
	bne	check_joystick

	jsr	print_help
	jmp	done_keypress

	; can't be ^J as that's the same as down
check_joystick:
	cmp	#'J'			; J
	bne	check_left

	lda	JOYSTICK_ENABLED
	eor	#1
	sta	JOYSTICK_ENABLED
	jmp	done_keypress

check_left:
	cmp	#'A'
	beq	left_pressed
	cmp	#8			; left key
	bne	check_right

left_pressed:
	ldy	MARS_X
	dey
	ldx	MARS_Y
	jsr	check_valid_feet
	bcc	done_left_pressed
	dec	MARS_X
done_left_pressed:
	jmp	done_keypress

check_right:
	cmp	#'D'
	beq	right_pressed
	cmp	#$15			; right key
	bne	check_up

right_pressed:
	ldy	MARS_X
	iny
	ldx	MARS_Y
	jsr	check_valid_feet
	bcc	done_right_pressed
	inc	MARS_X
done_right_pressed:
	jmp	done_keypress

check_up:
	cmp	#'W'
	beq	up_pressed
	cmp	#$0B			; up key
	bne	check_down

up_pressed:
	ldy	MARS_X
	ldx	MARS_Y
	dex
	jsr	check_valid_feet
	bcc	done_up_pressed
	dec	MARS_Y
done_up_pressed:
	jmp	done_keypress

check_down:
	cmp	#'S'
	beq	down_pressed
	cmp	#$0A
	bne	check_space
down_pressed:
	ldy	MARS_X
	ldx	MARS_Y
	inx
	jsr	check_valid_feet
	bcc	done_up_pressed
	inc	MARS_Y
done_down_pressed:
	jmp	done_keypress

check_space:
	cmp	#' '
	bne	check_return
space_pressed:

	jsr	do_action

	jmp	done_keypress

check_return:
	cmp	#13
	bne	check_escape

return_pressed:
	;inc	LEVEL_OVER

	jsr	do_action

done_return:
	jmp	no_keypress

check_escape:
	cmp	#27
	bne	done_keypress

	jsr	print_quit

	jmp	done_keypress



done_keypress:
no_keypress:
	bit	KEYRESET
	rts



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
	clc
	rts





	;====================================
	; show parts screen
	;====================================
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

	lda	#<mars_zx02
	sta	ZX0_src
	lda	#>mars_zx02
	sta	ZX0_src+1

	lda	#$c    ; load to page $c00

	jsr	full_decomp	; tail call

	rts


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
