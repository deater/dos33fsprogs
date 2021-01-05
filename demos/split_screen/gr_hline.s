	;==================================
	; HLINE
	;==================================
	; Color in A
	; Y has which line
	; takes 435 cycles
hline:
	pha							; 3
	ldx	gr_offsets,y					; 4+
	stx	hline_loop+1	; self-modify code		; 4
	lda	gr_offsets+1,y					; 4+
	clc							; 2
	adc	DRAW_PAGE					; 3
	sta	hline_loop+2	; self-modify code		; 4
	pla							; 4
	ldx	#39						; 2
							;===========
							;	 30
hline_loop:
	sta	$5d0,X		; 38				; 5
	dex							; 2
	bpl	hline_loop					; 2nt/3
							;===========
							; 40*(10)=400

								; -1
	rts							; 6

	;==========================
	; Clear gr screen
	;==========================
	; Color in A, Clears 0 to and including Y
	; clear_gr: takes 2+(48/2)*(6+435+7)+5 = 10759
	; cpl:      takes (Y/2)*(6+435+7)+5 = ?
clear_gr:
	ldy	#46						; 2
clear_page_loop:
	jsr	hline						; 6+435
	dey							; 2
	dey							; 2
	bpl	clear_page_loop					; 2/3
	rts							; 6

gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0

