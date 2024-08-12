;===============================================
; level data for Large Projector Area level
;===============================================

locations:
	.word location0

; RIVEN_PROJECTOR	-- looking at projector
location0:
	.byte	$E0|0			; north exit
	.byte	LOAD_MID<<4|RIVEN_MID		; south exit
	.byte	LOAD_ENTRY<<4|RIVEN_NEAR_DOOR		; east exit
	.byte	$FF			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	projector_n_zx02	; north bg
	.word	projector_s_zx02	; south bg
	.word	projector_e_zx02	; east bg
	.word	projector_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$FF		; special exit (none)
