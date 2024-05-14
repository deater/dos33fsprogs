;===============================================
; level data for Dome Island level
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_MAGLEV1	-- maglev steps
location0:
	.byte	RIVEN_MAGLEV2		; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	maglev1_n_zx02	; north bg
	.word	maglev1_s_zx02	; south bg
	.word	maglev1_e_zx02	; east bg
	.word	maglev1_w_zx02	; west bg
	.byte	BG_EAST|BG_NORTH|BG_SOUTH|BG_WEST	; all bgs
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	location0-1			; FIXME

; RIVEN_MAGLEV2	-- maglev steps
location1:
	.byte	RIVEN_MAGLEV3		; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	maglev2_n_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	location1-1	; special function FIXME

; RIVEN_MAGLEV3	-- maglev inside
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	maglev3_n_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	location2-1	; FIXME

