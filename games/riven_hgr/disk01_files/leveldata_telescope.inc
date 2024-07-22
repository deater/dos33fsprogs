;===============================================
; level data for Arrival Telescope Area
;===============================================

locations:
	.word location0,location1

; RIVEN_TELESCOPE -- near telescope
location0:
	.byte	LOAD_ARRIVAL3<<4|RIVEN_ARRIVAL3	; north exit
	.byte	LOAD_ARRIVAL2<<4|RIVEN_ARRIVAL2	; south exit
	.byte	$FF		; east exit
	.byte	RIVEN_MANHOLE	; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	telescope_n_zx02	; north bg
	.word	telescope_s_zx02	; south bg
	.word	telescope_e_zx02	; east bg
	.word	telescope_w_zx02	; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST|BG_WEST
	.byte	$ff	; special exit


; RIVEN_MANHOLE	-- looking at the manhole
location1:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	RIVEN_TELESCOPE	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	$0000		; east bg
	.word	manhole_w_zx02	; west bg
	.byte	BG_WEST		; backgrounds
	.byte	DIRECTION_W	; special exit
	.byte	15,24		; special x
	.byte	108,149		; special y
	.word	manhole_clicked-1

