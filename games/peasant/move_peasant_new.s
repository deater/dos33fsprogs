; Move that Peasant!

move_peasant:

	; redraw peasant if moved

	lda	PEASANT_XADD
	ora	PEASANT_YADD		; sneaky way to see if both nonzero
	bne	really_move_peasant

	jmp	peasant_the_same

really_move_peasant:

	; increment step count, wrapping at 6

	inc	PEASANT_STEPS
	lda	PEASANT_STEPS
	cmp	#6
	bne	no_peasant_wrap
	lda	#0
	sta	PEASANT_STEPS

no_peasant_wrap:

	; restore bg behind peasant

	jsr	erase_peasant

	;=========================
	;=========================
	; move peasant
	;=========================
	;=========================


	;==========================
	; first move in X direction

	clc
	lda	PEASANT_X
	adc	PEASANT_XADD			; A = new X

	bmi	peasant_x_negative		; if newx <0, handle

	cmp	#40
	bcs	peasant_x_toobig		; if newx>=40, hanfle (bge)


	;======================================
	; not off screen, so check if collision

	pha

	tay
	; FIXME: should we add YADD first, like we do in peasant_move_tiny?

	ldx	PEASANT_Y
	jsr	peasant_collide

	pla

	bcc	do_move_peasant_y		; no X collide

	;==================================
	; we collided in X, so stop moving

	jsr	stop_peasant			; stop moving

	; leave PEASANT_X same as was
	lda	PEASANT_X
	jmp	do_move_peasant_y

	;============================
peasant_x_toobig:

	jsr	move_map_east

	lda	#0		; new X location

	jmp	done_movex

	;============================
peasant_x_negative:

	jsr	move_map_west

	lda	#39		; new X location

	jmp	done_movex

	; check edge of screen
done_movex:
	; if we get here we changed screens
	sta	PEASANT_X		; update new location
	jmp	peasant_the_same	; skip checking for Y collision



	; Move Peasant Y
do_move_peasant_y:
	sta	PEASANT_X
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

	jsr	move_map_south

	lda	#45		; new Y location

	jmp	done_movey


	;============================
peasant_y_negative:

	jsr	move_map_north

	lda	#160		; new Y location

	jmp	done_movey

	; check edge of screen
done_movey:
	sta	PEASANT_Y

	; if we moved off screen, don't re-draw peasant ?

peasant_the_same:

	rts

.if 0
	;===========================
	; erase peasant
	;===========================

	; restore bg behind peasant
erase_peasant:

	; erase flame if applicable
	ldy	#5
	jsr	hgr_partial_restore_by_num


;	lda	PEASANT_Y
;	sta	SAVED_Y1
;	clc
;	adc	#30
;	sta	SAVED_Y2

;	ldx	PEASANT_X
;	txa
;	inx

;	jmp	hgr_partial_restore	; tail call


	ldy	#4

	jmp	hgr_partial_restore_by_num	; tail call


;	rts

.endif


; when peasants collide

	;===================
	; peasant_collide
	;===================
	; newx/7 in Y
	; newy in X
	; returns C=0 if no collide
	;	  C=1 if collide

	; collide data, 6 rows of 40 columns
	;	then in 8 bit chunks

	; rrrtttii
	;	bottom 2 bits don't matter (lores tile is 4 rows high)
	;	next 3 bits = which of 8 bits is relevant
	;	top 3 bits are row lookup

peasant_collide:

	; assume 3-wide sprite, colliding with feet of the middle?

	iny
	sty	collision_smc1+1

	; add 28 to collide with feet
	txa
	clc
	adc	#28		; FIXME: if want to collide somewhere else

	lsr
	lsr		; need to divide by 4 for offset lookup
	pha
	and	#$7
	sta	collision_smc2+1
	pla

	lsr
	lsr		; shift 3 more times for row lookup
	lsr

	tax
	lda	collision_offset,X		; get collision offset
	clc
collision_smc1:
	adc	#$00				; add in XPOS

	tax

	lda	collision_location,X		; get 8 bits of collision info

collision_smc2:
	ldx	#$01
	and	collision_masks,X

	bne	collide_true		; true if bit set

collide_false:
	clc
	rts

collide_true:
	sec
	rts


;move_map_east:
;move_map_west:
;move_map_north:
;move_map_south:
;	rts


collision_offset:
	.byte 0,40,80,120,160,200

collision_masks:
	.byte $80,$40,$20,$10,$08,$04,$02,$01
