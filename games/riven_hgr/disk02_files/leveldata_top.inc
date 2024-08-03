;===============================================
; level data for top of steps
;===============================================

locations:
	.word location0,location1

; RIVEN_TOP	-- top of steps
location0:
	.byte	$E1		; north exit
	.byte	LOAD_STEPS3<<4|RIVEN_STEPS4		; south exit
	.byte	LOAD_BRIDGE<<4|RIVEN_BRIDGE		; east exit
	.byte	RIVEN_ALCOVE	; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	top_n_zx02	; north bg
	.word	top_s_zx02	; south bg
	.word	top_e_zx02	; east bg
	.word	top_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST	; all bgs
	.byte	$ff		; special exit

; RIVEN_ALCOVE	-- looking into rotation room
location1:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	RIVEN_TOP	; east exit
	.byte	$E3		; west exit
	.byte	$FF		; north exit_dir
	.byte	$fF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	alcove_e_zx02	; east bg
	.word	alcove_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST	; all bgs
	.byte	$ff		; special exit

