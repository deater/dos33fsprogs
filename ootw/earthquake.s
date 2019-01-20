	;==========================
	; check for earthquake

earthquake_handler:
	lda     FRAMEH
	and	#3
	bne	earth_mover
	lda	FRAMEL
	cmp	#$ff
	bne	earth_mover
earthquake_init:
	lda	#200
	sta	EQUAKE_PROGRESS

	lda	#0
	sta	BOULDER_Y
	jsr	random16
	lda	SEEDL
	and	#$1f
	clc
	adc	#4
	sta	BOULDER_X


earth_mover:
	lda	EQUAKE_PROGRESS
	beq	earth_still

	and	#$8
	bne	earth_calm

	lda	#2
	bne	earth_decrement

earth_calm:
	lda	#0
earth_decrement:
	sta	EARTH_OFFSET
	dec	EQUAKE_PROGRESS
	jmp	earth_done


earth_still:
	lda	#0
	sta	EARTH_OFFSET

earth_done:

	;================================
	; copy background to current page

	lda	EARTH_OFFSET
	bne	shake_shake
no_shake:
	jsr	gr_copy_to_current
	jmp	done_shake
shake_shake:
	jsr	gr_copy_to_current_1000
done_shake:

	rts


	;======================
	; draw falling boulders
draw_boulder:
	lda	BOULDER_Y
	cmp	#38
	bpl	no_boulder

	lda	#<boulder
	sta	INL
	lda	#>boulder
	sta	INH

	lda	BOULDER_X
	sta	XPOS
	lda	BOULDER_Y
	sta	YPOS
        jsr	put_sprite

	lda	FRAMEL
	and	#$3
	bne	no_boulder
	inc	BOULDER_Y
	inc	BOULDER_Y

no_boulder:

	rts

