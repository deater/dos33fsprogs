;===============================================
; level data for doorway in cave
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_TOP	-- top of the cave
location0:
	.byte	$FF		; north exit
	.byte	$ff		; south exit
	.byte	LOAD_CAVE<<4|RIVEN_MIDDLE		; east exit
	.byte	RIVEN_PEEPHOLE	; west exit
	.byte	$FF		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	top_e_zx02	; east bg
	.word	top_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; RIVEN_PEEPHOLE	-- at the peephole
location1:
	.byte	$FF		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	RIVEN_VIEW	; west exit
	.byte	$FF		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	peephole_w_zx02	; west bg
	.byte	BG_WEST
	.byte	$ff		; special exit

; note, change this based on rotation

; RIVEN_VIEW	-- view in room
location2:
	.byte	$FF		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	RIVEN_PEEPHOLE	; west exit
	.byte	$FF		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	view1_w_zx02	; west bg
	.byte	BG_WEST
	.byte	$ff		; special exit

