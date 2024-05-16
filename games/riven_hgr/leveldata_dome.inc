;===============================================
; level data for Dome Island level
;===============================================

locations:
	.word location0

; RIVEN_MAGLEV1	-- maglev steps
location0:
	.byte	LOAD_MAGSTEPS<<4|RIVEN_MAGSTEPS2	; north exit
	.byte	LOAD_PROJECTOR<<4|RIVEN_PROJ_DOOR	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	maglev1_n_zx02	; north bg
	.word	maglev1_s_zx02	; south bg
	.word	maglev1_e_zx02	; east bg
	.word	maglev1_w_zx02	; west bg
	.byte	BG_EAST|BG_NORTH|BG_SOUTH|BG_WEST	; all bgs
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	location0-1			; FIXME


