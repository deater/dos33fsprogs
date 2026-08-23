	;=============================
	;=============================
	;=============================
	; load proper shooting sprite
	;=============================
	;=============================
	;=============================

NUM_SHOOTING_SPRITES = 9

load_shooting_sprites:

	;    PPKKK	right
	;     PPK	right
	;      KPP	left
	;      KKKPP	left
	; so if roughly PP <=kerrek shoot right

	lda	PEASANT_X
	cmp	KERREK_X
	bcs	shoot_left		; bge

shoot_right:
	lda     #<shoot_right_zx02
	sta     zx_src_l+1
	lda	#>shoot_right_zx02
	jmp	shoot_common

shoot_left:
	lda     #<shoot_left_zx02
	sta     zx_src_l+1
	lda	#>shoot_left_zx02

shoot_common:

	sta	zx_src_h+1

	; decompress data to $A800

	lda	#>$a800

	jsr	zx02_full_decomp

	; copy to the sprite data

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

	rts

	;=============================
	;=============================
	;=============================
	; load proper kerrek walk sprites
	;=============================
	;=============================
	;=============================

NUM_KERREK_WALK_SPRITES = 8

load_kerrek_walking_sprites:

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0 = left
	beq	load_walk_left

load_walk_right:
	lda     #<walk_right_zx02
	sta     zx_src_l+1
	lda	#>walk_right_zx02
	jmp	load_walk_common

load_walk_left:
	lda     #<walk_left_zx02
	sta     zx_src_l+1
	lda	#>walk_left_zx02

load_walk_common:

	sta	zx_src_h+1

	; decompress data to $9e00

	lda	#>$9e00

	jsr	zx02_full_decomp

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

	rts


	;=============================
	;=============================
	;=============================
	; load proper kerrek hit sprites
	;=============================
	;=============================
	;=============================

NUM_KERREK_HIT_SPRITES = 7

load_kerrek_hit_sprites:

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0 = left
	beq	load_hit_left

load_hit_right:
	lda     #<hit_right_zx02
	sta     zx_src_l+1
	lda	#>hit_right_zx02
	jmp	load_hit_common

load_hit_left:
	lda     #<hit_left_zx02
	sta     zx_src_l+1
	lda	#>hit_left_zx02

load_hit_common:

	sta	zx_src_h+1

	; decompress data to $9200

	lda	#>$9200

	jsr	zx02_full_decomp

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

hit_right_zx02:
.incbin	"kerrek_hit_right_sprites.zx02"
hit_left_zx02:
.incbin	"kerrek_hit_left_sprites.zx02"

walk_right_zx02:
.incbin	"kerrek_walk_right_sprites.zx02"
walk_left_zx02:
.incbin	"kerrek_walk_left_sprites.zx02"

shoot_right_zx02:
.incbin	"shoot_right_sprites.zx02"
shoot_left_zx02:
.incbin	"shoot_left_sprites.zx02"

