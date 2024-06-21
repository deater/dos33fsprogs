;===============================================
; level data for Jungle Outside
;===============================================

locations:
	.word location0,location1


; RIVEN_OUTSIDE_PATH  -- path away from maglev
location0:
	.byte	$FF		; north exit
	.byte	$FF		; south exit
	.byte	LOAD_MAGLEV<<4|RIVEN_OUTSIDE	; east exit
	.byte	RIVEN_OUTSIDE_PLAZA		; west exit
	.byte	$FF		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	out_path_e_zx02	; east bg
	.word	out_path_w_zx02	; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff		; special exit

; RIVEN_OUTSIDE_PLAZA  -- plaza near maglev
location1:
	.byte	$FF		; north exit
	.byte	$E0|0		; change disk, exit 0	; south exit
	.byte	$FF		; east exit
	.byte	$FF		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	out_plaza_n_zx02	; north bg
	.word	out_plaza_s_zx02	; south bg
	.word	out_plaza_e_zx02	; east bg
	.word	out_plaza_w_zx02	; west bg
	.byte	BG_WEST|BG_NORTH|BG_SOUTH|BG_EAST
	.byte	$ff		; special exit

