	;================================
	; htab_vtab
	;================================
	; move to CH/CV
htab_vtab:
	lda	CV
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

	rts

	;================================
	; move_and_print
	;================================
	; move to CH/CV
move_and_print:
	jsr	htab_vtab

	;================================
	; print_string
	;================================

print_string:
	ldy	#0
print_string_loop:
	lda	(OUTL),Y
	beq	done_print_string
	ora	#$80
	sta	(BASL),Y
	iny
	bne	print_string_loop
done_print_string:
	rts

	;====================
	; point_to_end_string
	;====================
point_to_end_string:
	iny
	tya
	clc
	adc	OUTL
	sta	OUTL
	lda	#0
	adc	OUTH
	sta	OUTH

	rts


	;================================
	; print_both_pages
	;================================
print_both_pages:
	lda	DRAW_PAGE
	sta	draw_page_smc+1

	lda	#0
	sta	DRAW_PAGE
	jsr	move_and_print

	lda	#4
	sta	DRAW_PAGE
	jsr	move_and_print

draw_page_smc:
	lda	#$d1
	sta	DRAW_PAGE

	rts	; oops forgot this initially
		; explains the weird vertical stripes on the screen

