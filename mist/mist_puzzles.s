	;==========================
	; adjust ship up/down
	;==========================
adjust_ship:

	lda	SHIP_RAISED
	bne	make_ship_up
	jmp	make_ship_down

make_ship_up:

	; update backgrounds south

	ldy	#LOCATION_SOUTH_BG

	lda	#<pool_shipup_s_lzsa
	sta	location10,Y				; MIST_POOL
	lda	#>pool_shipup_s_lzsa
	sta	location10+1,Y				; MIST_POOL

	lda	#<gear_shipup_s_lzsa
	sta	location15,Y				; MIST_GEAR
	lda	#>gear_shipup_s_lzsa
	sta	location15+1,Y				; MIST_GEAR

	lda	#<dock_switch_shipup_s_lzsa
	sta	location1,Y				; MIST_DOCK_SWITCH
	lda	#>dock_switch_shipup_s_lzsa
	sta	location1+1,Y				; MIST_DOCK_SWITCH

	lda	#<above_dock_shipup_s_lzsa
	sta	location3,Y				; MIST_ABOVE_DOCK
	lda	#>above_dock_shipup_s_lzsa
	sta	location3+1,Y				; MIST_ABOVE_DOCK



	; update backgrounds north

	ldy	#LOCATION_NORTH_BG

	lda	#<tree1_shipup_n_lzsa
	sta	location20,Y				; MIST_TREE_CORRIDOR_1
	lda	#>tree1_shipup_n_lzsa
	sta	location20+1,Y				; MIST_TREE_CORRIDOR_1

	lda	#<dock_shipup_n_lzsa
	sta	location0,Y				; MIST_ARRIVAL_DOCK
	lda	#>dock_shipup_n_lzsa
	sta	location0+1,Y				; MIST_ARRIVAL_DOCK

	; update backgrounds east

	ldy	#LOCATION_EAST_BG
	lda	#<step_top_shipup_e_lzsa
	sta	location9,Y				; MIST_OUTSIDE_TEMPLE
	lda	#>step_top_shipup_e_lzsa
	sta	location9+1,Y				; MIST_OUTSIDE_TEMPLE

	lda	#<step_land3_shipup_e_lzsa
	sta	location8,Y				; MIST_STEPS_4TH_LANDING
	lda	#>step_land3_shipup_e_lzsa
	sta	location8+1,Y				; MIST_STEPS_4TH_LANDING

	lda	#<step_dentist_shipup_e_lzsa
	sta	location7,Y				; MIST_STEPS_DENTIST
	lda	#>step_dentist_shipup_e_lzsa
	sta	location7+1,Y				; MIST_STEPS_DENTIST

	lda	#<step_land2_shipup_e_lzsa
	sta	location6,Y				; MIST_STEPS_2ND_LANDING
	lda	#>step_land2_shipup_e_lzsa
	sta	location6+1,Y				; MIST_STEPS_2ND_LANDING

	lda	#<step_land1_shipup_e_lzsa
	sta	location5,Y				; MIST_STEPS_1ST_LANDING
	lda	#>step_land1_shipup_e_lzsa
	sta	location5+1,Y				; MIST_STEPS_1ST_LANDING

	lda	#<above_dock_shipup_e_lzsa
	sta	location3,Y				; MIST_ABOVE_DOCK
	sta	location16,Y				; MIST_GEAR_BASE
	lda	#>above_dock_shipup_e_lzsa
	sta	location3+1,Y				; MIST_ABOVE_DOCK
	sta	location16+1,Y				; MIST_GEAR_BASE

	lda	#<dock_shipup_e_lzsa
	sta	location0,Y				; MIST_ARRIVAL_DOCK
	sta	location30,Y				; MIST_VIEWER_DOOR
	lda	#>dock_shipup_e_lzsa
	sta	location0+1,Y				; MIST_ARRIVAL_DOCK
	sta	location30+1,Y				; MIST_VIEWER_DOOR


	; FIXME: hook up exit on dock to ship


	rts

