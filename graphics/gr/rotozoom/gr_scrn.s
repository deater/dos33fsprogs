	;================================
	; scrn routine
	;================================
	; Xcoord in XPOS
	; Ycoord in YPOS
	; color returned in A
	; assume reading from $c00

scrn:
	lda	YPOS							; 3

	and	#$fe		; make even				; 2
	tay								; 2

	lda	gr_offsets,Y	; lookup low-res memory address		; 4
        clc								; 2
        adc	XPOS							; 3
        sta	GBASL							; 3

        lda	gr_offsets+1,Y						; 4
        adc	#$8	; assume reading from $c0			; 3
        sta	GBASH							; 3

	ldy	#0							; 2

	lda	YPOS							; 3
	lsr								; 2
	bcs	scrn_adjust_even					;2nt/3t

scrn_adjust_odd:
	lda	(GBASL),Y	; top/bottom color			; 5+
	jmp	scrn_done						; 3

scrn_adjust_even:
	lda	(GBASL),Y	; top/bottom color			; 5+

	lsr								; 2
	lsr								; 2
	lsr								; 2
	lsr								; 2

scrn_done:

	and	#$f							; 2

	rts								; 6
