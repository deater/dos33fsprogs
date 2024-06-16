;===============================================
; level data for inside the maglev
;===============================================

locations:
	.word location0,location1,location2


; RIVEN_LOOKIN	-- looking into the maglev
location0:
	.byte	$FF			; north exit
	.byte	LOAD_MAGSTEPS<<4|RIVEN_MAGSTEPS3	; south exit
	.byte	$ff			; east exit
	.byte	RIVEN_INSEAT		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	inseat_s_zx02	; south bg
	.word	$0000		; east bg
	.word	lookin_w_zx02	; west bg
	.byte	BG_WEST|BG_SOUTH
	.byte	DIRECTION_E	; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	location0-1			; FIXME

; RIVEN_INSEAT	-- when sitting in seat
location1:
	.byte	$FF			; north exit
	.byte	LOAD_MAGSTEPS<<4|RIVEN_MAGSTEPS3	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	inseat_s_zx02	; south bg
	.word	$0000		; east bg
	.word	inseat_w_zx02	; west bg
	.byte	BG_WEST|BG_SOUTH
	.byte	DIRECTION_W	; special exit
	.byte	11,14		; special x
	.byte	119,145		; special y
	.word	handle1_clicked-1	; special function

; RIVEN_READY2GO	-- ready for maglev ride
location2:
	.byte	$FF			; north exit
	.byte	$FF			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	inseat_e_zx02	; east bg
	.word	$0000		; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	17,23		; special x
	.byte	155,168		; special y
	.word	handle2_clicked-1	; special function

