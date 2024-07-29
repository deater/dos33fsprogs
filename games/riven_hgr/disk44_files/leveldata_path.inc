;===============================================
; level data for initial path
;===============================================

locations:
	.word location0

; RIVEN_PATH	-- start of trail
location0:
	.byte	$FF		; north exit
	.byte	$ff		; south exit
	.byte	LOAD_FISH<<4|RIVEN_FISH		; east exit
	.byte	$E0		; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	path_n_zx02	; north bg
	.word	path_s_zx02	; south bg
	.word	path_e_zx02	; east bg
	.word	path_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff		; special exit
