
	;=============================
	;=============================
	;=============================
	; shoot the bow
	;=============================
	;=============================
	;=============================

PEASANT_MAX_BOW = 28


peasant_bow_progress:
.byte	0,0,1,2,3,4		; (hand moving up in air)
.byte	6,6			; small sparkle
.byte	7,7			; medium sparkle
.byte	8,8,8,8,8		; bright sparkle
.byte	7,7
.byte	6,6
.byte	4,3,3,3,3,3,3,2,2

peasant_bow_offset_x:
.byte $ff,$ff,$ff,$ff,	0,0,0,0, $ff

peasant_bow_offset_y:
.byte 1,1,0,$ff,	$fd,$fb,$f8,$f5, $f2


	;===============================
	;

draw_peasant_bow:

	lda	#0
	sta	PEASANT_BOW_COUNT

	lda	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

	;FIXME:	RAISE_UP_SOUND
;	jsr	raise_up_sound

draw_peasant_bow_loop:

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

	; turn peasant back on

	lda	SUPPRESS_DRAWING
	and	#<(~SUPPRESS_PEASANT)
	sta	SUPPRESS_DRAWING

	rts

