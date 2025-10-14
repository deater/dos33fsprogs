; PLASMAGORIA, hi-res version

; based on code by French Touch


.include "zp.inc"
.include "hardware.inc"

mod7_table      = $1c00
div7_table      = $1d00
hposn_low       = $1e00
hposn_high      = $1f00

hposn_high_div8=$6200
hposn_low_div8 =$6300

hires_colors_even_l0=$7000
hires_colors_odd_l0 =$7100
hires_colors_even_l1=$7200
hires_colors_odd_l1 =$7300

; was in page0, we don't really have room
Table1	= $74A0	; 40 bytes
Table2	= $74D0	; 40 bytes


; =============================================================================
; ROUTINE MAIN
; =============================================================================

plasma_debut:

	jsr	hgr_make_tables

	lda     #0
	jsr	hgr_page1_clearscreen
	jsr	hgr_page2_clearscreen

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	;=========================================
	; init div8
	;=========================================

	ldx	#23
	ldy	#184
div8_loop:
	lda	hposn_low,Y
	sta	hposn_low_div8,X
	lda	hposn_high,Y
	sta	hposn_high_div8,X
	dey
	dey
	dey
	dey
	dey
	dey
	dey
	dey
	dex
	bpl	div8_loop

	;=========================================

	lda	#0
	sta	DRAW_PAGE

	;=============================
	; do blue/orange

	lda	#49
	sta	plasma_end_smc+1

	jsr	init_plasma_colors
	jsr	do_plasma

	; drop
	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE

	jsr	scroll_off

;	lda	#25
;	jsr	wait_ticks

	;=============================
	; do purple/green

	ldx	#63
change_purple:
	lda	hires_colors_even_lookup_l0,X
	and	#$7f
	sta	hires_colors_even_lookup_l0,X
	dex
	bpl	change_purple


	jsr	init_plasma_colors

	lda	#50
	sta	plasma_end_smc+1

	jsr	do_plasma

	; drop
	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE

	jsr	scroll_off

;	lda	#25
;	jsr	wait_ticks


	;=============================
	; do black/white?

	ldx	#63
change_mono:
	lda	hires_colors_even_lookup_l0,X
	ora	#$aa
	sta	hires_colors_even_lookup_l0,X
	dex
	bpl	change_mono

	jsr	init_plasma_colors

	lda	#52
	sta	plasma_end_smc+1

	jsr	do_plasma

	; drop
	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE

	jsr	scroll_off

	lda     #0
	jsr	hgr_page1_clearscreen
	jsr	hgr_page2_clearscreen

	rts

.include "wait.s"

.include "init_plasma.s"
.include "do_plasma.s"
.include "hgr_clear_screen.s"
.include "scroll_off.s"
;.include "../irq_wait.s"


.include "hgr_table.s"

.align 256
sin1:
.incbin "tables"
sin2=sin1+256
sin3=sin2+256
