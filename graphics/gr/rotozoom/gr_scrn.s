	;================================
	; scrn routine
	;================================
	; Xcoord in XPOS
	; Ycoord in YPOS
	; color returned in A
	; assume reading from $c00

scrn:
	lda	YPOS							; 2

;	lsr			; shift bottom bit into carry		; 2

;	bcc	scrn_even						; 2nt/3
;scrn_odd:
;	ldx	#$f0							; 2
;	bcs	scrn_c_done						; 2nt/3
;scrn_even:
;	ldx	#$0f							; 2
;scrn_c_done:
;	stx	MASK							; 3

;	asl			; shift back (now even)			; 2

	and	#$fe		; make even
	tay

	lda	gr_offsets,Y	; lookup low-res memory address		; 4
        clc								; 2
        adc	XPOS							; 3
        sta	GBASL							; 3

        lda	gr_offsets+1,Y						; 4
        adc	#$8	; assume reading from $c0			; 3
        sta	GBASH							; 3

	ldy	#0

	lda	YPOS
	lsr
	bcs	scrn_adjust_even

scrn_adjust_odd:
	lda	(GBASL),Y	; top/bottom color
	jmp	scrn_done

scrn_adjust_even:
	lda	(GBASL),Y	; top/bottom color

	lsr
	lsr
	lsr
	lsr

scrn_done:

	and	#$f

	rts
