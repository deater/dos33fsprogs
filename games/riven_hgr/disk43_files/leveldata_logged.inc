;===============================================
; level data for Logged Area
;===============================================

locations:
	.word location0,location1

; RIVEN_LOGGED		-- logged area
location0:
	.byte	$FF	; north exit
	.byte	$ff	; south exit
	.byte	LOAD_BRIDGE<<4|RIVEN_FAR_BRIDGE	; east exit
	.byte	RIVEN_LOGGED2	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	logged_e_zx02	; east bg
	.word	logged_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST	; bgs
	.byte	$ff		; special exit

; RIVEN_LOGGED2		-- second logged area
location1:
	.byte	$FF		; north exit
	.byte	$ff		; south exit
	.byte	RIVEN_LOGGED	; east exit
	.byte	LOAD_LOGGED3<<4|RIVEN_LOGGED3		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	logged2_e_zx02	; east bg
	.word	logged2_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST	; bgs
	.byte	$ff		; special exit


