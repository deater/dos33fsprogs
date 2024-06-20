;===============================================
; level data for Dome Island level
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_MAGLEV1	-- maglev steps
location0:
	.byte	LOAD_MAGSTEPS<<4|RIVEN_MAGSTEPS2	; north exit
	.byte	RIVEN_MAGPATH		; south exit
	.byte	RIVEN_OVERLOOK		; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	maglev1_n_zx02	; north bg
	.word	maglev1_s_zx02	; south bg
	.word	maglev1_e_zx02	; east bg
	.word	maglev1_w_zx02	; west bg
	.byte	BG_EAST|BG_NORTH|BG_SOUTH|BG_WEST	; all bgs
	.byte	$ff		; special exit

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

; RIVEN_OVERLOOK - scenic overlook
location2:
	.byte	RIVEN_MAGLEV1	; north exit
	.byte	$ff		; south exit
	.byte	$FF		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	overlook_n_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte	$ff	; special exit

.if 0

; if we can free up 1k more to hold the s location

; RIVEN_OVERLOOK - scenic overlook
location2:
	.byte	$FF		; north exit
	.byte	RIVEN_MAGLEV1	; south exit
	.byte	$FF		; east exit
	.byte	$ff		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	overlook_n_zx02	; north bg
	.word	overlook_s_zx02 ; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff	; special exit

.endif
