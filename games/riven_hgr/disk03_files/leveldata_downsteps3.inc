;===============================================
; level data for going down steps again
;===============================================

locations:
	.word location0

; RIVEN_DOWN3	-- starting down
location0:
	.byte	LOAD_OUTSIDE<<4|RIVEN_OUTSIDE	; north exit
	.byte	LOAD_DSTEPS1<<4|RIVEN_DOWN2	; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	downsteps3_n_zx02	; north bg
	.word	downsteps3_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

