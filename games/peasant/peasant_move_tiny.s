; Move that Peasant!

move_peasant_tiny:

	; redraw peasant if moved

	lda	PEASANT_XADD
	ora	PEASANT_YADD
	bne	really_move_peasant

	jmp	peasant_the_same

really_move_peasant:

	; restore bg behind peasant

	lda	PEASANT_X
	sta	CURSOR_X

	lda	PEASANT_Y
	sta	CURSOR_Y

	jsr	restore_bg_1x5

	; move peasant

	clc
	lda	PEASANT_X
	adc	PEASANT_XADD			; A = new X

	bmi	peasant_x_negative		; if newx <0, handle

	cmp	#40
	bcs	peasant_x_toobig		; if newx>=40, hanfle (bge)

	pha

	tay
	clc
	lda	PEASANT_Y
	adc	PEASANT_YADD
	tax
	jsr	peasant_collide

	pla

	bcc	done_movex			; no collide

	jsr	stop_peasant			; stop moving

	lda	PEASANT_X			; leave same

	jmp	done_movex

	;============================
peasant_x_toobig:
peasant_x_negative:

done_movex:
	sta	PEASANT_X


	; Move Peasant Y

	clc
	lda	PEASANT_Y
	adc	PEASANT_YADD			; newy in A

	cmp	#45				; if <45 then off screen
	bcc	peasant_y_negative		; blt

	cmp	#160				; if >=150 then off screen
	bcs	peasant_y_toobig		; bge

	; check collide

	pha

	ldy	PEASANT_X
	tax	; newy
	jsr	peasant_collide

	pla

	bcc	done_movey			; no collide

	jsr	stop_peasant			; stop moving

	lda	PEASANT_Y			; leave same

	jmp	done_movey


	;============================
peasant_y_toobig:
peasant_y_negative:

	jmp	done_movey

	; check edge of screen
done_movey:
	sta	PEASANT_Y

	; if we moved off screen, don't re-draw peasant

        lda     LEVEL_OVER
        bne     peasant_the_same

	; save behind new position

	lda	PEASANT_X
	sta	CURSOR_X

	lda	PEASANT_Y
	sta	CURSOR_Y

	jsr	save_bg_1x5

	; draw peasant

	jsr	draw_peasant

peasant_the_same:

	rts



; when peasants collide

; at B2 = 178
;	178 - 4 = 174
;	check for collide 174+5 = 179 = $B3 1011 0011

	;===================
	; peasant_collide
	;===================
	; newx/7 in Y
	; newy in X
	; returns C=0 if no collide
	;	  C=1 if collide
peasant_collide:
			; rrrr rtii	top 5 bits row, bit 2 top/bottom

	; add 5 to collide with feet
	txa
	clc
	adc	#5
	tax

	txa
	and	#$04	; see if odd/even
	beq	peasant_collide_even

peasant_collide_odd:
	lda	#$f0
	bne	peasant_collide_mask		; bra

peasant_collide_even:
	lda	#$0f
peasant_collide_mask:

	sta	MASK

	txa
	lsr
	lsr		; need to divide by 8 then * 2
	lsr		; can't just div by 4 as we need to mask bottom bit
	asl
	tax

	lda	gr_offsets,X
	sta	INL
	lda	gr_offsets+1,X
	sta	INH

	lda	(INL),Y			; get value

	and	MASK

;	ldy	MASK
;	cpy	#$f0
;	beq	in_top
;in_bottom:
;	and	#$0f
;	jmp	done_feet
;in_top:
;	lsr
;	lsr
;	lsr
;	lsr
;done_feet:

	beq	collide_true		; true if color 0
	;bne	collide_false

collide_false:
	clc
	rts

collide_true:
	sec
	rts



.include "gr_offsets.s"
