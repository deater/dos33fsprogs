;================================
; draw the sorta vectored logo
;================================

; 908 bytes -- first display
; 916 bytes -- scroll down

show_logo:

	lda	#76
	sta	LETTER_Y

logo_loop:
	ldx	#7
	jsr	HCOLOR1						; set color

	lda	#14
	sta	LETTER_X

	lda	#<letter_d
	sta	INL
	lda	#>letter_d
	sta	INH
	jsr	draw_letter

	lda	#62
	sta	LETTER_X
	lda	#<letter_e
	sta	INL
	lda	#>letter_e
	sta	INH
	jsr	draw_letter

	lda	#110
	sta	LETTER_X
	lda	#<letter_s
	sta	INL
	lda	#>letter_s
	sta	INH
	jsr	draw_letter

	lda	#154
	sta	LETTER_X
	lda	#<letter_i
	sta	INL
	lda	#>letter_i
	sta	INH
	jsr	draw_letter

	lda	#176
	sta	LETTER_X
	lda	#<letter_r
	sta	INL
	lda	#>letter_r
	sta	INH
	jsr	draw_letter

	lda	#220
	sta	LETTER_X
	lda	#<letter_e
	sta	INL
	lda	#>letter_e
	sta	INH
	jsr	draw_letter

	inc	LETTER_Y
	lda	LETTER_Y
	cmp	#77
	bne	logo_loop



logo_done:
	jmp	skip_it


	;========================
	; draw letter
	;========================
	; so inefficient
	; letter to draw in INL:INH

draw_letter:

	ldy	#0			; iterator
letter_loop:
	lda	(INL),Y

	cmp	#$FF
	beq	letter_done

	cmp	#$8D
	bne	hplot_to
hplot:
	iny

	lda	(INL),Y			; get X value
	asl				; need to multiply by 2
	clc
	adc	LETTER_X
	tax				; put in X

	iny				; point to Y value

	tya				; save Y value on stack for later
	pha

	lda	(INL),Y			; get Y value
	clc
	adc	LETTER_Y

	ldy	#0			; set top of X value (FIXME)

	jsr     HPLOT0  	        ; plot at (Y,X), (A)

	pla				; restore pointer
	tay

	iny

hplot_to:

	lda	(INL),Y
	asl
	clc
	adc	LETTER_X
	sta	TEMP

	lda	#0
	adc	#0
	tax

	iny

	tya
	pha

	lda	(INL),Y
	clc
	adc	LETTER_Y
	tay

	lda	TEMP

	jsr	HGLIN		; line to (X,A),(Y)

	pla
	tay

	iny

	jmp	letter_loop
letter_done:
	rts

skip_it:
