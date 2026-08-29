	; patch the sprite tables

NUM_BELT_SPRITES = 10

BELT_LOCATION = $AB00
BODY_LOCATION = $E400

	;=================================
	;=================================
	;=================================

patch_sprite_tables:

	;==============================
	; patch belt sprite
	;==============================

	ldx	#0
copy_belt_loop:
	; mask_l
	lda	BELT_LOCATION,X
	sta	sprites_mask_l+PEASANT_BELT_BASE_OFFSET,X
	; mask_h
	lda	BELT_LOCATION+NUM_BELT_SPRITES,X
	sta	sprites_mask_h+PEASANT_BELT_BASE_OFFSET,X
	; sprite_l
	lda	BELT_LOCATION+(NUM_BELT_SPRITES*2),X
	sta	sprites_data_l+PEASANT_BELT_BASE_OFFSET,X
	; sprite_h
	lda	BELT_LOCATION+(NUM_BELT_SPRITES*3),X
	sta	sprites_data_h+PEASANT_BELT_BASE_OFFSET,X
	; sprite_xsize
	lda	BELT_LOCATION+(NUM_BELT_SPRITES*4),X
	sta	sprites_xsize+PEASANT_BELT_BASE_OFFSET,X
	; sprite_h
	lda	BELT_LOCATION+(NUM_BELT_SPRITES*5),X
	sta	sprites_ysize+PEASANT_BELT_BASE_OFFSET,X

	inx
	cpx	#NUM_BELT_SPRITES
	bne	copy_belt_loop


	;==============================
	; patch body sprite
	;==============================

NUM_KERREK_BODY_SPRITES = 4

patch_body_sprites:

	; copy to the sprite data

	ldx	#0
copy_body_loop:
	; mask_l
	lda	BODY_LOCATION,X
	sta	sprites_mask_l+KERREK_BODY_OFFSET,X
	; mask_h
	lda	BODY_LOCATION+NUM_KERREK_BODY_SPRITES,X
	sta	sprites_mask_h+KERREK_BODY_OFFSET,X
	; sprite_l
	lda	BODY_LOCATION+(NUM_KERREK_BODY_SPRITES*2),X
	sta	sprites_data_l+KERREK_BODY_OFFSET,X
	; sprite_h
	lda	BODY_LOCATION+(NUM_KERREK_BODY_SPRITES*3),X
	sta	sprites_data_h+KERREK_BODY_OFFSET,X
	; sprite_xsize
	lda	BODY_LOCATION+(NUM_KERREK_BODY_SPRITES*4),X
	sta	sprites_xsize+KERREK_BODY_OFFSET,X
	; sprite_h
	lda	BODY_LOCATION+(NUM_KERREK_BODY_SPRITES*5),X
	sta	sprites_ysize+KERREK_BODY_OFFSET,X

	inx
	cpx	#NUM_KERREK_BODY_SPRITES
	bne	copy_body_loop

	rts

