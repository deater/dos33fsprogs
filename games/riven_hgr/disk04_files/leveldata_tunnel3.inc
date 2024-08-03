;===============================================
; level data for Start level
;===============================================

locations:
	.word location0,location1

; RIVEN_TUNNEL3	-- outside the door
location0:
	.byte	RIVEN_TUNNEL3_OPEN		; north exit
	.byte	$ff		; south exit
	.byte	$E1		; east exit
	.byte	LOAD_BRIDGE2<<4|RIVEN_BRIDGE2		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	tunnel3_n_zx02	; north bg
	.word	$0000		; south bg
	.word	tunnel3_e_zx02	; east bg
	.word	tunnel3_w_zx02	; west bg
	.byte	BG_EAST|BG_NORTH|BG_WEST
	.byte	$ff		; special exit

; RIVEN_TUNNEL3_OPEN	-- outside the door, open
location1:
	.byte	$E2		; north exit
	.byte	$ff		; south exit
	.byte	$E1		; east exit
	.byte	$E0		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	tunnel3_open_n_zx02	; north bg
	.word	$0000		; south bg
	.word	tunnel3_e_zx02	; east bg
	.word	tunnel3_w_zx02	; west bg
	.byte	BG_EAST|BG_NORTH|BG_WEST
	.byte	$ff		; special exit

