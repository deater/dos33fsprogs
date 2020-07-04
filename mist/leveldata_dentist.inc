;===============================================
; level data for Dentist/Planetarium level
;===============================================

locations:
	.word location0, location1, location2, location3
	.word location4, location5

; DENTIST_OUTSIDE		-- outside dentist door
location0:
	.byte	DENTIST_OUTSIDE_OPEN	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	dentist_door_n_lzsa	; north bg
	.word	dentist_door_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH | BG_SOUTH
	.byte	DIRECTION_S	; special exit
	.byte	10,30		; special x
	.byte	0,46		; special y
	.word	back_to_mist-1

; DENTIST_OUTSIDE_OPEN		-- outside dentist door, which is open
location1:
	.byte	DENTIST_INSIDE_DOOR	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	dentist_door_open_n_lzsa	; north bg
	.word	dentist_door_s_lzsa		; south bg
	.word	$0000				; east bg
	.word	$0000				; west bg
	.byte	BG_NORTH | BG_SOUTH
	.byte	DIRECTION_S	; special exit
	.byte	10,30		; special x
	.byte	0,46		; special y
	.word	back_to_mist-1

; DENTIST_INSIDE_DOOR		-- chair view
location2:
	.byte	DENTIST_CHAIR_CLOSE	; north exit
	.byte	DENTIST_OUTSIDE		; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	chair_view_n_lzsa	; north bg
	.word	chair_view_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH | BG_SOUTH
	.byte	DIRECTION_S	; special exit
	.byte	29,34		; special x
	.byte	18,30		; special y
	.word	light_switch-1

; DENTIST_CHAIR_CLOSE		-- chair view
location3:
	.byte	DENTIST_PANEL_UP	; north exit
	.byte	DENTIST_INSIDE_DOOR	; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	chair_close_n_lzsa	; north bg
	.word	chair_close_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH | BG_SOUTH
	.byte	$ff		; TODO: lightswitch

; DENTIST_PANEL_UP		-- sitting in chair
location4:
	.byte	DENTIST_CHAIR_CLOSE	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_S	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	panel_up_lzsa		; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	10,30		; special x
	.byte	0,20		; special y
	.word	pull_down_panel-1


; DENTIST_PANEL			-- looking at panel
location5:
	.byte	DENTIST_PANEL_UP	; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	panel_lzsa		; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	DIRECTION_N	; special exit
	.byte	16,38		; special x
	.byte	0,32		; special y
	.word	panel_pressed-1
