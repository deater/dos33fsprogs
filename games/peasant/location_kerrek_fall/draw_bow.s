	;=============================
	;=============================
	;=============================
	; shoot the bow
	;=============================
	;=============================
	;=============================

PEASANT_MAX_BOW = 16


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

peasant_bow_offset_y_left:
.byte 0,0,0,0,	0,0,0,0, 0

peasant_bow_offset_x:
.byte $0,$0,$0,$0,	$0,$0,$0,$0, $0

peasant_bow_offset_y:
.byte 0,0,0,0,	0,0,0,0, 0


	;===============================
	;

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
	lda	peasant_bow_progress,Y
	tay

	clc
	lda	PEASANT_X
	adc	peasant_bow_offset_x,Y
	sta	SPRITE_X

	clc
	lda	PEASANT_Y
	adc	peasant_bow_offset_y,Y
	sta	SPRITE_Y

	clc
	tya
	adc	#PEASANT_BOW_OFFSET_RIGHT

	tax

	jsr	hgr_draw_sprite_mask



	jsr	hgr_page_flip

	jsr	wait_until_keypress

	; increment count

	inc	PEASANT_BOW_COUNT
	lda	PEASANT_BOW_COUNT
	cmp	#PEASANT_MAX_BOW

	bne	draw_peasant_bow_loop

	; turn peasant back on

	lda	SUPPRESS_DRAWING
	and	#<(~SUPPRESS_PEASANT)
	sta	SUPPRESS_DRAWING

	rts

