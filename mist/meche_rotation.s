	;=================================
	;=================================
	; rotation stuff
	;=================================
	;=================================

handle_rotation_controls:

	lda	CURSOR_Y

	cmp	#34
	bcs	rot_button_press

	lda	CURSOR_X
	cmp	#19
	bcc	handle_left	; blt

handle_right:

	lda	MECHE_LEVERS
	eor	#RIGHT_LEVER
	sta	MECHE_LEVERS

	rts

handle_left:
	lda	MECHE_LEVERS
	eor	#LEFT_LEVER
	sta	MECHE_LEVERS

	; if flip to 0, then update rotation

	and	#LEFT_LEVER
	bne	done_handle_left

	jsr	rotate_fortress

done_handle_left:
	rts


rot_button_press:

	; get outside and face elevator
	lda	#MECHE_TOP_FLOOR
	sta	LOCATION
	lda	#DIRECTION_W
	sta	DIRECTION

	; change to plain elevator
	ldy	#LOCATION_WEST_BG
	lda	#<top_floor_ye_w_lzsa
	sta	location27,Y
	lda	#>top_floor_ye_w_lzsa
	sta	location27+1,Y

	; change destination to controls
	ldy	#LOCATION_WEST_EXIT
	lda	#MECHE_IN_ELEVATOR
	sta	location27,Y

	jmp	change_location		; tail call




	;=================================
	; draw rotation controls
	;=================================

draw_rotation_controls:

	;==========================
	; rotate, where applicable

	lda	MECHE_LEVERS
	and	#LEFT_LEVER
	beq	draw_rotation

	lda	MECHE_LEVERS
	and	#RIGHT_LEVER
	beq	draw_rotation

	lda	FRAMEL
	and	#$f
	bne	draw_rotation

	inc	MECHE_ROTATION
	lda	MECHE_ROTATION
	and	#$f
	sta	MECHE_ROTATION

draw_rotation:

	; draw rotation
	lda	MECHE_ROTATION
	lsr
	lsr
	; 0 -> $C1 at 19,8
	; 1 -> $10 at 21,4
	; 2 -> $01 at 19,2
	; 3 -> $10 at 17,4

	beq	rot0
	cmp	#1
	beq	rot1
	cmp	#2
	beq	rot2
	bne	rot3

rot0:
	lda	#$C1
	sta	$613
	sta	$A13
	jmp	draw_levers
rot1:
	lda	#$10
	sta	$515
	sta	$915
	jmp	draw_levers
rot2:
	lda	#$01
	sta	$493
	sta	$893
	jmp	draw_levers
rot3:
	lda	#$10
	sta	$511
	sta	$911
	jmp	draw_levers

draw_levers:
	; draw left lever
	lda	#<lever_sprite
	sta	INL
	lda	#>lever_sprite
	sta	INH

	lda	#15
	sta	XPOS

	lda	MECHE_LEVERS
	and	#LEFT_LEVER
	eor	#LEFT_LEVER
	asl
	asl
	asl
	clc
	adc	#20
	sta	YPOS

	jsr	put_sprite_crop

	; draw right lever

	lda	#<lever_sprite
	sta	INL
	lda	#>lever_sprite
	sta	INH

	lda	#21
	sta	XPOS

	lda	MECHE_LEVERS
	and	#RIGHT_LEVER
	eor	#RIGHT_LEVER
	asl
	asl
	clc
	adc	#20
	sta	YPOS

	jsr	put_sprite_crop

	rts

lever_sprite:
	.byte 4,3
	.byte $0A,$00,$00,$0A
	.byte $00,$00,$05,$00
	.byte $A0,$00,$00,$A0





	;========================
	; rotate fortress

rotate_fortress:

	lda	MECHE_ROTATION
	lsr
	lsr
	beq	fortress_south
	cmp	#1
	beq	fortress_east
	cmp	#2
	beq	fortress_north
	bne	fortress_west

fortress_south:

	; point exit south (original entry point)

	ldy	#LOCATION_SOUTH_EXIT
	lda	#MECHE_BRIDGE2
	sta	location8,Y			; MECH_FORT_ENTRY

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_S
	sta	location8,Y			; MECH_FORT_ENTRY

	; set bg to orig entry background

	ldy	#LOCATION_SOUTH_BG

	lda	#<fort_entry_s_lzsa
	sta	location8,Y
	lda	#>fort_entry_s_lzsa

	jmp	rotate_fortress_done

fortress_west:

	; point exit south (original entry point)

	ldy	#LOCATION_SOUTH_EXIT
	lda	#MECHE_WEST_PLATFORM
	sta	location8,Y			; MECH_FORT_ENTRY

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_W
	sta	location8,Y			; MECH_FORT_ENTRY

	; set bg to orig entry background

	ldy	#LOCATION_SOUTH_BG

	lda	#<fort_exit_w_lzsa
	sta	location8,Y
	lda	#>fort_exit_w_lzsa

	jmp	rotate_fortress_done

fortress_east:

	; point exit south (original entry point)

	ldy	#LOCATION_SOUTH_EXIT
	lda	#MECHE_EAST_PLATFORM
	sta	location8,Y			; MECH_FORT_ENTRY

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_E
	sta	location8,Y			; MECH_FORT_ENTRY

	; set bg to orig entry background

	ldy	#LOCATION_SOUTH_BG

	lda	#<fort_exit_e_lzsa
	sta	location8,Y
	lda	#>fort_exit_e_lzsa

	jmp	rotate_fortress_done

fortress_north:

	; point exit south (original entry point)

	ldy	#LOCATION_SOUTH_EXIT
	lda	#MECHE_NORTH_PLATFORM
	sta	location8,Y			; MECH_FORT_ENTRY

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_N
	sta	location8,Y			; MECH_FORT_ENTRY

	; set bg to orig entry background

	ldy	#LOCATION_SOUTH_BG

	lda	#<fort_exit_n_lzsa
	sta	location8,Y
	lda	#>fort_exit_n_lzsa

	jmp	rotate_fortress_done



rotate_fortress_done:

	sta	location8+1,Y

	rts



	;==================================
	; elevator stuff
	;==================================


	;==============================
	; handle elevator button pushes

elevator_button:
	lda	CURSOR_Y
	cmp	#24
	bcs	elevator_goto_ground
	cmp	#20
	bcs	elevator_goto_half

elevator_goto_top:

	; set exit to top floor

	ldy	#LOCATION_EAST_EXIT
	lda	#MECHE_TOP_FLOOR
	sta	location26,Y

	; set bg to top-floor backround

	ldy	#LOCATION_EAST_BG

	lda	#<elevator_top_e_lzsa
	sta	location26,Y
	lda	#>elevator_top_e_lzsa

	jmp	elevator_button_done


elevator_goto_ground:

	; set exit to top floor

	ldy	#LOCATION_EAST_EXIT
	lda	#MECHE_ELEVATOR_PATH
	sta	location26,Y

	; set bg to top-floor backround

	ldy	#LOCATION_EAST_BG

	lda	#<elevator_ground_e_lzsa
	sta	location26,Y
	lda	#>elevator_ground_e_lzsa

	jmp	elevator_button_done




elevator_goto_half:

	;  if at top kick outside and lower
	; TODO: animation?

	ldy	#LOCATION_EAST_EXIT
	cpy	#MECHE_TOP_FLOOR
	beq	regular_half

half_and_controls:
	;=============================
	; kick us out, lower controls

	; get outside and face elevator
	lda	#MECHE_TOP_FLOOR
	sta	LOCATION
	lda	#DIRECTION_W
	sta	DIRECTION

	; change to elevator roof
	ldy	#LOCATION_WEST_BG
	lda	#<top_floor_ne_w_lzsa
	sta	location27,Y
	lda	#>top_floor_ne_w_lzsa
	sta	location27+1,Y

	; change destination to controls
	ldy	#LOCATION_WEST_EXIT
	lda	#MECHE_ROTATE_CONTROLS
	sta	location27,Y

	jmp	elevator_button_done_no_update

