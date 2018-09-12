
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


.align	$100
	;==========================
	; HGR2
	;==========================
hgr2:
	; F3D8
	bit	HISCR		; BIT SW.HISCR Use PAGE2 ($C055)
	bit	MIXCLR		; BIT SW.MIXCLR
	lda	#$40		; HIRES Page 2 at $4000
	bne	sethpg
	;==========================
	; HGR
	;==========================
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


msktbl:	.byte $81,$82,$84,$88,$90,$A0,$C0	; original

	;====================================================
	; HPOSN
	;	time = 9 + 61 + 31 + 22 + 42 + 22 + 23 = 210

hposn:
	; F411: move values into expected zp locations
	sta	HGR_Y							; 3
	stx	HGR_X							; 3
	sty	HGR_X+1							; 3
								;===========
								;         9

	; calc y-position addr.  no lookup table?
	pha								; 3
	and	#$C0							; 2
	sta	GBASL							; 3
	lsr								; 2
	lsr								; 2
	ora	GBASL							; 3
	sta	GBASL							; 3
	pla								; 4
	sta	GBASH							; 3
	asl								; 2
	asl								; 2
	asl								; 2
	rol	GBASH							; 5
	asl								; 2
	rol	GBASH							; 5
	asl								; 2
	ror	GBASL							; 5
	lda	GBASH							; 3
	and	#$1f							; 2
	ora	HGR_PAGE						; 3
	sta	GBASH							; 3
								;============
								;	 61
	; F438
	; divide/mod 16-bit x poisition by 7
	; incoming, X=(y,x)
	; outgoing y=q, a=r

	; Divide by 7 (From December '84 Apple Assembly Line)

	txa								; 2
	clc								; 2
	sta	HGR_HORIZ						; 3
	lsr								; 2
	lsr								; 2
	lsr								; 2
	adc	HGR_HORIZ						; 3
	ror								; 2
	lsr								; 2
	lsr								; 2
	adc	HGR_HORIZ						; 3
	ror								; 2
	lsr								; 2
	lsr								; 2
	; x/7 is in A
								;============
								;	 31
	; calculate remainder
	clc								; 2
	sta	HGR_HORIZ						; 3
	asl								; 2
	adc	HGR_HORIZ						; 3
	asl								; 2
	adc	HGR_HORIZ						; 3
	; HGR_HORIZ=x/7, A=HGR_HORIZ*7
	; calculate remainder by X-(Q*7)
	sec								; 2
	eor	#$ff							; 2
	adc	HGR_X							; 3
	; A = remainder						;===========
								;	 22
;============================================================================

	cpy	#0							; 2
	beq	done_mod_nop_23						; 3
								;==========
								;	  5
theres_high:
									; -1
	clc								; 2
	adc	#4		; make remainder match			; 2
	pha								; 3
	lda	HGR_HORIZ						; 3
	adc	#36							; 2
	sta	HGR_HORIZ						; 3
	pla								; 4

	cmp	#7							; 2
	bcc	done_mod_nop14	; blt					; 3
								;============
								;	 23


									; -1
	sec								; 2
	sbc	#7							; 2
	inc	HGR_HORIZ						; 5
	ldy	HGR_HORIZ	; nop					; 3
	jmp	done_mod						; 3
								;============
								;	14
				;===========================
				; Y=HIGH,bcc = 5+23+ 14 = 42
				; Y=HIGH,bcs = 5+23+ 14 = 42
				; Y=LOW = 5 + 14+23 = 42

done_mod_nop_23:
	inc	HGR_HORIZ,X		; (nop)				; 6
	dec	HGR_HORIZ,X		; (nop)				; 6
	ldy	HGR_HORIZ		; (nop)				; 3
	ldy	HGR_HORIZ		; (nop)				; 3
	ldy	HGR_HORIZ		; (nop)				; 3
	nop								; 2
done_mod_nop14:
	inc	HGR_HORIZ,X		; (nop)				; 6
	dec	HGR_HORIZ,X		; (nop)				; 6
	nop								; 2

done_mod:
	ldy	HGR_HORIZ						; 3
	tax								; 2
	lda	msktbl,x						; 4+

	sta	HMASK							; 3
	tya								; 2
	lsr								; 2
	lda	HGR_COLOR						; 3
	sta	HGR_BITS						; 3
								;===========
								;	 22

	bcs	color_shift						; 3
				; cs = 3+20
									;-1

				; need 23 = 2+6+X = 15
	inc	HMASK,X		; nop					; 6
	dec	HMASK,X		; nop					; 6
	lda	HMASK		; nop					; 3


	rts								; 6
								;===========
								;	 23

	;=====================================
	; HPLOT0
	;=====================================
	; point in (YX),A
	; 244 cycles
hplot0:
	; F457
	jsr	hposn							; 6+210
	lda	HGR_BITS						; 3
	eor	(GBASL),y						; 5+
	and	HMASK							; 3
	eor	(GBASL),y						; 5+
	sta	(GBASL),y						; 6
	rts								; 6
								;============
								;	 244

move_left_or_right:
	; F465
	bpl	move_right

	lda	HMASK							; 3
	lsr								; 2
	bcs	lr_2
	eor	#$c0							; 2
lr_1:
	sta	HMASK							; 3
	rts								; 6

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


	;===================================
	; COLOR_SHIFT
	;===================================
	;	positive = 7+(7)+6 = 20
	;	negative = 7+ 7 +6 = 20

color_shift:				; F47E
	asl								; 2
	cmp	#$c0							; 2

	bpl	done_color_shift					; 3
									; -1
	lda	HGR_BITS						; 3
	eor	#$7f							; 2
	sta	HGR_BITS						; 3
	rts								; 6
done_color_shift:
	lda	HGR_BITS	; nop					; 3
	nop								; 2
	nop								; 2
	rts								; 6


	;==============================================================

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
	pha								; 3
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

	;===================================
	; HGLIN
	;===================================
	; cycles = 22+

hglin:

	; F53A: calc quadrant
	pha								; 3
	sec								; 2
	sbc	HGR_X							; 3
	pha								; 3
	txa								; 2
	sbc	HGR_X+1							; 3
	sta	HGR_QUADRANT						; 3
								;===========
								;	 22

	; F544
	bcs	hglin_1

	pla								; 4
	eor	#$ff							; 2
	adc	#1							; 2
	pha								; 3
	lda	#0							; 2
	sbc	HGR_QUADRANT						; 3

	; F550
hglin_1:
	sta	HGR_DX+1						; 3
	sta	HGR_E+1							; 3
	pla								; 4
	sta	HGR_DX							; 3
	sta	HGR_E							; 3
	pla								; 4
	sta	HGR_X							; 3
	stx	HGR_X+1							; 3
	tya								; 2
	clc								; 2
	sbc	HGR_Y							; 3
	bcc	hglin_2							; 3

	eor	#$ff							; 2
	adc	#$fe							; 2
hglin_2:
	; F568
	sta	HGR_DY							; 3
	sty	HGR_Y							; 3
	ror	HGR_QUADRANT
	sec								; 2
	sbc	HGR_DX							; 3
	tax								; 2
	lda	#$ff							; 3
	sbc	HGR_DX+1						; 3
	sta	HGR_COUNT						; 3
	ldy	HGR_HORIZ						; 3
	bcs	movex2		; always?				; 3
	; f57c
movex:
	asl								; 2
	jsr	move_left_or_right					; 6+?
	sec								; 2

	; f581
movex2:
	lda	HGR_E							; 3
	adc	HGR_DY							; 3
	sta	HGR_E							; 3
	lda	HGR_E+1							; 3
	sbc	#0							; 2
movex2_1:
	sta	HGR_E+1							; 3
	lda	(GBASL),y
	eor	HGR_BITS						; 3
	and	HMASK							; 3
	eor	(GBASL),y
	sta	(GBASL),y
	inx								; 2
	bne	movex2_2

	inc	HGR_COUNT
	beq	rts22
	; F59e
movex2_2:
	lda	HGR_QUADRANT						; 3
	bcs	movex

	jsr	move_up_or_down						; 6+
	clc								; 2
	lda	HGR_E							; 3
	adc	HGR_DX							; 3
	sta	HGR_E							; 3
	lda	HGR_E+1							; 3
	adc	HGR_DX+1						; 3
	bvc	movex2_1						; 3


	;===============================
	; HPLOT_TO
	;===============================
	;
	; cycles = 10 + 6 + X + 6
hplot_to:

	; F712: put vars in right location
	sty	DSCTMP							; 3
	tay								; 2
	txa								; 2
	ldx	DSCTMP							; 3
								;============
								;	 10

	jsr	hglin							;6+?
rts22:
	rts								; 6

.align	$100

	;=============================
	; HCOLOR_EQUALS
	;=============================
	; Color in X
	; 13 cycles
hcolor_equals:

	; F6E9
	; TODO: mask to be less than 8

	lda	colortbl,x						; 4+
	sta	HGR_COLOR						; 3
	rts								; 6

colortbl:
	.byte	$00,$2A,$55,$7F,$80,$AA,$D5,$FF

