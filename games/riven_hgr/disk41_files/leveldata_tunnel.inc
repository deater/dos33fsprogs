;===============================================
; level data for Jungle Tunnel2
;===============================================

locations:
	.word location0,location1,location2,location3

; RIVEN_TUNNEL5  -- mid-tunnel
location0:
	.byte	$E0|0		; north exit
	.byte	RIVEN_TUNNEL6	; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tunnel5_n_zx02	; north bg
	.word	tunnel5_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; RIVEN_TUNNEL6  -- mid-tunnel
location1:
	.byte	RIVEN_TUNNEL5	; north exit
	.byte	RIVEN_TUNNEL7	; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tunnel6_n_zx02	; north bg
	.word	tunnel6_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; RIVEN_TUNNEL7  -- mid-tunnel
location2:
	.byte	RIVEN_TUNNEL6	; north exit
	.byte	RIVEN_TUNNEL8	; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tunnel7_n_zx02	; north bg
	.word	tunnel7_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; RIVEN_TUNNEL8  -- mid-tunnel
location3:
	.byte	RIVEN_TUNNEL7	; north exit
	.byte	LOAD_STAIRS<<4|RIVEN_STAIRS	; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tunnel8_n_zx02	; north bg
	.word	tunnel8_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

