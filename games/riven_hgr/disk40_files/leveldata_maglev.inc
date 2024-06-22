;===============================================
; level data for Jungle Maglev
;===============================================

locations:
	.word location0,location1,location2,location3,location4


; RIVEN_LOOKIN  -- looking into the maglev
location0:
	.byte	$FF		; north exit
	.byte	RIVEN_OUTSIDE	; south exit
	.byte	$ff		; east exit
	.byte	RIVEN_INSEAT	; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_W	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	inseat_s_zx02	; south bg
	.word	$0000		; east bg
	.word	lookin_w_zx02	; west bg
	.byte	BG_WEST|BG_SOUTH
	.byte	$ff		; special exit

; RIVEN_INSEAT  -- when sitting in seat
location1:
	.byte   $FF                     ; north exit
	.byte	RIVEN_OUTSIDE	; south exit
	.byte   $ff		; east exit
	.byte	$ff		; west exit
	.byte   $FF             ; north exit_dir
	.byte   DIRECTION_W	; south exit_dir
	.byte   $ff             ; east exit_dir
	.byte   $ff             ; west exit_dir
	.word   $0000           ; north bg
	.word   inseat_s_zx02   ; south bg
	.word   $0000           ; east bg
	.word   inseat_w_zx02   ; west bg
	.byte   BG_WEST|BG_SOUTH
	.byte   DIRECTION_W     ; special exit
	.byte   11,14           ; special x
	.byte   119,145         ; special y
	.word   handle1_clicked-1       ; special function


; RIVEN_READY2GO        -- ready for maglev ride
location2:
        .byte   $FF		; north exit
        .byte   $FF		; south exit
        .byte   $ff		; east exit
        .byte   $ff		; west exit
        .byte   $FF             ; north exit_dir
        .byte   $FF             ; south exit_dir
        .byte   $ff             ; east exit_dir
        .byte   $ff             ; west exit_dir
        .word   $0000           ; north bg
        .word   $0000           ; south bg
        .word   inseat_e_zx02   ; east bg
        .word   $0000           ; west bg
        .byte   BG_EAST
        .byte   DIRECTION_E     ; special exit
        .byte   17,29           ; special x
        .byte   127,168         ; special y
        .word   handle2_clicked-1       ; special function


; RIVEN_JUNGLE_OUTSIDE  -- just outside the maglev
location3:
	.byte	RIVEN_LOOKIN	; north exit
	.byte	$FF		; south exit
	.byte	$FF		; east exit
	.byte	RIVEN_OUTSIDE_PATH	; west exit
	.byte	DIRECTION_W	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	outside_n_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	outside_w_zx02	; west bg
	.byte	BG_WEST|BG_NORTH
	.byte	$ff		; special exit

; RIVEN_OUTSIDE_PATH  -- path away from maglev
location4:
	.byte	$FF		; north exit
	.byte	$FF		; south exit
	.byte	RIVEN_OUTSIDE	; east exit
	.byte	LOAD_OUTSIDE<<4|RIVEN_OUTSIDE_PLAZA		; west exit
	.byte	$FF		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_N	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	out_path_e_zx02	; east bg
	.word	out_path_w_zx02	; west bg
	.byte	BG_WEST|BG_EAST
	.byte	$ff		; special exit
