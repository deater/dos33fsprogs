; PLASMAGORIA, double hi-res version

; based on code by French Touch


;hposn_low       = $1e00
;hposn_high      = $1f00

hires_colors_even_l0	= $a000
hires_colors_odd_l0	= $a100
hires_colors_even_l1	= $a200
hires_colors_odd_l1	= $a300

hposn_high_div8		= $a400
hposn_low_div8		= $a500

mod7_table		= $a600
div7_table		= $a700

; was in page0, we don't really have room
; can fit at top of hposn tables (only 192 bytes used)
Table1	= $a8A0	; 40 bytes
Table2	= $a9D0	; 40 bytes


; =============================================================================
; ROUTINE MAIN
; =============================================================================

	; assume hgr tables already set

	; assume already in double-hires

	; assume background screens already cleared if wanted

plasma_debut:

	;=====================
	; make /7 %7 tables
	;=====================

hgr_make_7_tables:

	ldy	#0
	lda	#0
	ldx	#0
div7_loop:
	sta	div7_table,Y

	inx
	cpx	#7
	bne	div7_not7

	clc
	adc	#1
	ldx	#0
div7_not7:
	iny
	bne	div7_loop


	ldy	#0
	lda	#0
mod7_loop:
	sta	mod7_table,Y
	clc
	adc	#1
	cmp	#7
	bne	mod7_not7
	lda	#0
mod7_not7:
	iny
	bne	mod7_loop

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
plasma_loop:
	;=============================
	; do blue/orange

;	lda	#49
;	sta	plasma_end_smc+1

	jsr	init_plasma_colors
	jsr	do_plasma

	; switch to draw to visible page

	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE

	jsr	scroll_off

	; now do same for AUX page

	sta	WRITEAUXMEM

	jsr	scroll_off

	sta	WRITEMAINMEM


;	lda     #0
;	jsr	hgr_page1_clearscreen
;	jsr	hgr_page2_clearscreen

	rts

;	jmp	plasma_loop

;=========================================================================
;=========================================================================
;=========================================================================


do_plasma:
	; init

BP3:

; ============================================================================
; Precalculate some values (inlined)
; ROUTINES PRE CALCUL
; ============================================================================
;
; cycles = 30 + (40*53) -1 + 25 = 2174 cycles

precalc:
; 0
	lda	PARAM1		; self modify various parts		; 3
	sta	pc_off1+1						; 4
	lda	PARAM2							; 3
	sta	pc_off2+1						; 4
	lda	PARAM3							; 3
	sta	pc_off3+1						; 4
	lda	PARAM4							; 3
	sta	pc_off4+1						; 4

; 28

	; Table1(X) = sin1(PARAM1+X)+sin2(PARAM1+X)
	; Table2(X) = sin3(PARAM3+X)+sin1(PARAM4+X)

	ldx	#$28		; 40					; 2
; 30

precalc_loop:

pc_off1:
	lda	sin1							; 4
pc_off2:
	adc	sin2							; 4
	sta	Table1,X						; 4
; 12

pc_off3:
	lda	sin3							; 4
pc_off4:
	adc	sin1							; 4
	sta	Table2,X						; 4
; 24

	inc	pc_off1+1						; 6
	inc	pc_off2+1						; 6
	inc	pc_off3+1						; 6
	inc	pc_off4+1						; 6
; 48
 	dex								; 2
	bpl	precalc_loop						; 2/3
; 53

 	inc	PARAM1							; 5
 	inc	PARAM1							; 5
	dec	PARAM2							; 5
 	inc	PARAM3							; 5
	dec	PARAM4							; 5
; 25

; ============================================================================
; Display Routines
; ROUTINES AFFICHAGES
; ============================================================================
; 26+( 24*(11+(40*(39+(38*2))) = 110,690
; 26+( 24*(11+(40*(39+(38*4))) = 183,650
; 26+( 24*(11+(40*(39+(38*8))) = 329,570

; Display "Normal"
; AFFICHAGE "NORMAL"

display_normal:

	ldx	#23			; lines 0-23	lignes 0-23	; 2

display_line_loop:
; 0
	lda	hposn_low_div8,X	; setup line pointer		; 4
	sta	GBASL							; 3
; 7
	ldy	#39			; col 0-39			; 2

	lda	Table2,X		; setup base sine value for row	; 4
	sta	display_row_sin_smc+1					; 4
; 17

display_col_loop:

	lda	Table1,Y		; load in column sine value	; 4
display_row_sin_smc:
	adc	#00			; add in row value		; 2
	sta	display_lookup_smc+1	; patch in low byte of lookup	; 4
; 8
	; pick 0/1 for odd even
	lda	display_lookup_smc+2					; 4
	eor	#$01							; 2
	sta	display_lookup_smc+2					; 4

; 18

;	lda	hires_colors_even_l0	; attention: must be aligned
;	sta	color_smc+1

	lda	hposn_high_div8,X					; 4
	clc								; 2
	adc	DRAW_PAGE						; 3
	sta	GBASH							; 3
; 30
	lda	#1							; 2
	sta	COUNT							; 3
; 35
store_loop:
color_smc:

	lda	display_lookup_smc+2					; 4
	eor	#$02							; 2
	sta	display_lookup_smc+2					; 4
; 10

display_lookup_smc:
	lda	hires_colors_even_l0	; attention: must be aligned	; 4
;	lda	#$fe
	sta	(GBASL),Y						; 6
	clc								; 2
	lda	#$10							; 2
	adc	GBASH							; 3
	sta	GBASH							; 3
	dec	COUNT							; 5
	bpl	store_loop						; 2/3
; 38

	dey								; 2
	bpl	display_col_loop					; 2/3

	dex								; 2
	bpl	display_line_loop					; 2/3

; ============================================================================

	lda	DRAW_PAGE						; 3
	beq	was_page1						; 2/3
was_page2:
	bit	PAGE2							; 4
	lda	#0							; 2
	beq	done_pageflip						; 2/3
was_page1:
	bit	PAGE1							; 4
	lda	#$20							; 2
done_pageflip:
	sta	DRAW_PAGE						; 3

;plasma_end_smc:
;	lda	#52
;	jsr	wait_for_pattern

	lda	KEYPRESS

	bpl	wasnt_keypress

	bit	KEYRESET
	jmp	done_plasma

wasnt_keypress:


; 15?
	inc	COMPT1							; 6
	beq	display_done2						; 2/3

;	bne	BP3
	jmp	BP3							; 3

display_done2:

	dec	COMPT2							; 6
	beq	display_done						; 2/3
;	bne	BP3
	jmp	BP3							; 3
display_done:

	jmp	do_plasma
;	beq	do_plasma	; bra


done_plasma:
	bit	KEYRESET
	rts

;.include "wait.s"
.include "init_plasma.s"
;.include "hgr_clear_screen.s"
.include "scroll_off.s"
;.include "../irq_wait.s"


;.include "hgr_table.s"

.align 256
sin1:
.incbin "tables"
sin2=sin1+256
sin3=sin2+256
