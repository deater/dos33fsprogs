draw_pillar:
	lda	LOCATION
	sec
	sbc	#MIST_PILLAR_EYE	; find which one we are on
	tay
	tax

	lda	PILLAR_ON
	and	powersoftwo,Y

	beq	done_draw_pillar

	; is on, so draw it green
	txa
	asl
	tay

	lda	pillar_sprites,Y
	sta	INL
	lda	pillar_sprites+1,Y
	sta	INH

	lda	#17
	sta	XPOS
	lda	#16
	sta	YPOS

	jsr	put_sprite_crop

done_draw_pillar:
	rts


touch_pillar:
	lda	PILLAR_ON
	tax			; save to see if toggle ship state

	lda	LOCATION
	sec
	sbc	#MIST_PILLAR_EYE	; find which on we touched
	tay

	lda	PILLAR_ON
	eor	powersoftwo,Y
	sta	PILLAR_ON

	; check to see if we need to raise/lower ship

	rts

powersoftwo:
	.byte $01,$02,$04,$08,$10,$20,$40,$80

pillar_sprites:
	.word	eye_sprite,snake_sprite,bug_sprite,anchor_sprite
	.word	arrow_sprite,leaf_sprite,cross_sprite,emu_sprite

eye_sprite:	; @17,16
	.byte 7,6
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$4A,$4A,$4A,$AA,$AA
	.byte $4A,$A4,$44,$A4,$44,$A4,$4A
	.byte $A4,$4A,$44,$4A,$44,$4A,$A4
	.byte $AA,$AA,$A4,$A4,$A4,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA

snake_sprite:	; @17,16
	.byte 6,6
	.byte $AA,$4A,$4A,$AA,$AA,$AA
	.byte $AA,$44,$AA,$4A,$A4,$4A
	.byte $AA,$44,$AA,$44,$AA,$44
	.byte $AA,$44,$AA,$44,$AA,$44
	.byte $AA,$44,$AA,$44,$AA,$44
	.byte $AA,$AA,$A4,$AA,$AA,$A4

bug_sprite:	; @17,16
	.byte 6,5
	.byte $AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$44,$AA,$44,$AA,$44
	.byte $AA,$4A,$44,$44,$44,$4A
	.byte $AA,$AA,$44,$44,$44,$AA
	.byte $AA,$44,$AA,$A4,$AA,$44


anchor_sprite:	; @17,16
	.byte 6,6
	.byte $AA,$AA,$AA,$4A,$AA,$AA
	.byte $AA,$AA,$AA,$44,$AA,$AA
	.byte $AA,$AA,$A4,$44,$A4,$AA
	.byte $AA,$AA,$AA,$44,$AA,$AA
	.byte $AA,$A4,$4A,$44,$4A,$A4
	.byte $AA,$AA,$AA,$A4,$AA,$AA

arrow_sprite:	; @17,16
	.byte 7,6
	.byte $AA,$AA,$AA,$AA,$4A,$4A,$4A
	.byte $AA,$AA,$AA,$AA,$AA,$44,$44
	.byte $AA,$AA,$AA,$4A,$A4,$AA,$A4
	.byte $AA,$AA,$44,$AA,$AA,$AA,$AA
	.byte $A4,$44,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$A4,$AA,$AA,$AA,$AA,$AA

leaf_sprite:	; @17,16
	.byte 6,6
	.byte $AA,$4A,$AA,$AA,$AA,$4A
	.byte $AA,$44,$44,$4A,$44,$44
	.byte $AA,$44,$44,$44,$44,$AA
	.byte $AA,$A4,$44,$44,$44,$4A
	.byte $AA,$4A,$AA,$44,$44,$44
	.byte $AA,$A4,$AA,$AA,$AA,$AA

cross_sprite:	; @17,16
	.byte 6,6
	.byte $AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$A4,$44,$A4,$AA
	.byte $AA,$4A,$AA,$44,$AA,$4A
	.byte $AA,$44,$A4,$44,$A4,$44
	.byte $AA,$AA,$AA,$44,$AA,$AA
	.byte $AA,$AA,$A4,$A4,$A4,$AA

emu_sprite:	; @17,16
	.byte 7,6
	.byte $AA,$AA,$AA,$AA,$AA,$4A,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$44,$A4
	.byte $AA,$4A,$44,$44,$44,$44,$AA
	.byte $AA,$44,$44,$44,$44,$A4,$AA
	.byte $AA,$44,$AA,$44,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$A4,$A4,$AA,$AA





