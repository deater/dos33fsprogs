;===============================================
; level data for Maglev Steps on Dome Island
;===============================================

locations:
	.word location0,location1

; RIVEN_MAGSTEPS2	-- meglev steps middle
location0:
	.byte	RIVEN_MAGSTEPS3		; north exit
	.byte	LOAD_DOME<<4|RIVEN_MAGLEV1	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	magsteps2_n_zx02	; north bg
	.word	magsteps2_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	location0-1			; FIXME

; RIVEN_MAGSTEPS3	-- maglev steps top
location1:
	.byte	RIVEN_MAGSTEPS3		; north exit
	.byte	RIVEN_MAGSTEPS2		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	magsteps3_n_zx02	; north bg
	.word	magsteps3_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	location1-1	; special function FIXME
