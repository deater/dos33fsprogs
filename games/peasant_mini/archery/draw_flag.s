	;=======================
	; clear flag
	;=======================
	; reset it for next round
clear_flag:

	;========================
	; clear top

	lda	#30			; 210/7
	sta	CURSOR_X
	lda	#28
	sta	CURSOR_Y

	; set up sprites

	lda	#<flag_bg0
	sta	INL
	lda	#>flag_bg0
	sta	INH

	jsr	hgr_draw_sprite

	;========================
	; clear bottom

	lda	#30			; 210/7
	sta	CURSOR_X
	lda	#49
	sta	CURSOR_Y

	; set up sprites

	lda	#<flag_bg1
	sta	INL
	lda	#>flag_bg1
	sta	INH

	jsr	hgr_draw_sprite


	rts



	;=======================
	; draw flag
	;=======================
draw_flag:

	lda	WIND_DIR
	asl
	tax

	lda	FRAME
	and	#$02
	bne	flag_even
flag_odd:
	inx
flag_even:

	lda	flag_x,X
	sta	CURSOR_X
	lda	#28
	sta	CURSOR_Y

	; set up sprites

	lda	flag_sprites_l,X
	sta	INL
	lda	flag_sprites_h,X
	sta	INH

	jsr	hgr_draw_sprite

	rts


	; start at 30
flag_x:
	.byte 32,32, 33,33
	.byte 30,30, 30,30
	.byte 33,33

flag_sprites_l:
	.byte <flag_nowind0,<flag_nowind0
	.byte <flag_rwindl0,<flag_rwindl1
	.byte <flag_lwindl0,<flag_lwindl1
	.byte <flag_lwindh0,<flag_lwindh1
	.byte <flag_rwindh0,<flag_rwindh1


flag_sprites_h:
	.byte >flag_nowind0,>flag_nowind0
	.byte >flag_rwindl0,>flag_rwindl1
	.byte >flag_lwindl0,>flag_lwindl1
	.byte >flag_lwindh0,>flag_lwindh1
	.byte >flag_rwindh0,>flag_rwindh1



