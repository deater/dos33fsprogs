; Handle shield

; when pressed, find empty slot?  Up to 3?
; gradually expire, flash when done
; should update the laser range when start/stop
; destroyed by blast.  Weakened by laser?

MAX_SHIELDS	=	3

shield_out:
shield0_out:		.byte $0
shield1_out:		.byte $0
shield2_out:		.byte $0

shield_x:
shield0_x:		.byte $0
shield1_x:		.byte $0
shield2_x:		.byte $0

shield_y:
shield0_y:		.byte $0
shield1_y:		.byte $0
shield2_y:		.byte $0

shield_count:
shield0_count:		.byte $0
shield1_count:		.byte $0
shield2_count:		.byte $0

	;=========================
	; activate_shield
	;=========================

activate_shield:

	lda	SHIELD_OUT
	cmp	#MAX_SHIELDS
	beq	done_activate_shield

	; find slot
	ldx	#0
activate_shield_loop:
	lda	shield_out,X
	beq	found_shield_slot
	inx
	bne	activate_shield_loop	; bra

found_shield_slot:

	; take the slot

	inc	SHIELD_OUT
	inc	shield_out,X

	; reset count

	lda	#0
	sta	shield_count,X

	; set y

	lda	PHYSICIST_Y
	sta	shield_y,X

	; set x
	lda	DIRECTION
	bne	shield_right

shield_left:

	ldy	PHYSICIST_X
	dey
	tya
	sta	shield_x,X

	jmp	done_activate_shield

shield_right:

	lda	PHYSICIST_X
	clc
	adc	#5
	sta	shield_x,X

done_activate_shield:
	rts


	;====================
	; draw shields
	;====================

draw_shields:

	lda	SHIELD_OUT
	beq	done_draw_shields

	ldx	#0

draw_shields_loop:

	lda	shield_out,X
	beq	draw_shields_loop_continue

	lda	shield_x,X
	sta	XPOS
	lda	shield_y,X
	sta	YPOS

	ldy	shield_count,X

	lda	shield_progression,Y
	bmi	destroy_shield

	tay

	lda	FRAMEL
	and	#$7
	bne	dont_increment_shield

	inc	shield_count,X

dont_increment_shield:

	lda	shield_table_lo,Y
	sta	INL
	lda	shield_table_hi,Y
	sta	INH

	txa
	pha

	jsr	put_sprite

	pla
	tax
	jmp	draw_shields_loop_continue

destroy_shield:
	lda	#0
	sta	shield_out,X
	dec	SHIELD_OUT

draw_shields_loop_continue:
	inx
	cpx	#MAX_SHIELDS
	bne	draw_shields_loop

done_draw_shields:

	rts

	;====================
	; init shields
	;====================

init_shields:

	ldx	#0
	stx	SHIELD_OUT
init_shields_loop:

	lda	#0
	sta	shield_out,X

	inx
	cpx	#MAX_SHIELDS
	bne	init_shields_loop

	rts

shield_progression:
	.byte 0,1
	.byte 2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3
	.byte 2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3,2,3
	.byte 4,5,4,5,4,5,4,5,4,5,4,5
	.byte 4,5,4,5,4,5,4,5,4,5,4,5
	.byte 6,7,6,7,6,7,6,7
	.byte 6,7,6,7,6,7,6,7
	.byte 0
	.byte $FF

shield_table_hi:
	.byte >shield_flash_sprite	; 0
	.byte >shield_start_sprite	; 1
	.byte >shield_high1_sprite	; 2
	.byte >shield_high2_sprite	; 3
	.byte >shield_medium1_sprite	; 4
	.byte >shield_medium2_sprite	; 5
	.byte >shield_low1_sprite	; 6
	.byte >shield_low2_sprite	; 7

shield_table_lo:
	.byte <shield_flash_sprite
	.byte <shield_start_sprite
	.byte <shield_high1_sprite
	.byte <shield_high2_sprite
	.byte <shield_medium1_sprite
	.byte <shield_medium2_sprite
	.byte <shield_low1_sprite
	.byte <shield_low2_sprite




shield_flash_sprite:
	.byte 1,8
	.byte $f3
	.byte $ff
	.byte $ff
	.byte $ff
	.byte $ff
	.byte $3f
	.byte $AA
	.byte $AA

shield_start_sprite:
	.byte 1,8
	.byte $11
	.byte $11
	.byte $11
	.byte $11
	.byte $11
	.byte $11
	.byte $11
	.byte $11

shield_high1_sprite:
	.byte 1,8
	.byte $BA
	.byte $3A
	.byte $A1
	.byte $A1
	.byte $BA
	.byte $A3
	.byte $BA
	.byte $13

shield_high2_sprite:
	.byte 1,8
	.byte $3A
	.byte $1A
	.byte $3A
	.byte $AA
	.byte $AB
	.byte $3A
	.byte $1B
	.byte $3A

shield_medium1_sprite:
	.byte 1,8
	.byte $A1
	.byte $AA
	.byte $1B
	.byte $AA
	.byte $A3
	.byte $AA
	.byte $3A
	.byte $BA

shield_medium2_sprite:
	.byte 1,8
	.byte $AB
	.byte $AA
	.byte $A3
	.byte $A3
	.byte $AA
	.byte $B3
	.byte $AA
	.byte $1A

shield_low1_sprite:
	.byte 1,8
	.byte $A3
	.byte $AB
	.byte $AA
	.byte $3A
	.byte $AA
	.byte $AA
	.byte $1A
	.byte $AA

shield_low2_sprite:
	.byte 1,8
	.byte $A1
	.byte $AA
	.byte $AA
	.byte $A1
	.byte $AA
	.byte $AA
	.byte $A3
	.byte $AB


