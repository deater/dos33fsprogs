; Mist Title

; loads a HGR version of the title

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


mist_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	HIRES
	bit	FULLGR

	;===================
	; Load graphics
	;===================
reload_everything:

	lda     #<file
	sta     LZSA_SRC_LO
	lda     #>file
	sta     LZSA_SRC_HI

	lda	#$20

	jsr	decompress_lzsa2_fast


	bit	KEYRESET

keyloop:
	lda	KEYPRESS
	bpl	keyloop

	bit	KEYRESET

	lda	#1		; load mist
	sta	5
	rts


	.include	"decompress_fast_v2.s"


file:
.incbin "graphics_title/mist_title.lzsa"

