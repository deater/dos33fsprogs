	; there are two peasant animations we have to handle
	; shooting the arrow
	; getting the belt
	; note it might make sense size-wise to split the kerrek levels
	;	in two, a separate one for after he's dead



	;=============================
	;=============================
	;=============================
	; get the belt
	;=============================
	;=============================
	;=============================


; note robe version the spark is to the side?

; all from DefineSprite(425), frame 486


; to save space we draw peasant in two parts, the legs, then the upper part

; get belt        6 6 7 7 8 8 8 8 8 7 7 6 6
;	0,1,2,3,4,5,5,5,5,5,5,5,5,5,5,5,5,5,4,3,3,3,3,3,3,2,2
;                 + +,|,|,*,*,*,*,*,|,|,+,+,

; you walk over, just above belly
; pick up belt while the music plays
; message appears
; get-points happens after the message is done

PEASANT_MAX_BELT = 28


peasant_belt_progress:
.byte	0,0,1,2,3,4		; (hand moving up in air)
.byte	6,6			; small sparkle
.byte	7,7			; medium sparkle
.byte	8,8,8,8,8		; bright sparkle
.byte	7,7
.byte	6,6
.byte	4,3,3,3,3,3,3,2,2

peasant_belt_offset_x:
.byte $ff,$ff,$ff,$ff,	0,0,0,0, $ff

peasant_belt_offset_y:
.byte 1,1,0,$ff,	$fd,$fb,$f8,$f5, $f2


	;===============================
	;

draw_peasant_belt:

	lda	#0
	sta	PEASANT_BELT_COUNT

	lda	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

	;FIXME:	RAISE_UP_SOUND
	jsr	raise_up_sound

draw_peasant_belt_loop:

	jsr	update_screen

	;==============================
	; first, draw baseline peasant


	lda	PEASANT_X
	sta	SPRITE_X
	clc
	lda	PEASANT_Y
	adc	#9		; 9 down from "normal" peasant

	sta	SPRITE_Y

	ldx	#PEASANT_BELT_BASE_OFFSET

	jsr	hgr_draw_sprite_mask


	;==============================
	; next draw appropriate top

	ldy	PEASANT_BELT_COUNT
	lda	peasant_belt_progress,Y
	tay

	clc
	lda	PEASANT_X
	adc	peasant_belt_offset_x,Y
	sta	SPRITE_X

	clc
	lda	PEASANT_Y
	adc	peasant_belt_offset_y,Y
	sta	SPRITE_Y

	clc
	tya
	adc	#PEASANT_BELT_OFFSET

	tax

	jsr	hgr_draw_sprite_mask



	jsr	hgr_page_flip

;	jsr	wait_until_keypress

	; increment count

	inc	PEASANT_BELT_COUNT
	lda	PEASANT_BELT_COUNT
	cmp	#PEASANT_MAX_BELT

	bne	draw_peasant_belt_loop

	; turn peasant back on

	lda	SUPPRESS_DRAWING
	and	#<(~SUPPRESS_PEASANT)
	sta	SUPPRESS_DRAWING

	rts

