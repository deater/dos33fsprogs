;===============================================
; level data for Jungle stair going up
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_UP1  -- going up
location0:
	.byte	$ff		; north exit
	.byte	$FF		; south exit
	.byte	LOAD_STAIRS<<4|RIVEN_STAIRS	; east exit
	.byte	RIVEN_UP2	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	stairs_up1_e_zx02	; east bg
	.word	stairs_up1_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; RIVEN_UP2  -- going up
location1:
	.byte	$ff		; north exit
	.byte	$FF		; south exit
	.byte	RIVEN_UP1	; east exit
	.byte	RIVEN_UP3	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	stairs_up2_e_zx02	; east bg
	.word	stairs_up2_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; RIVEN_UP3  -- going up
location2:
	.byte	$ff		; north exit
	.byte	$FF		; south exit
	.byte	RIVEN_UP2	; east exit
	.byte	$FF		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	stairs_up3_e_zx02	; east bg
	.word	stairs_up3_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

