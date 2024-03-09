	;=============================
	; normal_text
	;=============================
	; modify so print normal text
normal_text:

	; want ora #$80
	lda	#$09
	sta	ps_smc1

	lda	#$80
	sta	ps_smc1+1

	rts

	;=============================
	; inverse_text
	;=============================
	; modify so print inverse text
inverse_text:

	; want and #$3f
	lda	#$29
	sta	ps_smc1

	lda	#$3f
	sta	ps_smc1+1

	rts


	;=============================
	; raw text
	;=============================
	; modify so print raw string
raw_text:

	; want nop nop
	lda	#$EA
	sta	ps_smc1

	lda	#$EA
	sta	ps_smc1+1

	rts



	;================================
	; move_and_print
	;================================
	; get X,Y from OUTL/OUTH
	; then print following string to that address
	; stop at NUL
	; convert to APPLE ASCII (or with 0x80)
	; leave OUTL/OUTH pointing to next string

move_and_print:
	ldy	#0
	lda	(OUTL),Y
	sta	CH
	iny
	lda	(OUTL),Y
	asl
	tay
	lda	gr_offsets,Y    ; lookup low-res memory address
	clc
	adc	CH		; add in xpos
	sta	BASL		; store out low byte of addy

	lda	gr_offsets+1,Y	; look up high byte
	adc	DRAW_PAGE	;
	sta	BASH		; and store it out
				; BASH:BASL now points at right place

	clc
	lda	OUTL
	adc	#2
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

	;================================
	; print_string
	;================================

print_string:
	ldy	#0
print_string_loop:
	lda	(OUTL),Y
	beq	done_print_string
ps_smc1:
	and	#$3f			; make sure we are inverse
	sta	(BASL),Y
	iny
	bne	print_string_loop
done_print_string:
	iny
	clc
	tya
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

	rts


	;================================
	; move and print a list of lines
	;================================
move_and_print_list:
	jsr	move_and_print
	ldy	#0
	lda	(OUTL),Y
	bpl	move_and_print_list

	rts


.if 0
	;================================
	; move and print a list of lines
	;================================
move_and_print_list_both_pages:
	lda	DRAW_PAGE
	pha

	lda	OUTL
	pha
	lda	OUTH
	pha

	lda	#0
	sta	DRAW_PAGE

	jsr	move_and_print_list

	pla
	sta	OUTH
	pla
	sta	OUTL

	lda	#4
	sta	DRAW_PAGE

	jsr	move_and_print_list

	pla
	sta	DRAW_PAGE


	rts



	;=======================
	; print to both pages
	;=======================
print_both_pages:
	lda	DRAW_PAGE
	pha

	lda	OUTL
	pha
	lda	OUTH
	pha

	lda	#0
	sta	DRAW_PAGE

	jsr	move_and_print

	pla
	sta	OUTH
	pla
	sta	OUTL

	lda	#4
	sta	DRAW_PAGE

	jsr	move_and_print

	pla
	sta	DRAW_PAGE


	rts
.endif
