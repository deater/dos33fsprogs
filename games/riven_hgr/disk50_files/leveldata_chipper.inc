;===============================================
; level data for Start level
;===============================================

locations:
	.word location0

; RIVEN_CHIPPER	-- just arrived by cart
location0:
	.byte	$FF		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	chipper_n_zx02	; north bg
	.word	chipper_s_zx02	; south bg
	.word	chipper_e_zx02	; east bg
	.word	chipper_w_zx02	; west bg
	.byte	BG_EAST|BG_NORTH|BG_SOUTH|BG_WEST	; all bgs
	.byte	$ff		; special exit
