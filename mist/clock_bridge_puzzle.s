;======================
; raise bridge

raise_bridge:

	ldy	#LOCATION_SOUTH_EXIT
	lda	#26
	sta	location25,Y

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_S
	sta	location25,Y

	ldy	#LOCATION_SOUTH_BG
	lda	#<clock_puzzle_bridge_lzsa
	sta	location25,Y
	lda	#>clock_puzzle_bridge_lzsa
	sta	location25+1,Y

	jsr	change_location

	rts

;======================
; draw the clock face

draw_clock_face:

	lda	CLOCK_HOUR
	asl
	tay
	lda	clock_hour_sprites,Y
	sta	INL
	lda	clock_hour_sprites+1,Y
	sta	INH

	lda	#20
	sta	XPOS
	lda	#6
	sta	YPOS
	jsr	put_sprite_crop

	lda	CLOCK_MINUTE
	asl
	tay
	lda	clock_minute_sprites,Y
	sta	INL
	lda	clock_minute_sprites+1,Y
	sta	INH

	lda	#20
	sta	XPOS
	lda	#6
	sta	YPOS
	jsr	put_sprite_crop

	rts


;======================
; clock puzzle

clock_puzzle:
	lda	CURSOR_X
	cmp	#19
	bcc	clock_puzzle_hours		; blt

	cmp	#24
	bcc	clock_puzzle_minutes		; blt
	bcs	clock_puzzle_button		; bge

clock_puzzle_hours:
	inc	CLOCK_HOUR
	lda	CLOCK_HOUR
	cmp	#12
	bne	clock_puzzle_done

	lda	#0
	sta	CLOCK_HOUR
	beq	clock_puzzle_done

clock_puzzle_minutes:
	inc	CLOCK_MINUTE
	lda	CLOCK_MINUTE
	cmp	#12
	bne	clock_puzzle_done

	lda	#0
	sta	CLOCK_MINUTE
	beq	clock_puzzle_done

clock_puzzle_button:

	lda	CLOCK_MINUTE
	cmp	#8
	bne	bridge_down

	lda	CLOCK_HOUR
	cmp	#2
	bne	bridge_down

	lda	#1
	jmp	bridge_adjust

bridge_down:
	lda	#0

bridge_adjust:
	sta	CLOCK_BRIDGE

	bit	$C030		; click speaker

	jsr	raise_bridge

clock_puzzle_done:

	rts


.include "clock_sprites.inc"
