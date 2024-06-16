;===============================================
; level data for Cart level
;===============================================

locations:
	.word location0,location1

; RIVEN_OUTSIDE_CART	-- just outside cart
location0:
	.byte	RIVEN_IN_CART	; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_E	; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	cart_n_zx02	; north bg
	.word	cart_s_zx02	; south bg
	.word	cart_e_zx02	; east bg
	.word	cart_w_zx02	; west bg
	.byte	BG_EAST|BG_NORTH|BG_SOUTH|BG_WEST	; all bgs
	.byte	$ff		; special exit

; RIVEN_IN_CART	-- sitting in cart
location1:
	.byte	$ff			; north exit
	.byte	$ff			; south exit
	.byte	$ff			; east exit
	.byte	$ff			; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000		; north bg
	.word	$0000		; south bg
	.word	in_cart_e_zx02	; east bg
	.word	$0000		; west bg
	.byte	BG_EAST		; all bgs
	.byte	DIRECTION_E	; special exit
	.byte	32,34		; special x
	.byte	136,154		; special y
	.word	call_button_clicked-1

