;===============================================
; level data for Large Projector Area level
;===============================================

locations:
	.word location0,location1

; RIVEN_PROJECTOR	-- looking at projector
location0:
	.byte	$E0|0			; north exit
	.byte	RIVEN_WAHRK		; south exit
	.byte	$E0|1			; east exit
	.byte	$FF			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	projector_n_zx02	; north bg
	.word	projector_s_zx02	; south bg
	.word	projector_e_zx02	; east bg
	.word	projector_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$FF		; special exit (none)

; RIVEN_WAHRK	-- big fish
location1:
	.byte	$ff			; north exit
	.byte	RIVEN_PROJECTOR		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$ff		; north bg
	.word	wahrk_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$FF		; special exit
