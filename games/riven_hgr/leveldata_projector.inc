;===============================================
; level data for Large Projector Area level
;===============================================

locations:
	.word location0,location1,location2,location3

; RIVEN_PROJECTOR	-- looking at projector
location0:
	.byte	RIVEN_PROJ_DOOR		; north exit
	.byte	RIVEN_WAHRK		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	projector_n_zx02	; north bg
	.word	projector_s_zx02	; south bg
	.word	projector_e_zx02	; east bg
	.word	projector_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$FF		; special exit (none)

; RIVEN_PROJ_DOOR	-- doorway to projector room
location1:
	.byte	RIVEN_PROJ_STEPS	; north exit
	.byte	RIVEN_PROJECTOR		; south exit
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

; RIVEN_PROJ_STEPS	-- doorway to projector room
location2:
	.byte	LOAD_OUTSIDE<<4 | RIVEN_MAGPATH	; north exit
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

; RIVEN_WAHRK	-- big fish
location3:
	.byte	$ff			; north exit
	.byte	RIVEN_PROJECTOR		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$ff		; north bg
	.word	wahrk_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$FF		; special exit



