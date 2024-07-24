;===============================================
; level data for top of steps
;===============================================

locations:
	.word location0

; RIVEN_TOP	-- top of steps
location0:
	.byte	$E1		; north exit
	.byte	LOAD_STEPS1<<4|RIVEN_STEPS1		; south exit
	.byte	$E2		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	top_n_zx02	; north bg
	.word	top_s_zx02	; south bg
	.word	top_e_zx02	; east bg
	.word	top_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST	; all bgs
	.byte	$ff		; special exit
