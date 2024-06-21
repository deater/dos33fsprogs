;===============================================
; level data for Jungle Outside
;===============================================

locations:
	.word location0


; RIVEN_JUNGLE_OUTSIDE  -- just outside the maglev
location0:
	.byte	LOAD_MAGLEV<<4|RIVEN_LOOKIN	; north exit
	.byte	$FF		; south exit
	.byte	$FF		; east exit
	.byte	$E0|0		; change disk, exit 0	; west exit
	.byte	DIRECTION_W	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	outside_n_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	outside_w_zx02	; west bg
	.byte	BG_WEST|BG_NORTH
	.byte	$ff		; special exit
