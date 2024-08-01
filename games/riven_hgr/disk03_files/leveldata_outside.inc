;===============================================
; level data for outside
;===============================================

locations:
	.word location0,location1

; RIVEN_OUTSIDE	-- outside the door
location0:
	.byte	$FF		; north exit
	.byte	LOAD_DSTEPS3<<4|RIVEN_DOWN3		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	outside_n_zx02	; north bg
	.word	outside_s_zx02	; south bg
	.word	outside_e_zx02	; east bg
	.word	outside_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST	; all bgs
	.byte	DIRECTION_W	; special exit
	.byte	14,26		; special x
	.byte	42,180		; special y
	.word	gate_clicked-1	; special function

; RIVEN_UNDERDOOR	-- under the door
location1:
	.byte	$FF		; north exit
	.byte	$FF		; south exit
	.byte	$ff		; east exit
	.byte	LOAD_CAVE<<4|RIVEN_LADDER		; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	underdoor_w_zx02	; west bg
	.byte	BG_WEST	; all bgs
	.byte	$ff		; special exit

