;===============================================
; level data for Jungle Maglev
;===============================================

locations:
	.word location0

; RIVEN_MAGLEV_SIT	-- sitting in maglev
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	maglev_sit_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH	; bgs
	.byte   DIRECTION_S     ; special exit
        .byte   3,5             ; special x
        .byte   107,130         ; special y
        .word   cart_button_clicked-1

