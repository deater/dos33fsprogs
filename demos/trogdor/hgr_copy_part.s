	;=========================================================
	; hgr copy from page in A to current DRAW_PAGE
	;=========================================================
	;	from source, assume $6000
	;		from COPY_X1,Y1 to WIDTH, Y2
	;	copy to DRAW_PAGE
	;		SPRITE_X,SPRITE_Y
hgr_copy_part:

hgr_copy_outer_loop:

	ldy	COPY_Y1
	lda	hposn_low,Y
	clc
	adc	COPY_X1
	sta	INL
	lda	hposn_high,Y
	clc
	adc	#$40			; force $6000
	sta	INH

	ldy	SPRITE_Y
	lda	hposn_low,Y
	clc
	adc	SPRITE_X
	sta	OUTL
	lda	hposn_high,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH


	ldy	COPY_WIDTH
	dey
hgr_copy_inner_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	dey
	bpl	hgr_copy_inner_loop

	inc	COPY_Y1
	inc	SPRITE_Y
	lda	COPY_Y1
	cmp	COPY_Y2
	bne	hgr_copy_outer_loop

	rts					; 6


	;=========================================
	; hgr_copy_right
	;=========================================
	; copy right side of $6000 to current page
hgr_copy_right:
	lda	#0
	sta	COPY_Y1
	sta	SPRITE_Y
	lda	#10
	sta	SPRITE_X
	lda	#20
	sta	COPY_X1
	lda	#20
	sta	COPY_WIDTH
	lda	#191
	sta	COPY_Y2

	jmp	hgr_copy_part		; tail call


	;=========================================
	; hgr_copy_left
	;=========================================
	; copy left side of $6000 to current page
hgr_copy_left:
	lda	#0
	sta	COPY_X1
	sta	COPY_Y1
	sta	SPRITE_Y
	lda	#10
	sta	SPRITE_X
	lda	#20
	sta	COPY_WIDTH
	lda	#191
	sta	COPY_Y2

	jmp	hgr_copy_part		; tail call

