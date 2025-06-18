
	;=================================
	; load peasant sprites to peasant_sprites_location ($de00)
	;	which to load in A
	;	current is in WHICH_PEASANT_SPRITES

load_peasant_sprites:
	sta	WHICH_PEASANT_SPRITES

	lda	#LOAD_PEASANT_SPRITES
	sta	WHICH_LOAD

	jsr	load_file

	; loads to $6000 (peasant_sprites_temp)

	lda	WHICH_PEASANT_SPRITES
	asl
	tax
	lda	peasant_sprites_temp,X
        sta     zx_src_l+1
	lda	peasant_sprites_temp+1,X
        sta     zx_src_h+1

        lda     #>peasant_sprites_location

        jsr     zx02_full_decomp

	rts					; TODO: tail call?

