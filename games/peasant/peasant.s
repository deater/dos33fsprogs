; A Peasant's Quest????

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"




peasant_quest:

	jsr	hgr_make_tables

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called


	;*******************************
	; restart music, only drum loop
	;******************************

	; hack! modify the PT3 file to ignore the latter half

	PT3_LOC=$E00+$E00
	pt3_init_song=$e00+$A56
	pt3_clear_ay_both=$e00+$CDF

	lda	#$ff			; end after 4 patterns
	sta	PT3_LOC+$C9+$4

	lda	#$0			; set LOOP to 0
	sta	PT3_LOC+$66

	jsr	pt3_init_song

	cli

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

	lda	#LOAD_ENDING
	sta	WHICH_LOAD

	rts


.include "decompress_fast_v2.s"
.include "wait_keypress.s"

.include "cottage.s"
.include "lake_w.s"
.include "lake_e.s"
.include "river.s"
.include "knight.s"

.include "hgr_font.s"
.include "draw_box.s"
.include "hgr_rectangle.s"
.include "hgr_7x30_sprite.s"
.include "hgr_1x5_sprite.s"
.include "hgr_save_restore.s"
.include "hgr_input.s"
.include "hgr_tables.s"

.include "wait_a_bit.s"

.include "graphics/graphics.inc"
