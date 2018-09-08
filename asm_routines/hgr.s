
HGR_SHAPE =	$1A
HGR_SHAPE_H =	$1B
HGR_BITS =	$1C
HGR_COUNT =	$1D

HMASK	=	$30

DSCTMP	=	$9D

HGR_DX	=	$D0
HGR_DX_H =	$D1
HGR_DY	=	$D2
HGR_QUADRANT =	$D3
HGR_E	=	$D4
HGR_E_H	=	$D5
HGR_X	=	$E0
HGR_X_H	=	$E1
HGR_Y	=	$E2
;HGR_COLOR =	$E4
HGR_HORIZ =	$E5
HGR_PAGE =	$E6


TXTCLR	=	$C050
MIXSET	=	$C053
LOWSCR	=	$C054
MIXCLR	=	$C052
HISCR	=	$C055










hgr2:
	; F3D8
	bit	HISCR		; BIT SW.HISCR Use PAGE2 ($C055)
	bit	MIXCLR		; BIT SW.MIXCLR
	lda	#$40		; HIRES Page 2 at $4000
	bne	sethpg
hgr:
	; F3E2
	lda	#$20		; HIRES Page 1 at $2000
	bit	LOWSCR		; BIT SW.LOWSCR Use PAGE1 ($C054)
        bit	MIXSET		;  BIT SW.MIXSET (Mixed text)
sethpg:
	; F3EA
	sta	HGR_PAGE
	lda	HIRES
	lda	TXTCLR
hclr:
	lda	#0			; black background
	sta	HGR_BITS
bkgnd:
	; F3F6
	lda	HGR_PAGE
	sta	HGR_SHAPE+1
	ldy	#0
	sty	HGR_SHAPE
bkgnd_loop:
	lda	HGR_BITS

	sta	(HGR_SHAPE),y

	jsr	color_shift

	iny
	bne	bkgnd_loop

	inc	HGR_SHAPE+1
	lda	HGR_SHAPE+1
	and	#$1f			; see if $40 or $60
	bne	bkgnd_loop
	rts



msktbl:	.byte $81,$82,$84,$88,$90,$A0,$C0

hposn:
	; F411
	sta	HGR_Y
	stx	HGR_X
	sty	HGR_X+1
	pha
	and	#$C0
	sta	GBASL
	lsr
	lsr
	ora	GBASL
	sta	GBASL
	pla
	; F423
	sta	GBASH
	asl
	asl
	asl
	rol	GBASH
	asl
	rol	GBASH
	asl
	ror	GBASL
	lda	GBASH
	and	#$1f
	ora	HGR_PAGE
	sta	GBASH

	; F438
	txa
	cpy	#0
	beq	hposn_2

	ldy	#35
	adc	#4
hposn_1:
	iny
	; f442
hposn_2:
	sbc	#7
	bcs	hposn_1
	sty	HGR_HORIZ
	tax
	lda	msktbl-$100+7,x		; LDA MSKTBL-$100+7,X  BIT MASK
					; MSKTBL=F5B2
	sta	HMASK
	tya
	lsr
	lda	HGR_COLOR
	sta	HGR_BITS
	bcs	color_shift
	rts

hplot0:
	; F457
	jsr	hposn
	lda	HGR_BITS
	eor	(GBASL),y
	and	HMASK
	eor	(GBASL),y
	sta	(GBASL),y
	rts

move_left_or_right:
	; F465
	bpl	move_right

	lda	HMASK
	lsr
	bcs	lr_2
	eor	#$c0
lr_1:
	sta	HMASK
	rts
lr_2:
	dey
	bpl	lr_3
	ldy	#39
lr_3:
	lda	#$c0
lr_4:
	sta	HMASK
	sty	HGR_HORIZ
	lda	HGR_BITS

color_shift:
	; F47E
	asl
	cmp	#$c0

	bpl	done_color_shift

	lda	HGR_BITS
	eor	#$7f
	sta	HGR_BITS

