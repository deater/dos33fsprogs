;===============================================
; level data for Dome Island level
;===============================================

locations:
	.word location0,location1,location2

; RIVEN_ARRIVAL - first arrival
location0:
	.byte	RIVEN_ARRIVAL_NEAR	; north exit
	.byte	$ff		; south exit
	.byte	$FF		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	arrival_n_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte	$ff	; special exit


; RIVEN_ARRIVAL_NEAR	-- just outside the cage
location1:
	.byte	LOAD_ARRIVAL2<<4|RIVEN_ARRIVAL2		; north exit
	.byte	RIVEN_ARRIVAL	; south exit
	.byte	$E0		; leave to disk39		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_N	; south exit_dir
	.byte	DIRECTION_W	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	arrival_near_n_zx02	; north bg
	.word	arrival_near_s_zx02	; south bg
	.word	arrival_near_e_zx02	; east bg
	.word	arrival_near_w_zx02	; west bg
	.byte	BG_EAST|BG_NORTH|BG_SOUTH|BG_WEST	; all bgs
	.byte	DIRECTION_E	; special exit
	.byte	12,16		; special x
	.byte	100,161		; special y
	.word	handle_clicked-1

; RIVEN_HANDLE - big handle
location2:
	.byte	RIVEN_ARRIVAL_NEAR	; north exit
	.byte	$ff		; south exit
	.byte	$FF		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	arrival_handle_n_zx02	; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	$0000		; west bg
	.byte	BG_NORTH
	.byte	$ff	; special exit
