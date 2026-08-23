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


shoot_right_zx02:
.incbin	"shoot_right_sprites.zx02"
shoot_left_zx02:
.incbin	"shoot_left_sprites.zx02"

