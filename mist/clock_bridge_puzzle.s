; note, the clock is a bit different in the real game
; can't see face when pressing buttons
; and the way the hands move is a bit more complex

;======================
; reset the puzzle inside the clock

clock_inside_reset:

	lda	#0
	sta	CLOCK_TOP
	sta	CLOCK_MIDDLE
	sta	CLOCK_BOTTOM
	sta	CLOCK_COUNT
	sta	CLOCK_LAST
	rts


;======================
; handle the clock inside puzzle

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

	lda	CLOCK_LAST
	cmp	#1
	bne	left_spin_bottom
	lda	YPOS
	cmp	#24
	bcs	left_nospin_bottom

left_spin_bottom:
	inc	CLOCK_BOTTOM

left_nospin_bottom:
	lda	#1
	jmp	wrap_wheels

inside_right:
	inc	CLOCK_MIDDLE

	lda	CLOCK_LAST
	cmp	#2
	bne	right_spin_top
	lda	YPOS
	cmp	#24
	bcs	right_nospin_top

right_spin_top:
	inc	CLOCK_TOP
right_nospin_top:
	lda	#2

wrap_wheels:
	sta	CLOCK_LAST
	inc	CLOCK_COUNT

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

	; see if done!
	; note 0->3, 1->1, 2->2 so want 2/2/1 -> 2/2/1
	lda	CLOCK_TOP
	cmp	#2
	bne	no_open_gear
	lda	CLOCK_MIDDLE
	cmp	#2
	bne	no_open_gear
	lda	CLOCK_BOTTOM
	cmp	#1
	bne	no_open_gear

	lda	#1
change_gear:
	sta	GEAR_OPEN

	jsr	open_the_gear
	jmp	inside_done

no_open_gear:
	lda	GEAR_OPEN
	beq	inside_done

	; change if it was open
	lda	#0
	jmp	change_gear

inside_done:
	rts



;======================
; draw the clock inside

draw_clock_inside:

	lda	DIRECTION
	cmp	#DIRECTION_S
	bne	done_draw_clock_puzzle

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
	adc	#4
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
done_draw_clock_puzzle:
	rts


;======================
; open the gear

open_the_gear:

	lda	GEAR_OPEN
	beq	no_gear_open

yes_gear_open:
	ldy	#LOCATION_NORTH_EXIT
	lda	#MIST_OPEN_GEAR
	sta	location15,Y			; MIST_GEAR

	ldy	#LOCATION_NORTH_EXIT_DIR
	lda	#DIRECTION_E
	sta	location15,Y			; MIST_GEAR

	ldy	#LOCATION_NORTH_BG
	lda	#<gear_open_n_lzsa
	sta	location15,Y			; MIST_GEAR
	lda	#>gear_open_n_lzsa
	sta	location15+1,Y			; MIST_GEAR

	ldy	#LOCATION_SOUTH_BG
	lda	#<clock_inside_open_lzsa
	sta	location23,Y			; MIST_CLOCK_INSIDE
	lda	#>clock_inside_open_lzsa
	sta	location23+1,Y			; MIST_CLOCK_INSIDE

	jmp	done_open_the_gear


no_gear_open:

	ldy	#LOCATION_NORTH_EXIT
	lda	#$FF
	sta	location15,Y			; MIST_GEAR

;	ldy	#LOCATION_NORTH_EXIT_DIR
;	lda	#DIRECTION_E
;	sta	location15,Y

	ldy	#LOCATION_NORTH_BG
	lda	#<gear_n_lzsa
	sta	location15,Y			; MIST_GEAR
	lda	#>gear_n_lzsa
	sta	location15+1,Y			; MIST_GEAR

	ldy	#LOCATION_SOUTH_BG
	lda	#<clock_inside_s_lzsa		; MIST_CLOCK_INSIDE
	sta	location23,Y
	lda	#>clock_inside_s_lzsa
	sta	location23+1,Y

done_open_the_gear:

	jsr	change_location

	rts



