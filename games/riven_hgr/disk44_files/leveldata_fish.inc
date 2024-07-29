;===============================================
; level data for Fish level
;===============================================

locations:
	.word location0

; RIVEN_RISH	-- arrived at big fish
location0:
	.byte	$FF		; north exit
	.byte	LOAD_PATH<<4|RIVEN_PATH		; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	fish_n_zx02	; north bg
	.word	fish_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit
