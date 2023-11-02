; PLASMAGORIA, hi-res version

; based on code by French Touch


.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"

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

	; debug
	lda     #47
        sta     current_pattern_smc+1
        jsr     pt3_set_pattern



	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda     #0
	jsr	hgr_page1_clearscreen
	jsr	hgr_page2_clearscreen


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
	sta	PAGE

	jsr	init_plasma_colors

; ============================================================================

; 26+( 24*(11+(40*(39+(38*2))) = 110,690 +2174 = 112,864 = 9fps
; 26+( 24*(11+(40*(39+(38*4))) = 183,650 +2174 = 185,824 = 5.5fps
; 26+( 24*(11+(40*(39+(38*8))) = 329,570 +2174 = 	 = 3fps


	jsr	do_plasma

	rts

.include "init_plasma.s"
.include "do_plasma.s"
.include "../hgr_clear_screen.s"
.include "../irq_wait.s"

;.include "hgr_table.s"

.align 256
sin1:
.incbin "tables"
sin2=sin1+256
sin3=sin2+256
