;===============================================
; level data for Dome Island level
;===============================================

locations:
	.word location0

; RIVEN_START - first arrival
location0:
	.byte	$E0|0		; north exit
	.byte	$ff		; south exit
	.byte	$FF		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	arrival_n_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte	$ff	; special exit

