;===============================================
; level data for outside
;===============================================

locations:
	.word location0

; RIVEN_OUTSIDE	-- outside the door
location0:
	.byte	$FF		; north exit
	.byte	LOAD_DSTEPS1<<4|RIVEN_DOWN2		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	outside_n_zx02	; north bg
	.word	outside_s_zx02	; south bg
	.word	outside_e_zx02	; east bg
	.word	outside_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST	; all bgs
	.byte	$ff		; special exit
