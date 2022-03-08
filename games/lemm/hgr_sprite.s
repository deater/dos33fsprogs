	;===========================================
	; hgr draw sprite (only at 7-bit boundaries)
	;===========================================
	; SPRITE in INL/INH
	; Location at CURSOR_X CURSOR_Y

	; xsize, ysize  in first two bytes

	; sprite AT INL/INH

hgr_draw_sprite:

	; self modify to shift for odd start location

	; SEC=$38 0b0011 1000 CLC=$18 0b0001 10000

	lda	CURSOR_X
	lsr
	bcc	make_it_even

make_it_odd:
	lda	#$18
	bne	make_it_so
make_it_even:
	lda	#$38
make_it_so:
	sta	odd_even_smc


	ldy	#0
	lda	(INL),Y			; load xsize
	clc
	adc	CURSOR_X
	sta	sprite_width_end_smc+1	; self modify for end of line

	iny				; load ysize
	lda	(INL),Y
	sta	sprite_ysize_smc+1	; self modify

	; skip the xsize/ysize and point to sprite
	clc
	lda	INL			; 16-bit add
	adc	#2
	sta	sprite_smc1+1
	lda	INH
	adc	#0
	sta	sprite_smc1+2

	ldx	#0			; X is pointer offset

	stx	MASK			; actual row

hgr_sprite_yloop:

	lda	MASK			; row

	clc
	adc	CURSOR_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y

	; eor	#$00 draws on page2
	; eor	#$60 draws on page1
hgr_sprite_page_smc:
	eor	#$00
	sta	GBASH

	ldy	CURSOR_X

sprite_inner_loop:

sprite_smc1:
	lda	$d000		; get sprite pattern

;	lsr

odd_even_smc:
	sec
	bcs	no_adjust

	asl
	php
	clc
	lsr
	plp
	ror
no_adjust:
	;? Xcababab
	;X cababab?
	;? X0cababa

;	clc			; rol asl
;	rol



	sta	(GBASL),Y	; store out

	inx
	iny


	inc	sprite_smc1+1
	bne	sprite_noflo
	inc	sprite_smc1+2
sprite_noflo:

sprite_width_end_smc:
	cpy	#6
	bne	sprite_inner_loop


	inc	MASK		; row
	lda	MASK		; row

sprite_ysize_smc:
	cmp	#31
	bne	hgr_sprite_yloop

	rts

