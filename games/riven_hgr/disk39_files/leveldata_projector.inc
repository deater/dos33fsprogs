;===============================================
; level data for Large Projector Area level
;===============================================

locations:
	.word location0,location1, location2

; RIVEN_PROJ_DOOR	-- doorway to projector room
location0:
	.byte	RIVEN_PROJ_STEPS	; north exit
	.byte	$E0|1			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	doorway_n_zx02	; north bg
	.word	doorway_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$FF		; special exit

; RIVEN_PROJ_STEPS	-- steps to projector room
location1:
	.byte	RIVEN_MAGPATH	; north exit
	.byte	RIVEN_PROJ_DOOR		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	steps_n_zx02	; north bg
	.word	steps_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$FF		; special exit

; RIVEN_MAGPATH	-- path to maglev
location2:
	.byte	LOAD_OUTSIDE<<4|RIVEN_MAGLEV1	; north exit
	.byte	RIVEN_PROJ_STEPS	; south exit
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
