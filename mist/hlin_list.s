
	; draw a list of hlins, two wide
	; at call time:
	;	INL:INH = addrss of list
	;	X is y value to start at (must be even)
	; list is
	;	color,xstart,xlen
	;	xlen >128 means quit

hlin_list:

	ldy	#0
hlin_list_yloop:

	lda	(INL),Y			; color
	iny
	sta	hlin_list_color_smc+1

	lda	gr_offsets,X		; address low
	clc
	adc	(INL),Y
	sec
	sbc	#1
	iny
	sta	hlin_list_addr_smc+1

	lda	(INL),Y			; count
	bmi	done_hlin_list
	iny
	sta	hlin_list_start_smc+1

	lda	gr_offsets+1,X		; address high
	clc
	adc	DRAW_PAGE
	sta	hlin_list_addr_smc+2

	txa
	pha

	;============================
	; hlin

hlin_list_color_smc:
	lda	#$00
hlin_list_start_smc:
	ldx	#$00
hlin_list_xloop:

hlin_list_addr_smc:
	sta	$400,X
	dex
	bne	hlin_list_xloop

	;
	;=============================

	pla
	tax
	inx
	inx
	jmp	hlin_list_yloop
done_hlin_list:
	rts
