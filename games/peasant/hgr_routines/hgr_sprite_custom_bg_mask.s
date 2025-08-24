	;===============================================
	; hgr draw sprite, with bg mask in GR $400
	;===============================================
	; this sets up mask and then calls into main routine
	;	this is because the actual code is fairly specific
	;	to drawing the peasant but we want to reuse it

	; Location at CURSOR_X CURSOR_Y

hgr_sprite_custom_bg_mask:

	;==================================
	; calculate end of sprite on screen for Xpos loop

	lda	custom_sprites_xsize,X
	sta	hdsb_width_smc+1
	sta	mask_store_smc+1

	;================================
	; calculate bottom of sprite for Ypos loop

	lda	custom_sprites_ysize,X
	sta	hdsb_ysize_smc+1

	;==================================
	; set up sprite pointers
	lda	custom_sprites_data_l,X
	sta	h728_smc1+1
	sta	h728_smc2+1
	lda	custom_sprites_data_h,X
	sta	h728_smc1+2
	sta	h728_smc2+2

	;==================================
	; set up mask pointers
	lda	custom_mask_data_l,X
	sta	h728_smc3+1
	sta	h728_smc4+1
	lda	custom_mask_data_h,X
	sta	h728_smc3+2
	sta	h728_smc4+2

	jmp	hgr_draw_sprite_bg_mask_common



