;===============================================
; level data for Start level
;===============================================

locations:
	.word location0

; RIVEN_BRIDGE1 -- part way across the bridge

location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	LOAD_BRIDGE2<<4|RIVEN_BRIDGE2		; east exit
	.byte	$E0		; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	bridge1_e_zx02	; east bg
	.word	bridge1_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

