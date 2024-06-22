;===============================================
; level data for Jungle Tunnel
;===============================================

locations:
	.word location0,location1,location2,location3

; RIVEN_TUNNEL1  -- start of tunnel
location0:
	.byte	LOAD_OUTSIDE<<4|RIVEN_CAVE_ENTRANCE	; north exit
	.byte	RIVEN_TUNNEL2	; south exit
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

; RIVEN_TUNNEL2  -- more tunnel
location1:
	.byte	RIVEN_TUNNEL1	; north exit
	.byte	RIVEN_TUNNEL3	; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tunnel2_n_zx02	; north bg
	.word	tunnel2_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; RIVEN_TUNNEL3  -- more tunnel
location2:
	.byte	RIVEN_TUNNEL2	; north exit
	.byte	RIVEN_TUNNEL4	; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tunnel3_n_zx02	; north bg
	.word	tunnel3_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; RIVEN_TUNNEL4  -- more tunnel
location3:
	.byte	RIVEN_TUNNEL3	; north exit
	.byte	$E0|0		; next disk (41) ; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	tunnel4_n_zx02	; north bg
	.word	tunnel4_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit
