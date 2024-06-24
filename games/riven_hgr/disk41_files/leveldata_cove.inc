;===============================================
; level data for Jungle Cove
;===============================================

locations:
	.word location0,location1

; RIVEN_DOWN2  -- down two flights of stairs
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte   LOAD_MOVIE_COVE<<4
;	.byte	RIVEN_COVE	; east exit
	.byte	LOAD_STAIRS<<4|RIVEN_DOWN1	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	stairs_down2_e_zx02	; east bg
	.word	stairs_down2_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; RIVEN_COVE  -- down by the cove
location1:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	RIVEN_DOWN2	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	cove_e_zx02	; east bg
	.word	cove_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

