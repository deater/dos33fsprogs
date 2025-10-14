
; ============================================================================
; init hires colors (inline)
; ============================================================================

init_plasma_colors:

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

	rts

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

