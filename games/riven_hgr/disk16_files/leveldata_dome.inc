;===============================================
; level data for just inside dome
;===============================================

locations:
	.word location0

; RIVEN_DOME	-- dome
location0:
	.byte	$ff		; north exit
	.byte	LOAD_DOME_BRIDGE2<<4|RIVEN_DOME_BRIDGE2		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	inside_dome_n_zx02	; north bg
	.word	inside_dome_s_zx02	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff
