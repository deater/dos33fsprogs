
move_ducks:

	ldx	#1			; start with duck2

move_duck_loop:

	clc
	lda	D1_XPOS,X
	adc	D1_XSPEED,X
	sta	D1_XPOS,X


	; check out of bounds
	; duck XPOS is middle of duck (which is 12 wide)
	;
	; to stay in pond want XPOS to be between and 8 and 34?

	lda	D1_XPOS,X
	cmp	#8
	bcc	duck_too_far_left	; blt
	cmp	#34
	bcs	duck_too_far_right	; bge
	jmp	duck_good

duck_too_far_left:
	lda	#$1			; move right
	sta	D1_XSPEED,X

	lda	D1_STATE,X		; face right
	ora	#DUCK_RIGHT
	sta	D1_STATE,X

	jmp	duck_good
duck_too_far_right:

	lda	#$ff			; move left
	sta	D1_XSPEED,X


	lda	D1_STATE,X		; face left
	and	#<~DUCK_RIGHT
	sta	D1_STATE,X

duck_good:
	dex
	bpl	move_duck_loop


	rts
