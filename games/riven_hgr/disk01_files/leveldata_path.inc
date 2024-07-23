;===============================================
; level data for Dome Island level -- path to rest
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_PATH
location0:
	.byte	RIVEN_STEPS_BASE	; north exit
	.byte	$FF			; south exit
	.byte	RIVEN_STEPS_BASE	; east exit
	.byte	LOAD_ARRIVAL<<4|RIVEN_ARRIVAL_NEAR		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	step_path_n_zx02	; north bg
	.word	$0000			; south bg
	.word	step_path_e_zx02	; east bg
	.word	step_path_w_zx02	; west bg
	.byte	BG_NORTH|BG_EAST|BG_WEST
	.byte	$ff	; special exit

; RIVEN_STEPS_BASE
location1:
	.byte	$E0	; disk1		; north exit
	.byte	$ff			; south exit
	.byte	RIVEN_CLIFF_BASE	; east exit
	.byte	RIVEN_PATH		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	steps_base_n_zx02	; north bg
	.word	$0000			; south bg
	.word	steps_base_e_zx02	; east bg
	.word	steps_base_w_zx02	; west bg
	.byte	BG_NORTH|BG_EAST|BG_WEST
	.byte	$ff	; special exit

; RIVEN_CLIFF_BASE
location2:
	.byte	$FF		; north exit
	.byte	$FF		; south exit
	.byte	RIVEN_STEPS_BASE		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	cliff_base_e_zx02		; east bg
	.word	$0000		; west bg
	.byte	BG_EAST
	.byte	$ff	; special exit

