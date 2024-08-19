;===============================================
; level data -- rotate room, center
;===============================================

locations:
	.word location0,location1,location2,location3,location4

; RIVEN_CENTER_51 -- inside from bridge

location0:
	.byte	$ff		; north exit
	.byte	$FF		; south exit
	.byte	$FF		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$FF		; west exit_dir
	.word	center_51_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte   DIRECTION_N|DIRECTION_ONLY_POINT	; special exit
	.byte	1,39
	.byte	0,180
	.word	move_51-1

; RIVEN_CENTER_12 -- 

location1:
	.byte	$ff		; north exit
	.byte	$FF		; south exit
	.byte	$FF		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$FF		; west exit_dir
	.word	center_12_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte   DIRECTION_N|DIRECTION_ONLY_POINT	; special exit
	.byte	1,39
	.byte	0,180
	.word	move_12-1

; RIVEN_CENTER_23 --

location2:
	.byte	$ff		; north exit
	.byte	$FF		; south exit
	.byte	$FF		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$FF		; west exit_dir
	.word	center_23_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte   DIRECTION_N|DIRECTION_ONLY_POINT	; special exit
	.byte	1,39
	.byte	0,180
	.word	move_23-1

; RIVEN_CENTER_34 -- inside from bridge

location3:
	.byte	$ff		; north exit
	.byte	$FF		; south exit
	.byte	$FF		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$FF		; west exit_dir
	.word	center_34_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte   DIRECTION_N|DIRECTION_ONLY_POINT	; special exit
	.byte	1,39
	.byte	0,180
	.word	move_34-1

; RIVEN_CENTER_45 --

location4:
	.byte	$ff		; north exit
	.byte	$FF		; south exit
	.byte	$FF		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$FF		; west exit_dir
	.word	center_45_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte   DIRECTION_N|DIRECTION_ONLY_POINT	; special exit
	.byte	1,39
	.byte	0,180
	.word	move_45-1
