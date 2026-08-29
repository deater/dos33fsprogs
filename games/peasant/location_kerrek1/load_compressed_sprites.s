	;=============================
	;=============================
	;=============================
	; load proper belt sprites
	;=============================
	;=============================
	;=============================

	; FIXME: should have mud case too?  though actual game doesn't?

NUM_BELT_SPRITES = 10

load_belt_sprites:
	lda	GAME_STATE_1
	and	#WEARING_ROBE
	bne	load_belt_robe

load_belt:
	lda     #<peasant_belt_zx02
	sta     zx_src_l+1
	lda	#>peasant_belt_zx02
	jmp	load_belt_common

load_belt_robe:
	lda     #<peasant_belt_robe_zx02
	sta     zx_src_l+1
	lda	#>peasant_belt_robe_zx02

load_belt_common:

	sta	zx_src_h+1

	; decompress data to $AB00

	lda	#>$ab00

	jsr	zx02_full_decomp

	rts

	;=============================
	;=============================
	;=============================
	; load proper kerrek body sprites
	;=============================
	;=============================
	;=============================

NUM_KERREK_WALK_SPRITES = 4

load_kerrek_body_sprites:

	lda	KERREK_STATE
	and	#KERREK_DIRECTION	; 0 = left
	beq	load_body_left

load_body_right:
	lda     #<body_right_zx02
	sta     zx_src_l+1
	lda	#>body_right_zx02
	jmp	load_body_common

load_body_left:
	lda     #<body_left_zx02
	sta     zx_src_l+1
	lda	#>body_left_zx02

load_body_common:

	sta	zx_src_h+1

	; decompress data to $e400

	lda	#>$e400

	jsr	zx02_full_decomp

	rts



peasant_belt_robe_zx02:
.incbin	"peasant_belt_robe_sprites.zx02"
peasant_belt_zx02:
.incbin	"peasant_belt_sprites.zx02"

body_right_zx02:
.incbin	"kerrek_body_right_sprites.zx02"
body_left_zx02:
.incbin	"kerrek_body_left_sprites.zx02"

