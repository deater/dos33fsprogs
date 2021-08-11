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
	; Title
	;************************

	jsr	title


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

	jsr	lake_west

	;************************
	; Lake East
	;************************

	jsr	lake_east

	;************************
	; River
	;************************

	jsr	river

	;************************
	; Knight
	;************************

	jsr knight

	;************************
	; Ending
	;************************

	jsr ending


forever:
	jmp	forever


.include "decompress_fast_v2.s"
.include "wait_keypress.s"

.include "title.s"
.include "directions.s"
.include "cottage.s"
.include "lake_w.s"
.include "lake_e.s"
.include "river.s"
.include "knight.s"
.include "ending.s"

.include "hgr_font.s"

.include "graphics/graphics.inc"
