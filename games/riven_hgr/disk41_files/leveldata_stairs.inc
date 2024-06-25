;===============================================
; level data for Jungle stair
;===============================================

locations:
	.word location0,location1

; RIVEN_STAIRS  -- mid-stairs
location0:
	.byte	LOAD_TUNNEL2<<4|RIVEN_TUNNEL8; north exit
	.byte	$FF		; south exit
	.byte	LOAD_COVE<<4|RIVEN_DOWN1	; east exit
	.byte	RIVEN_UP1		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	stairs_n_zx02	; north bg
	.word	stairs_s_zx02	; south bg
	.word	stairs_e_zx02	; east bg
	.word	stairs_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff		; special exit


; RIVEN_UP1  -- going up
location1:
	.byte	$ff		; north exit
	.byte	$FF		; south exit
	.byte	RIVEN_STAIRS	; east exit
	.byte	LOAD_STAIRS2<<4|RIVEN_UP2	; west exit
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

