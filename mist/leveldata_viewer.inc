
;===============================================
; level data for Viewer Room
;===============================================

locations:
	.word location0, location1

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

; VIEWER_POOL		-- the viewer pool
location1:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	VIEWER_STEPS		; east exit
	.byte	VIEWER_POOL		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	DIRECTION_E	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	viewer_e_lzsa		; east bg
	.word	viewer_w_lzsa		; west bg
	.byte	BG_EAST|BG_WEST
;	.byte	DIRECTION_E	; special exit
;	.byte	12,25		; special x
;	.byte	26,46		; special y
;	.word	controls_pressed-1		; special function


