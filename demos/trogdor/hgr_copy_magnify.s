	;=============================================================
	; hgr copy from page in A to current DRAW_PAGE but magnify 2x
	;=========================================================

hgr_copy_magnify:

INPUT_OFFSET = 20

	ldx	#0
magnify_outer_loop:
	txa
	pha
	clc
	adc	#INPUT_OFFSET
	tax

	lda	hposn_low,X
	sta	INL

	lda	hposn_high,X
	clc
	adc	#$40		; hardcode at $60
	sta	INH

	pla

	pha

	asl
	tax

	lda	hposn_low,X
	sta	OUTL

	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	OUTH

	inx

	lda	hposn_low,X
	sta	GBASL


	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	GBASH


	ldy	#0						; 2
magnify_inner_loop:
	lda	(INL),Y					 	; 5
	and	#$f						; 2
	tax							; 2
	lda	magnify_table_low,X				; 4
	sta	(OUTL),Y					; 6
	sta	(GBASL),Y					; 6

	inc	OUTL						; 5
	inc	GBASL						; 5

	lda	(INL),Y						; 5
	lsr							; 2
	lsr							; 2
	lsr							; 2
	tax							; 2
	lda	magnify_table_high,X				; 4
	sta	(OUTL),Y					; 6
	sta	(GBASL),Y					; 6

	iny							; 2
	cpy	#20						; 2
	bne	magnify_inner_loop				; 2/3

	pla
	tax

	inx
	cpx	#96
	bne	magnify_outer_loop

	rts


	; XXXXABCD = XA BB CC DD
magnify_table_low:
	.byte	$00	; 0000 => 000 0000
	.byte	$03	; 0001 => 000 0011
	.byte	$0C	; 0010 => 000 1100
	.byte	$0F	; 0011 => 000 1111
	.byte	$30	; 0100 => 011 0000
	.byte	$33	; 0101 => 011 0011
	.byte	$3C	; 0110 => 011 1100
	.byte	$3F	; 0111 => 011 1111

	.byte	$40	; 1000 => 100 0000
	.byte	$43	; 1001 => 100 0011
	.byte	$4C	; 1010 => 100 1100
	.byte	$4F	; 1011 => 100 1111
	.byte	$70	; 1100 => 111 0000
	.byte	$73	; 1101 => 111 0011
	.byte	$7C	; 1110 => 111 1100
	.byte	$7F	; 1111 => 111 1111


	; XEFGABCD = XE EF FG GA
magnify_table_high:
	.byte	$00	; 0000 => 000 0000
	.byte	$01	; 0001 => 000 0001
	.byte	$06	; 0010 => 000 0110
	.byte	$07	; 0011 => 000 0111
	.byte	$18	; 0100 => 001 1000
	.byte	$19	; 0101 => 001 1001
	.byte	$1E	; 0110 => 001 1110
	.byte	$1F	; 0111 => 001 1111

	.byte	$60	; 1000 => 110 0000
	.byte	$61	; 1001 => 110 0001
	.byte	$66	; 1010 => 110 0110
	.byte	$67	; 1011 => 110 0111
	.byte	$78	; 1100 => 111 1000
	.byte	$79	; 1101 => 111 1001
	.byte	$7E	; 1110 => 111 1110
	.byte	$7F	; 1111 => 111 1111
