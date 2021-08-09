; A Peasant's Quest????

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"

NIBCOUNT	= $09


hgr_display:
	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called

	;************************
	; Opening
	;************************

	lda	#<(videlectrix_lzsa)
	sta	getsrc_smc+1
	lda	#>(videlectrix_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress

	;************************
	; Title
	;************************

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

	lda	#<(tips_lzsa)
	sta	getsrc_smc+1
	lda	#>(tips_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress


	;************************
	; Cottage
	;************************

	lda	#<(cottage_lzsa)
	sta	getsrc_smc+1
	lda	#>(cottage_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress


	;************************
	; Lake West
	;************************

	lda	#<(lake_w_lzsa)
	sta	getsrc_smc+1
	lda	#>(lake_w_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress


	;************************
	; Lake East
	;************************

	lda	#<(lake_e_lzsa)
	sta	getsrc_smc+1
	lda	#>(lake_e_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress

	;************************
	; River
	;************************

	lda	#<(river_lzsa)
	sta	getsrc_smc+1
	lda	#>(river_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress


	;************************
	; Knight
	;************************

	lda	#<(knight_lzsa)
	sta	getsrc_smc+1
	lda	#>(knight_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress



forever:
	jmp	forever


.include "decompress_fast_v2.s"
.include "wait_keypress.s"

.include "graphics/graphics.inc"
