	;===============================================
	; Move Letters
	;===============================================
	; Normal	=10+25+38+9 = 82     need 28  (28)
	; End of line   =10+25+38+37 = 110
	; Next line	=10+5+12+34 = 61     need 49  (28+21)
	; done entirely =10+5+9 = 24         need 86  (28+21+37)

	; all forced to be 109

move_letters:
	ldy	#0							; 2
	lda	(LETTERL),Y						; 5
	sta	LETTER							; 3
								;==========
								;       10
	bmi	letter_special
									; 2
	lda	LETTERY							; 3
	asl								; 2
	tay								; 2
	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	sta	BASL		; store out low byte of addy		; 3
	lda	gr_offsets+1,Y	; look up high byte			; 4
	sta	BASH							; 3
	lda	#0		; cycle-killer				; 2
								;==========
								;       25

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

	lda	LETTERX							; 3
	cmp	LETTERD							; 3
								;===========
								;        38
	beq	letter_next
									; 2
	lda	#0							; 2
	lda	#0							; 2
	jmp	waste_28						; 3
								;==========
								;	  9
letter_next:
									; 3
	clc								; 2
	lda	LETTERL							; 3
	adc	#1							; 2
	sta	LETTERL							; 3
	lda	LETTERH							; 3
	adc	#0							; 2
	sta	LETTERH							; 3
	inc	LETTERD							; 5
	lda	#39							; 2
	sta	LETTERX							; 3
	rts								; 6
								;===========
								;        37

letter_special:
									; 3
	cmp	#$ff							; 2
								;==========
								;         5

	beq	letter_done
									; 2
	ldy	#1							; 2
	lda	(LETTERL),Y						; 5
	sta	LETTERY							; 3
								;===========
								;	 12

	iny								; 2
	lda	(LETTERL),Y						; 5
	sta	LETTERD							; 3

	clc								; 2
	lda	LETTERL							; 3
	adc	#3							; 2
	sta	LETTERL							; 3
	lda	LETTERH							; 3
	adc	#0							; 2
	sta	LETTERH							; 3
	lda	LETTERH		; waste					; 3
	jmp	waste_21						; 3

								;===========
								;        34
letter_done:
				; 3
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
waste_21:
	ldx	#0		; 2
	ldx	#0		; 2
	ldx	#0		; 2
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
	;.byte	22,30,
	.byte	      "CODE BY",128
	.byte	23,30,"DEATER",128
	.byte	22,30,"FIREWORKS",128
	.byte	23,30,"FOZZTEXX",128
	.byte	22,30,"A VMW",128
	.byte	23,30,"PRODUCTION",128
	.byte	255
