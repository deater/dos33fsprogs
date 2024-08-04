;===============================================
; level data for Logged Area 2
;===============================================

locations:
	.word location0

; RIVEN_LOGGED3		-- more logging
location0:
	.byte	$FF	; north exit
	.byte	$ff	; south exit
	.byte	LOAD_LOGGED<<4|RIVEN_LOGGED2	; east exit
	.byte	LOAD_LOGGED4<<4|RIVEN_LOGGED4	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	logged3_n_zx02	; north bg
	.word	logged3_s_zx02	; south bg
	.word	logged3_e_zx02	; east bg
	.word	logged3_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST|BG_SOUTH|BG_NORTH	; bgs
	.byte   DIRECTION_W|DIRECTION_ONLY_POINT        ; special exit
        .byte   7,33
        .byte   0,180
        .word   handle_split_dir1-1
