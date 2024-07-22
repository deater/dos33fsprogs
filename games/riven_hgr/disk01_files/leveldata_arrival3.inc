;===============================================
; level data for Dome Island level -- arrival3
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_ARRIVAL3 - third arrival
location0:
	.byte	RIVEN_ARRIVAL4	; north exit
	.byte	LOAD_TELESCOPE<<4|RIVEN_TELESCOPE		; south exit
	.byte	$FF		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	arrival3_n_zx02	; north bg
	.word	arrival3_s_zx02	; south bg
	.word	arrival3_e_zx02	; east bg
	.word	arrival3_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff	; special exit

; arrival4
location1:
	.byte	RIVEN_ARRIVAL5	; north exit
	.byte	RIVEN_ARRIVAL3	; south exit
	.byte	$FF		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	arrival4_n_zx02	; north bg
	.word	arrival4_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff	; special exit

; arrival5
location2:
	.byte	RIVEN_ARRIVAL4	; north exit
	.byte	$FF		; south exit
	.byte	$FF		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	arrival5_n_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte	$ff	; special exit

