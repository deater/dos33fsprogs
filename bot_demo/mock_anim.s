	;=============================
	; mockingboard where available
	;=============================

mock_anim:

	lda	#11
	sta	CH
	lda	#21
	sta	CV
	jsr	VTAB

	lda	#<mock_string
	ldy	#>mock_string

	jsr	STROUT

	lda	#9
	sta	paren_limit_smc+1
	jsr	paren_move

	lda	#7
	sta	paren_limit_smc+1
	jsr	paren_move

	lda	#5
	sta	paren_limit_smc+1
	jsr	paren_move

	; flip the parens

	lda	#9
	sta	paren_flip1_smc+1
	lda	#30
	sta	paren_flip2_smc+1
	jsr	paren_flip

	lda	#7
	sta	paren_flip1_smc+1
	lda	#32
	sta	paren_flip2_smc+1
	jsr	paren_flip

	lda	#5
	sta	paren_flip1_smc+1
	lda	#34
	sta	paren_flip2_smc+1
	jsr	paren_flip



	; where available

	lda	#12
	sta	CH
	lda	#22
	sta	CV
	jsr	VTAB

	lda	#<mock2_string
	ldy	#>mock2_string

	jsr	STROUT


	rts


	; animate the parenthesis
paren_move:
	ldx	#0
	ldy	#39
parenthesis_loop:

	lda	#' '|$80
	sta	$6d0,X
	sta	$6d0,Y

	inx
	dey

	lda	#'('|$80
	sta	$6d0,X
	lda	#')'|$80
	sta	$6d0,Y

	lda	#128
	jsr	WAIT

paren_limit_smc:
	cpx	#9
	bne	parenthesis_loop

	rts


	; flip the parenthesis
paren_flip:

paren_flip1_smc:
	ldx	#9
	lda	#')'|$80
	sta	$6d0,X

paren_flip2_smc:
	ldy	#30
	lda	#'('|$80
	sta	$6d0,Y

	lda	#200
	jsr	WAIT

	rts



mock_string:
	.byte "MOCKINGBOARD SOUND",0
;	.byte ") ) ) MOCKINGBOARD SOUND ( ( (",0
mock2_string:
	.byte "WHERE AVAILABLE",0
