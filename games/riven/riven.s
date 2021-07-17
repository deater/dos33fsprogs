; Riven fake out

NIBCOUNT	= $09

KEYPRESS	= $C000
KEYRESET	= $C010
PAGE0		= $C054
LORES		= $C056

HGR2            = $F3D8


hgr_display:
	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called

	bit	PAGE0

	lda	#<(riven_title_lzsa)
	sta	getsrc_smc+1
	lda	#>(riven_title_lzsa)
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast


	jsr	wait_until_keypress

	;===========================

	bit	LORES

	lda	#<(riven1_lzsa)
	sta	getsrc_smc+1
	lda	#>(riven1_lzsa)
	sta	getsrc_smc+2

	lda	#$04

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress

	;===========================

	bit	LORES

	lda	#<(riven3_lzsa)
	sta	getsrc_smc+1
	lda	#>(riven3_lzsa)
	sta	getsrc_smc+2

	lda	#$04

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress



forever:
	jmp	forever




.include "wait_keypress.s"
.include "decompress_fast_v2.s"

riven_title_lzsa:
.incbin "riven_title.lzsa"

riven1_lzsa:
.incbin "riven1.lzsa"

riven3_lzsa:
.incbin "riven3.lzsa"