;======================
; raise bridge

raise_bridge:

	lda	CLOCK_BRIDGE
	beq	lower_bridge

	ldy	#LOCATION_SOUTH_EXIT
	lda	#MIST_CLOCK_ISLAND
	sta	location21,Y			; MIST_CLOCK_PUZZLE

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_S
	sta	location21,Y			; MIST_CLOCK_PUZZLE

	ldy	#LOCATION_SOUTH_BG
	lda	#<clock_puzzle_bridge_lzsa
	sta	location21,Y			; MIST_CLOCK_PUZZLE
	lda	#>clock_puzzle_bridge_lzsa
	sta	location21+1,Y			; MIST_CLOCK_PUZZLE

	; draw it on other too
	lda	#<clock_bridge_lzsa
	sta	location11,Y			; MIST_CLOCK
	lda	#>clock_bridge_lzsa
	sta	location11+1,Y			; MIST_CLOCK

	jmp	done_clock_bridge

lower_bridge:

	ldy	#LOCATION_SOUTH_EXIT
;	lda	#MIST_TREE_CORRIDOR_5
	lda	#$ff
	sta	location21,Y			; MIST_CLOCK_PUZZLE

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_N
	sta	location21,Y			; MIST_CLOCK_PUZZLE

	ldy	#LOCATION_SOUTH_BG
	lda	#<clock_puzzle_s_lzsa
	sta	location21,Y			; MIST_CLOCK_PUZZLE
	lda	#>clock_puzzle_s_lzsa
	sta	location21+1,Y			; MIST_CLOCK_PUZZLE

	; lower on other too

	lda	#<clock_s_lzsa
	sta	location11,Y			; MIST_CLOCK
	lda	#>clock_s_lzsa
	sta	location11+1,Y			; MIST_CLOCK

done_clock_bridge:

	rts

;======================
; draw the clock face

draw_clock_face:

	lda	DIRECTION
	cmp	#DIRECTION_S
	bne	done_draw_clock_face

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
done_draw_clock_face:

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

	jsr	click_speaker		; click speaker

	jsr	raise_bridge

	; update the background

	jsr	change_location

clock_puzzle_done:

	rts


.include "clock_sprites.inc"


; put at 12,6 on screen 4 N
gear_block_sprite1:
	.byte 4,3
	.byte $ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$0f

; put at 9,6 on screen 20 N
gear_block_sprite2:
	.byte 7,4
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $fd,$fd,$dd,$ff,$dd,$fd,$df
	.byte $ff,$ff,$dd,$ff,$dd,$ff,$0f

; put at 21,4 on screen 5 N
gear_block_sprite3:
	.byte 2,2
	.byte $ff,$ff
	.byte $ff,$ff


check_gear_delete:

	; all views of gear are when looking north?

	lda	DIRECTION
	cmp	#DIRECTION_N
	bne	done_gear_delete

	lda	LOCATION
	cmp	#MIST_ABOVE_DOCK
	beq	gear_look1
	cmp	#MIST_DOCK_STEPS
	beq	gear_look2
	cmp	#MIST_GEAR_BASE
	beq	gear_look2
	cmp	#MIST_BASE_STEPS
	beq	gear_look3
	bne	done_gear_delete

gear_look1:
	lda	#<gear_block_sprite1
	sta	INL
	lda	#>gear_block_sprite1
	sta	INH
	lda	#12
	sta	XPOS
	lda	#6
	jmp	draw_gear_delete

gear_look2:
	lda	#<gear_block_sprite2
	sta	INL
	lda	#>gear_block_sprite2
	sta	INH
	lda	#9
	sta	XPOS
	lda	#6
	jmp	draw_gear_delete

gear_look3:
	lda	#<gear_block_sprite3
	sta	INL
	lda	#>gear_block_sprite3
	sta	INH
	lda	#21
	sta	XPOS
	lda	#4

draw_gear_delete:
	sta	YPOS
	jsr	put_sprite_crop

done_gear_delete:
	rts
