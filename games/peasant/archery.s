; Peasant's Quest

; Archery Minigame

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"
.include "parse_input.inc"

LOCATION_BASE	= LOCATION_ARCHERY ; (28)

archery:
	lda	#0
	sta	LEVEL_OVER
	sta	FRAME

	jsr	hgr_make_tables
	jsr	hgr2

	;=============================
	;=============================
	; new screen location
	;=============================
	;=============================

new_location:
	lda	#0
	sta	LEVEL_OVER

	;=====================
	; load bg

	lda     MAP_LOCATION
	sec
	sbc     #LOCATION_BASE
	tax

	lda	#<target_zx02
	sta	zx_src_l+1
	lda	#>target_zx02
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp

	; put peasant text

;	lda	#<peasant_text
;	sta	OUTL
;	lda	#>peasant_text
;	sta	OUTH

;	jsr	hgr_put_string

	; put score

;	jsr	print_score

	;=====================
	; move peasant
	; FIXME: don't do this if loading game

;	lda	#20
;	sta	PEASANT_X
;	lda	#150
;	sta	PEASANT_Y

	;====================
	; save background

;	lda	PEASANT_X
;	sta	CURSOR_X
;	lda	PEASANT_Y
;	sta	CURSOR_Y

	;=======================
	; draw initial peasant

;	jsr	save_bg_1x28

;	jsr	draw_peasant

game_loop:

;	jsr	move_peasant

	inc	FRAME

	bit	KEYRESET

	jsr	wait_until_keypress

;	lda	#$30		; got 0 of 3
;	lda	#$31		; got 1 of 3
	lda	#$33		; got 3 of 3
	sta	ARROW_SCORE

	lda	ARROW_SCORE
	ora	#ARROW_DONE
	sta	ARROW_SCORE

	lda	#LOCATION_ARCHERY
	jmp	update_map_location



;	jsr	check_keyboard

;	lda	LEVEL_OVER
;	bmi	oops_new_location
;	bne	game_over


	; delay

;	lda	#200
;	jsr	wait


;	jmp	game_loop

;oops_new_location:
;	jmp	new_location


	;************************
	; exit level
	;************************
game_over:
	lda	ARROW_SCORE
	ora	#ARROW_DONE
	sta	ARROW_SCORE

	rts




;.include "draw_peasant.s"

;.include "gr_copy.s"

.include "new_map_location.s"

;.include "peasant_move.s"

;.include "score.s"

;.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "graphics_archery/archery_graphics.inc"


