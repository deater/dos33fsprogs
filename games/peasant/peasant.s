; A Peasant's Quest????

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"




peasant_quest:

	jsr	hgr_make_tables

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called


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

.include "cottage.s"
.include "lake_w.s"
.include "lake_e.s"
.include "river.s"
.include "knight.s"
.include "ending.s"

.include "hgr_font.s"
.include "draw_box.s"
.include "hgr_rectangle.s"

.include "graphics/graphics.inc"
