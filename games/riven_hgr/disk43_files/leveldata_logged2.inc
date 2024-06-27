;===============================================
; level data for Logged Area 2
;===============================================

locations:
	.word location0,location1

; RIVEN_LOGGED3		-- more logging
location0:
	.byte	$FF	; north exit
	.byte	$ff	; south exit
	.byte	LOAD_LOGGED<<4|RIVEN_LOGGED2	; east exit
	.byte	RIVEN_LOGGED4	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	logged3_e_zx02	; east bg
	.word	logged3_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST	; bgs
	.byte	$ff		; special exit

; RIVEN_LOGGED4		-- fourth logged area
location1:
	.byte	$FF		; north exit
	.byte	$ff		; south exit
	.byte	RIVEN_LOGGED3	; east exit
	.byte	LOAD_CART<<4|RIVEN_OUTSIDE_CART	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	logged4_e_zx02	; east bg
	.word	logged4_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST	; bgs
	.byte	$ff		; special exit
