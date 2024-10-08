;===============================================
; level data for bridge to dome2
;===============================================

locations:
	.word location0

; RIVEN_BRIDGE2	-- bridge to dome2
location0:
	.byte	LOAD_DOME<<4|RIVEN_DOME				; north exit
	.byte	LOAD_DOME_BRIDGE<<4|RIVEN_DOME_BRIDGE		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	dome_bridge2_n_zx02	; north bg
	.word	dome_bridge2_s_zx02	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff
