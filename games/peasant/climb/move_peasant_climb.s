; Move that Peasant!

; climbing edition

; note: left/right across screen is roughly 24 keypresses
; width on Apple II roughly 30 across
; so the full animation should in the end only move one box, not 4?

move_peasant:

	lda	PEASANT_FALLING
	beq	peasant_not_falling


peasant_falling:
	; if PEASANT_FALLING == 1, then falling
	; if PEASANT_FALLING == 2, then crashing
	; if PEASANT_FALLING == 3, then crashed


	lda	PEASANT_FALLING
	cmp	#3
	bcs	done_falling_peasant	; bge

	; restore bg behind peasant

;	jsr	erase_peasant


	; falling, see if hit bottom
	; 

	lda	MAP_LOCATION
	beq	check_falling_hit_ground

	; otherwise see if hit bottom of screen
	lda	PEASANT_Y
	cmp	#180
	bcc	move_falling_peasant

	; new screen

	dec	MAP_LOCATION
	lda	#12		; move back to top of screen
	sta	PEASANT_Y

	jsr	reset_enemy_state

	lda	#$FF
	sta	LEVEL_OVER
	jmp	done_falling_peasant


check_falling_hit_ground:
	lda	PEASANT_Y
	cmp	#115

	bcc	move_falling_peasant

	; if here, finish falling

	inc	PEASANT_FALLING
	jmp	done_falling_peasant


move_falling_peasant:
	inc	PEASANT_Y
	inc	PEASANT_Y

done_falling_peasant:
	rts


peasant_not_falling:

	; redraw peasant if moved

	lda	CLIMB_COUNT
	bne	really_move_peasant

	jmp	peasant_the_same

really_move_peasant:

	; decrement climb count

	dec	CLIMB_COUNT
	bne	climb_continue
climb_stop:

	jsr	stop_peasant

climb_continue:

	; restore bg behind peasant

;	jsr	erase_peasant

	;=========================
	;=========================
	; move peasant
	;=========================
	;=========================


	;==========================
	; first move in X direction

	lda	CLIMB_COUNT
	cmp	#3
	beq	do_xadd
	cmp	#1
	bne	skip_xadd
do_xadd:
	clc
	lda	PEASANT_X
	adc	PEASANT_XADD			; A = new X
	jmp	done_xadd

skip_xadd:
	lda	PEASANT_X
done_xadd:

	; in theory this can't happen when climbing

;	bmi	peasant_x_negative		; if newx <0, handle

;	cmp	#40
;	bcs	peasant_x_toobig		; if newx>=40, handle (bge)


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
;peasant_x_toobig:

;	jsr	move_map_east

;	lda	#0		; new X location

;	jmp	done_movex

	;============================
;peasant_x_negative:

;	jsr	move_map_west

;	lda	#39		; new X location

;	jmp	done_movex

	; check edge of screen
;done_movex:
	; if we get here we changed screens
;	sta	PEASANT_X		; update new location
;	jmp	peasant_the_same	; skip checking for Y collision



	; Move Peasant Y
do_move_peasant_y:
	sta	PEASANT_X
	clc
	lda	PEASANT_Y
	adc	PEASANT_YADD			; newy in A

	cmp	#12				; if <12 then off screen
	bcc	peasant_y_negative		; blt


	; FIXME: in theory can never go down

;	cmp	#160				; if >=150 then off screen
;	bcs	peasant_y_toobig		; bge

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

;	jsr	move_map_south

;	lda	#12		; new Y location

	jmp	done_movey


	;============================
	; move up over top of screen

peasant_y_negative:


	lda	#$FF
	sta	LEVEL_OVER

	inc	MAP_LOCATION
	; FIXME: if high enough, we won
	; in the coach Z version, increase score
	; bcd
	lda	MAX_HEIGHT
	clc
	sed
	adc	#$01
	cld
	sta	MAX_HEIGHT

	lda	#158		; new Y location

	jmp	done_movey

	; check edge of screen
done_movey:
	sta	PEASANT_Y

	; if we moved off screen, don't re-draw peasant ?

peasant_the_same:

	rts


	;===========================
	; erase peasant
	;===========================

	; restore bg behind peasant
;erase_peasant:

	; erase flame if applicable
;	ldy	#5
;	jsr	hgr_partial_restore_by_num

	; erase peasant

;	ldy	#4

;	jmp	hgr_partial_restore_by_num	; tail call


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


move_map_east:
move_map_west:
move_map_north:
move_map_south:
	rts


stop_peasant:
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
	sta	PEASANT_DIR	; PEASANT_UP is 0
	rts

collision_offset:
	.byte 0,40,80,120,160,200

collision_masks:
	.byte $80,$40,$20,$10,$08,$04,$02,$01




