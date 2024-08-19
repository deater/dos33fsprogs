;===============================================
; level data -- pillars
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_BEETLE_R

location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	$ff	; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	beetle_r_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	DIRECTION_S|DIRECTION_ONLY_POINT	; special exit
	.byte	0,39
	.byte	0,180
	.word	move_to_center-1

; RIVEN_BEETLE_R_OPEN

location1:
	.byte	$ff		; north exit
	.byte	RIVEN_BEETLE_R	; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	beetle_open_r_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	DIRECTION_S
	.byte	9,32
	.byte	50,110
	.word	view_stained-1


; RIVEN_STAINED

location2:
	.byte	$ff		; north exit
	.byte	RIVEN_BEETLE_R_OPEN		; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	stained01_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$FF
