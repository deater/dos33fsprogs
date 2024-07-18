;===============================================
; level data for Dome Island level -- arrival2
;===============================================

locations:
	.word location0

; RIVEN_ARRIVAL2 - second arrival
location0:
	.byte	LOAD_TELESCOPE<<4|RIVEN_TELESCOPE	; north exit
	.byte	LOAD_ARRIVAL<<4|RIVEN_ARRIVAL_NEAR	; south exit
	.byte	$FF		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	arrival2_n_zx02	; north bg
	.word	arrival2_s_zx02	; south bg
	.word	arrival2_e_zx02	; east bg
	.word	arrival2_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff	; special exit

