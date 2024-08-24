;===============================================
; level data for bridge to dome
;===============================================

locations:
	.word location0

; RIVEN_BRIDGE	-- bridge to dome
location0:
	.byte	$ff		; north exit
	.byte	$E0		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	dome_bridge_n_zx02	; north bg
	.word	dome_bridge_s_zx02	; south bg
	.word	dome_bridge_e_zx02	; east bg
	.word	dome_bridge_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST	; all bgs
	.byte	DIRECTION_E	; special exit
	.byte	16,26		; x
	.byte	82,140		; y
	.word	bridge_button-1
