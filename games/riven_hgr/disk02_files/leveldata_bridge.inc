;===============================================
; level data for top of steps
;===============================================

locations:
	.word location0

; RIVEN_BRIDGE -- first part of bridge
location0:
	.byte	$ff		; north exit
	.byte	LOAD_STEPS3<<4|RIVEN_STEPS4		; south exit
	.byte	$E2		; east exit
	.byte	LOAD_TOP<<4|RIVEN_TOP	; west exit
	.byte	$00		; north exit_dir
	.byte	$00		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	bridge_n_zx02	; north bg
	.word	bridge_s_zx02	; south bg
	.word	bridge_e_zx02	; east bg
	.word	bridge_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST	; all bgs
	.byte	$ff		; special exit
