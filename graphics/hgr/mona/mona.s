
NIBCOUNT	= $09

HGR2            = $F3D8


hgr_display:
	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called

	lda	#<(mona_lzsa)
	sta	getsrc_smc+1
	lda	#>(mona_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast


forever:
	jmp	forever


.include "decompress_fast_v2.s"

.include "graphics/graphics.inc"
