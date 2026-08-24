;===============================================
; kerrek progress
;===============================================
; ignore first 16 steps (peasant shooting, kerrek walking)

; 37 frames

; sprite 675

kerrek_hit_progress:
.byte	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
.byte	$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
.byte	0,0	; 81, 82 (hit0)
.byte	1,1,1	; 83, 84, 85     (hit1)
.byte	2,2	; 86, 87 (hit2)
.byte	3,3	; 88, 89 (hit3)
.byte	2,2	; 90, 91 (hit2)
.byte	3,3	; 92, 93 (hit3)
.byte	2,2	; 94, 95 (hit2)
.byte	3,3	; 96, 97 (hit3)
.byte	4,4	; 98, 99  (hit4) (fallen, arms up)
.byte	4,4	; 100,101 (hit4)
		; (techincally there's a "bounce" frame we don't have)
.byte	5	; 102	 (hit5) (flat)
.byte	6	; 103    (hit6) (fallen, arms down)
.byte	5,5,5,5	; 104,105,106,107	(hit5)
.byte	5,5,5,5	; 108,109,110,111
.byte	5,5,5,5	; 112,113,114,115
.byte	5,5,5	; 116,117,118

kerrek_hit_offset_x_left:
.byte $00,$fe,$ff,$ff,	$ff,$ff,$00

kerrek_hit_offset_x_right:
.byte $0,$0,$0,$0,	$0,$0,$0

kerrek_hit_offset_y_left:
.byte 0,0,3,3,	25,34,25

kerrek_hit_offset_y_right:
.byte 0,0,3,3,	25,34,25


	;=======================
	;=======================
	; kerrek draw
	;=======================
	;=======================
kerrek_draw:

	ldy	PEASANT_BOW_COUNT
	lda	kerrek_hit_progress,Y
	bpl	kerrek_draw_hit

kerrek_draw_walk:

	lda	KERREK_X
	sta	SPRITE_X
	lda	KERREK_Y
	sta	SPRITE_Y

	ldx	KERREK_COUNT

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0=LEFT
	beq	kerrek_correct_dir

	txa				; could just OR with 8?
	clc
	adc	#$8
	tax

kerrek_correct_dir:
	jsr	hgr_draw_sprite_mask

	rts				; tail call?


kerrek_draw_hit:

	lda	kerrek_hit_progress,Y
	tay

	; adjust for left/right

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0 = left
	beq	adjust_kerrek_hit_left

adjust_kerrek_hit_right:

	clc
	lda	KERREK_X
	adc	kerrek_hit_offset_x_right,Y
	jmp	adjust_kerrek_hit_common

adjust_kerrek_hit_left:

	clc
	lda	KERREK_X
	adc	kerrek_hit_offset_x_left,Y

adjust_kerrek_hit_common:
	sta	SPRITE_X

	clc
	lda	KERREK_Y
	adc	kerrek_hit_offset_y_left,Y
	sta	SPRITE_Y

	clc
	tya
	adc	#KERREK_HIT_OFFSET

	tax

	jsr	hgr_draw_sprite_mask

	rts





