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

; FIXME: check for water power
; FIXME: animate
book_elevator_handle:

	; click speaker
	bit	SPEAKER

	; check for water power

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

; FIXME: check for water power
; FIXME: animate
elev1_handle:

	; click speaker
	bit	SPEAKER

	; check for water power

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

; if CHANNEL_SWITCHES CHANNEL_SW_WINDMILL and CHANNEL_SW_FAUCET
; TODO: also if various valves in correct pattern

; verified: can raise and lower bridge if powered with water

raise_bridge:

	jsr	click_speaker	; click speaker

	; only raise/lower if water is flowing

	lda	CHANNEL_SWITCHES
	and	#CHANNEL_SW_WINDMILL|CHANNEL_SW_FAUCET
	cmp	#CHANNEL_SW_WINDMILL|CHANNEL_SW_FAUCET
;	bne	no_raise_bridge


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
