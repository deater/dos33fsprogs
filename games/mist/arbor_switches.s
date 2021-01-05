;=============================
; elevator1 handle pulled
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

	; go to bottom floor, which involves moving to CHANNEL level

	lda	#CHANNEL_IN_ELEV1_CLOSED
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION

	lda	#LOAD_CHANNEL
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	lda	CHANNEL_SWITCHES		; make elevator down
	and	#<(~CHANNEL_ELEVATOR1_UP)
	sta	CHANNEL_SWITCHES


	rts


;=========================
;=========================
; close elevator1 door
;=========================
;=========================

elev1_close_door:

	lda	#ARBOR_INSIDE_ELEV1
	sta	LOCATION
	jmp	change_location


;==================================
;==================================
; hut handle, toggle top stair gate
;==================================
;==================================

hut_handle:
	lda	CHANNEL_SWITCHES
	eor	#CHANNEL_SW_GATE_TOP
	sta	CHANNEL_SWITCHES
	jsr	update_arbor_state
	jmp	change_location



;=============================
;=============================
; elevator2 handle pulled
;=============================
;=============================
; TODO: animate

elevator2_handle:

	; click speaker
	bit	SPEAKER

	; check for water power

	lda	CHANNEL_SWITCHES
	bpl	no_elev2_water_power	; water on is high bit

	; check for proper valves

	lda	CHANNEL_VALVES
	and	#$1	; check V1
	beq	elev2_water_power_good	; want V1 off

no_elev2_water_power:
	rts

elev2_water_power_good:

	lda	#NIBEL_IN_ELEV2_TOP_CLOSED
	sta	LOCATION

	lda	#LOAD_NIBEL
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts


;=========================
;=========================
; close elevator2 door
;=========================
;=========================

elevator2_close_door:

	lda	#ARBOR_INSIDE_ELEV2_CLOSED
	sta	LOCATION
	jmp	change_location



;=========================
;=========================
; handle_top_gate
;=========================
;=========================

handle_top_gate:

	lda	CHANNEL_SWITCHES
	and	#CHANNEL_SW_GATE_TOP
	beq	done_handle_top_gate		; if gate not open


	lda	#ARBOR_STEPS_TOP
	sta	LOCATION
	jsr	change_location


done_handle_top_gate:
	rts


;=================================
;=================================
; handle gate at bottom of stairs
;=================================
;=================================

stair_gate:

	lda	CHANNEL_SWITCHES
	and	#CHANNEL_SW_GATE_BOTTOM
	beq	stair_gate_closed		; if gate not open


stair_gate_open:

	; 13-16 close gate
	lda	CURSOR_X
	cmp	#16
	bcc	close_stair_gate

	; otherwise, exit back to channelwood

	lda	#CHANNEL_STEPS_DOOR
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION

	lda	#LOAD_CHANNEL
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts



close_stair_gate:

	; open the gate

	lda	CHANNEL_SWITCHES
	and	#<(~CHANNEL_SW_GATE_BOTTOM)
	jmp	update_stair_gate


stair_gate_closed:

	; open the gate

	lda	CHANNEL_SWITCHES
	ora	#CHANNEL_SW_GATE_BOTTOM

update_stair_gate:
	sta	CHANNEL_SWITCHES

	jsr	update_arbor_state

	jmp	change_location


;===============================================
; draw bridge1 bg
;===============================================
; if the elevator is down, erase it
; doing it this way is abour 40 bytes
; doing it with dedicated bg image would be about 400 bytes
draw_bridge1_bg:

	; only if bridge down
	lda	CHANNEL_SWITCHES
	and	#CHANNEL_ELEVATOR1_UP
	bne	done_bridge1_bg

	; only if facing east

	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_E
	bne	done_bridge1_bg

	lda	#18
	sta	XPOS
	lda	#10
	sta	YPOS

	lda	#<elev_down_patch_sprite
	sta	INL
	lda	#>elev_down_patch_sprite
	sta	INH

	jsr	put_sprite_crop
done_bridge1_bg:
	rts

elev_down_patch_sprite:
	.byte	4,6
	.byte	$55,$00,$00,$55
	.byte	$55,$00,$00,$55
	.byte	$55,$00,$00,$55
	.byte	$55,$00,$00,$55
	.byte	$55,$00,$00,$55
	.byte	$58,$08,$08,$58






;===============================================
;===============================================
; update all backgrounds based on switch states
;===============================================
;===============================================

update_arbor_state:
	; update on elevator1
	lda	CHANNEL_SWITCHES
	and	#CHANNEL_ELEVATOR1_UP
	beq	make_elevator1_down
make_elevator1_up:

	; change elevator view
	ldy	#LOCATION_EAST_BG
	lda	#<arrival_e_lzsa
	sta	location2,Y				; ARBOR_ARRIVAL_CLOSED
	lda	#>arrival_e_lzsa
	sta	location2+1,Y				; ARBOR_ARRIVAL_CLOSED

	; connect elevator exit
	ldy	#LOCATION_EAST_EXIT
	lda	#ARBOR_ARRIVAL_OPEN
	sta	location2,Y				; ARBOR_ARRIVAL_CLOSED

	jmp	make_elevator1_done
