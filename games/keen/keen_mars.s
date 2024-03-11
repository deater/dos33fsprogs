; Keen MARS main map

; TODO: should make it scrollable, etc

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

keen_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	FULLGR

	jsr	clear_all	; avoid grey stripes at load

	;=====================
	; init vars
	;=====================

	lda	#0
	sta	ANIMATE_FRAME
	sta	FRAMEL
	sta	FRAMEH
	sta	DISP_PAGE
	sta	JOYSTICK_ENABLED
	sta	KEEN_WALKING
	sta	KEEN_JUMPING
	sta	LEVEL_OVER
	sta	LASER_OUT
	sta	KEEN_XL
	sta	SCORE0
	sta	SCORE1
	sta	SCORE2
	sta	KEEN_FALLING
	sta	KEEN_SHOOTING
	sta	KICK_UP_DUST
	sta	DOOR_ACTIVATED
	sta	INVENTORY

;	lda	#<enemy_data
;	sta	ENEMY_DATAL
;	lda	#>enemy_data
;	sta	ENEMY_DATAH

	; FIXME: temporary
;	lda	INVENTORY
;	ora	#INV_RED_KEY
;	sta	INVENTORY

;	lda	#$10
;	sta	SCORE0

	lda	#1
	sta	FIREPOWER

	lda	#2			; draw twice (both pages)
	sta	UPDATE_STATUS

	lda	#7
	sta	HEALTH

	lda	#4
	sta	DRAW_PAGE

	lda	#18
	sta	KEEN_X
	lda	#11
	sta	KEEN_Y

	;====================================
	; load mars background
	;====================================

	lda	#<mars_zx02
	sta	ZX0_src
	lda	#>mars_zx02
	sta	ZX0_src+1

	lda	#$c    ; load to page $c00

	jsr	full_decomp



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

	;===========================
	; check end of level
	;===========================

	lda	LEVEL_OVER
	beq	do_keen_loop

	jmp	done_with_keen




do_keen_loop:

	; delay
;	lda	#200
;	jsr	WAIT

	jmp	keen_loop


done_with_keen:
	bit	KEYRESET	; clear keypress


        lda     #LOAD_KEEN1
        sta     WHICH_LOAD

	rts			; exit back


	;==========================
	; includes
	;==========================

	; level graphics

mars_zx02:
	.incbin	"maps/mars_map.gr.zx02"

	.include	"text_print.s"
	.include	"gr_offsets.s"
	.include	"gr_fast_clear.s"
	.include	"gr_copy.s"
	.include	"gr_pageflip.s"
;	.include	"gr_putsprite_crop.s"
	.include	"zx02_optim.s"

;	.include	"status_bar.s"
;	.include	"keyboard.s"
	.include	"joystick.s"

	.include	"text_drawbox.s"
	.include	"print_help.s"
	.include	"quit_yn.s"
;	.include	"level_end.s"

	.include	"sound_effects.s"
	.include	"speaker_tone.s"



	;=========================
	; draw keen
	;=========================
	; D32
draw_keen:

	lda	KEEN_Y
	and	#1
	bne	draw_keen_odd

draw_keen_odd:


draw_keen_even:
	lda	KEEN_Y
	and	#$FE
	tay
	lda	gr_offsets,Y
	sta	OUTL
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH

	ldy	KEEN_X
	lda	#$3D
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
;	lda	KEEN_DIRECTION
;	cmp	#$ff			; check if facing left
;	bne	face_left

;	lda	#1
;	sta	KEEN_WALKING
	dec	KEEN_X
done_left_pressed:
	jmp	done_keypress

check_right:
	cmp	#'D'
	beq	right_pressed
	cmp	#$15			; right key
	bne	check_up

right_pressed:
	inc	KEEN_X
done_right_pressed:
	jmp	done_keypress

check_up:
	cmp	#'W'
	beq	up_pressed
	cmp	#$0B			; up key
	bne	check_down

up_pressed:
	dec	KEEN_Y
done_up_pressed:
	jmp	done_keypress

check_down:
	cmp	#'S'
	beq	down_pressed
	cmp	#$0A
	bne	check_space
down_pressed:

	inc	KEEN_Y
done_down_pressed:
	jmp	done_keypress

check_space:
	cmp	#' '
	bne	check_return
space_pressed:


;	lda	KEEN_JUMPING
;	bne	done_keypress	; don't jump if already jumping

	inc	LEVEL_OVER

	jmp	done_keypress

check_return:
	cmp	#13
	bne	check_escape

return_pressed:
	inc	LEVEL_OVER

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
