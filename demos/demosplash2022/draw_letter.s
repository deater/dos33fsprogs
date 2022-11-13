	;========================
	; draw letter
	;========================
	; so inefficient
	; letter to draw in INL:INH
	; A is X offset

draw_letter:
	sty	LETTER_X
	ldy	#$FF			; iterator
letter_loop:


hplot:
	; setup X value

	iny				; skip the new-line indicator

	jsr	get_x			; get adjusted x-coord in A

	tax				; put in X

	; setup Y value

	jsr	get_y			; get adjusted y-coord in A

	ldy	#0			; set top of X value (FIXME)

	jsr     HPLOT0  	        ; plot at (Y,X), (A)

	ldy	SAVE_Y			; restore pointer

	iny

hplot_to:

	; get X value

	jsr	get_x			; get adjusted x-coord in A

	pha				; save for later

	lda	#0			; wrap if > 256
	adc	#0
	tax

	; get Y value

	jsr	get_y

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


	;================
	; get next X co-ord
	; multipy by 2
	; increment y
get_x:
	lda	(INL),Y			; get X value
	asl				; need to multiply by 2
	clc
	adc	LETTER_X

	iny

	rts

	;================
	; get next Y co-ord
	; increment y
	; save to SAVE_Y

get_y:
	sty	SAVE_Y			; save Y value on stack for later

	lda	(INL),Y			; get Y value
	clc
	adc	LETTER_Y

	rts

