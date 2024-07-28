;===============================================
; level data for going down steps
;===============================================

locations:
	.word location0, location1

; RIVEN_DOWN1	-- starting down
location0:
	.byte	RIVEN_DOWN2	; north exit
	.byte	$E0		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	down1_n_zx02	; north bg
	.word	down1_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

; RIVEN_DOWN2	-- continuing down
location1:
	.byte	LOAD_DSTEPS3<<4|RIVEN_DOWN3		; north exit
	.byte	RIVEN_DOWN1	; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	down2_n_zx02	; north bg
	.word	down2_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff		; special exit

