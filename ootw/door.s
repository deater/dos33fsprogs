
DOOR_STATUS_OPEN	= $00
DOOR_STATUS_OPENING1	= $01
DOOR_STATUS_OPENING2	= $02
DOOR_STATUS_CLOSING1	= $03
DOOR_STATUS_CLOSING2	= $04
DOOR_STATUS_CLOSED	= $05
DOOR_STATUS_EXPLODED	= $06
DOOR_STATUS_LOCKED	= $07
DOOR_STATUS_EXPLODING	= $08


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

;	ldy	#1

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

	jsr	put_sprite

	pla
	tax

draw_doors_continue:
	inx
	cpx	NUM_DOORS
	bne	draw_doors_loop

done_draw_doors:

	rts


	;==========================
	; handle doors

handle_doors:

	; if closed xpos in range and phys ypos match -> opening
	; if open, xpos out of range, -> closing

	; if opening, update

	; if closing, update

	; if exploding, update



	rts




;======================================
;======================================
; door sprites
;======================================
;======================================


door_sprite_lookup_lo:
	.byte <door_open_sprite		; DOOR_STATUS_OPEN
	.byte <door_opening_sprite1	; DOOR_STATUS_OPENING1
	.byte <door_opening_sprite2	; DOOR_STATUS_OPENING2
	.byte <door_closing_sprite1	; DOOR_STATUS_CLOSING1
	.byte <door_closing_sprite2	; DOOR_STATUS_CLOSING2
	.byte <door_closed_sprite	; DOOR_STATUS_CLOSED
	.byte <door_exploded_sprite	; DOOR_STATUS_EXPLODED
	.byte <door_closed_sprite	; DOOR_STATUS_LOCKED
	.byte <door_exploding_sprite1	; DOOR_STATUS_EXPLODING

door_sprite_lookup_hi:

	.byte >door_open_sprite		; DOOR_STATUS_OPEN
	.byte >door_opening_sprite1	; DOOR_STATUS_OPENING1
	.byte >door_opening_sprite2	; DOOR_STATUS_OPENING2
	.byte >door_closing_sprite1	; DOOR_STATUS_CLOSING1
	.byte >door_closing_sprite2	; DOOR_STATUS_CLOSING2
	.byte >door_closed_sprite	; DOOR_STATUS_CLOSED
	.byte >door_exploded_sprite	; DOOR_STATUS_EXPLODED
	.byte >door_closed_sprite	; DOOR_STATUS_LOCKED
	.byte >door_exploding_sprite1	; DOOR_STATUS_EXPLODING


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
