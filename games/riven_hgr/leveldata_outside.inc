;===============================================
; level data for Dome Island level
;===============================================

locations:
	.word location0,location1

; RIVEN_MAGLEV1	-- maglev steps
location0:
	.byte	LOAD_MAGSTEPS<<4|RIVEN_MAGSTEPS2	; north exit
	.byte	RIVEN_MAGPATH		; south exit
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
	.byte	DIRECTION_N	; special exit
	.byte	32,34		; special x
	.byte	136,154		; special y
	.word	call_button_clicked-1

; RIVEN_MAGPATH	-- path to maglev
location1:
	.byte	RIVEN_MAGLEV1	; north exit
	.byte	LOAD_PROJECTOR<<4|RIVEN_PROJ_STEPS	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	magpath_n_zx02	; north bg
	.word	magpath_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff	; special exit

