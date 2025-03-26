; copy from $A000+start : $A000+end  to $2000/$4000


	; X=start
	; Y=len
	; A=offset

slow_copy_aux:
	sta	WRAUX
	sta	RDAUX

slow_copy_main:

slow_copy:
	sty	LENGTH
	sta	OFFSET

slow_copy_outer_loop:
	stx	INDEX
	txa
	clc
	adc	OFFSET
	tax

	lda	hposn_low,X		; copy src
	sta	slow_copy_smc1+1
	lda	hposn_high,X
	clc
	adc	#$80			; to $A0
	sta	slow_copy_smc1+2

	ldx	INDEX			; restore index

	lda	hposn_low,X		; copy dest
	sta	slow_copy_smc2+1

	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	slow_copy_smc2+2

	ldy	#39
slow_copy_loop:

slow_copy_smc1:
	lda	$A000,Y
slow_copy_smc2:
	sta	$2000,Y
	dey
	bpl	slow_copy_loop

	inx
	dec	LENGTH
	bne	slow_copy_outer_loop

	bit	RDMAIN
	bit	WRMAIN

	rts
