;===============================================
; level data for Channely Wood
;===============================================

locations:
	.word location0


; CHANNEL_OUTSIDE_DOOR		-- outside
location0:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff
;	.byte	DIRECTION_E	; special exit
;	.byte	12,25		; special x
;	.byte	26,46		; special y
;	.word	controls_pressed-1		; special function

