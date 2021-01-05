
.include "zp.inc"
.include "hardware.inc"

	lda	#0
	sta	DRAW_PAGE

	bit	SET_GR
	bit	PAGE0

	lda	#<graphic_start
	sta	LZSA_SRC_LO
	lda	#>graphic_start
	sta	LZSA_SRC_HI

	lda	#$c

	jsr	decompress_lzsa2

	jsr	gr_copy_to_current


blah:
	jmp	blah


	.include "decompress_small_v2.s"
	.include "gr_copy.s"
	.include "gr_offsets.s"

graphic_start:
	.incbin "spaceship_far_n.gr.small_v2"
graphic_end:
