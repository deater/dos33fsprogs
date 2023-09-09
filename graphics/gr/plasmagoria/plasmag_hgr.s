; PLASMAGORIA, hi-res version

; original code by French Touch


.include "hardware.inc"

hposn_high=$6000
hposn_low =$6100
hposn_high_div8=$6200
hposn_low_div8 =$6300

hires_colors_even_l0=$8000
hires_colors_odd_l0 =$8100
hires_colors_even_l1=$8200
hires_colors_odd_l1 =$8300

;Table1	=	$8000
;Table2	=	$8000+64

HGR     =       $F3E2

; Page Zero

GBASL	= $26
GBASH	= $27

COMPT1	= $30
COMPT2	= $31

PARAM1	= $60
PARAM2	= $61
PARAM3	= $62
PARAM4	= $63

Table1	= $A0	; 40 bytes
Table2	= $D0	; 40 bytes

PAGE	= $FC
COUNT	= $FD
GBASH_SAVE = $FE

; =============================================================================
; ROUTINE MAIN
; =============================================================================

plasma_debut:
	jsr	HGR		; have table gen appear on hgr page1
	bit	FULLGR

	jsr	build_tables

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

	lda	#0
	sta	PAGE



; ============================================================================
; init lores colors (inline)
; ============================================================================

init_hires_colors:

init_hires_colors_even_l0:
	ldx	#0
	ldy	#0
; 347

init_hires_colors_even_l0_loop:
	lda	hires_colors_even_lookup_l0,X
	sta	hires_colors_even_l0,Y
	iny
	sta	hires_colors_even_l0,Y
	iny
	sta	hires_colors_even_l0,Y
	iny
	sta	hires_colors_even_l0,Y
	iny
	beq	done_init_hires_colors_even_l0

	inx
	txa
	and	#$f
	tax
	jmp	init_hires_colors_even_l0_loop

done_init_hires_colors_even_l0:

;============================

init_hires_colors_odd_l0:
	ldx	#0
	ldy	#0
; 347

init_hires_colors_odd_l0_loop:
	lda	hires_colors_odd_lookup_l0,X
	sta	hires_colors_odd_l0,Y
	iny
	sta	hires_colors_odd_l0,Y
	iny
	sta	hires_colors_odd_l0,Y
	iny
	sta	hires_colors_odd_l0,Y
	iny
	beq	done_init_hires_colors_odd_l0

	inx
	txa
	and	#$f
	tax
	jmp	init_hires_colors_odd_l0_loop

done_init_hires_colors_odd_l0:


; ============================================================================

do_plasma:
	; init

;	lda	#02
;	ldx	#5
;init_loop:
;	sta	COMPT1,X
;	dex
;	bne	init_loop

BP3:

; ============================================================================
; Precalculate some values (inlined)
; ROUTINES PRE CALCUL
; ============================================================================
precalc:
	lda	PARAM1		; self modify various parts
	sta	pc_off1+1
	lda	PARAM2
	sta	pc_off2+1
	lda	PARAM3
	sta	pc_off3+1
	lda	PARAM4
	sta	pc_off4+1

	; Table1(X) = sin1(PARAM1+X)+sin2(PARAM1+X)
	; Table2(X) = sin3(PARAM3+X)+sin1(PARAM4+X)

	ldx	#$28		; 40
pc_b1:
pc_off1:
	lda	sin1
pc_off2:
	adc	sin2
	sta	Table1,X
pc_off3:
	lda	sin3
pc_off4:
	adc	sin1
	sta	Table2,X

	inc	pc_off1+1
	inc	pc_off2+1
	inc	pc_off3+1
	inc	pc_off4+1

 	dex
	bpl	pc_b1

 	inc	PARAM1
 	inc	PARAM1
	dec	PARAM2
 	inc	PARAM3
	dec	PARAM4

; ============================================================================
; Display Routines
; ROUTINES AFFICHAGES
; ============================================================================

; Display "Normal"
; AFFICHAGE "NORMAL"

display_normal:

	ldx	#23			; lines 0-23	lignes 0-23

display_line_loop:

	lda	hposn_low_div8,X
	sta	GBASL

	ldy	#39			; col 0-39

	lda	Table2,X		; setup base sine value for row
	sta	display_row_sin_smc+1
display_col_loop:
	lda	Table1,Y		; load in column sine value
display_row_sin_smc:
	adc	#00			; add in row value
	sta	display_lookup_smc+1	; patch in low byte of lookup

	lda	display_lookup_smc+2
	eor	#$01
	sta	display_lookup_smc+2

display_lookup_smc:
	lda	hires_colors_even_l0	; attention: must be aligned
	sta	color_smc+1

	lda	hposn_high_div8,X
	clc
	adc	PAGE
	sta	GBASH

	lda	#7
	sta	COUNT
store_loop:
color_smc:
	lda	#$fe
	sta	(GBASL),Y
	clc
	lda	#$4
	adc	GBASH
	sta	GBASH
	dec	COUNT
	bpl	store_loop
	dey
	bpl	display_col_loop

	dex
	bpl	display_line_loop

; ============================================================================

	lda	PAGE
	beq	was_page1
was_page2:
	bit	PAGE2
	lda	#0
	beq	done_pageflip
was_page1:
	bit	PAGE1
	lda	#$20
done_pageflip:
	sta	PAGE

	inc	COMPT1
	beq	display_done2
;	bne	BP3
	jmp	BP3

display_done2:

	dec	COMPT2
	beq	display_done
;	bne	BP3
	jmp	BP3
display_done:

	jmp	do_plasma
;	beq	do_plasma	; bra





hires_colors_even_lookup_l0:
.byte $00						; black
.byte $A2	; 01 00 01 0 -> 1 01 00 01 0 = $A2	; dark orange
.byte $A2	; 01 00 01 0 -> 1 01 00 01 0 = $A2	; med orange
.byte $88	; 00 01 00 0 -> 1 00 01 00 0 = $88	; light orange
.byte $AA	; 01 01 01 0 -> 1 01 01 01 0 = $AA	; solid orange
.byte $BB	; 11 01 11 0 -> 1 01 11 01 1 = $BB	; white orange
.byte $EE	; 01 11 01 1 -> 1 11 01 11 0 = $EE	; med white/o
.byte $EE 	; 01 11 01 1 -> 1 11 01 11 0 = $EE	; wwo
.byte $FF	; 11 11 11 1 -> 1 11 11 11 1 = $FF	; white
.byte $DD	; 10 11 10 1 -> 1 10 11 10 1 = $DD	; white/blue
.byte $DD	; 10 11 10 1 -> 1 10 11 10 1 = $DD	; med white/blue
.byte $F7	; 11 10 11 1 -> 1 11 10 11 1 = $F7	; blue/white
.byte $D5	; 10 10 10 1 -> 1 10 10 10 1 = $D5	; blue
.byte $C4	; 00 10 00 1 -> 1 10 00 10 0 = $C4	; black/blue
.byte $D1	; 10 00 10 1 -> 1 10 10 00 1 = $D1	; med
.byte $D1	; 10 00 10 1 -> 1 10 10 00 1 = $D1	; med/dark

hires_colors_odd_lookup_l0:
.byte $00						; black
.byte $C5	; 1 01 00 01 -> 1 10 00 10 1 = $C5	; dark orange
.byte $C5	; 1 01 00 01 -> 1 10 00 10 1 = $C5	; med orange
.byte $91	; 1 00 01 00 -> 1 00 10 00 1 = $91	; light orange
.byte $D5	; 1 01 01 01 -> 1 10 10 10 1 = $D5	; solid orange
.byte $DD	; 1 01 11 01 -> 1 10 11 10 1 = $DD	; white orange
.byte $F7	; 1 11 01 11 -> 1 11 10 11 1 = $F7	; med white/o
.byte $F7 	; 1 11 01 11 -> 1 11 10 11 1 = $F7
.byte $FF	; 1 11 11 11 -> 1 11 11 11 1 = $FF	; white
.byte $BB	; 1 10 11 10 -> 1 01 11 01 1 = $BB	; white/blue
.byte $BB	; 1 10 11 10 -> 1 01 11 01 1 = $BB	; med white/blue
.byte $EE	; 0 11 10 11 -> 1 11 01 11 0 = $EE	; blue/white
.byte $AA	; 0 10 10 10 -> 1 01 01 01 0 = $AA	; blue
.byte $88	; 0 00 10 00 -> 1 00 01 00 0 = $88	; black/blue
.byte $A2	; 0 10 00 10 -> 1 01 00 01 0 = $A2	; med
.byte $A2	; 0 10 00 10 -> 1 01 00 01 0 = $A2	; med/dark

hires_colors_even_lookup_l1:
.byte $00						; black
.byte $A2	; 01 00 01 0 -> 1 01 00 01 0 = $A2	; dark orange
.byte $A2	; 01 00 01 0 -> 1 01 00 01 0 = $A2	; med orange
.byte $88	; 00 01 00 0 -> 1 00 01 00 0 = $88	; light orange
.byte $AA	; 01 01 01 0 -> 1 01 01 01 0 = $AA	; solid orange
.byte $BB	; 11 01 11 0 -> 1 01 11 01 1 = $BB	; white orange
.byte $EE	; 01 11 01 1 -> 1 11 01 11 0 = $EE	; med white/o
.byte $EE 	; 01 11 01 1 -> 1 11 01 11 0 = $EE	; wwo
.byte $FF	; 11 11 11 1 -> 1 11 11 11 1 = $FF	; white
.byte $DD	; 10 11 10 1 -> 1 10 11 10 1 = $DD	; white/blue
.byte $DD	; 10 11 10 1 -> 1 10 11 10 1 = $DD	; med white/blue
.byte $F7	; 11 10 11 1 -> 1 11 10 11 1 = $F7	; blue/white
.byte $D5	; 10 10 10 1 -> 1 10 10 10 1 = $D5	; blue
.byte $C4	; 00 10 00 1 -> 1 10 00 10 0 = $C4	; black/blue
.byte $D1	; 10 00 10 1 -> 1 10 10 00 1 = $D1	; med
.byte $D1	; 10 00 10 1 -> 1 10 10 00 1 = $D1	; med/dark

hires_colors_odd_lookup_l1:
.byte $00						; black
.byte $C5	; 1 01 00 01 -> 1 10 00 10 1 = $C5	; dark orange
.byte $C5	; 1 01 00 01 -> 1 10 00 10 1 = $C5	; med orange
.byte $91	; 1 00 01 00 -> 1 00 10 00 1 = $91	; light orange
.byte $D5	; 1 01 01 01 -> 1 10 10 10 1 = $D5	; solid orange
.byte $DD	; 1 01 11 01 -> 1 10 11 10 1 = $DD	; white orange
.byte $F7	; 1 11 01 11 -> 1 11 10 11 1 = $F7	; med white/o
.byte $F7 	; 1 11 01 11 -> 1 11 10 11 1 = $F7
.byte $FF	; 1 11 11 11 -> 1 11 11 11 1 = $FF	; white
.byte $BB	; 1 10 11 10 -> 1 01 11 01 1 = $BB	; white/blue
.byte $BB	; 1 10 11 10 -> 1 01 11 01 1 = $BB	; med white/blue
.byte $EE	; 0 11 10 11 -> 1 11 01 11 0 = $EE	; blue/white
.byte $AA	; 0 10 10 10 -> 1 01 01 01 0 = $AA	; blue
.byte $88	; 0 00 10 00 -> 1 00 01 00 0 = $88	; black/blue
.byte $A2	; 0 10 00 10 -> 1 01 00 01 0 = $A2	; med
.byte $A2	; 0 10 00 10 -> 1 01 00 01 0 = $A2	; med/dark




.include "hgr_table.s"

.align 256
sin1:
.incbin "tables"
sin2=sin1+256
sin3=sin2+256
