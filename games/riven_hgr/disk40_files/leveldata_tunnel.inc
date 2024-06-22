;===============================================
; level data for Jungle Tunnel
;===============================================

locations:
	.word location0

; RIVEN_TUNNEL1  -- start of tunnel
location0:
	.byte	LOAD_OUTSIDE<<4|RIVEN_CAVE_ENTRANCE	; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tunnel1_n_zx02	; north bg
	.word	tunnel1_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit
