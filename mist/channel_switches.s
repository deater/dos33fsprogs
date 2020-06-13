;=======================
; raise bridge

; if CHANNEL_SWITCHES CHANNEL_SW_WINDMILL and CHANNEL_SW_FAUCET
; TODO: also if various valves in correct pattern

raise_bridge:

	bit	$C030		; click speaker

	; only raise it if water is flowing

	lda	CHANNEL_SWITCHES
	and	#CHANNEL_SW_WINDMILL|CHANNEL_SW_FAUCET
	cmp	#CHANNEL_SW_WINDMILL|CHANNEL_SW_FAUCET
;	bne	no_raise_bridge


	; only raise the bridge, don't think you can lower it

	lda	CHANNEL_SWITCHES
	ora	#CHANNEL_BRIDGE_UP
	sta	CHANNEL_SWITCHES

	jsr	adjust_after_changes

	jsr	change_location

no_raise_bridge:
	rts



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
	sta	location16,Y				; CHANNEL_BRIDGE
	lda	#>bridge_up_e_lzsa
	sta	location16+1,Y				; CHANNEL_BRIDGE

	; change to allow crossing bridge
	ldy	#LOCATION_EAST_EXIT
	lda	#CHANNEL_AFTER_BRIDGE1
	sta	location16,Y				; CHANNEL_BRIDGE
	jmp	adjust_pipe

bridge_is_down:
	; change to bridge down bg

	ldy	#LOCATION_EAST_BG

	lda	#<bridge_down_e_lzsa
	sta	location16,Y				; CHANNEL_BRIDGE
	lda	#>bridge_down_e_lzsa
	sta	location16+1,Y				; CHANNEL_BRIDGE

	; change to allow crossing bridge
	ldy	#LOCATION_EAST_EXIT
	lda	#$ff
	sta	location16,Y				; CHANNEL_BRIDGE

adjust_pipe:
	;=======================
	; extend pipe or not


	rts
