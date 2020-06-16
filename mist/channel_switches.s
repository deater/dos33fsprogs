
;===========================
; pick up myst linking book
book_room_grab_book:

	lda	#CHANNEL_BOOK_CLOSED
	sta	LOCATION
	jmp	change_location

	rts

;=============================
; book elevator handle pulled

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

	;=========================
	; close door
book_elevator_close_door:

	lda	#CHANNEL_BOOK_E_IN_CLOSED
	sta	LOCATION
	jmp	change_location


;=======================
; raise bridge

; if CHANNEL_SWITCHES CHANNEL_SW_WINDMILL and CHANNEL_SW_FAUCET
; TODO: also if various valves in correct pattern

; verified: can raise and lower bridge if powered with water

raise_bridge:

	bit	$C030		; click speaker

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
; extend_pipe

; verified: can open/shut even if water is flowing

extend_pipe:

	bit	$C030		; click speaker

	; toggle state

	lda	CHANNEL_SWITCHES
	eor	#CHANNEL_PIPE_EXTENDED
	sta	CHANNEL_SWITCHES

	jsr	adjust_after_changes

	jsr	change_location

no_extend_pipe:
	rts



	;======================================
	; adjust after changes
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

	jmp	done_adjust_changes

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

done_adjust_changes:

	rts
