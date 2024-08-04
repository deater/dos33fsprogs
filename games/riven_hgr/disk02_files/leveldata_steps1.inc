;===============================================
; level data for Steps1
;===============================================

locations:
	.word location0,location1

; RIVEN_STEPS1	-- first level of steps
location0:
	.byte	RIVEN_STEPS2	; north exit
	.byte	$E0		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	steps1_n_zx02	; north bg
	.word	steps1_s_zx02	; south bg
	.word	steps1_e_zx02	; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte	$ff		; special exit

; RIVEN_STEPS2	-- second level of steps
location1:
	.byte	LOAD_STEPS3<<4|RIVEN_STEPS3		; north exit
	.byte	RIVEN_STEPS1	; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	steps2_n_zx02	; north bg
	.word	steps2_s_zx02	; south bg
	.word	steps2_e_zx02	; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte	$ff		; special exit

