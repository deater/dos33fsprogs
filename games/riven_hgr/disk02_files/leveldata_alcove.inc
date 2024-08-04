;===============================================
; level data for rotation alcove
;===============================================

locations:
	.word location0

; RIVEN_ALCOVE	-- looking into rotation room
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	LOAD_TOP<<4|RIVEN_TOP	; east exit
	.byte	$E3		; west exit
	.byte	$FF		; north exit_dir
	.byte	$fF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	alcove_e_zx02	; east bg
	.word	alcove_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST	; all bgs
	.byte	DIRECTION_W	; special exit
	.byte	30,36		; x
	.byte	96,130		; y
	.word	alcove_button-1