regular_half:
	; set exit to top floor

	ldy	#LOCATION_EAST_EXIT
	lda	#$ff
	sta	location26,Y

	; set bg to half-floor backround

	ldy	#LOCATION_EAST_BG

	lda	#<elevator_half_e_lzsa
	sta	location26,Y
	lda	#>elevator_half_e_lzsa

	jmp	elevator_button_done



elevator_goto_controls:

elevator_button_done:

	sta	location26+1,Y

elevator_button_done_no_update:

	jsr	change_location		; tail call?

	rts


	;=================
	; elevator panel clicked

	; behavior a bit different in real game (it slides around more)
	; also in theory could animate handle
	; Apple II doesn't let you know length of keypress

elevator_panel_clicked:

	lda	MECHE_ELEVATOR
	clc
	adc	#1
	and	#$83
	sta	MECHE_ELEVATOR

	jsr	adjust_basement_door

	rts


	;=====================
	; draw elevator panel

draw_elevator_panel:

	lda	MECHE_ELEVATOR
	and	#$f
	asl
	tay

	lda	elevator_rotation_sprites,Y
	sta	INL
	lda	elevator_rotation_sprites+1,Y
	sta	INH

	lda	#13
	sta	XPOS
	lda	#20
	sta	YPOS

	jsr	put_sprite_crop

	rts

	;==================================
	; basement door button
	;==================================

basement_button:

	; flip switch

	lda	#$80
	eor	MECHE_ELEVATOR
	sta	MECHE_ELEVATOR

	jsr	adjust_basement_door

	jsr	change_location

	rts

	;==================================
	; adjust basement door
	;==================================

adjust_basement_door:

	lda	MECHE_ELEVATOR
	bmi	floor_open

floor_closed:
	and	#$f
	cmp	#2
	beq	floor_closed_elevator_on
	bne	floor_closed_elevator_off

floor_open:

	; point exit to basement

	ldy	#LOCATION_WEST_EXIT
	lda	#MECHE_BASEMENT
	sta	location18,Y

	lda	MECHE_ELEVATOR
	and	#$f
	cmp	#2
	beq	floor_open_elevator_on
	bne	floor_open_elevator_off

floor_open_elevator_on:

	; point background to open floor / open elevator

	ldy	#LOCATION_WEST_BG
	lda	#<red_button_of_oe_w_lzsa
	sta	location18,Y
	lda	#>red_button_of_oe_w_lzsa
	jmp	adjust_basement_door_done

floor_open_elevator_off:

	; point background to open floor / closed elevator

	ldy	#LOCATION_WEST_BG

	lda	#<red_button_of_ce_w_lzsa
	sta	location18,Y
	lda	#>red_button_of_ce_w_lzsa
	jmp	adjust_basement_door_done

floor_closed_elevator_on:

	; point hallway to elevator path

	ldy	#LOCATION_WEST_EXIT
	lda	#MECHE_ELEVATOR_PATH
	sta	location18,Y

	ldy	#LOCATION_WEST_BG

	lda	#<red_button_cf_oe_w_lzsa
	sta	location18,Y
	lda	#>red_button_cf_oe_w_lzsa
	jmp	adjust_basement_door_done


floor_closed_elevator_off:

	; disabl exit

	ldy	#LOCATION_WEST_EXIT
	lda	#$ff
	sta	location18,Y

	ldy	#LOCATION_WEST_BG

	lda	#<red_button_cf_ce_w_lzsa
	sta	location18,Y
	lda	#>red_button_cf_ce_w_lzsa
	jmp	adjust_basement_door_done


adjust_basement_door_done:
	sta	location18+1,Y
	rts

adjust_fortress_rotation:

	rts


	;==================================
	; sprites
	;==================================

elevator_rotation_sprites:
	.word elevator0,elevator1,elevator2,elevator3

elevator0:
	.byte 3,2
	.byte $00,$ff,$00
	.byte $f0,$0f,$f0

elevator1:
	.byte 3,2
	.byte $0f,$f0,$f0
	.byte $f0,$0f,$0f

elevator2:
	.byte 3,2
	.byte $1f,$f1,$1f
	.byte $11,$ff,$11

elevator3:
	.byte 3,2
	.byte $f0,$f0,$0f
	.byte $0f,$0f,$f0
