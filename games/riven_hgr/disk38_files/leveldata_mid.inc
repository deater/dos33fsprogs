;===============================================
; level data for Projector, middle
;===============================================

locations:
	.word location0

; RIVEN_MID	-- looking at projector
location0:
	.byte	LOAD_PROJECTOR<<4|RIVEN_PROJECTOR	; north exit
	.byte	LOAD_CLOSE<<4|RIVEN_CLOSE		; south exit
	.byte	$FF			; east exit
	.byte	$FF			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	mid_n_zx02	; north bg
	.word	mid_s_zx02	; south bg
	.word	mid_e_zx02	; east bg
	.word	mid_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	DIRECTION_S|DIRECTION_ONLY_POINT        ; special exit
	.byte	7,33
	.byte	0,180
	.word	handle_wahrks-1
