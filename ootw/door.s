
DOOR_STATUS	= 0
	DOOR_STATUS_OPEN	= $01
	DOOR_STATUS_OPENING	= $02
	DOOR_STATUS_CLOSING	= $04
	DOOR_STATUS_CLOSED	= $08
	DOOR_STATUS_EXPLODED	= $10
	DOOR_STATUS_LOCKED	= $20
	DOOR_STATUS_EXPLODING	= $40
DOOR_EXPLODE_DIR	= 1
DOOR_LEFT_TRIGGER	= 2
DOOR_RIGHT_TRIGGER	= 3
DOOR_STEP		= 4
DOOR_XPOS		= 5
DOOR_YPOS		= 6

door_state:

door_state0:
	.byte $0	; status
	.byte $0	; explode_dir
	.byte $0	; left_trigger
	.byte $0	; right_trigger
	.byte $0	; step


draw_doors:

	lda	door_state+DOOR_STATUS
	and	#(DOOR_STATUS_OPEN | DOOR_STATUS_EXPLODED)
	bne	done_draw_doors

	lda	door_state+DOOR_STATUS
	cmp	#DOOR_STATUS_CLOSED
	bne	door_not_closed

door_closed:
	lda	#<door_closed_sprite
	sta	INL
	lda	#>door_closed_sprite
	sta	INH
	jmp	actually_draw_door


door_not_closed:


actually_draw_door:
	lda	door_state+DOOR_XPOS
	sta	XPOS
	lda	door_state+DOOR_YPOS
	sta	YPOS

	jsr	put_sprite

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

door_opening_sprite:
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