tree2_pillars:
	lda	DIRECTION
	cmp	#DIRECTION_E
	beq	tree2_east
	bne	tree2_west

tree2_west:
	lda	CURSOR_X
	cmp	#22
	bcs	goto_bug_pillar
	bcc	goto_anchor_pillar

tree2_east:
	lda	CURSOR_X
	cmp	#18
	bcs	goto_arrow_pillar
	bcc	goto_leaf_pillar

pool_pillars:
	lda	DIRECTION
	cmp	#DIRECTION_E
	beq	pool_east
	bne	pool_west

pool_west:
	lda	CURSOR_X
	cmp	#28
	bcs	goto_eye_pillar
	cmp	#12
	bcs	goto_snake_pillar
	bcc	goto_bug_pillar

pool_east:
	lda	CURSOR_X
	cmp	#28
	bcs	goto_leaf_pillar
	cmp	#11
	bcs	goto_cross_pillar
	bcc	goto_emu_pillar


goto_eye_pillar:
	lda	#MIST_PILLAR_EYE
	jmp	done_pillar

goto_snake_pillar:
	lda	#MIST_PILLAR_SNAKE
	jmp	done_pillar

goto_bug_pillar:
	lda	#MIST_PILLAR_BUG
	jmp	done_pillar

goto_anchor_pillar:
	lda	#MIST_PILLAR_ANCHOR
	jmp	done_pillar


goto_emu_pillar:
	lda	#MIST_PILLAR_EMU
	jmp	done_pillar

goto_cross_pillar:
	lda	#MIST_PILLAR_CROSS
	jmp	done_pillar

goto_leaf_pillar:
	lda	#MIST_PILLAR_LEAF
	jmp	done_pillar

goto_arrow_pillar:
	lda	#MIST_PILLAR_ARROW
	jmp	done_pillar

done_pillar:
	sta	LOCATION
	jmp	change_location



;=======================
; flip circuit breaker

; if room==MIST_TOWER2_TOP, and with #$fe
; if room==MIST_TOWER1_TOP, and with #$fd

circuit_breaker:

	bit	$C030		; click speaker

	lda	LOCATION
	cmp	#MIST_TOWER2_TOP
	bne	other_circuit_breaker

	lda	BREAKER_TRIPPED
	and	#$fe
	jmp	done_circuit_breaker

other_circuit_breaker:
	lda	BREAKER_TRIPPED
	and	#$fd

done_circuit_breaker:
	sta	BREAKER_TRIPPED

	bne	done_turn_on_breaker

turn_on_breaker:

	lda	GENERATOR_VOLTS
	cmp	#$60
	bcs	done_turn_on_breaker

	sta	ROCKET_VOLTS
	sta	ROCKET_VOLTS_DISP


done_turn_on_breaker:

	rts


;======================
; open the spaceship door

open_ss_door:

	; check if voltage is 59
	lda	ROCKET_VOLTS
	cmp	#$59
	bne	done_ss_door

	; change to open door image
	ldy	#LOCATION_NORTH_BG
	lda	#<spaceship_door_open_n_lzsa
	sta	location26,Y				; MIST_ROCKET_CLOSE
	lda	#>spaceship_door_open_n_lzsa
	sta	location26+1,Y				; MIST_ROCKET_CLOSE

	; change to load new level if through
	ldy	#LOCATION_SPECIAL_FUNC
	lda	#<(go_to_selena-1)
	sta	location26,Y				; MIST_ROCKET_CLOSE
	lda	#>(go_to_selena-1)
	sta	location26+1,Y				; MIST_ROCKET_CLOSE

	jsr	change_location

done_ss_door:
	rts


;======================
; go to selena
;======================

go_to_selena:

	lda	#LOAD_SELENA		; Selena
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts

;======================
; go to generator
;======================

go_to_generator:

	lda	CURSOR_X
	cmp	#27
	bcs	goto_tower

	cmp	#13
	bcs	goto_shack

marker_switch:
	; FIXME
	rts

goto_shack:
	lda	#GEN_GREEN_SHACK
	jmp	into_generator

goto_tower:
	lda	#GEN_TOWER1_TRAIL

into_generator:
	sta	LOCATION

	lda	#LOAD_GENERATOR		; Selena
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts






