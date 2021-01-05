;===========================
; draw windmill handle
;===========================

draw_windmill_handle:
	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_N
	bne	no_draw_windmill_handle

	lda	CHANNEL_SWITCHES
	and	#CHANNEL_SW_WINDMILL
	beq	no_draw_windmill_handle

	lda	#11
	sta	XPOS
	lda	#32
	sta	YPOS
	lda	#<windmill_handle_sprite
	sta	INL
	lda	#>windmill_handle_sprite
	sta	INH

	jsr	put_sprite_crop
no_draw_windmill_handle:
	rts

windmill_handle_sprite:
	.byte 3,2
	.byte $04,$ff,$44
	.byte $21,$41,$41

;===========================
; draw water valve
;===========================

draw_water_faucet:
	lda	CHANNEL_SWITCHES
	and	#CHANNEL_SW_FAUCET
	beq	no_draw_faucet

	lda	#17
	sta	XPOS
	lda	#20
	sta	YPOS
	lda	#<faucet_open_sprite
	sta	INL
	lda	#>faucet_open_sprite
	sta	INH

	jsr	put_sprite_crop
no_draw_faucet:
	rts


faucet_open_sprite:
	.byte 6,6
	.byte $77,$77,$ff,$ff,$ff,$ff
	.byte $f9,$97,$77,$9f,$f9,$ff
	.byte $ff,$97,$d0,$9f,$ff,$ff
	.byte $f9,$dd,$dd,$dd,$f9,$ff
	.byte $ff,$ff,$dd,$77,$67,$27
	.byte $ff,$ff,$fd,$77,$82,$96




;===========================
;===========================
; handle valve 1-6
;===========================
;===========================
handle_valve1:
	lda	CHANNEL_VALVES
	eor	#CHANNEL_VALVE1
	jmp	common_handle_valves
handle_valve2:
	lda	CHANNEL_VALVES
	eor	#CHANNEL_VALVE2
	jmp	common_handle_valves
handle_valve3:
	lda	CHANNEL_VALVES
	eor	#CHANNEL_VALVE3
	jmp	common_handle_valves
handle_valve4:
	lda	CHANNEL_VALVES
	eor	#CHANNEL_VALVE4
	jmp	common_handle_valves
handle_valve5:
	lda	CHANNEL_VALVES
	eor	#CHANNEL_VALVE5
	jmp	common_handle_valves
handle_valve6:
	lda	CHANNEL_VALVES
	eor	#CHANNEL_VALVE6

common_handle_valves:
	sta	CHANNEL_VALVES
	jsr	adjust_valve_backgrounds

	jsr	click_speaker

	jmp	change_direction	; update background

;===========================
;===========================
; goto valves multiple case
;===========================
;===========================

; path5

goto_path5_valve:
	lda	DIRECTION
	cmp	#DIRECTION_N
	bne	path5_south

path5_north:
	lda	CURSOR_Y
	cmp	#38
	bcc	path5_go_north	; blt
	jmp	goto_valve2
path5_go_north:
	lda	#CHANNEL_PATH7	; didn't hit valve, move instead
	sta	LOCATION
	jmp	change_location

path5_south:
	lda	CURSOR_Y
	cmp	#32
	bcs	path5_go_south
	jmp	goto_valve5

path5_go_south:
	lda	#CHANNEL_PATH6	; didn't hit valve, move instead
	sta	LOCATION
	jmp	change_location



; path6
; 6S goes to valve6
; 6W goes to valve5
; 6N goes to valve4

goto_path6_valve:
	lda	DIRECTION
	cmp	#DIRECTION_S
	beq	path6_south
	cmp	#DIRECTION_W
	beq	path6_west

path6_north:
	lda	CURSOR_Y
	cmp	#38
	bcc	path6_go_north	; blt
	jmp	goto_valve5
path6_go_north:
	lda	#CHANNEL_PATH5	; didn't hit valve, move instead
	sta	LOCATION
	jmp	change_location

path6_south:
	lda	CURSOR_Y
	cmp	#32
	bcs	path6_go_south	; bge
	jmp	goto_valve6

path6_go_south:
	lda	#CHANNEL_PATH2	; didn't hit valve, move instead
	sta	LOCATION
	jmp	change_location

path6_west:
	lda	CURSOR_Y
	cmp	#32
	bcs	path6_go_west	; bge
	jmp	goto_valve4

path6_go_west:
	lda	#CHANNEL_FORK	; didn't hit valve, move instead
	sta	LOCATION
	jmp	change_location

;===========================
;===========================
; goto valves
;===========================
;===========================
goto_valve1:
	lda	#CHANNEL_VALVE1_ELEVATOR2
	bne	common_goto_valve		; bra
goto_valve2:
	lda	#CHANNEL_VALVE2_TREE
	bne	common_goto_valve		; bra
goto_valve3:
	lda	#CHANNEL_VALVE3_BROKEN
	bne	common_goto_valve		; bra
goto_valve4:
	lda	#CHANNEL_VALVE4_ELEVATOR1
	bne	common_goto_valve		; bra
goto_valve5:
	lda	#CHANNEL_VALVE5_FORK
	bne	common_goto_valve		; bra
goto_valve6:
	lda	#CHANNEL_VALVE6_ENTRY
	bne	common_goto_valve		; bra
common_goto_valve:
	sta	LOCATION
	jmp	change_location


;===========================
;===========================
; adjust valve backgrounds
;===========================
;===========================
adjust_valve_backgrounds:

	;=======================
	; for valve1

check_valve1:
	lda	CHANNEL_VALVES
	and	#CHANNEL_VALVE1
	beq	valve1_is_off

valve1_is_on:
	ldy	#LOCATION_NORTH_BG
	lda	#<valve_bottom_on_lzsa
	sta	location38,Y				; CHANNEL_VALVE1_ELEVATOR2
	lda	#>valve_bottom_on_lzsa
	sta	location38+1,Y				; CHANNEL_VALVE1_ELEVATOR2

	ldy	#LOCATION_SOUTH_BG
	lda	#<valve_top_on_lzsa
	sta	location38,Y				; CHANNEL_VALVE1_ELEVATOR2
	lda	#>valve_top_on_lzsa
	sta	location38+1,Y				; CHANNEL_VALVE1_ELEVATOR2

	jmp	check_valve2

valve1_is_off:
	ldy	#LOCATION_NORTH_BG
	lda	#<valve_bottom_off_lzsa
	sta	location38,Y				; CHANNEL_VALVE1_ELEVATOR2
	lda	#>valve_bottom_off_lzsa
	sta	location38+1,Y				; CHANNEL_VALVE1_ELEVATOR2

	ldy	#LOCATION_SOUTH_BG
	lda	#<valve_top_off_lzsa
	sta	location38,Y				; CHANNEL_VALVE1_ELEVATOR2
	lda	#>valve_top_off_lzsa
	sta	location38+1,Y				; CHANNEL_VALVE1_ELEVATOR2


check_valve2:

	lda	CHANNEL_VALVES
	and	#CHANNEL_VALVE2
	beq	valve2_is_off

valve2_is_on:
	ldy	#LOCATION_NORTH_BG
	lda	#<valve_bottom_on_lzsa
	sta	location39,Y				; CHANNEL_VALVE2
	lda	#>valve_bottom_on_lzsa
	sta	location39+1,Y				; CHANNEL_VALVE2

	ldy	#LOCATION_SOUTH_BG
	lda	#<valve_top_on_lzsa
	sta	location39,Y				; CHANNEL_VALVE2
	lda	#>valve_top_on_lzsa
	sta	location39+1,Y				; CHANNEL_VALVE2

	jmp	check_valve3

valve2_is_off:
	ldy	#LOCATION_NORTH_BG
	lda	#<valve_bottom_off_lzsa
	sta	location39,Y				; CHANNEL_VALVE2
	lda	#>valve_bottom_off_lzsa
	sta	location39+1,Y				; CHANNEL_VALVE2

	ldy	#LOCATION_SOUTH_BG
	lda	#<valve_top_off_lzsa
	sta	location39,Y				; CHANNEL_VALVE2
	lda	#>valve_top_off_lzsa
	sta	location39+1,Y				; CHANNEL_VALVE2

check_valve3:

	lda	CHANNEL_VALVES
	and	#CHANNEL_VALVE3
	beq	valve3_is_off

valve3_is_on:
	ldy	#LOCATION_WEST_BG
	lda	#<valve_bottom_on_lzsa
	sta	location40,Y				; CHANNEL_VALVE3
	lda	#>valve_bottom_on_lzsa
	sta	location40+1,Y				; CHANNEL_VALVE3

	jmp	check_valve4

valve3_is_off:
	ldy	#LOCATION_WEST_BG
	lda	#<valve_bottom_off_lzsa
	sta	location40,Y				; CHANNEL_VALVE3
	lda	#>valve_bottom_off_lzsa
	sta	location40+1,Y				; CHANNEL_VALVE3

check_valve4:

	lda	CHANNEL_VALVES
	and	#CHANNEL_VALVE4
	beq	valve4_is_off

valve4_is_on:
	ldy	#LOCATION_NORTH_BG
	lda	#<valve_bottom_on_lzsa
	sta	location41,Y				; CHANNEL_VALVE4
	lda	#>valve_bottom_on_lzsa
	sta	location41+1,Y				; CHANNEL_VALVE4

	ldy	#LOCATION_WEST_BG
	lda	#<valve_top_on_lzsa
	sta	location41,Y				; CHANNEL_VALVE4
	lda	#>valve_top_on_lzsa
	sta	location41+1,Y				; CHANNEL_VALVE4

	jmp	check_valve5

valve4_is_off:
	ldy	#LOCATION_NORTH_BG
	lda	#<valve_bottom_off_lzsa
	sta	location41,Y				; CHANNEL_VALVE4
	lda	#>valve_bottom_off_lzsa
	sta	location41+1,Y				; CHANNEL_VALVE4

	ldy	#LOCATION_WEST_BG
	lda	#<valve_top_off_lzsa
	sta	location41,Y				; CHANNEL_VALVE4
	lda	#>valve_top_off_lzsa
	sta	location41+1,Y				; CHANNEL_VALVE4

check_valve5:

	lda	CHANNEL_VALVES
	and	#CHANNEL_VALVE5
	beq	valve5_is_off

valve5_is_on:
	ldy	#LOCATION_NORTH_BG
	lda	#<valve_bottom_on_lzsa
	sta	location42,Y				; CHANNEL_VALVE5
	lda	#>valve_bottom_on_lzsa
	sta	location42+1,Y				; CHANNEL_VALVE5

	ldy	#LOCATION_SOUTH_BG
	lda	#<valve_top_on_lzsa
	sta	location42,Y				; CHANNEL_VALVE5
	lda	#>valve_top_on_lzsa
	sta	location42+1,Y				; CHANNEL_VALVE5

	jmp	check_valve6

valve5_is_off:
	ldy	#LOCATION_NORTH_BG
	lda	#<valve_bottom_off_lzsa
	sta	location42,Y				; CHANNEL_VALVE5
	lda	#>valve_bottom_off_lzsa
	sta	location42+1,Y				; CHANNEL_VALVE5

	ldy	#LOCATION_SOUTH_BG
	lda	#<valve_top_off_lzsa
	sta	location42,Y				; CHANNEL_VALVE5
	lda	#>valve_top_off_lzsa
	sta	location42+1,Y				; CHANNEL_VALVE5

check_valve6:

	lda	CHANNEL_VALVES
	and	#CHANNEL_VALVE6
	beq	valve6_is_off

valve6_is_on:
	ldy	#LOCATION_NORTH_BG
	lda	#<valve_bottom_on_lzsa
	sta	location43,Y				; CHANNEL_VALVE6
	lda	#>valve_bottom_on_lzsa
	sta	location43+1,Y				; CHANNEL_VALVE6

	ldy	#LOCATION_SOUTH_BG
	lda	#<valve_top_on_lzsa
	sta	location43,Y				; CHANNEL_VALVE6
	lda	#>valve_top_on_lzsa
	sta	location43+1,Y				; CHANNEL_VALVE6

	jmp	check_valve_done

valve6_is_off:
	ldy	#LOCATION_NORTH_BG
	lda	#<valve_bottom_off_lzsa
	sta	location43,Y				; CHANNEL_VALVE6
	lda	#>valve_bottom_off_lzsa
	sta	location43+1,Y				; CHANNEL_VALVE6

	ldy	#LOCATION_SOUTH_BG
	lda	#<valve_top_off_lzsa
	sta	location43,Y				; CHANNEL_VALVE6
	lda	#>valve_top_off_lzsa
	sta	location43+1,Y				; CHANNEL_VALVE6

check_valve_done:
	rts


;===========================
;===========================
; pick up myst linking book
;===========================
;===========================
book_room_grab_book:

	lda	#CHANNEL_BOOK_CLOSED
	sta	LOCATION
	jmp	change_location

	rts

;=============================
;=============================
; book elevator handle pulled
;=============================
;=============================
; TODO: animate

book_elevator_handle:

	; click speaker
	bit	SPEAKER

	; check for water power
	lda	CHANNEL_SWITCHES
	and	#<(CHANNEL_SW_FAUCET|CHANNEL_PIPE_EXTENDED)
	cmp	#<(CHANNEL_SW_FAUCET|CHANNEL_PIPE_EXTENDED)
	bne	no_book_water_power

	; check for proper valves
	lda	CHANNEL_VALVES
	and	#$0b	; check V1,V2,V4,V5
	cmp	#$09	; want V1 V4 on, V2,V5 off
	beq	book_water_power_good

no_book_water_power:
	rts

book_water_power_good:
	; toggle floor

	lda	CHANNEL_SWITCHES
	eor	#CHANNEL_BOOK_ELEVATOR_UP
	sta	CHANNEL_SWITCHES
	and	#CHANNEL_BOOK_ELEVATOR_UP
	bne	book_elevator_floor2

book_elevator_floor1:

	; change to ground floor
	ldy	#LOCATION_SOUTH_BG

	lda	#<book_elevator_inside_gnd_closed_lzsa
	sta	location31,Y		; CHANNEL_BOOK_E_IN_CLOSED
	lda	#>book_elevator_inside_gnd_closed_lzsa
	sta	location31+1,Y		; CHANNEL_BOOK_E_IN_CLOSED

	; change exit
	ldy	#LOCATION_SOUTH_EXIT
	lda	#CHANNEL_BOOK_E_INSIDE_GND
	sta	location31,Y		; CHANNEL_BOOK_E_IN_CLOSED

	jmp	book_elevator_handle_done
book_elevator_floor2:

	; change to 2nd floor
	ldy	#LOCATION_SOUTH_BG

	lda	#<book_elevator_inside_top_closed_lzsa
	sta	location31,Y		; CHANNEL_BOOK_E_IN_CLOSED
	lda	#>book_elevator_inside_top_closed_lzsa
	sta	location31+1,Y		; CHANNEL_BOOK_E_IN_CLOSED

	; change exit
	ldy	#LOCATION_SOUTH_EXIT
	lda	#CHANNEL_BOOK_E_INSIDE_TOP
	sta	location31,Y		; CHANNEL_BOOK_E_IN_CLOSED

book_elevator_handle_done:

	jsr	change_location

	rts


;=============================
;=============================
;=============================
; elevator1 handle pulled
;=============================
;=============================
; TODO: animate

elev1_handle:

	; click speaker
	bit	SPEAKER

	; check for water power
	lda	CHANNEL_SWITCHES
	bpl	no_elev1_water_power	; water on is high bit

	; check for proper valves
	lda	CHANNEL_VALVES
	and	#$0b	; check V1,V2,V4,V5
	cmp	#$01	; want V1 on, V2,V4,V5 off
	beq	elev1_water_power_good

no_elev1_water_power:
	rts

elev1_water_power_good:

	; go to next floor, which involves moving to ARBOR level

	lda	#ARBOR_INSIDE_ELEV1
	sta	LOCATION

	lda	#DIRECTION_W
	sta	DIRECTION

	lda	#LOAD_ARBOR
	sta	WHICH_LOAD

	lda	CHANNEL_SWITCHES		; make elevator up
	ora	#CHANNEL_ELEVATOR1_UP
	sta	CHANNEL_SWITCHES

	lda	#$ff
	sta	LEVEL_OVER

	rts


;=============================
;=============================
;=============================
; climb steps
;=============================
;=============================

