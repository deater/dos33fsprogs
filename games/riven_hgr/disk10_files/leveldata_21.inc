;===============================================
; level data -- rotate room, between pillars 2+1
;===============================================

locations:
	.word location0

; RIVEN_21 -- 

location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$FF		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$FF		; west exit_dir
	.word	pillars_21_in_zx02	; north bg
	.word	pillars_21_out_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte   DIRECTION_N|DIRECTION_ONLY_POINT	; special exit
	.byte	7,33
	.byte	0,180
	.word	move_to_center-1