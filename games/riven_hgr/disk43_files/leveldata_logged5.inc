;===============================================
; level data for Logged Area 5
;===============================================

locations:
	.word location0

; RIVEN_LOGGED5		-- fifth logged area
location0:
	.byte	LOAD_CART<<4|RIVEN_OUTSIDE_CART		; north exit
	.byte	LOAD_LOGGED4<<4|RIVEN_LOGGED4		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_E		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	logged5_n_zx02	; north bg
	.word	logged5_s_zx02	; south bg
	.word	logged5_e_zx02	; east bg
	.word	logged5_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST|BG_NORTH|BG_SOUTH	; bgs
	.byte	$ff		; special exit