climb_steps:

	; enter steps, which is in ARBOR level

	lda	#ARBOR_STEPS_BOTTOM
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION

	lda	#LOAD_ARBOR
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts



;=========================
;=========================
; close book elevator door
;=========================
;=========================

book_elevator_close_door:

	lda	#CHANNEL_BOOK_E_IN_CLOSED
	sta	LOCATION
	jmp	change_location

	;=========================
	; close elevator1 door
elev1_close_door:

	lda	#CHANNEL_IN_ELEV1_CLOSED
	sta	LOCATION
	jmp	change_location



;=======================
;=======================
; raise bridge
;=======================
;=======================
; verified real game behavior: can raise and lower bridge if powered with water

raise_bridge:

	jsr	click_speaker	; click speaker

	; only raise/lower if water is flowing

	; check for water power
	lda	CHANNEL_SWITCHES
	bpl	no_bridge_water_power	; water on is high bit

	; check for proper valves
	; there are actually two solutions

	lda	CHANNEL_VALVES
	and	#$33	; check V1,V2,V5,V6
	cmp	#$31	; want V1,V5,V6 on, V2 off
	beq	bridge_water_power_good

	lda	CHANNEL_VALVES
	and	#$07	; check V1,V2,V3
	cmp	#$03	; want V1,V2 on, V3 off
	beq	bridge_water_power_good

no_bridge_water_power:
	rts

bridge_water_power_good:

	; toggle bridge state

	lda	CHANNEL_SWITCHES
	eor	#CHANNEL_BRIDGE_UP
	sta	CHANNEL_SWITCHES

	jsr	adjust_after_changes

	jsr	change_location

no_raise_bridge:
	rts




;=======================
;=======================
; extend_pipe
;=======================
;=======================

; verified: can open/shut even if water is flowing

extend_pipe:

	jsr	click_speaker		; click speaker

	; toggle state

	lda	CHANNEL_SWITCHES
	eor	#CHANNEL_PIPE_EXTENDED
	sta	CHANNEL_SWITCHES

	jsr	adjust_after_changes

	jsr	change_location

no_extend_pipe:
	rts



;======================================
;======================================
; adjust after changes
;======================================
;======================================

	; should call this when entering level
adjust_after_changes:

	jsr	adjust_valve_backgrounds

adjust_bridge:
	;=======================
	; put bridge up or down

	lda	CHANNEL_SWITCHES
	and	#CHANNEL_BRIDGE_UP
	beq	bridge_is_down

bridge_is_up:
	; change to bridge up bg
	ldy	#LOCATION_EAST_BG

	lda	#<bridge_up_e_lzsa
	sta	location3,Y				; CHANNEL_BRIDGE
	lda	#>bridge_up_e_lzsa
	sta	location3+1,Y				; CHANNEL_BRIDGE

	; change to allow crossing bridge
	ldy	#LOCATION_EAST_EXIT
	lda	#CHANNEL_AFTER_BRIDGE1
	sta	location3,Y				; CHANNEL_BRIDGE
	jmp	adjust_pipe

bridge_is_down:
	; change to bridge down bg

	ldy	#LOCATION_EAST_BG

	lda	#<bridge_down_e_lzsa
	sta	location3,Y				; CHANNEL_BRIDGE
	lda	#>bridge_down_e_lzsa
	sta	location3+1,Y				; CHANNEL_BRIDGE

	; change to allow crossing bridge
	ldy	#LOCATION_EAST_EXIT
	lda	#$ff
	sta	location3,Y				; CHANNEL_BRIDGE

adjust_pipe:

	;=======================
	; extend pipe or not

	lda	CHANNEL_SWITCHES
	and	#CHANNEL_PIPE_EXTENDED
	beq	pipe_stowed

pipe_extended:
	; change to pipe_extend bg
	ldy	#LOCATION_SOUTH_BG

	lda	#<pipe_extend_up_s_lzsa
	sta	location27,Y				; CHANNEL_PIPE_EXTEND
	lda	#>pipe_extend_up_s_lzsa
	sta	location27+1,Y				; CHANNEL_PIPE_EXTEND

	; also change for other side of bridge

	ldy	#LOCATION_WEST_BG

	lda	#<pipe_bridge2_up_w_lzsa
	sta	location10,Y				; CHANNEL_PIPE_BRIDGE2
	lda	#>pipe_bridge2_up_w_lzsa
	sta	location10+1,Y				; CHANNEL_PIPE_BRIDGE2

	jmp	hide_elevator1