make_ship_down:

	; update backgrounds south

	ldy	#LOCATION_SOUTH_BG
	lda	#<pool_s_lzsa
	sta	location10,Y				; MIST_POOL
	lda	#>pool_s_lzsa
	sta	location10+1,Y				; MIST_POOL

	lda	#<gear_s_lzsa
	sta	location15,Y				; MIST_GEAR
	lda	#>gear_s_lzsa
	sta	location15+1,Y				; MIST_GEAR

	lda	#<dock_switch_s_lzsa
	sta	location1,Y				; MIST_DOCK_SWITCH
	lda	#>dock_switch_s_lzsa
	sta	location1+1,Y				; MIST_DOCK_SWITCH

	lda	#<above_dock_s_lzsa
	sta	location3,Y				; MIST_ABOVE_DOCK
	lda	#>above_dock_s_lzsa
	sta	location3+1,Y				; MIST_ABOVE_DOCK

	; update backgrounds north

	ldy	#LOCATION_NORTH_BG
	lda	#<tree1_n_lzsa
	sta	location20,Y				; MIST_TREE_CORRIDOR_1
	lda	#>tree1_n_lzsa
	sta	location20+1,Y				; MIST_TREE_CORRIDOR_1

	lda	#<dock_n_lzsa
	sta	location0,Y				; MIST_ARRIVAL_DOCK
	lda	#>dock_n_lzsa
	sta	location0+1,Y				; MIST_ARRIVAL_DOCK

	; update backgrounds east

	ldy	#LOCATION_EAST_BG
	lda	#<step_top_e_lzsa
	sta	location9,Y				; MIST_OUTSIDE_TEMPLE
	lda	#>step_top_e_lzsa
	sta	location9+1,Y				; MIST_OUTSIDE_TEMPLE

	lda	#<step_land3_e_lzsa
	sta	location8,Y				; MIST_STEPS_4TH_LANDING
	lda	#>step_land3_e_lzsa
	sta	location8+1,Y				; MIST_STEPS_4TH_LANDING

	lda	#<step_dentist_e_lzsa
	sta	location7,Y				; MIST_STEPS_DENTIST
	lda	#>step_dentist_e_lzsa
	sta	location7+1,Y				; MIST_STEPS_DENTIST

	lda	#<step_land2_e_lzsa
	sta	location6,Y				; MIST_STEPS_2ND_LANDING
	lda	#>step_land2_e_lzsa
	sta	location6+1,Y				; MIST_STEPS_2ND_LANDING

	lda	#<step_land1_e_lzsa
	sta	location5,Y				; MIST_STEPS_1ST_LANDING
	lda	#>step_land1_e_lzsa
	sta	location5+1,Y				; MIST_STEPS_1ST_LANDING

	lda	#<above_dock_e_lzsa
	sta	location3,Y				; MIST_ABOVE_DOCK
	sta	location16,Y				; MIST_GEAR_BASE
	lda	#>above_dock_e_lzsa
	sta	location3+1,Y				; MIST_ABOVE_DOCK
	sta	location16+1,Y				; MIST_GEAR_BASE

	lda	#<dock_e_lzsa
	sta	location0,Y				; MIST_ARRIVAL_DOCK
	sta	location30,Y				; MIST_VIEWER_DOOR
	lda	#>dock_e_lzsa
	sta	location0+1,Y				; MIST_ARRIVAL_DOCK
	sta	location30+1,Y				; MIST_VIEWER_DOOR

	; FIXME: remove exit on dock to ship



	rts



	;==========================
	; draw green if on
	;==========================
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


	;=========================
	; pillar was touched
	;=========================

touch_pillar:

	lda	LOCATION
	sec
	sbc	#MIST_PILLAR_EYE	; find which on we touched
	tay

	lda	PILLAR_ON
	eor	powersoftwo,Y
	sta	PILLAR_ON

	rts

	;=====================================
	; check to see if ship needs to change
	;=====================================

check_change_ship:

	; check to see if we need to raise/lower ship

	lda	SHIP_RAISED
	beq	ship_is_down

ship_is_up:
	lda	PILLAR_ON
	cmp	#(PILLAR_SNAKE|PILLAR_BUG|PILLAR_LEAF)
	beq	done_adjusting_ship

	; lower ship
	lda	#0
	jmp	move_the_ship

ship_is_down:

	lda	PILLAR_ON
	cmp	#(PILLAR_SNAKE|PILLAR_BUG|PILLAR_LEAF)
	bne	done_adjusting_ship

	; raise ship
	lda	#1
	jmp	move_the_ship

done_adjusting_ship:
	rts


move_the_ship:
	sta	SHIP_RAISED

	; play noise

	jsr	long_beep

	; adjust the backgrounds

	jsr	adjust_ship

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
	cmp	#DIRECTION_W
	beq	tree2_west

	; handle the pool marker switch
tree2_north:
	lda	CURSOR_X
	cmp	#25
	bcc	tree2_not_switch
	cmp	#32
	bcs	tree2_not_switch

	lda	CURSOR_Y
	cmp	#16
	bcc	tree2_not_switch
	cmp	#24
	bcs	tree2_not_switch

	lda	#MARKER_POOL
	jmp	click_marker_switch

tree2_not_switch:
	; we have to fake going north
	lda	#MIST_TREE_CORRIDOR_1
	sta	LOCATION
	jmp	change_location

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

	jsr	click_speaker	; click speaker

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
	lda	CURSOR_Y
	cmp	#24
	bcc	missed_switch

	cmp	#38
	bcs	missed_switch

	lda	#MARKER_GENERATOR
	jmp	click_marker_switch

missed_switch:

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



	;=================================
	; marker switch compartment stuff
	;=================================

draw_white_page:

	lda	DIRECTION
	cmp	#DIRECTION_N
	bne	no_white_page

	lda	COMPARTMENT_OPEN
	beq	no_white_page

	lda	WHITE_PAGE_TAKEN
	bne	no_white_page

	lda	#<white_page_sprite
	sta	INL
	lda	#>white_page_sprite
	sta	INH

	lda	#25
	sta	XPOS
	lda	#34
	sta	YPOS

	jsr	put_sprite_crop

no_white_page:
	rts


grab_white_page:
	lda	WHITE_PAGE_TAKEN
	bne	missing_page

	jmp	take_white_page

missing_page:
	rts

