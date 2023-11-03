	;============================
	; do the pan

horiz_pan:

pan_loop:

	lda	#0
	sta	COUNT
	sta	TICKER
	sta	P2_OFFSET

pan_outer_outer_loop:

	ldx	#191
pan_outer_loop:

	; $2000					; 0010 -> 0100 0011 -> 0101
	lda	hposn_high,X
	sta	pil_smc1+2
	sta	pil_smc2+2
	sta	pil_smc3+2
;	sta	pil_smc4+2
	sta	pil_smc6+2
	; $4000
	eor	#$60
	sta	pil_smc5+2
	sta	pil_smc7+2
	sta	pil_smc8+2
	sta	pil_smc9+2

	; $2000
	lda	hposn_low,X
	sta	pil_smc1+1
	sta	pil_smc2+1
;	sta	pil_smc4+1
	sta	pil_smc6+1
	sta	pil_smc5+1
	sta	pil_smc8+1

	; $2000+1

	sta	pil_smc3+1
	inc	pil_smc3+1
	sta	pil_smc7+1
	inc	pil_smc7+1
	sta	pil_smc9+1
	inc	pil_smc9+1


	stx	XSAVE


	ldy	#0

	; original: 36*39 = ??
	; updated:  34*39

pil_smc1:
	ldx	$2000,Y			;			; 4+
pan_inner_loop:

	lda	left_lookup_main,X			; 4+
	sta	TEMPY					; 3

pil_smc3:
	ldx	$2000+1,Y				; 4+
	lda	left_lookup_next,X			; 4+
	ora	TEMPY					; 3

pil_smc2:
	sta	$2000,Y					; 5

	iny						; 2
	cpy	#39					; 2
	bne	pan_inner_loop				; 2/3

; leftover

	; X has $2000,39
	lda	left_lookup_main,X			; 4+
	sta	TEMPY					; 3

pil_smc5:
	ldx	$4000					; 4+
	lda	left_lookup_next,X			; 4+
	ora	TEMPY					; 3

pil_smc6:
	sta	$2000,Y					; 5

	; X has $4000
	lda	left_lookup_main,X			; 4+
	sta	TEMPY					; 3

pil_smc7:
	ldx	$4000+1					; 4+
	lda	left_lookup_next,X			; 4+
	ora	TEMPY					; 3

pil_smc8:
	sta	$4000					; 5

	lda	left_lookup_main,X			; 4+
pil_smc9:
	sta	$4000+1					; 5

	;   $2038  $2039   $4000    $4001
	;0 DCCBBAA GGFFEED KJJIIHH  NNMMLLK
	;1 EDDCCBB HHGGFFE LKKJJII  ~~NNMML
	;2 FEEDDCC IIHHGGF MLLKKJJ  ~~~~NNM
	;3 GFFEEDD JJIIHHG NMMLLKK  ~~~~~~N
	;4 HGGFFEE KKJJIIH ~NNMMLL  ~~~~~~~
	;5 IHHGGFF LLKKJJI ~~~NNMM  ~~~~~~~
	;6 JIIHHGG MMLLKKJ ~~~~~NN  ~~~~~~~
	;7 KJJIIHH NNMMLLK ~~~~~~~  ~~~~~~~
	;8                 RQQPPOO  UUTTSSR

	; every 8 clicks need to copy over two more columns

	ldx	XSAVE

	dex
	cpx	#$ff
;	bne	pan_outer_loop
	beq	done_pan_outer_loop
	jmp	pan_outer_loop
done_pan_outer_loop:

	lda	KEYPRESS
	bmi	done_pan

	; check if update
	; FIXME: use mod 7 table here
	inc	TICKER
	lda	TICKER
	cmp	#7
	bne	no_ticker

	lda	#0
	sta	TICKER
	inc	P2_OFFSET
	inc	P2_OFFSET

	ldx	#0
p2_loop:
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	eor	#$60
	sta	GBASH

	ldy	P2_OFFSET
	lda	(GBASL),Y
	pha
	iny
	lda	(GBASL),Y
	ldy	#1
	sta	(GBASL),Y
	dey
	pla
	sta	(GBASL),Y

	inx
	cpx	#192
	bne	p2_loop


no_ticker:
	inc	COUNT
	lda	COUNT
	cmp	#139
	beq	done_pan

;	bne	pan_outer_outer_loop
	jmp	pan_outer_outer_loop

done_pan:
	bit	KEYRESET

	rts

.include "scroll_tables.s"
