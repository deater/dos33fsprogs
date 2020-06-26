;=============================
; elevator1 handle pulled

; FIXME: check for water power
; FIXME: animate
elev1_handle:

	; click speaker
	bit	SPEAKER

	; check for water power

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
	and	#~CHANNEL_ELEVATOR1_UP
	sta	CHANNEL_SWITCHES


	rts


	;=========================
	; close elevator1 door
elev1_close_door:

	lda	#ARBOR_INSIDE_ELEV1
	sta	LOCATION
	jmp	change_location


	;==================================
	; hut handle, toggle top stair gate
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


; FIXME: check for water power
; FIXME: animate
elevator2_handle:

	; click speaker
	bit	SPEAKER

	; check for water power

	lda	LOCATION
	cmp	#ARBOR_INSIDE_ELEV2_CLOSED
	beq	elev2_goto_top

elev2_goto_bottom:
	lda	#ARBOR_INSIDE_ELEV2_CLOSED
	bne	done_elev2_handle

elev2_goto_top:
	lda	#ARBOR_IN_ELEV2_TOP_CLOSED

done_elev2_handle:
	sta	LOCATION
	jmp	change_location


;=========================
;=========================
; close elevator2 door
;=========================
;=========================

elevator2_close_door:

	lda	LOCATION
	cmp	#ARBOR_INSIDE_ELEV2_OPEN
	bne	elev2_close_top

elev2_close_bottom:
	lda	#ARBOR_INSIDE_ELEV2_CLOSED
	bne	done_elev2_close_door

elev2_close_top:
	lda	#ARBOR_IN_ELEV2_TOP_CLOSED

done_elev2_close_door:
	sta	LOCATION
	jmp	change_location



;=========================
;=========================
; handle_top_gate
;=========================
;=========================

handle_top_gate:


	rts


;===============================================
;===============================================
; update all backgrounds based on switch states
;===============================================
;===============================================

update_arbor_state:

	lda	CHANNEL_SWITCHES
	and	#CHANNEL_SW_GATE_TOP
	beq	top_gate_closed

top_gate_open:

	; change top gate to open
	ldy	#LOCATION_SOUTH_BG

        lda	#<switch_hut_open_s_lzsa
        sta	location14,Y				; ARBOR_SWITCH_HUT
        lda	#>switch_hut_open_s_lzsa
        sta	location14+1,Y				; ARBOR_SWITCH_HUT

	; FIXME: change gate graphic close
	; FIXME: change gate exit
	; change to allow crossing bridge
;	ldy	#LOCATION_EAST_EXIT
;	lda	#CHANNEL_AFTER_BRIDGE1
;	sta	location3,Y                             ; CHANNEL_BRIDGE

	jmp	top_gate_done
top_gate_closed:

	; change top gate to open
	ldy	#LOCATION_SOUTH_BG

        lda	#<switch_hut_closed_s_lzsa
        sta	location14,Y				; ARBOR_SWITCH_HUT
        lda	#>switch_hut_closed_s_lzsa
        sta	location14+1,Y				; ARBOR_SWITCH_HUT

	; FIXME: change gate graphic close
	; FIXME: change gate exit
	; change to allow crossing bridge
;	ldy	#LOCATION_EAST_EXIT
;	lda	#CHANNEL_AFTER_BRIDGE1
;	sta	location3,Y                             ; CHANNEL_BRIDGE


top_gate_done:

done_update_arbor_state:

	rts



