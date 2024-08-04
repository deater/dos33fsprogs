;===============================================
; level data for Logged Area 4
;===============================================

locations:
	.word location0

; RIVEN_LOGGED4		-- fourth logged area
location0:
	.byte	$FF		; north exit
	.byte	$ff		; south exit
	.byte	LOAD_LOGGED3<<4|RIVEN_LOGGED3	; east exit
	.byte	LOAD_LOGGED5<<4|RIVEN_LOGGED5	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_N	; west exit_dir
	.word	logged4_n_zx02	; north bg
	.word	$0000		; south bg
	.word	logged4_e_zx02	; east bg
	.word	logged4_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST|BG_NORTH	; bgs
	.byte	$ff		; special exit
