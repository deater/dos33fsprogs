
.include "hardware.inc"

CURSOR_X	= $62
CURSOR_Y	= $63
NIBCOUNT	= $09

GBASL		= $26
GBASH		= $27

WHICH		= $FD
OUTL		= $FE
OUTH		= $FF

sprite_test:

	jsr	HGR		; Hi-res graphics
	bit	FULLGR		; full screen


	lda	#0
	sta	WHICH

	lda	#<(mona_lzsa)
	sta	getsrc_smc+1
	lda	#>(mona_lzsa)
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast



	;==================
	; sprite stuff

	lda	#10
	sta	CURSOR_X
	lda	#10
	sta	CURSOR_Y

forever:
	jsr	save_bg_14x14		; save bg

	lda	WHICH
	bne	do_grab

do_point:
	lda	#<point_sprite_l
	sta	OUTL
	lda	#>point_sprite_l
	jmp	done_select
do_grab:

	lda	#<grab_sprite_l
	sta	OUTL
	lda	#>grab_sprite_l

done_select:
	sta	OUTH

	jsr	hgr_draw_sprite_14x14	; draw sprite

keyloop:
	lda	KEYPRESS
	bpl	keyloop

	pha
	jsr	restore_bg_14x14	; restore bg
	pla

check_right:
	cmp	#'D'|$80
	bne	check_left

	inc	CURSOR_X
	jmp	done_key

check_left:
	cmp	#'A'|$80
	bne	check_up

	dec	CURSOR_X
	jmp	done_key

check_up:
	cmp	#'W'|$80
	bne	check_down

	dec	CURSOR_Y
	dec	CURSOR_Y
	dec	CURSOR_Y
	dec	CURSOR_Y
	dec	CURSOR_Y

	jmp	done_key

check_down:
	cmp	#'S'|$80
	bne	check_space

	inc	CURSOR_Y
	inc	CURSOR_Y
	inc	CURSOR_Y
	inc	CURSOR_Y
	inc	CURSOR_Y

	jmp	done_key

check_space:
	cmp	#' '|$80
	bne	done_key

	lda	WHICH
	eor	#$1
	sta	WHICH

	jmp	done_key

done_key:
	lda	KEYRESET
nokey:

	jmp	forever


.include "hgr_14x14_sprite.s"

.include "decompress_fast_v2.s"

.include "graphics/graphics.inc"

.include "hand_sprites.inc"
