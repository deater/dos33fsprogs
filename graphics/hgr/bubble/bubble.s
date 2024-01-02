; bubble universe -- Apple II Hires

; original = 612 bytes
; clear screen:
;	bkgnd0 = $44198 = 278936 cycles = max ~4fps
;	new: $A616 = 42518 = max ~22fps
; hplot
;	hplot0 = ($14E-$15C) $14E = 334 * 1024 = 342016 = max ~3fps
;	lookup = 46 * 1024 = 47104 = max ~21fps


; after fast graphics
;	D7E77 = 884343 = 1.1fps
;	DD06E = ?? (made J countdown, why longer?)
;	DB584 = destructive U when plotting
;	D57A2 = rotate right instead of left for HPLOT *32 (U)
;	D1D53 = same byt for V
;	C2679 = optimize sine, don't care about bottom byte in addition
;	AB2FC = optimize sine, keep H value in accumulator = 1.4fps
;	A9A38 = optimize cosine slightly
;		TODO: separate lookup table for sign
;		TODO: inline/unroll sine/cosine calls

; soft-switches

KEYPRESS	= $C000
KEYRESET	= $C010
PAGE1		= $C054
PAGE2		= $C055

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

GBASL		= $26
GBASH		= $27


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

	;========================
	; setup lookup tables

	jsr	hgr_make_tables

	;=======================
	; init graphics

	jsr	HGR2

	;=======================
	; init variables

	lda	#0
	sta	XL
	sta	XH
	sta	VL
	sta	VH
	sta	TL
	sta	TH

	;=========================
	;=========================
	; main loop
	;=========================
	;=========================

next_frame:

	;===========================
	; "fast" clear screen
	; inline to save 12 cycles

	jsr	hgr_clear_screen

	ldx	#0							; 2
	stx	I							; 3

outer_loop:

	; setup R*I to inner loop
	;	save NUM*4 (128) cycles at expense of 11 cycles

	ldx	I							; 3
	lda	rl,X							; 4
	sta	rl_smc+1						; 4

	ldx	#NUM							; 2
	stx	J							; 3

inner_loop:

	; fixed_add(rh[i],rl[i],xh,xl,&rxh,&rxl);
	; note: rh is always 0

	; pre-calc (R*I)+X for later use

	clc								; 2
rl_smc:
	lda	#0		; R*I					; 2
	adc	XL							; 3
	sta	RXL							; 3
	lda	#0							; 2
	adc	XH							; 3
	sta	RXH							; 3

	; fixed_add(i,0,vh,vl,&ivh,&ivl);

	; precalc I+V for later use
	;	this is 8.8 fixed point so bottom byte of I is 0

;	clc			; C should be 0 from prev		;
	lda	VL							; 3
	sta	IVL							; 3
	lda	I							; 3
	adc	VH							; 3
	sta	IVH							; 3

	; U=SIN(I+V)+SIN(RR+X)

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
	clc								; 2
	lda	UL							; 3
	adc	TL							; 3
	sta	XL							; 3
	lda	UH							; 3
	adc	TH							; 3
	sta	XH							; 3

	; HPLOT 32*U+140,32*V+96

	; U can be destroyed as we don't use it again?

	; 01234567 89ABCDEF

	; 56789ABC DEF00000

	; we want 56789ABC, rotate right by 3 is two iterations faster?

	lda	UL							; 3

	lsr	UH							; 5
	ror								; 2

	lsr	UH							; 5
	ror								; 2

	lsr	UH							; 5
	ror								; 2

	clc								; 2
	adc	#140							; 2
	tax								; 2

	; calculate Ypos

	lda	VH
	sta	HPLOTYL
	lda	VL

	lsr	HPLOTYL
	ror

	lsr	HPLOTYL
	ror

	lsr	HPLOTYL
	ror

	clc
	adc	#96

	; "fast" hplot, Xpos in X, Ypos in A

	tay								; 2
	lda	hposn_low,Y						; 4
	sta	GBASL							; 3
	clc								; 2
	lda	hposn_high,Y						; 4
	adc	HGR_PAGE						; 3
	sta	GBASH							; 3
; 21

	ldy	div7_table,X						; 4

	lda	mod7_table,X						; 4
	tax								; 2
; 31
	lda	(GBASL),Y						; 5
	ora	log_lookup,X						; 4
	sta	(GBASL),Y						; 6
; 46

	dec	J							; 5
	bmi	done_j							; 2/3
	jmp	inner_loop						; 3
;	bpl	inner_loop
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

	; TODO: is CLC necessary? (bcs=bge, bcc=blt)
	;	carry always set here

	clc								; 2
	lda	TL							; 3
	adc	#$8							; 2
	sta	TL							; 3
	lda	#0							; 2
	adc	TH							; 3
	sta	TH							; 3

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

	lda	IVL,Y		; note, uses absolute as no ZP equiv	; 4
	sta	STEMP1L							; 3
	lda	IVH,Y							; 4
already_loaded:
	; A has STEMP1H

	; i2=i<<3;


	asl	STEMP1L							; 5
	rol								; 2
	asl	STEMP1L							; 5
	rol								; 2
	asl	STEMP1L							; 5
	rol								; 2

	; i1=i<<5;

	ldx	STEMP1L							; 3
	stx	STEMP2L							; 3

	sta	STEMP1H							; 3

	asl	STEMP2L							; 5
	rol								; 2
	asl	STEMP2L							; 5
	rol								; 2

	; i=(i1+i2)>>8;

	; We ignore the low byte as we don't need it
	; possibly inaccurate as we don't clear carry?

	adc	STEMP1H							; 2
	tax								; 2

	; sl=fsinh[i];

	; TODO: tradeoff size for speed by having lookup
	;	table for sign bits

	lda	sin_lookup,X						; 4+
	asl								; 2
	sta	OUT1L,Y							; 5

	bcs	sin_negative						; 2/3
sin_positive:
	lda	#$0							; 2
	beq	set_sin_sign			; bra			; 3
sin_negative:
	lda	#$FF							; 2
set_sin_sign:
	sta	OUT1H,Y							; 5

	rts								; 6

	;=============================
cos:
	; 1.57 is roughly 0x0192 in 8.8

	clc								; 2
	lda	IVL,Y							; 4
	adc	#$92							; 2
	sta	STEMP1L							; 3

	lda	IVH,Y							; 4
	adc	#1							; 2
;	sta	STEMP1H							; 3

	jmp	already_loaded						; 3


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

log_lookup:
	.byte $81,$82,$84,$88,$90,$A0,$C0,$80

.include "hgr_clear_screen.s"
.include "hgr_table.s"
