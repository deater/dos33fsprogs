;===============================================
; level data for inside the room
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_INSIDE -- part way across the bridge

location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$E0		; east exit
	.byte	RIVEN_PILLAR_23	; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	entrance_e_zx02	; east bg
	.word	entrance_w_zx02	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	$ff		; special exit

; RIVEN_PILLAR23

location1:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	RIVEN_INSIDE	; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	pillars_51_zx02	; east bg
	.word	pillars_23_zx02	; west bg
	.byte	BG_WEST|BG_EAST
	.byte   DIRECTION_W|DIRECTION_ONLY_POINT        ; special exit
        .byte   7,33
        .byte   0,180
        .word   handle_pillars_23-1



; RIVEN_PILLAR51

location2:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	RIVEN_INSIDE	; west exit
	.byte	$FF		; north exit_dir
	.byte	$FF		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	pillars_51_zx02	; west bg
	.byte	BG_WEST
	.byte	$ff		; special exit



