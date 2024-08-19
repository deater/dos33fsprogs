;===============================================
; level data -- rotate room, between pillars 1+5
;===============================================

locations:
	.word location0

; RIVEN_15 -- inside from bridge

location0:
	.byte	$ff		; north exit
	.byte	$E0		; south exit
	.byte	$FF		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$FF		; west exit_dir
	.word	pillars_15_in_zx02	; north bg
	.word	pillars_15_out_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte   DIRECTION_N|DIRECTION_ONLY_POINT	; special exit
	.byte	7,33
	.byte	0,180
	.word	move_to_center-1

.if 0

; RIVEN_BEETLE_1

location1:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	RIVEN_BEETLE_1_OPEN	; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	beetle_1_r_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$FF

;	.byte	BG_SOUTH
;	.byte   DIRECTION_W|DIRECTION_ONLY_POINT        ; special exit
 ;       .byte   7,33
  ;      .byte   0,180
  ;      .word   handle_pillars_23-1

; RIVEN_BEETLE_1_OPEN

location2:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$FF		; west exit
	.byte	$FF		; north exit_dir
	.byte	RIVEN_STAINED1	; south exit_dir
	.byte	$FF		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	stained01_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	$FF

;	.byte	BG_SOUTH
;	.byte   DIRECTION_W|DIRECTION_ONLY_POINT        ; special exit
 ;       .byte   7,33
  ;      .byte   0,180
  ;      .word   handle_pillars_23-1

.endif
