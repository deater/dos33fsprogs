;================================
; draw the sorta vectored logo
;================================

; 908 bytes -- first display
; 916 bytes -- scroll down
; 914 bytes -- assume < 256 co-ords
; 908 bytes -- assume first co-oord is an HPLOT
; 906 bytes -- save value on stack rather than ZP

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

	ldy	#$FF			; iterator
letter_loop:


hplot:

	; setup X value

	iny

	lda	(INL),Y			; get X value
	asl				; need to multiply by 2
	clc
	adc	LETTER_X
	tax				; put in X

	; setup Y value

	iny				; point to Y value

	sty	SAVE_Y			; save Y value on stack for later

	lda	(INL),Y			; get Y value
	clc
	adc	LETTER_Y

	ldy	#0			; set top of X value (FIXME)

	jsr     HPLOT0  	        ; plot at (Y,X), (A)

	ldy	SAVE_Y			; restore pointer

	iny

hplot_to:

	; get X value

	lda	(INL),Y			; get next value
	asl				; mul by 2
	clc
	adc	LETTER_X		; add in offset
	pha				; save for later

	lda	#0			; wrap if > 256
	adc	#0
	tax

	; get Y value

	iny

	sty	SAVE_Y			; save Y value

	lda	(INL),Y			; get next value
	clc				; add Y offset
	adc	LETTER_Y
	tay				; put into Y

	pla				; restore X value

	jsr	HGLIN			; line to (X,A),(Y)

	ldy	SAVE_Y

	iny

	; see if at end of line or of whole thing

	lda	(INL),Y			; get next value

	bmi	letter_done		; if negative, we are done

	cmp	#$7F
	beq	hplot
	bne	hplot_to

letter_done:
	rts

skip_it:
