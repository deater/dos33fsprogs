
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

