; o/~ It's the Title Screen, Yes it's the Title Screen o/~

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"


title:
	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called

	;************************
	; Title
	;************************

do_title:
	lda	#<(title_lzsa)
	sta	getsrc_smc+1
	lda	#>(title_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress


	;************************
	; Tips
	;************************

	jsr	directions


	lda	#LOAD_PEASANT
	sta	WHICH_LOAD


	rts




.include "decompress_fast_v2.s"
.include "wait_keypress.s"

.include "directions.s"

.include "hgr_font.s"

.include "graphics_title/title_graphics.inc"
