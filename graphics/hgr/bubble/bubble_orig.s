; bubble universe -- Apple II Hires

; soft-switches

KEYPRESS	= $C000
KEYRESET	= $C010
PAGE1           =       $C054
PAGE2           =       $C055

; ROM routines

BKGND0		= $F3F4         ; clear current page to A
HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
HPLOT0		= $F457		; plot at (Y,X), (A)
HLINRL		= $F530		; line to (X,A), (Y)
HCOLOR1		= $F6F0		; set HGR_COLOR to value in X
COLORTBL	= $F6F6
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

; zero page

HPLOTXL		= $90
HPLOTXH		= $91
HPLOTYL		= $92
HPLOTYH		= $93
IVL		= $94
IVH		= $95
RXL		= $96
RXH		= $97
OUT1L		= $98
OUT1H		= $99
OUT2L		= $9A
OUT2H		= $9B
STEMP1L		= $9C
STEMP1H		= $9D
STEMP2L		= $9E
STEMP2H		= $9F

I		= $D0
J		= $D1
XL		= $D4
XH		= $D5
VL		= $D6
VH		= $D7
TL		= $DA
TH		= $DB
UL		= $DC
UH		= $DD

HGR_PAGE	= $E6

; const

NUM		= 32

bubble:

	jsr	HGR2

	ldx	#7
	jsr	HCOLOR1

	lda	#0
	sta	XL
	sta	XH
	sta	VL
	sta	VH
	sta	TL
	sta	TH

next_frame:

	lda	#0
	jsr	BKGND0

main_loop:

	; clear screen: TODO

	ldx	#0
	stx	I
outer_loop:

	ldx	#0
	stx	J

inner_loop:

	; fixed_add(rh[i],rl[i],xh,xl,&rxh,&rxl);
	ldx	I							; 3
	clc								; 2
	lda	rl,X
	adc	XL							; 3
	sta	RXL							; 3
	lda	rh,X
	adc	XH							; 3
	sta	RXH							; 3

	; fixed_add(i,0,vh,vl,&ivh,&ivl);
	clc
	lda	#0
	adc	VL
	sta	IVL
	lda	I
	adc	VH
	sta	IVH

	; U=SIN(I+V)+SIN(RR+X)
	; float_to_fixed(sin(ivh,ivl) + sin(rxh,rxl), &uh,&ul);

	ldy	#0
	jsr	sin
	ldy	#2
	jsr	sin

	clc
	lda	OUT1L
	adc	OUT2L
	sta	UL
	lda	OUT1H
	adc	OUT2H
	sta	UH

	; V=COS(I+V)+COS(RR+X)
	; float_to_fixed(cos(ivh,ivl) + cos(rxh,rxl), &vh,&vl);

	ldy	#0
	jsr	cos
	ldy	#2
	jsr	cos

	clc
	lda	OUT1L
	adc	OUT2L
	sta	VL
	lda	OUT1H
	adc	OUT2H
	sta	VH


	; X=U+T
	; fixed_add(uh,ul,th,tl,&xh,&xl);
	clc
	lda	UL
	adc	TL
	sta	XL
	lda	UH
	adc	TH
	sta	XH

	; HPLOT 32*U+140,32*V+96
	; hplot(48*fixed_to_float(uh,ul)+140,
	;	48*fixed_to_float(vh,vl)+96);

	; HPLOT0 plot at (Y,X), (A)

	lda	UL
	sta	HPLOTYL

	lda	UH

	asl	HPLOTYL
	rol
	asl	HPLOTYL
	rol
	asl	HPLOTYL
	rol
	asl	HPLOTYL
	rol
	asl	HPLOTYL
	rol

	clc
	adc	#140
	tax

	lda	VL
	sta	HPLOTYL

	lda	VH

	asl	HPLOTYL
	rol
	asl	HPLOTYL
	rol
	asl	HPLOTYL
	rol
	asl	HPLOTYL
	rol
	asl	HPLOTYL
	rol

	clc
	adc	#96


	ldy	#0		; never bigger than 140+48 = 188
;	ldx	#140
;	lda	#96
	jsr	HPLOT0

	inc	J
	lda	J
	cmp	#NUM
	beq	done_j
	jmp	inner_loop
done_j:

	inc	I
	lda	I
	cmp	#NUM
	beq	done_i
	jmp	outer_loop
done_i:

	; t=t+(1.0/32.0);
	;  1/2 1/4 1/8 1/16 | 1/32 1/64 1/128 1/256
	;	$0x08

	clc
	lda	TL
	adc	#$8
	sta	TL
	lda	#0
	adc	TH
	sta	TH

end:
	; flip pages

	; if $20 (draw PAGE1) draw PAGE2, SHOW page1
	; if $40 (draw PAGE2) draw PAGE1, SHOW page2

	lda	HGR_PAGE
	eor	#$60
	sta	HGR_PAGE

	cmp	#$40
	bne	flip2
