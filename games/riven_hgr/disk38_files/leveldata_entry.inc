;===============================================
; level data for Temple entry from Tunnel
;===============================================

locations:
	.word location0,location1

; RIVEN_DOOR	-- looking at projector
location0:
	.byte	$ff			; north exit
	.byte	$FF			; south exit
	.byte	$E0|1			; east exit
	.byte	RIVEN_NEAR_DOOR	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_S	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	door_e_zx02	; east bg
	.word	door_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$FF		; special exit (none)

; RIVEN_NEAR_DOOR	-- near door.  Note actual game has extra location
;				that's hard to get to

location1:
	.byte	$ff			; north exit
	.byte	LOAD_PROJECTOR<<4|RIVEN_PROJECTOR	; south exit
	.byte	RIVEN_DOOR		; east exit
	.byte	LOAD_PROJECTOR<<4|RIVEN_PROJECTOR	; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$ff		; north bg
	.word	near_door_s_zx02		; south bg
	.word	near_door_e_zx02		; east bg
	.word	near_door_w_zx02		; west bg
	.byte	BG_EAST|BG_WEST|BG_SOUTH
	.byte	$FF		; special exit
