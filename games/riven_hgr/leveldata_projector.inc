;===============================================
; level data for Large Projector Area level
;===============================================

locations:
	.word location0,location1

; RIVEN_PROJECTOR	-- looking at projector
location0:
	.byte	RIVEN_PROJ_DOOR		; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	projector_n_zx02	; north bg
	.word	projector_s_zx02	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$FF		; special exit (none)

; RIVEN_PROJ_DOOR	-- doorway to projector room
location1:
	.byte	LOAD_DOME<<4 | RIVEN_MAGLEV1	; north exit
	.byte	RIVEN_PROJECTOR		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	doorway_n_zx02	; north bg
	.word	doorway_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	location1-1	; special function FIXME
