; bubble universe -- Apple II Hires

; original = 612 bytes
; clear screen:
;	bkgnd0 = $44198 = 278936 cycles = max ~4fps
;	new: $A616 = 42518 = max ~22fps
; hplot
;	hplot0 = ($14E-$15C) $14E = 334 * 1024 = 342016 = max ~3fps
;	lookup = 46 * 1024 = 47104 = max ~21fps


; after fast graphics
;	D7E77(??) = 884343 = 1.1fps
;	DD06E = (made J countdown, why longer?)
;	DB584 = destructive U when plotting
;	D57A2 = rotate right instead of left for HPLOT *32 (U)
;	D1D53 = same byt for V
;	C2679 = optimize sine, don't care about bottom byte in addition
;	AB2FC = optimize sine, keep H value in accumulator = 1.4fps
;	A9A38 = optimize cosine slightly
;	A50BF = use lookup table for sine sign (takes 256 more bytes)
;	9F673 = clear screen, only clear X region we use
;	9DD73 = clear screen, only clear Y region we use
;	906FE = inline/unroll the sines
;	817BE = inline/unroll the cosines
;	817A7 = inline clear screen (now no stack usage)
;	64987 = calc sine and cosine at same time = 2.5fps


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

	jsr	HGR
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

.include "hgr_clear_part.s"


	; FIXME: see value of X/Y/A after clear

	ldx	#0							; 2
	stx	I							; 3

outer_loop:

	;===========================================================
	; setup R*I to inner loop
	;	save NUM*4 (128) cycles at expense of 11 cycles

	ldx	I							; 3
	lda	rl,X							; 4
	sta	rl_smc+1						; 4

	; countdown NUM times

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

	; 8 cycles to always add 0 for high byte
	; since we're also copying can't save time by branching if no carry
	;	3 if no carry / 2+5=7 if carry for branch/check

	lda	#0							; 2
	adc	XH							; 3
	sta	RXH							; 3

no_rl_carry:

	; fixed_add(i,0,vh,vl,&ivh,&ivl);

	; precalc I+V for later use
	;	this is 8.8 fixed point so bottom byte of I is 0

;	clc			; C should be 0 from prev		;
	lda	VL							; 3
	sta	IVL							; 3
	lda	I							; 3
	adc	VH							; 3
	sta	IVH							; 3

	;=========================
	; U=SIN(I+V)+SIN(RR+X)
	; V=COS(I+V)+COS(RR+X)

	lda	IVL							; 3
	sta	STEMP1L							; 3
	lda	IVH							; 3

.include "sin_unrolled.s"

	lda	sin_table_low,X						; 4
	sta	UL							; 3
	lda	sin_table_high,X					; 4
	sta	UH							; 3

	txa
	clc
	adc	#64
	tax

	lda	sin_table_low,X						; 4
	sta	VL							; 3
	lda	sin_table_high,X					; 4
	sta	VH							; 3


	lda	RXL							; 3
	sta	STEMP1L							; 3
	lda	RXH							; 3

.include "sin_unrolled.s"

	clc
	lda	UL
	adc	sin_table_low,X
	sta	UL
	lda	UH
	adc	sin_table_high,X
	sta	UH

	txa
	clc
	adc	#64
	tax

.if 0
	; 1.57 is roughly 0x0192 in 8.8
	clc								; 2
	lda	IVL							; 3
	adc	#$92							; 2
	sta	STEMP1L							; 3

	lda	IVH							; 4
	adc	#1							; 2

.include "sin_unrolled.s"
	lda	sin_table_low,X						; 4
	sta	OUT1L							; 3
	lda	sin_table_high,X					; 4
	sta	OUT1H							; 3


	; 1.57 is roughly 0x0192 in 8.8
	clc								; 2
	lda	RXL							; 3
	adc	#$92							; 2
	sta	STEMP1L							; 3
	lda	RXH							; 3
	adc	#1							; 2

.include "sin_unrolled.s"
.endif

	clc
	lda	VL
	adc	sin_table_low,X
	sta	VL
	lda	VH
	adc	sin_table_high,X
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

	inc	I							; 5
	lda	I							; 3
	cmp	#NUM							; 2
	beq	done_i							; 2/3
	jmp	outer_loop						; 3
done_i:

	; t=t+(1.0/32.0);
	;  1/2 1/4 1/8 1/16 | 1/32 1/64 1/128 1/256
	;	$0x08

	; carry always set here as we got here from a BEQ
	; 	(bcs=bge, bcc=blt)

	lda	TL							; 3
	adc	#$7	; really 8, carry always set			; 2
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

;.include "hgr_clear_part.s"
.include "hgr_table.s"

.align $100
sin_table_low:
	.byte	$00,$06,$0C,$12,$19,$1F,$25,$2B,$31,$38,$3E,$44,$4A,$50,$56,$5C
	.byte	$61,$67,$6D,$73,$78,$7E,$83,$88,$8E,$93,$98,$9D,$A2,$A7,$AB,$B0
	.byte	$B4,$B9,$BD,$C1,$C5,$C9,$CD,$D1,$D4,$D8,$DB,$DE,$E1,$E4,$E7,$E9
	.byte	$EC,$EE,$F0,$F3,$F4,$F6,$F8,$F9,$FB,$FC,$FD,$FE,$FE,$FF,$FF,$FF
	.byte	$FF,$FF,$FF,$FF,$FE,$FE,$FD,$FC,$FB,$F9,$F8,$F6,$F5,$F3,$F1,$EE
	.byte	$EC,$EA,$E7,$E4,$E1,$DE,$DB,$D8,$D5,$D1,$CD,$C9,$C6,$C2,$BD,$B9
	.byte	$B5,$B0,$AC,$A7,$A2,$9D,$98,$93,$8E,$89,$83,$7E,$78,$73,$6D,$68
	.byte	$62,$5C,$56,$50,$4A,$44,$3E,$38,$32,$2C,$25,$1F,$19,$13,$0C,$06
	.byte	$00,$FB,$F4,$EE,$E8,$E2,$DB,$D5,$CF,$C9,$C3,$BD,$B7,$B1,$AB,$A5
	.byte	$9F,$99,$93,$8E,$88,$83,$7D,$78,$73,$6D,$68,$63,$5E,$5A,$55,$50
	.byte	$4C,$47,$43,$3F,$3B,$37,$33,$30,$2C,$29,$25,$22,$1F,$1C,$19,$17
	.byte	$14,$12,$10,$0E,$0C,$0A,$08,$07,$06,$04,$03,$02,$02,$01,$01,$01
	.byte	$01,$01,$01,$01,$02,$02,$03,$04,$05,$07,$08,$0A,$0B,$0D,$0F,$11
	.byte	$14,$16,$19,$1C,$1E,$21,$25,$28,$2B,$2F,$32,$36,$3A,$3E,$42,$47
	.byte	$4B,$4F,$54,$59,$5E,$62,$67,$6C,$72,$77,$7C,$82,$87,$8D,$92,$98
	.byte	$9E,$A4,$AA,$AF,$B5,$BB,$C2,$C8,$CE,$D4,$DA,$E0,$E7,$ED,$F3,$F9
sin_table_high:
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte	$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

rl:
.byte	$00,$06,$0C,$12,$19,$1F,$25,$2B
.byte	$32,$38,$3E,$45,$4B,$51,$57,$5E
.byte	$64,$6A,$71,$77,$7D,$83,$8A,$90
.byte	$96,$9D,$A3,$A9,$AF,$B6,$BC,$C2

log_lookup:
	.byte $81,$82,$84,$88,$90,$A0,$C0,$80

