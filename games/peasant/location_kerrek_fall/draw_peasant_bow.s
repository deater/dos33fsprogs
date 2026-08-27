	;================================
	;================================
	;================================
	; shoot the bow / hit the kerrek
	;================================
	;================================
	;================================

PEASANT_MAX_BOW = 16+37

;===============================================
; peasant progress
;===============================================

peasant_bow_progress:
.byte	0			; 455
.byte	1			; 456
.byte	2			; 457
.byte	3			; 458 (arrow out)
.byte	4			; 459 (arrow up)
.byte	5			; 460
; missing?			; 461 (start draw)
.byte	6			; 462
.byte	7,7,7,7,7,7		; 463,464,465,466,467,468
.byte	8,8,8			; 469 (release)
.byte	0			; 471 back to orig

peasant_bow_offset_x_left:
.byte $ff,$ff,$ff,$ff,	$ff,$fe,$fe,$fe, $ff

peasant_bow_offset_x_right:
.byte $0,$0,$0,$0,	$0,$0,$0,$0, $0

;peasant_bow_offset_y:
;.byte 0,0,0,0,	0,0,0,0, 0



;===============================
;===============================
; actual code
;===============================
;===============================

draw_peasant_bow:

	lda	#0
	sta	PEASANT_BOW_COUNT

	lda	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

draw_peasant_bow_loop:

	jsr	kerrek_move		; walk during first part

	jsr	update_screen

	;==============================
	; next draw appropriate frame

	ldy	PEASANT_BOW_COUNT
	cpy	#16
	bcc	bow_count_less_than_16

	ldy	#16			; force to 16 if higher

bow_count_less_than_16:

	lda	peasant_bow_progress,Y
	tay

	; adjust for left/right

	lda	PEASANT_X
	cmp	KERREK_X
	bcs	adjust_shooter_left

adjust_shooter_right:

	clc
	lda	PEASANT_X
	adc	peasant_bow_offset_x_right,Y
	jmp	adjust_shooter_common

adjust_shooter_left:

	clc
	lda	PEASANT_X
	adc	peasant_bow_offset_x_left,Y

adjust_shooter_common:
	sta	SPRITE_X

;	clc
;	lda	PEASANT_Y
;	adc	peasant_bow_offset_y_left,Y

	lda	PEASANT_Y			; offset always 0
	sta	SPRITE_Y

	clc
	tya
	adc	#PEASANT_BOW_OFFSET

	tax

	jsr	hgr_draw_sprite_mask

	jsr	hgr_page_flip

;	jsr	wait_until_keypress

	; increment count

	inc	PEASANT_BOW_COUNT
	lda	PEASANT_BOW_COUNT
	cmp	#PEASANT_MAX_BOW

	bne	draw_peasant_bow_loop

	;=================================
	; done with animation

	; turn peasant back on
	;	real game keep holding bow until moved??

	lda	SUPPRESS_DRAWING
	and	#<(~SUPPRESS_PEASANT)
	sta	SUPPRESS_DRAWING

	ldx	#<kerrek_kill_message2
	ldy	#>kerrek_kill_message2
	jsr	partial_message_step

	lda	#5
	jsr	score_points

	; make kerrek dead

	lda	GAME_STATE_3
	ora	#KERREK_DEAD
	sta	GAME_STATE_3

	; draw body on background

;	jsr	kerrek_draw_body

	; make it rain, make the puddle wet

	; sound: three thunders

	jsr     thunder_sound
	; pause?
	jsr     thunder_sound
	; pause?
	jsr     thunder_sound

	lda	GAME_STATE_1
	ora	#(PUDDLE_WET)
	sta	GAME_STATE_1

	lda	#6			; should this be 5?
	sta	RAIN_COUNT

	ldx     #<kerrek_kill_message3
	ldy     #>kerrek_kill_message3
	jsr	partial_message_step

	; return to level we were called from

	lda	PREVIOUS_LOCATION
	jmp	update_map_location

	rts


kerrek_kill_message2:
.byte "ARROWED!! Nice shot. You",13
.byte "smote the Kerrek! He lay",13
.byte "there stinking.",0

; start the rain

; pause
kerrek_kill_message3:
.byte "A light rain heralds the",13
.byte "washing free of the",13
.byte "Kerrek's grip on the land.",13
.byte "You're feeling pretty",13
.byte "good, though, so the",13
.byte "artless symbolism doesn't",13
.byte "bug you.",0