make_elevator1_down:

	; change elevator view
	ldy	#LOCATION_EAST_BG
	lda	#<arrival_noelev_e_lzsa
	sta	location2,Y				; ARBOR_ARRIVAL_CLOSED
	lda	#>arrival_noelev_e_lzsa
	sta	location2+1,Y				; ARBOR_ARRIVAL_CLOSED

	; disconnect elevator exit
	ldy	#LOCATION_EAST_EXIT
	lda	#ARBOR_ARRIVAL_NOELEV
	sta	location2,Y				; ARBOR_ARRIVAL_CLOSED

make_elevator1_done:

	; update based on switches

	lda	CHANNEL_SWITCHES
	and	#CHANNEL_SW_GATE_TOP
	beq	top_gate_closed

top_gate_open:

	; change top gate to open

	; change far view
	ldy	#LOCATION_SOUTH_BG
	lda	#<switch_hut_open_s_lzsa
	sta	location14,Y				; ARBOR_SWITCH_HUT
	lda	#>switch_hut_open_s_lzsa
	sta	location14+1,Y				; ARBOR_SWITCH_HUT

	; change bridge view
	ldy	#LOCATION_WEST_BG
	lda	#<bridge7_open_w_lzsa
	sta	location22,Y				; ARBOR_BRIDGE7
	lda	#>bridge7_open_w_lzsa
	sta	location22+1,Y				; ARBOR_BRIDGE7

	; change doors, elevator closed view
	; should be gate open, elevator closed
	lda	#<doors_open_elev2_closed_w_lzsa
	sta	location23,Y				; ARBOR_DOORS
	lda	#>doors_open_elev2_closed_w_lzsa
	sta	location23+1,Y				; ARBOR_DOORS

	; change doors, elevator open view
	; should be gate open, elevator open
	lda	#<doors_open_w_lzsa
	sta	location24,Y				; ARBOR_DOORS_ELEV2_OPEN
	lda	#>doors_open_w_lzsa
	sta	location24+1,Y				; ARBOR_DOORS_ELEV2_OPEN

	; change to allow traversing gate
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_W
	sta	location23,Y				; ARBOR_DOORS
	sta	location24,Y				; ARBOR_DOORS_ELEV2_OPEN

	jmp	top_gate_done

top_gate_closed:

	; change top gate to closed

	; change far view
	ldy	#LOCATION_SOUTH_BG
        lda	#<switch_hut_closed_s_lzsa
        sta	location14,Y				; ARBOR_SWITCH_HUT
        lda	#>switch_hut_closed_s_lzsa
        sta	location14+1,Y				; ARBOR_SWITCH_HUT

	; change bridge view
	ldy	#LOCATION_WEST_BG
	lda	#<bridge7_closed_w_lzsa
	sta	location22,Y				; ARBOR_BRIDGE7
	lda	#>bridge7_closed_w_lzsa
	sta	location22+1,Y				; ARBOR_BRIDGE7

	; change doors, elevator closed view
	; should be gate closed, elevator closed
	lda	#<doors_closed_w_lzsa
	sta	location23,Y				; ARBOR_DOORS
	lda	#>doors_closed_w_lzsa
	sta	location23+1,Y				; ARBOR_DOORS

	; change doors, elevator open view
	; should be gate closed, elevator open
	lda	#<doors_elev2_open_w_lzsa
	sta	location24,Y				; ARBOR_DOORS_ELEV2_OPEN
	lda	#>doors_elev2_open_w_lzsa
	sta	location24+1,Y				; ARBOR_DOORS_ELEV2_OPEN

	; change to disallow traversing gate
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location23,Y				; ARBOR_DOORS
	sta	location24,Y				; ARBOR_DOORS_ELEV2_OPEN

top_gate_done:


update_stair_door:

	lda	CHANNEL_SWITCHES
	and	#CHANNEL_SW_GATE_BOTTOM
	beq	bottom_gate_closed

bottom_gate_open:

	; change bottom gate to open

	ldy	#LOCATION_WEST_BG
	lda	#<steps_bottom_open_w_lzsa
	sta	location30,Y				; ARBOR_STEPS_BOTTOM
	lda	#>steps_bottom_open_w_lzsa
	sta	location30+1,Y				; ARBOR_STEPS_BOTTOM

	jmp	bottom_gate_done

bottom_gate_closed:

	ldy	#LOCATION_WEST_BG
	lda	#<steps_bottom_closed_w_lzsa
	sta	location30,Y				; ARBOR_STEPS_BOTTOM
	lda	#>steps_bottom_closed_w_lzsa
	sta	location30+1,Y				; ARBOR_STEPS_BOTTOM


bottom_gate_done:

done_update_arbor_state:

	rts