flip1:
	bit	PAGE1
	jmp	next_frame
flip2:
	bit	PAGE2
	jmp	next_frame




	;=======================
sin:

	; / 6.28	is roughly the same as *0.16
	;               = .5 .25 .125 .0625 .03125
	; 1/6.28 = 0.16 =  0 0    1   0       1 0 0 0 = 0x28

	; i=(i*0x28)>>8;

	lda	IVL,Y
	sta	STEMP1L
	lda	IVH,Y
	sta	STEMP1H
already_loaded:
	; i2=i<<3;

	asl	STEMP1L
	rol	STEMP1H
	asl	STEMP1L
	rol	STEMP1H
	asl	STEMP1L
	rol	STEMP1H

	; i1=i<<5;

	lda	STEMP1L
	sta	STEMP2L
	lda	STEMP1H
	sta	STEMP2H

	asl	STEMP2L
	rol	STEMP2H
	asl	STEMP2L
	rol	STEMP2H

	; i=(i1+i2)>>8;

	clc
	lda	STEMP1L
	adc	STEMP2L
	sta	STEMP1L

	lda	STEMP1H
	adc	STEMP2H
	sta	STEMP1H

	ldx	STEMP1H

	; sl=fsinh[i];

	lda	sin_lookup,X
	asl
	sta	OUT1L,Y

	bcs	sin_negative
sin_positive:
	lda	#$0
	beq	set_sin_sign
sin_negative:
	lda	#$FF
set_sin_sign:
	sta	OUT1H,Y

	rts

	;=============================
cos:
	; 1.57 is roughly 0x0192 in 8.8

	clc
	lda	IVL,Y
	adc	#$92
	sta	STEMP1L
	lda	IVH,Y
	adc	#1
	sta	STEMP1H

	jmp	already_loaded


rh:
.byte	$00,$00,$00,$00,$00,$00,$00,$00
.byte	$00,$00,$00,$00,$00,$00,$00,$00
.byte	$00,$00,$00,$00,$00,$00,$00,$00
.byte	$00,$00,$00,$00,$00,$00,$00,$00

rl:
.byte	$00,$06,$0C,$12,$19,$1F,$25,$2B
.byte	$32,$38,$3E,$45,$4B,$51,$57,$5E
.byte	$64,$6A,$71,$77,$7D,$83,$8A,$90
.byte	$96,$9D,$A3,$A9,$AF,$B6,$BC,$C2

sin_lookup:
.byte	$00,$03,$06,$09,$0C,$0F,$12,$15,$18,$1C,$1F,$22,$25,$28,$2B,$2E
.byte	$30,$33,$36,$39,$3C,$3F,$41,$44,$47,$49,$4C,$4E,$51,$53,$55,$58
.byte	$5A,$5C,$5E,$60,$62,$64,$66,$68,$6A,$6C,$6D,$6F,$70,$72,$73,$74
.byte	$76,$77,$78,$79,$7A,$7B,$7C,$7C,$7D,$7E,$7E,$7F,$7F,$7F,$7F,$7F
.byte	$7F,$7F,$7F,$7F,$7F,$7F,$7E,$7E,$7D,$7C,$7C,$7B,$7A,$79,$78,$77
.byte	$76,$75,$73,$72,$70,$6F,$6D,$6C,$6A,$68,$66,$64,$63,$61,$5E,$5C
.byte	$5A,$58,$56,$53,$51,$4E,$4C,$49,$47,$44,$41,$3F,$3C,$39,$36,$34
.byte	$31,$2E,$2B,$28,$25,$22,$1F,$1C,$19,$16,$12,$0F,$0C,$09,$06,$03
.byte	$00,$FE,$FA,$F7,$F4,$F1,$EE,$EB,$E8,$E5,$E2,$DF,$DC,$D9,$D6,$D3
.byte	$D0,$CD,$CA,$C7,$C4,$C2,$BF,$BC,$BA,$B7,$B4,$B2,$AF,$AD,$AB,$A8
.byte	$A6,$A4,$A2,$A0,$9E,$9C,$9A,$98,$96,$95,$93,$91,$90,$8E,$8D,$8C
.byte	$8A,$89,$88,$87,$86,$85,$84,$84,$83,$82,$82,$81,$81,$81,$81,$81
.byte	$81,$81,$81,$81,$81,$81,$82,$82,$83,$84,$84,$85,$86,$87,$88,$89
.byte	$8A,$8B,$8D,$8E,$8F,$91,$93,$94,$96,$98,$99,$9B,$9D,$9F,$A1,$A4
.byte	$A6,$A8,$AA,$AD,$AF,$B1,$B4,$B6,$B9,$BC,$BE,$C1,$C4,$C7,$C9,$CC
.byte	$CF,$D2,$D5,$D8,$DB,$DE,$E1,$E4,$E7,$EA,$ED,$F0,$F4,$F7,$FA,$FD