done_color_shift:
	rts

move_right:
	lda	HMASK
	asl
	eor	#$80
	bmi	lr_1
	lda	#$81
	iny
	cpy	#40
	bcc	lr_4
	ldy	#0
	bcs	lr_4


con_1c:	.byte $1c
con_03:	.byte $03
con_04:	.byte $04

move_up_or_down:
	; F4D3
	bmi	move_down

	clc
	lda	GBASH
	bit	con_1c		; CON.1C
	bne	mu_5
	asl	GBASL
	bcs	mu_3
	bit	con_03		; CON.03
	beq	mu_1
	adc	#$1f
	sec
	bcs	 mu_4
	; F4Eb
mu_1:
	adc	#$23
	pha
	lda	GBASL
	adc	#$b0
	bcs	mu_2
	adc	#$f0
	; f4f6
mu_2:
	sta	GBASL
	pla
	bcs	mu_4
mu_3:
	adc	#$1f
mu_4:
	ror	GBASL
mu_5:
	adc	#$fc
ud_1:
	sta	GBASH
	rts

	; f505
move_down:
	lda	GBASH
	adc	#$4
	bit	con_1c
	bne	ud_1
	asl	GBASL
	bcc	md_2
	adc	#$e0
	clc
	bit	con_04
	beq	md_3;
	lda	GBASL
	adc	#$50
	eor	#$f0
	beq	md_1
	eor	#$f0
md_1:
	sta	GBASL
	lda	HGR_PAGE
	bcc	md_3
md_2:
	adc	#$e0
md_3:
	ror	GBASL
	bcc	ud_1


hglin:

	; F53A
	pha
	sec
	sbc	HGR_X
	pha
	txa
	sbc	HGR_X+1
	sta	HGR_QUADRANT
	; F544
	bcs	hglin_1
	pla
	eor	#$ff
	adc	#1
	pha
	lda	#0
	sbc	HGR_QUADRANT
	; F550
hglin_1:
	sta	HGR_DX+1
	sta	HGR_E+1
	pla
	sta	HGR_DX
	sta	HGR_E
	pla
	sta	HGR_X
	stx	HGR_X+1
	tya
	clc
	sbc	HGR_Y
	bcc	hglin_2
	eor	#$ff
	adc	#$fe
hglin_2:
	; F568
	sta	HGR_DY
	sty	HGR_Y
	ror	HGR_QUADRANT
	sec
	sbc	HGR_DX
	tax
	lda	#$ff
	sbc	HGR_DX+1
	sta	HGR_COUNT
	ldy	HGR_HORIZ
	bcs	movex2		; always?
	; f57c
movex:
	asl
	jsr	move_left_or_right
	sec

	; f581
movex2:
	lda	HGR_E
	adc	HGR_DY
	sta	HGR_E
	lda	HGR_E+1
	sbc	#0
movex2_1:
	sta	HGR_E+1
	lda	(GBASL),y
	eor	HGR_BITS
	and	HMASK
	eor	(GBASL),y
	sta	(GBASL),y
	inx
	bne	movex2_2
	inc	HGR_COUNT
	beq	rts22
	; F59e
movex2_2:
	lda	HGR_QUADRANT
	bcs	movex
	jsr	move_up_or_down
	clc
	lda	HGR_E
	adc	HGR_DX
	sta	HGR_E
	lda	HGR_E+1
	adc	HGR_DX+1
	bvc	movex2_1


hplot_to:

	; F712
	sty	DSCTMP
	tay
	txa
	ldx	DSCTMP
	jsr	hglin
rts22:
	rts


	; Color in X
hcolor_equals:

	; F6E9
	; TODO: mask to be less than 8

	lda	colortbl,x
	sta	HGR_COLOR
	rts

colortbl:
	.byte	$00,$2A,$55,$7F,$80,$AA,$D5,$FF

