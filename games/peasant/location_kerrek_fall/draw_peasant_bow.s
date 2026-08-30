	;================================
	;================================
	;================================
	; shoot the bow / hit the kerrek
	;================================
	;================================
	;================================

PEASANT_MAX_BOW = 16+37

PEASANT_SHOOT_NOISE = 16

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

	; we only have 16 peasant frames, so once we go past
	;	that halt at last one

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


	;=======================
	; do shooit noise

	lda	PEASANT_BOW_COUNT
	cmp	#PEASANT_SHOOT_NOISE
	bne	skip_shoot_noise

	jsr	arrow_shoot_sound

skip_shoot_noise:

	; increment count

	inc	PEASANT_BOW_COUNT
	lda	PEASANT_BOW_COUNT
	cmp	#PEASANT_MAX_BOW

	bne	draw_peasant_bow_loop

	;=================================
	; done with animation

	rts

