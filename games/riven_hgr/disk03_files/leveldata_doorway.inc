;===============================================
; level data for outside
;===============================================

locations:
	.word location0

; RIVEN_OUTSIDE	-- outside the door
location0:
	.byte	$FF		; north exit
	.byte	LOAD_DSTEPS3<<4|RIVEN_DOWN3		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	ladder_e_zx02	; east bg
	.word	ladder_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit
