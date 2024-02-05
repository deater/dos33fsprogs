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
HGR2           = $F3D8

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
	jsr	HGR2
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

;==============================================

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

;==============================================

init_hires_colors_even_l1:
	ldx	#0
	ldy	#0
; 347

init_hires_colors_even_l1_loop:
	lda	hires_colors_even_lookup_l1,X
	sta	hires_colors_even_l1,Y
	iny
	sta	hires_colors_even_l1,Y
	iny
	sta	hires_colors_even_l1,Y
	iny
	sta	hires_colors_even_l1,Y
	iny
	beq	done_init_hires_colors_even_l1

	inx
	txa
	and	#$f
	tax
	jmp	init_hires_colors_even_l1_loop

done_init_hires_colors_even_l1:

;============================

init_hires_colors_odd_l1:
	ldx	#0
	ldy	#0
; 347

init_hires_colors_odd_l1_loop:
	lda	hires_colors_odd_lookup_l1,X
	sta	hires_colors_odd_l1,Y
	iny
	sta	hires_colors_odd_l1,Y
	iny
	sta	hires_colors_odd_l1,Y
	iny
	sta	hires_colors_odd_l1,Y
	iny
	beq	done_init_hires_colors_odd_l1

	inx
	txa
	and	#$f
	tax
	jmp	init_hires_colors_odd_l1_loop

done_init_hires_colors_odd_l1:



; ============================================================================

