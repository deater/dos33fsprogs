;======================
; reset the puzzle inside the clock

clock_inside_reset:

	lda	#0
	sta	CLOCK_TOP
	sta	CLOCK_MIDDLE
	sta	CLOCK_BOTTOM
	sta	CLOCK_COUNT
	rts


;======================
; handle the clock iside puzzle

clock_inside_puzzle:

	lda	XPOS
	cmp	#25
	bcc	inside_not_reset

inside_reset:
	jsr	clock_inside_reset
	rts

inside_not_reset:
	lda	CLOCK_COUNT
	cmp	#9
	beq	inside_done

	lda	XPOS
	cmp	#18
	bcc	inside_left
	bcs	inside_right

inside_left:
	inc	CLOCK_MIDDLE
	inc	CLOCK_BOTTOM
	inc	CLOCK_COUNT
	jmp	wrap_wheels

inside_right:
	inc	CLOCK_MIDDLE
	inc	CLOCK_TOP
	inc	CLOCK_COUNT

wrap_wheels:

	ldx	#0
wrap_wheels_loop:
	lda	CLOCK_TOP,X
	cmp	#3
	bne	no_wrap
	lda	#0
	sta	CLOCK_TOP,X
no_wrap:
	inx
	cpx	#3
	bne	wrap_wheels_loop

inside_done:
	rts



;======================
; draw the clock inside

draw_clock_inside:

	; draw weight

	lda	#<clock_weight_sprite
	sta	INL
	lda	#>clock_weight_sprite
	sta	INH

	lda	#9
	sta	XPOS

	lda	CLOCK_COUNT
	asl
	asl
	clc
	adc	#6
	sta	YPOS
	jsr	put_sprite_crop

	lda	CLOCK_TOP
	asl
	tay
	lda	clock_gear_sprites,Y
	sta	INL
	lda	clock_gear_sprites+1,Y
	sta	INH

	lda	#17
	sta	XPOS
	lda	#8
	sta	YPOS
	jsr	put_sprite_crop

	lda	CLOCK_MIDDLE
	asl
	tay
	lda	clock_gear_sprites,Y
	sta	INL
	lda	clock_gear_sprites+1,Y
	sta	INH

	lda	#17
	sta	XPOS
	lda	#12
	sta	YPOS
	jsr	put_sprite_crop

	lda	CLOCK_BOTTOM
	asl
	tay
	lda	clock_gear_sprites,Y
	sta	INL
	lda	clock_gear_sprites+1,Y
	sta	INH

	lda	#17
	sta	XPOS
	lda	#16
	sta	YPOS
	jsr	put_sprite_crop

	rts


;======================
; open the gear

open_the_gear:

	; FIXME

	; replace gear bg 1
	; re-route click to MECHE age
	; replace gear bg 2
	; replace gear sprite inside clock

	rts



;======================
; raise bridge

raise_bridge:

	lda	CLOCK_BRIDGE
	beq	lower_bridge

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

	jmp	done_clock_bridge

lower_bridge:

	ldy	#LOCATION_SOUTH_EXIT
	lda	#18
	sta	location25,Y

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_N
	sta	location25,Y

	ldy	#LOCATION_SOUTH_BG
	lda	#<clock_puzzle_s_lzsa
	sta	location25,Y
	lda	#>clock_puzzle_s_lzsa
	sta	location25+1,Y


done_clock_bridge:
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