pipe_stowed:

	; change to pipe_extend bg
	ldy	#LOCATION_SOUTH_BG

	lda	#<pipe_extend_down_s_lzsa
	sta	location27,Y				; CHANNEL_PIPE_EXTEND
	lda	#>pipe_extend_down_s_lzsa
	sta	location27+1,Y				; CHANNEL_PIPE_EXTEND

	; also change for other side of bridge

	ldy	#LOCATION_WEST_BG

	lda	#<pipe_bridge2_w_lzsa
	sta	location10,Y				; CHANNEL_PIPE_BRIDGE2
	lda	#>pipe_bridge2_w_lzsa
	sta	location10+1,Y				; CHANNEL_PIPE_BRIDGE2

hide_elevator1:

	lda	CHANNEL_SWITCHES
	and	#CHANNEL_ELEVATOR1_UP
	beq	elevator1_down

elevator1_up:

	; change bgs so elevator up, can't board
	ldy	#LOCATION_WEST_BG

	lda	#<before_elev1_gone_w_lzsa
	sta	location8,Y				; CHANNEL_BEFORE_ELEV1
	lda	#>before_elev1_gone_w_lzsa
	sta	location8+1,Y				; CHANNEL_BEFORE_ELEV1

	lda	#<fork_gone_w_lzsa
	sta	location7,Y				; CHANNEL_FORK
	lda	#>fork_gone_w_lzsa
	sta	location7+1,Y				; CHANNEL_FORK

	; make so can't board
	ldy	#LOCATION_WEST_EXIT
	lda	#$ff
	sta	location8,Y				; CHANNEL_BEFORE_ELEV1

	jmp	open_gate

elevator1_down:
	; change bgs so elevator down
	ldy	#LOCATION_WEST_BG

	lda	#<before_elev1_w_lzsa
	sta	location8,Y				; CHANNEL_BEFORE_ELEV1
	lda	#>before_elev1_w_lzsa
	sta	location8+1,Y				; CHANNEL_BEFORE_ELEV1

	lda	#<fork_w_lzsa
	sta	location7,Y				; CHANNEL_FORK
	lda	#>fork_w_lzsa
	sta	location7+1,Y				; CHANNEL_FORK

	; make so can board
	ldy	#LOCATION_WEST_EXIT
	lda	#CHANNEL_ELEV1_OPEN
	sta	location8,Y				; CHANNEL_BEFORE_ELEV1

open_gate:
	lda	CHANNEL_SWITCHES
	and	#CHANNEL_SW_GATE_BOTTOM
	beq	gate_closed

gate_open:

	; change bgs so gate open

	ldy	#LOCATION_WEST_BG

	lda	#<steps_path_open_w_lzsa
	sta	location12,Y				; CHANNEL_STEPS_PATH
	lda	#>steps_path_open_w_lzsa
	sta	location12+1,Y				; CHANNEL_STEPS_PATH

	lda	#<steps_door_open_w_lzsa
	sta	location13,Y				; CHANNEL_STEPS_DOOR
	lda	#>steps_door_open_w_lzsa
	sta	location13+1,Y				; CHANNEL_STEPS_DOOR

	; make so can climb steps
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_W
	sta	location13,Y				; CHANNEL_STEPS_DOOR

	jmp	done_adjust_changes

gate_closed:

	; change bgs so gate closed

	ldy	#LOCATION_WEST_BG

	lda	#<steps_path_w_lzsa
	sta	location12,Y				; CHANNEL_STEPS_PATH
	lda	#>steps_path_w_lzsa
	sta	location12+1,Y				; CHANNEL_STEPS_PATH

	lda	#<steps_door_w_lzsa
	sta	location13,Y				; CHANNEL_STEPS_DOOR
	lda	#>steps_door_w_lzsa
	sta	location13+1,Y				; CHANNEL_STEPS_DOOR

	; make so can't climb steps
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location13,Y				; CHANNEL_STEPS_DOOR

done_adjust_changes:

	rts
