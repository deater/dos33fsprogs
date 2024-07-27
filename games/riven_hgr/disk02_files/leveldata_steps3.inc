;===============================================
; level data for Steps3
;===============================================

locations:
	.word location0,location1

; RIVEN_STEPS3	-- first level of steps
location0:
	.byte	RIVEN_STEPS4	; north exit
	.byte	LOAD_STEPS1<<4|RIVEN_STEPS2		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	steps3_n_zx02	; north bg
	.word	steps3_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH	; all bgs
	.byte	$ff		; special exit

; RIVEN_STEPS2	-- second level of steps
location1:
	.byte	LOAD_TOP<<4|RIVEN_TOP		; north exit
	.byte	RIVEN_STEPS3	; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	steps4_n_zx02	; north bg
	.word	steps4_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH	; all bgs
	.byte	$ff		; special exit

