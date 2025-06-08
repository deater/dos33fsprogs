load_sprites_temp = $6000

	;=================================
	; load peasant sprites to $A000
	;	which to load in A
	;	current is in WHICH_PEASANT_SPRITES

load_peasant_sprites:
	sta	WHICH_PEASANT_SPRITES

	lda	#LOAD_PEASANT_SPRITES
	sta	WHICH_LOAD

	jsr	load_file

	; loads to $6000

	lda	WHICH_PEASANT_SPRITES
	asl
	tax
	lda	load_sprites_temp,X
;        lda     #<robe_sprite_data
        sta     zx_src_l+1
;        lda     #>robe_sprite_data
	lda	load_sprites_temp+1,X
        sta     zx_src_h+1

        lda     #>peasant_sprites_location

        jsr     zx02_full_decomp

	rts					; tail call?

