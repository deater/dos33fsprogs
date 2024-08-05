;===============================================
; level data for Tunnel7
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_TUNNEL7	-- more tunnel
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	RIVEN_TUNNEL8	; east exit
	.byte	LOAD_TUNNEL4<<4|RIVEN_TUNNEL6		; west exit
	.byte	$ff		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	tunnel7_e_zx02	; east bg
	.word	tunnel7_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; RIVEN_TUNNEL8 -- more tunnel
location1:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	RIVEN_TUNNEL8_OPEN	; east exit
	.byte	RIVEN_TUNNEL7	; west exit
	.byte	$ff		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	tunnel8_e_zx02	; east bg
	.word	tunnel8_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; RIVEN_TUNNEL8_OPEN -- tunnel door open
location2:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$E1		; east exit
	.byte	RIVEN_TUNNEL7	; west exit
	.byte	$ff		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	tunnel8_open_e_zx02	; east bg
	.word	tunnel8_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

