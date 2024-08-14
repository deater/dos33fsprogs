;===============================================
; level data for chair level
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_CHAIR -- scary chair
location0:
	.byte	$ff		; north exit
	.byte	RIVEN_ENTRANCE	; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	chair_n_zx02	; north bg
	.word	chair_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH	;
	.byte	$ff		; special exit

; RIVEN_ENTRANCE -- entrance to chair room
location1:
	.byte	RIVEN_CHAIR		; north exit
	.byte	RIVEN_ENTRANCE_OPEN	; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	entrance_n_zx02	; north bg
	.word	entrance_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH	;
	.byte	$ff		; special exit

; RIVEN_ENTRANCE_OPEN -- entrance to chair room, door open
location2:
	.byte	RIVEN_CHAIR	; north exit
	.byte	$e0		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$FF		; north exit_dir
	.byte	DIRECTION_E	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	entrance_n_zx02	; north bg
	.word	entrance_open_s_zx02	; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH|BG_SOUTH	;
	.byte	$ff		; special exit


