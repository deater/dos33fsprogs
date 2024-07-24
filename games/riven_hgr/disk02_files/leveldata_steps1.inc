;===============================================
; level data for Steps1
;===============================================

locations:
	.word location0

; RIVEN_CHIPPER	-- just arrived by cart
location0:
	.byte	LOAD_TOP<<4|RIVEN_TOP		; north exit
	.byte	$E0		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	steps1_n_zx02	; north bg
	.word	steps1_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH	; all bgs
	.byte	$ff		; special exit
