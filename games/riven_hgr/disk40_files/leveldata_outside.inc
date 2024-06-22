;===============================================
; level data for Jungle Outside
;===============================================

locations:
	.word location0,location1

; RIVEN_OUTSIDE_PLAZA  -- plaza near maglev
location0:
	.byte	LOAD_ORB<<4|RIVEN_ORB1	; north exit
	.byte	RIVEN_CAVE_ENTRANCE	; south exit
	.byte	LOAD_MAGLEV<<4|RIVEN_OUTSIDE_PATH	; east exit
	.byte	$FF		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	out_plaza_n_zx02	; north bg
	.word	out_plaza_s_zx02	; south bg
	.word	out_plaza_e_zx02	; east bg
	.word	out_plaza_w_zx02	; west bg
	.byte	BG_WEST|BG_NORTH|BG_SOUTH|BG_EAST
	.byte	$ff		; special exit

; RIVEN_CAVE_ENTRANCE  -- plaza near maglev
location1:
	.byte	RIVEN_OUTSIDE_PLAZA		; north exit
	.byte	$E0|0		; change disk, exit 0	; south exit
	.byte	$FF		; east exit
	.byte	$FF		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	cave_n_zx02	; north bg
	.word	cave_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit


; RIVEN_OUTSIDE_PATH  -- path away from maglev
;location0:
;	.byte	$FF		; north exit
;	.byte	$FF		; south exit
;	.byte	LOAD_MAGLEV<<4|RIVEN_OUTSIDE	; east exit
;	.byte	RIVEN_OUTSIDE_PLAZA		; west exit
;	.byte	$FF		; north exit_dir
;	.byte	$ff		; south exit_dir
;	.byte	DIRECTION_N	; east exit_dir
;	.byte	DIRECTION_W	; west exit_dir
;	.word	$0000		; north bg
;	.word	$0000		; south bg
;	.word	out_path_e_zx02	; east bg
;	.word	out_path_w_zx02	; west bg
;	.byte	BG_WEST|BG_EAST
;	.byte	$ff		; special exit
