
.include "zp.inc"
.include "hardware.inc"

	lda	#0
	sta	DRAW_PAGE

	bit	SET_GR
	bit	PAGE0

	bit	KEYRESET
pause_loop:
	lda	KEYPRESS
	bpl	pause_loop

	lda	#<graphic_start
	sta	LZ4_SRC
	lda	#>graphic_start
	sta	LZ4_SRC+1

	lda	#<graphic_end
	sta	LZ4_END
	lda	#>graphic_end
	sta	LZ4_END+1

	lda	#$0
	sta	LZ4_DST
	lda	#$c
	sta	LZ4_DST+1

before:

	jsr	lz4_decode
after:

	jsr	gr_copy_to_current


blah:
	jmp	blah


	.include "lz4_decode.s"
	.include "gr_copy.s"
	.include "gr_offsets.s"

graphic_start:

	.incbin "spaceship_far_n.lz4"
graphic_end:
