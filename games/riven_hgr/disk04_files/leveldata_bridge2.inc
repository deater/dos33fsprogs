;===============================================
; level data for Start level
;===============================================

locations:
	.word location0

; RIVEN_BRIDGE1 -- part way across the bridge

location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	LOAD_TUNNEL3<<4|RIVEN_TUNNEL3		; east exit
	.byte	LOAD_BRIDGE1<<4|RIVEN_BRIDGE1		; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	bridge2_e_zx02	; east bg
	.word	bridge2_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

