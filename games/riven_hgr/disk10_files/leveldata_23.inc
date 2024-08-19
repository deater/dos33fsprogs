;===============================================
; level data for looking at stained glass
;===============================================

locations:
	.word location0,location1,location2,location3

; RIVEN_BEETLE_FAR_R

location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$FF		; east exit
	.byte	RIVEN_BEETLE_CLOSE	; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	beetle_far_r_zx02	; west bg
	.byte	BG_WEST
	.byte	$ff		; special exit

; RIVEN_BEETLE_CLOSE

location1:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$FF		; east exit
	.byte	RIVEN_STAINED3	; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	beetle_close_zx02	; west bg
	.byte	BG_WEST
	.byte	$ff		; special exit

; RIVEN_STAINED02

location2:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$FF		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	stained02_zx02	; west bg
	.byte	BG_WEST
	.byte	$ff		; special exit

; RIVEN_STAINED03

location3:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$FF		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	stained03_zx02	; west bg
	.byte	BG_WEST
	.byte	$ff		; special exit





