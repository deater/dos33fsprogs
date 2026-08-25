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

