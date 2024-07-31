;===============================================
; level data for in cave
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_LADDER	-- in front of ladder
location0:
	.byte	$FF		; north exit
	.byte	$FF		; south exit
	.byte	RIVEN_UNDERDOOR2	; east exit
	.byte	RIVEN_MIDDLE	; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	ladder_e_zx02	; east bg
	.word	ladder_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; RIVEN_MIDDLE	-- outside the door
location1:
	.byte	$FF		; north exit
	.byte	$ff		; south exit
	.byte	RIVEN_LADDER	; east exit
	.byte	LOAD_DOORWAY<<4|RIVEN_TOP	; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	middle_e_zx02	; east bg
	.word	middle_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; RIVEN_UNDERDOOR2	-- outside the door
location2:
	.byte	$FF		; north exit
	.byte	$ff		; south exit
	.byte	LOAD_OUTSIDE<<4|RIVEN_OUTSIDE	; east exit
	.byte	$ff		; west exit
	.byte	$FF		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_S	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	underdoor_e_zx02	; east bg
	.word	$0000		; west bg
	.byte	BG_EAST
	.byte	$ff		; special exit

