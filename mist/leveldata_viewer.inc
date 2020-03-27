
;===============================================
; level data for Viewer Room
;===============================================

locations:
	.word location0, location1, location2, location3

; VIEWER_STEPS		-- steps
location0:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff		; east exit
	.byte	VIEWER_POOL	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000				; north bg
	.word	$0000				; south bg
	.word	viewer_stairs_e_lzsa		; east bg
	.word	viewer_stairs_w_lzsa		; west bg
	.byte	BG_WEST | BG_EAST
	.byte	DIRECTION_E		; special exit
	.byte	9,29		; special x
	.byte	2,46		; special y
	.word	back_to_mist-1	; special function

; VIEWER_POOL		-- the viewer far
location1:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	VIEWER_STEPS		; east exit
	.byte	VIEWER_POOL_CLOSE	; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	viewer_e_lzsa		; east bg
	.word	viewer_far_w_lzsa	; west bg
	.byte	BG_EAST|BG_WEST
	.byte	DIRECTION_E	; special exit
	.byte	6,12		; special x
	.byte	18,26		; special y
	.word	enter_control_panel-1		; special function

; VIEWER_POOL_CLOSE		-- the viewer close
location2:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	VIEWER_POOL		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	viewer_w_lzsa		; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	18,23		; special x
	.byte	34,42		; special y
	.word	enter_viewer-1		; special function



; VIEWER_CONTROL_PANEL		-- the viewer control panel
location3:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	VIEWER_POOL		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_W	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	viewer_controls_e_lzsa	; east bg
	.word	$0000			; west bg
	.byte	BG_WEST
	.byte	DIRECTION_E	; special exit
	.byte	11,28		; special x
	.byte	16,40		; special y
	.word	control_panel_pressed-1		; special function

