
	; patch the sprite tables

NUM_SHOOTING_SPRITES = 9


	;=================================
	;=================================
	;=================================

patch_sprite_tables:

	;==============================
	; patch shooting sprite
	;==============================

	ldx	#0
copy_shoot_loop:
	; mask_l
	lda	$A800,X
	sta	sprites_mask_l+PEASANT_BOW_OFFSET,X
	; mask_h
	lda	$A800+NUM_SHOOTING_SPRITES,X
	sta	sprites_mask_h+PEASANT_BOW_OFFSET,X
	; sprite_l
	lda	$A800+(NUM_SHOOTING_SPRITES*2),X
	sta	sprites_data_l+PEASANT_BOW_OFFSET,X
	; sprite_h
	lda	$A800+(NUM_SHOOTING_SPRITES*3),X
	sta	sprites_data_h+PEASANT_BOW_OFFSET,X
	; sprite_xsize
	lda	$A800+(NUM_SHOOTING_SPRITES*4),X
	sta	sprites_xsize+PEASANT_BOW_OFFSET,X
	; sprite_h
	lda	$A800+(NUM_SHOOTING_SPRITES*5),X
	sta	sprites_ysize+PEASANT_BOW_OFFSET,X

	inx
	cpx	#NUM_SHOOTING_SPRITES
	bne	copy_shoot_loop


	;==============================
	; patch walking sprite
	;==============================

NUM_KERREK_WALK_SPRITES = 8

patch_walking_sprites:

	; copy to the sprite data

	ldx	#0
copy_walk_loop:
	; mask_l
	lda	$9e00,X
	sta	sprites_mask_l+KERREK_WALK_OFFSET,X
	; mask_h
	lda	$9e00+NUM_KERREK_WALK_SPRITES,X
	sta	sprites_mask_h+KERREK_WALK_OFFSET,X
	; sprite_l
	lda	$9e00+(NUM_KERREK_WALK_SPRITES*2),X
	sta	sprites_data_l+KERREK_WALK_OFFSET,X
	; sprite_h
	lda	$9e00+(NUM_KERREK_WALK_SPRITES*3),X
	sta	sprites_data_h+KERREK_WALK_OFFSET,X
	; sprite_xsize
	lda	$9e00+(NUM_KERREK_WALK_SPRITES*4),X
	sta	sprites_xsize+KERREK_WALK_OFFSET,X
	; sprite_h
	lda	$9e00+(NUM_KERREK_WALK_SPRITES*5),X
	sta	sprites_ysize+KERREK_WALK_OFFSET,X

	inx
	cpx	#NUM_KERREK_WALK_SPRITES
	bne	copy_walk_loop

	;==============================
	; patch kerrek hit  sprites
	;==============================


NUM_KERREK_HIT_SPRITES = 7

patch_kerrek_hit_sprites:

	; copy to the sprite data

	ldx	#0
copy_hit_loop:
	; mask_l
	lda	$9200,X
	sta	sprites_mask_l+KERREK_HIT_OFFSET,X
	; mask_h
	lda	$9200+NUM_KERREK_HIT_SPRITES,X
	sta	sprites_mask_h+KERREK_HIT_OFFSET,X
	; sprite_l
	lda	$9200+(NUM_KERREK_HIT_SPRITES*2),X
	sta	sprites_data_l+KERREK_HIT_OFFSET,X
	; sprite_h
	lda	$9200+(NUM_KERREK_HIT_SPRITES*3),X
	sta	sprites_data_h+KERREK_HIT_OFFSET,X
	; sprite_xsize
	lda	$9200+(NUM_KERREK_HIT_SPRITES*4),X
	sta	sprites_xsize+KERREK_HIT_OFFSET,X
	; sprite_h
	lda	$9200+(NUM_KERREK_HIT_SPRITES*5),X
	sta	sprites_ysize+KERREK_HIT_OFFSET,X

	inx
	cpx	#NUM_KERREK_HIT_SPRITES
	bne	copy_hit_loop

	rts

