;===============================================
; level data for chair level
;===============================================

locations:
	.word location0

; RIVEN_CHAIR -- scary chair
location0:
	.byte	$E0		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	chair_n_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH	; all bgs
	.byte	$ff		; special exit
