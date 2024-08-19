;===============================================
; level data for Tunnel4
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_TUNNEL4	-- more tunnel
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	RIVEN_TUNNEL5	; east exit
	.byte	LOAD_TUNNEL3<<4|RIVEN_TUNNEL3		; west exit
	.byte	$ff		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	tunnel4_e_zx02	; east bg
	.word	tunnel4_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte   DIRECTION_W|DIRECTION_ONLY_POINT	; special exit
	.byte   25,33
	.byte   0,180
	.word   look_at_door-1



; RIVEN_TUNNEL5 -- more tunnel
location1:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	RIVEN_TUNNEL6	; east exit
	.byte	RIVEN_TUNNEL4	; west exit
	.byte	$ff		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	tunnel5_e_zx02	; east bg
	.word	tunnel5_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; RIVEN_TUNNEL6 -- more tunnel
location2:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	LOAD_TUNNEL7<<4|RIVEN_TUNNEL7		; east exit
	.byte	RIVEN_TUNNEL5	; west exit
	.byte	$ff		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	tunnel6_e_zx02	; east bg
	.word	tunnel6_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

