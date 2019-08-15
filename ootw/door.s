DOOR_STATUS_OPENING1	= $00
DOOR_STATUS_OPENING2	= $01
DOOR_STATUS_OPEN	= $02
DOOR_STATUS_CLOSING1	= $03
DOOR_STATUS_CLOSING2	= $04
DOOR_STATUS_CLOSED	= $05
DOOR_STATUS_EXPLODED	= $06
DOOR_STATUS_LOCKED	= $07
DOOR_STATUS_EXPLODING1	= $08
DOOR_STATUS_EXPLODING2	= $09
DOOR_STATUS_EXPLODING3	= $0A
DOOR_STATUS_EXPLODING4	= $0B
DOOR_STATUS_EXPLODING5	= $0C
DOOR_STATUS_EXPLODING6	= $0D


	;==================================
	; draw_doors
	;==================================
	; be sure to smc to point to right place

draw_doors:
	lda	NUM_DOORS
	beq	done_draw_doors

	ldx	#0
draw_doors_loop:

	ldy	door_status,X

	lda	door_sprite_lookup_lo,Y
	sta	INL
	lda	door_sprite_lookup_hi,Y
	sta	INH

actually_draw_door:
	lda	door_x,X
	sta	XPOS

	lda	door_y,X
	sta	YPOS

	txa
	pha

	lda	door_status,X
	cmp	#DOOR_STATUS_EXPLODING1
	bcs	draw_exploding_door

	jsr	put_sprite

after_door_put_sprite:

	pla
	tax

draw_doors_continue:
	inx
	cpx	NUM_DOORS
	bne	draw_doors_loop

done_draw_doors:

	rts

draw_exploding_door:

	lda	FRAMEL
	and	#$7
	bne	not_done_exploding_door

	inc	door_status,X
	lda	door_status,X
	cmp	#DOOR_STATUS_EXPLODING6
	bcc	not_done_exploding_door

	lda	#DOOR_STATUS_EXPLODED
	sta	door_status,X

not_done_exploding_door:
	dec	XPOS

	jsr	put_sprite

	jmp	after_door_put_sprite



	;==========================
	;==========================
	; handle doors
	;==========================
	;==========================
handle_doors:

	lda	NUM_DOORS
	beq	done_handle_doors

	ldx	#0
handle_doors_loop:

	; state machine
	lda	door_status,X

	; if locked->do nothing
	cmp	#DOOR_STATUS_LOCKED
	beq	handle_doors_continue

	; if exploded->do nothing
	cmp	#DOOR_STATUS_EXPLODED
	beq	handle_doors_continue


	; if closed and xpos/ypos in range: open
	; if open and xpos/ypos not ni range: close
	cmp	#DOOR_STATUS_OPEN
	beq	handle_doors_open
	cmp	#DOOR_STATUS_CLOSED
	beq	handle_doors_closed

	; if exploding: continue exploding
	; we handle the increment elsewhere
	cmp	#DOOR_STATUS_EXPLODING1
	bcs	handle_doors_continue	; bge

	; if opening, continue to open
	; if closing, continue to close
handle_door_inc_state:
	inc	door_status,X

handle_doors_continue:
	inx
	cpx	NUM_DOORS
	bne	handle_doors_loop

done_handle_doors:
	rts

handle_doors_open:

	; only open/close if on same level
	ldy	door_y,X
	iny
	iny
	iny
	iny
	cpy	PHYSICIST_Y
	bne	close_door

	lda	PHYSICIST_X
	cmp	door_xmax,X
	bcs	close_door	; bge

	cmp	door_xmin,X
	bcc	close_door	; blt

	; made it here, we are in bounds, stay open

	jmp	handle_doors_continue

close_door:
	lda	#DOOR_STATUS_CLOSING1
	sta	door_status,X
	jmp	handle_doors_continue

handle_doors_closed:

	; only open if on same level

	ldy	door_y,X
	iny
	iny
	iny
	iny
	cpy	PHYSICIST_Y
	bne	handle_doors_continue

	lda	PHYSICIST_X
	cmp	door_xmax,X
	bcs	handle_doors_continue

	cmp	door_xmin,X
	bcc	handle_doors_continue

open_door:
	lda	#DOOR_STATUS_OPENING1
	sta	door_status,X
	jmp	handle_doors_continue









;======================================
;======================================
; door sprites
;======================================
;======================================


door_sprite_lookup_lo:
	.byte <door_opening_sprite1	; DOOR_STATUS_OPENING1
	.byte <door_opening_sprite2	; DOOR_STATUS_OPENING2
	.byte <door_open_sprite		; DOOR_STATUS_OPEN
	.byte <door_closing_sprite1	; DOOR_STATUS_CLOSING1
	.byte <door_closing_sprite2	; DOOR_STATUS_CLOSING2
	.byte <door_closed_sprite	; DOOR_STATUS_CLOSED
	.byte <door_exploded_sprite	; DOOR_STATUS_EXPLODED
	.byte <door_closed_sprite	; DOOR_STATUS_LOCKED
	.byte <door_exploding_sprite1	; DOOR_STATUS_EXPLODING1
	.byte <door_exploding_sprite2	; DOOR_STATUS_EXPLODING2
	.byte <door_exploding_sprite3	; DOOR_STATUS_EXPLODING3
	.byte <door_exploding_sprite4	; DOOR_STATUS_EXPLODING4
	.byte <door_exploding_sprite5	; DOOR_STATUS_EXPLODING5
	.byte <door_exploding_sprite6	; DOOR_STATUS_EXPLODING6

door_sprite_lookup_hi:

	.byte >door_opening_sprite1	; DOOR_STATUS_OPENING1
	.byte >door_opening_sprite2	; DOOR_STATUS_OPENING2
	.byte >door_open_sprite		; DOOR_STATUS_OPEN
	.byte >door_closing_sprite1	; DOOR_STATUS_CLOSING1
	.byte >door_closing_sprite2	; DOOR_STATUS_CLOSING2
	.byte >door_closed_sprite	; DOOR_STATUS_CLOSED
	.byte >door_exploded_sprite	; DOOR_STATUS_EXPLODED
	.byte >door_closed_sprite	; DOOR_STATUS_LOCKED
	.byte >door_exploding_sprite1	; DOOR_STATUS_EXPLODING1
	.byte >door_exploding_sprite2	; DOOR_STATUS_EXPLODING2
	.byte >door_exploding_sprite3	; DOOR_STATUS_EXPLODING3
	.byte >door_exploding_sprite4	; DOOR_STATUS_EXPLODING4
	.byte >door_exploding_sprite5	; DOOR_STATUS_EXPLODING5
	.byte >door_exploding_sprite6	; DOOR_STATUS_EXPLODING6


door_closed_sprite:
	.byte 1,10
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00
	.byte $00

door_open_sprite:
	.byte 1,10
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA

door_opening_sprite2:
door_closing_sprite1:
	.byte 1,10
	.byte $00
	.byte $A0
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $0A
	.byte $00

door_opening_sprite1:
door_closing_sprite2:
	.byte 1,10
	.byte $00
	.byte $00
	.byte $00
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $00
	.byte $00
	.byte $00


door_exploded_sprite:
	.byte 1,10
	.byte $00
	.byte $A5
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $AA
	.byte $A5

door_exploding_sprite1:
	.byte 3,10
	.byte $AA,$FF,$66
	.byte $AA,$FF,$66
	.byte $AA,$FF,$AA
	.byte $AA,$FF,$AA
	.byte $AA,$FF,$AA
	.byte $AA,$FF,$AA
	.byte $AA,$FF,$AA
	.byte $AA,$FF,$AA
	.byte $AA,$FF,$66
	.byte $AA,$FF,$66

door_exploding_sprite2:
	.byte 3,10
	.byte $AA,$FF,$EE
	.byte $AA,$FF,$EE
	.byte $EE,$FF,$EE
	.byte $FF,$FF,$EE
	.byte $FF,$FF,$EE
	.byte $FF,$FF,$EE
	.byte $EE,$FF,$EE
	.byte $AA,$FF,$EE
	.byte $AA,$FF,$EE
	.byte $AA,$FF,$EE

door_exploding_sprite3:
	.byte 3,10
	.byte $AA,$00,$AA
	.byte $AA,$A5,$AA
	.byte $FF,$AA,$AA
	.byte $FF,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $FF,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$A5,$AA

door_exploding_sprite4:
	.byte 3,10
	.byte $AA,$00,$AA
	.byte $AA,$A5,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $FF,$AA,$AA
	.byte $FF,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $FF,$AA,$AA
	.byte $AA,$A5,$AA

door_exploding_sprite5:
	.byte 3,10
	.byte $AA,$00,$AA
	.byte $AA,$A5,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $FA,$AA,$AA
	.byte $AF,$A5,$AA

door_exploding_sprite6:
	.byte 3,10
	.byte $AA,$00,$AA
	.byte $AA,$A5,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $FA,$AA,$AA
	.byte $AF,$A5,$AA


