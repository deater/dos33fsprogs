	; there are two peasant animations we have to handle
	; shooting the arrow
	; getting the belt
	; note it might make sense size-wise to split the kerrek levels
	;	in two, a separate one for after he's dead

; note robe version the spark is to the side?

; all from DefineSprite(425), frame 486

; get belt        6 6 7 7 8 8 8 8 8 7 7 6 6
;	0,1,2,3,4,5,5,5,5,5,5,5,5,5,5,5,5,5,4,3,3,3,3,3,3,2,2
;                 + +,|,|,*,*,*,*,*,|,|,+,+,
; note, at 4 he ducks a bit?
;  5 has +

; to save space we draw peasant in two parts, the legs, then the upper part

	;=============================
	; get the belt
	;=============================


; get belt        6 6 7 7 8 8 8 8 8 7 7 6 6
;	0,1,2,3,4,5,5,5,5,5,5,5,5,5,5,5,5,5,4,3,3,3,3,3,3,2,2
;                 + +,|,|,*,*,*,*,*,|,|,+,+,

PEASANT_MAX_BELT = 28
PEASANT_BELT_OFFSET = 0
PEASANT_BELT_BASE_OFFSET = 0


peasant_belt_progress:
.byte	0,0,1,2,3,4		; (hand moving up in air)
.byte	6,6			; small sparkle
.byte	7,7			; medium sparkle
.byte	8,8,8,8,8		; bright sparkle
.byte	7,7
.byte	6,6
.byte	4,3,3,3,3,3,3,2,2

peasant_belt_offset_x:
.byte 1,0,0,$ff,	$ff,0,0,$FE

peasant_belt_offset_y:
.byte 11,11,11,11,	6,$ff,$ff,11



draw_peasant_belt:

	;==============================
	; first, draw baseline peasant


	lda	PEASANT_X
	sta	SPRITE_X
	lda	PEASANT_Y
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

	lda	PEASANT_BELT_COUNT
	cmp	#PEASANT_MAX_BELT
	beq	belt_done_first
	bcs	belt_just_return

	; increment count

	inc	PEASANT_BELT_COUNT

	;FIXME:	RAISE_UP_SOUND
	jsr	raise_up_sound

belt_just_return:

	rts


belt_done_first:

	rts