; 26+( 24*(11+(40*(39+(38*2))) = 110,690 +2174 = 112,864 = 9fps
; 26+( 24*(11+(40*(39+(38*4))) = 183,650 +2174 = 185,824 = 5.5fps
; 26+( 24*(11+(40*(39+(38*8))) = 329,570 +2174 = 	 = 3fps

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
	adc	PAGE							; 3
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

	lda	PAGE							; 3
	beq	was_page1						; 2/3
was_page2:
	bit	PAGE2							; 4
	lda	#0							; 2
	beq	done_pageflip						; 2/3
was_page1:
	bit	PAGE1							; 4
	lda	#$20							; 2
done_pageflip:
	sta	PAGE							; 3
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


hires_colors_even_lookup_l0:
.byte $00						; black
.byte $A2	; 01 00 01 0 -> 1 01 00 01 0 = $A2	; dark orange
.byte $A2	; 01 00 01 0 -> 1 01 00 01 0 = $A2	; med orange
.byte $88	; 01 00 01 0 -> 1 01 00 01 0 = $A2	; light orange
.byte $AA	; 01 01 01 0 -> 1 01 01 01 0 = $AA	; solid orange
.byte $EE	; 01 11 01 1 -> 1 11 01 11 0 = $EE	; white orange
.byte $EE	; 01 11 01 1 -> 1 11 01 11 0 = $EE	; med white/o
.byte $EE 	; 01 11 01 1 -> 1 11 01 11 0 = $EE	; wwo
.byte $FF	; 11 11 11 1 -> 1 11 11 11 1 = $FF	; white
.byte $DD	; 10 11 10 1 -> 1 10 11 10 1 = $DD	; white/blue
.byte $DD	; 10 11 10 1 -> 1 10 11 10 1 = $DD	; med white/blue
.byte $DD	; 10 11 10 1 -> 1 10 11 10 1 = $DD	; blue/white
.byte $D5	; 10 10 10 1 -> 1 10 10 10 1 = $D5	; blue
.byte $91	; 10 00 10 0 -> 1 00 10 00 1 = $91	; black/blue
.byte $91	; 10 00 10 0 -> 1 00 10 00 1 = $91	; med
.byte $91	; 10 00 10 0 -> 1 00 10 00 1 = $91	; med/dark

hires_colors_odd_lookup_l0:
.byte $00						; black
.byte $91	; 1 00 01 00 -> 1 00 10 00 1 = $91	; dark orange
.byte $91	; 1 00 01 00 -> 1 00 10 00 1 = $91	; med orange
.byte $91	; 1 00 01 00 -> 1 00 10 00 1 = $91	; light orange
.byte $D5	; 1 01 01 01 -> 1 10 10 10 1 = $D5	; solid orange
.byte $DD	; 1 01 11 01 -> 1 10 11 10 1 = $DD	; white orange
.byte $DD	; 1 01 11 01 -> 1 10 11 10 1 = $DD	; med white/o
.byte $DD 	; 1 01 11 01 -> 1 10 11 10 1 = $DD	; wwo
.byte $FF	; 1 11 11 11 -> 1 11 11 11 1 = $FF	; white
.byte $BB	; 1 10 11 10 -> 1 01 11 01 1 = $BB	; white/blue
.byte $BB	; 1 10 11 10 -> 1 01 11 01 1 = $BB	; med white/blue
.byte $BB	; 1 10 11 10 -> 1 01 11 01 1 = $BB	; blue/white
.byte $AA	; 0 10 10 10 -> 1 01 01 01 0 = $AA	; blue
.byte $A2	; 0 10 00 10 -> 1 01 00 01 0 = $A2	; black/blue
.byte $A2	; 0 10 00 10 -> 1 01 00 01 0 = $A2	; med
.byte $A2	; 0 10 00 10 -> 1 01 00 01 0 = $A2	; med/dark

hires_colors_even_lookup_l1:
.byte $00						; black
.byte $00						; dark orange
.byte $88	; 00 01 00 0 -> 1 00 01 00 0 = $88	; med orange
.byte $AA	; 01 01 01 0 -> 1 01 01 01 0 = $AA	; light orange
.byte $AA	; 01 01 01 0 -> 1 01 01 01 0 = $AA	; solid orange
.byte $AA	; 01 01 01 0 -> 1 01 01 01 0 = $AA	; white orange
.byte $BB	; 11 01 11 0 -> 1 01 11 01 1 = $BB	; med white/o
.byte $FF 	; 11 11 11 1 -> 1 11 11 11 1 = $FF	; wwo
.byte $FF	; 11 11 11 1 -> 1 11 11 11 1 = $FF	; white
.byte $FF	; 11 11 11 1 -> 1 11 11 11 1 = $FF	; white/blue
.byte $F7	; 11 10 11 1 -> 1 11 10 11 1 = $F7	; med white/blue
.byte $D5	; 10 10 10 1 -> 1 10 10 10 1 = $D5	; blue/white
.byte $D5	; 10 10 10 1 -> 1 10 10 10 1 = $D5	; blue
.byte $D5	; 10 10 10 1 -> 1 10 10 10 1 = $D5	; black/blue
.byte $C4	; 00 10 00 1 -> 1 10 00 10 0 = $C4	; med
.byte $00						; med/dark

hires_colors_odd_lookup_l1:
.byte $00						; black
.byte $00						; dark orange
.byte $91	; 1 00 01 00 -> 1 00 10 00 1 = $91	; med orange
.byte $D5	; 1 01 01 01 -> 1 10 10 10 1 = $D5	; light orange
.byte $D5	; 1 01 01 01 -> 1 10 10 10 1 = $D5	; solid orange
.byte $D5	; 1 01 01 01 -> 1 10 10 10 1 = $D5	; white orange
.byte $F7	; 1 11 01 11 -> 1 11 10 11 1 = $F7	; med white/o
.byte $FF 	; 1 11 11 11 -> 1 11 11 11 1 = $FF	; wwo
.byte $FF	; 1 11 11 11 -> 1 11 11 11 1 = $FF	; white
.byte $FF	; 1 11 11 11 -> 1 11 11 11 1 = $FF	; white/blue
.byte $EE	; 0 11 10 11 -> 1 11 01 11 0 = $EE	; med white/blue
.byte $AA	; 0 10 10 10 -> 1 01 01 01 0 = $AA	; blue/white
.byte $AA	; 0 10 10 10 -> 1 01 01 01 0 = $AA	; blue
.byte $AA	; 0 10 10 10 -> 1 01 01 01 0 = $AA	; black/blue
.byte $A2	; 0 10 00 10 -> 1 01 00 01 0 = $A2	; med
.byte $00						; med/dark




.include "hgr_table.s"

.align 256
sin1:
.incbin "tables"
sin2=sin1+256
sin3=sin2+256
