;===============================================
; level data for Large Projector Area level
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_CLOSE		-- looking at projector
location0:
	.byte	LOAD_MID<<4|RIVEN_MID	; north exit
	.byte	$ff			; south exit
	.byte	RIVEN_WAHRK_L		; east exit
	.byte	RIVEN_WAHRK_R		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	DIRECTION_S		; west exit_dir
	.word	close_n_zx02	; north bg
	.word	close_s_zx02	; south bg
	.word	close_e_zx02	; east bg
	.word	close_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$FF		; special exit (none)

; RIVEN_WAHRK_L	-- big fish on the left
location1:
	.byte	$ff			; north exit
	.byte	LOAD_MID<<4|RIVEN_MID	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$ff		; north bg
	.word	wahrk_l_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$FF		; special exit

; RIVEN_WAHRK_R	-- big fish on the left
location2:
	.byte	$ff			; north exit
	.byte	LOAD_MID<<4|RIVEN_MID	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$ff		; north bg
	.word	wahrk_r_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_SOUTH
	.byte	$FF		; special exit

