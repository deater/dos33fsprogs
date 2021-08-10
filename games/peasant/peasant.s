; A Peasant's Quest????

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"

NIBCOUNT	= $09
GBASL		= $26
GBASH		= $27
CURSOR_X	= $62
CURSOR_Y	= $63
HGR_COLOR	= $E4
P0      = $F1
P1      = $F2
P2      = $F3
P3      = $F4
P4      = $F5
P5      = $F6

INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF



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

	jsr	directions

	;************************
	; Cottage
	;************************

	jsr	cottage


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


.if 0

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

.endif

forever:
	jmp	forever


.include "decompress_fast_v2.s"
.include "wait_keypress.s"

.include "directions.s"
.include "cottage.s"

.include "hgr_font.s"

.include "graphics/graphics.inc"
