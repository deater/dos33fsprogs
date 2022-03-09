

draw_flames:

	; draw left_flame
	lda	FRAMEL
	and	#$3
	tay

	lda	lflame_l,Y
	sta	INL
	lda	lflame_h,Y
	sta	INH

	ldx	#31		; 217
        stx     XPOS
	lda	#108
	sta	YPOS

	jsr	hgr_draw_sprite


	; draw right_flame
	lda	FRAMEL
	and	#$3
	tay

	lda	rflame_l,Y
	sta	INL
	lda	rflame_h,Y
	sta	INH

	ldx	#35		; 245
        stx     XPOS
	lda	#108
	sta	YPOS

	jmp	hgr_draw_sprite

;	rts


lflame_l:
.byte	<lflame1_sprite,<lflame2_sprite,<lflame3_sprite,<lflame4_sprite

lflame_h:
.byte	>lflame1_sprite,>lflame2_sprite,>lflame3_sprite,>lflame4_sprite

rflame_l:
.byte	<rflame1_sprite,<rflame2_sprite,<rflame3_sprite,<rflame4_sprite

rflame_h:
.byte	>rflame1_sprite,>rflame2_sprite,>rflame3_sprite,>rflame4_sprite
