	;===============================================
	; Move Letters
	;===============================================
	; Normal P0	=13+2+22+41+37 = 115
	; Normal P1	=13+2+22+41+37 = 115
	; End of line   =13+2+22+41+9+(28) = 115
	; done entirely =13+5+(6+37+26+28) = 115
	; Next line	=13+5+9+34+(26+28) = 115





	; all forced to be 115

move_letters:
	; load letter from pointer, save into LETTER

	ldy	#0							; 2
	lda	(LETTERL),Y						; 5
	sta	LETTER							; 3

	; if high bit set, is special case
	bmi	letter_special						; 3
								;==========
								;       13

	; just regular letter

									;-1
	lda	LETTERY		; get letter Y				; 3
	bmi	letter_page1
								;==========
								;	  2

letter_page0:								; -1
	asl			; map to memory address			; 2
	tay								; 2
	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	sta	BASL		; store out low byte of addy		; 3
	lda	gr_offsets+1,Y	; look up high byte			; 4
	sta	BASH							; 3
	lda	#0		; cycle-killer				; 2
	jmp	letter_erase						; 3
								;==========
								;       22

letter_page1:
	asl			; map to memory address			; 2
	tay								; 2
	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	sta	BASL		; store out low byte of addy		; 3
	lda	gr_offsets+1,Y	; look up high byte			; 4
	clc								; 2
	adc	#$4		; adjust to page1			; 2
	sta	BASH							; 3
								;==========
								;       22

	;============================
letter_erase:
	ldy	#0		; erase old char with space		; 2
	lda	#' '|$80						; 2
	ldy	LETTERX							; 3
	sta	(BASL),Y						; 6

	dey			; draw new char				; 2
	sty	LETTERX							; 3
	lda	LETTER							; 3
	ora	#$80							; 2
	ldy	LETTERX							; 3
	sta	(BASL),Y						; 6

	lda	LETTERX		; see if we are at destination		; 3
	cmp	LETTERD							; 3
	beq	letter_next						; 3
								;===========
								;        41

									;-1
	lda	#0							; 2
	lda	#0							; 2
	jmp	waste_28						; 3
								;==========
								;	  9
letter_next:
	clc			; 16-bit inc letter pointer		; 2
	lda	LETTERL							; 3
	adc	#1							; 2
	sta	LETTERL							; 3
	lda	LETTERH							; 3
	adc	#0							; 2
	sta	LETTERH							; 3

	inc	LETTERD		; inc destination X			; 5
	lda	#39		; start at right of screen		; 2
	sta	LETTERX							; 3
	rts								; 6
								;===========
								;        37

letter_special:
	cmp	#$ff		; handle FF, we're done			; 2
	beq	letter_done						; 3
								;==========
								;         5


									; -1
	ldy	#1		; otherwise, Y,X pair			; 2
	lda	(LETTERL),Y	; get Y, put in LETTERY			; 5
	sta	LETTERY							; 3
								;===========
								;	  9

	iny			; get dest				; 2
	lda	(LETTERL),Y						; 5
	sta	LETTERD		; put in LETTERD			; 3

	clc			; skip 3 bytes to begin of letters	; 2
	lda	LETTERL		; 16-bit add				; 3
	adc	#3							; 2
	sta	LETTERL							; 3
	lda	LETTERH							; 3
	adc	#0							; 2
	sta	LETTERH							; 3
	lda	LETTERH		; waste					; 3
	jmp	waste_26						; 3

								;===========
								;        34
letter_done:
	lda	LETTERH		; 3
	lda	LETTERH		; 3

waste_37:
	ldx	#0		; 2
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
waste_26:
	ldx	#0		; 2
	ldx	#0		; 2
	ldx	#0		; 2
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5

waste_28:
	ldx	#0		; 2
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	rts			; 6

letters:
;	.byte	22,28,
	.byte		  " ",128
	.byte   22+128,28," ",128

	.byte	23,28,    " ",128
	.byte	23+128,28," ",128

	.byte	22,28,    "CODE BY",128
	.byte	22+128,28,"CODE BY",128

	.byte	23,28,    "DEATER",128
	.byte	23+128,28,"DEATER",128

	.byte   22,28,    " ",128
	.byte   22+128,28," ",128

	.byte	23,28,    " ",128
	.byte	23+128,28," ",128

	.byte	22,28,    "FIREWORKS",128
	.byte	22+128,28,"FIREWORKS",128

	.byte	23,28,    "FOZZTEXX",128
	.byte	23+128,28,"FOZZTEXX",128

	.byte   22,28,    " ",128
	.byte   22+128,28," ",128

	.byte	23,28,    " ",128
	.byte	23+128,28," ",128

	.byte	22,28,"A VMW",128
	.byte	22+128,28,"A VMW",128

	.byte	23,28,"PRODUCTION",128
	.byte	23+128,28,"PRODUCTION"

	.byte	255
