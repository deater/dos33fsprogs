; bubble universe -- Apple II Hires

; by Vince `deater` Weaver
; based roughly on the BASIC code posted on the pouet forum
; original effect by yuruyrau on twitter

; original, unoptimized implementation = 612 bytes
; fast version = 2152 bytes (could probably fit in 2k if we generate SINE table)

; Fast hi-res pixel notes (Apple II hi-res graphics pain is
;	a bit much to get into here)

; clear screen routine:
;	ROM built-in:    BKGND0 = $44198 = 278936 cycles = max ~4fps
;	hand-optimized:            $A616 =  42518 cycles = max ~22fps
;       final version faster, only clears the 128x128 part of the screen we use

; hplot (plot pixel) routine, plot 32x32=1024 points
;	ROM HPLOT0 = ($14E-$15C) $14E = 334 * 1024 = 342016 = max ~3fps
;	hand-optimized                =  46 * 1024 =  47104 = max ~21fps


; after fast graphics, for I=32,J=32
;	cycle count (for frame0, from Applewin)
;	~~~~~~~~~~~~
;	D7E77(??) = 884343 = 1.1fps
;	DD06E = (made J countdown, why longer?)
;	DB584 = destructive U when plotting
;	D57A2 = rotate right instead of left for HPLOT *32 (U)
;	D1D53 = same but for V
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
;	61827 = remove unnecessary stores
;	5D7EF = add a cosine table
;	5CFBE = move TL/TH out of zero page
;	5C353 = put UL in Y = ~2.6fps

; NUM (I,J)=24	35CD3 = ~4.5fps
; NUM (I,J)=16	1A2DD = ~9 fps

; soft-switches

;KEYPRESS	= $C000
;KEYRESET	= $C010
PAGE1		= $C054
PAGE2		= $C055

; ROM routines

BKGND0		= $F3F4         ; clear current page to A
HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
HPLOT0		= $F457		; plot at (Y,X), (A)
;HLINRL		= $F530		; line to (X,A), (Y)
;HCOLOR1	= $F6F0		; set HGR_COLOR to value in X
;COLORTBL	= $F6F6
;WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

; zero page

GBASL		= $26
GBASH		= $27


HPLOTYL		= $92

RXL		= $96
RXH		= $97
STEMP1L		= $98
STEMP1H		= $99
STEMP2L		= $9A


I		= $D0
J		= $D1
XL		= $D2
XH		= $D3
VL		= $D4
VH		= $D5
;TL		= $D6
;TH		= $D7
UL		= $D8
UH		= $D9

HGR_PAGE	= $E6

; const

;NUM		= 32
NUM		= 24

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
;	sta	TL
;	sta	TH

	;=========================
	;=========================
	; main loop
	;=========================
	;=========================

next_frame:

	;===========================
	; "fast" clear screen

.include "hgr_clear_part.s"


	; TODO: see if value of X/Y/A useful after clear

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

	;=======================================
	; precalc I+V for later use
	; IV=I+V
	;	this is 8.8 fixed point so bottom byte of I is 0

;	clc			; C should be 0 from prev		;
	lda	VL							; 3
	sta	STEMP1L		; store IVL directly in sine input	; 3
	lda	I							; 3
	adc	VH		; IVH is in A for sine			; 3

	;=========================
	; U=SIN(I+V)+SIN(RR+X)
	; V=COS(I+V)+COS(RR+X)

	; calc SIN(I+V)	in STEMP1L/A

	; / 6.28	is roughly the same as *0.16
	;               = .5 .25 .125 .0625 .03125
	; 1/6.28 = 0.16 =  0 0    1   0       1 0 0 0 = 0x28

	; i=(i*0x28)>>8;

	; A has STEMP1H


	; 01234567 89ABCDEF

	;   3456789A
	; + 56789ABC
	;=============

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

	; tradeoff size for speed by having lookup
	;	table for sign bits
	;	the sign lookup only saves like 2 cycles


	;==========================
	; U=sin(IV)

	lda	sin_table_low,X						; 4
	sta	UL							; 3
	lda	sin_table_high,X					; 4
	sta	UH							; 3

	;===========================
	; V=sin(IV)

	lda	cos_table_low,X						; 4
	sta	VL							; 3
	lda	cos_table_high,X					; 4
	sta	VH							; 3

	lda	RXL							; 3
	sta	STEMP1L							; 3
	lda	RXH							; 3

	;=======================

	; / 6.28	is roughly the same as *0.16
	;               = .5 .25 .125 .0625 .03125
	; 1/6.28 = 0.16 =  0 0    1   0       1 0 0 0 = 0x28

	; i=(i*0x28)>>8;

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

	; tradeoff size for speed by having lookup
	;	table for sign bits
	;	the sign lookup only saves like 2 cycles

	;=====================
	; U+=sin(RX)

	clc								; 2
	lda	UL							; 3
	adc	sin_table_low,X						; 4
	tay			; UL in Y				; 2
;	sta	UL							; 3
	lda	UH							; 3
	adc	sin_table_high,X					; 4
	sta	UH							; 3

	;================
	; V+=cos(RX)

	clc								; 2
	lda	VL							; 3
	adc	cos_table_low,X						; 4+
	sta	VL							; 3
	lda	VH							; 3
	adc	cos_table_high,X					; 4+
	sta	VH							; 3

	; X=U+T
	clc								; 2
;	lda	UL							; 3
	tya		; UL in Y					; 2
tl_smc:
	adc	#0							; 2
	sta	XL							; 3
	lda	UH							; 3
th_smc:
	adc	#0							; 2
	sta	XH							; 3

	;===========================================================
	; HPLOT 32*U+140,32*V+96

	; U can be destroyed as we don't use it again

	; 01234567 89ABCDEF

	; 56789ABC DEF00000

	; we want 56789ABC, rotate right by 3 is two iterations faster?

	tya		; UL in Y					; 2

;	lda	UL							; 3

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

	; Apple II hi-res is more-or-less 280x192
	;	two consecutive pixels on are white
	;	single pixels are colored based on palette
	;	we treat things as a monochrome display, on a color
	;	display odd/even pixels will have different colors

	; The Y memory offset is a horrible interleaved mess, so we use
	;	a lookup table we generated at start.  We also add in
	;	the proper value for page-flipping

	; Apple II hi-res is 7 pixels/byte, so we also pre-generate
	;	div and mod by 7 tables at start and use those
	;	instead of dividing by 7
	;	We cheat and don't worry about the X positions larger
	;	than 256 because our algorithm only goes up to 208

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
	; get current 7-bit pixel range, OR in to set new pixel

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

	lda	tl_smc+1						; 4
	adc	#$7	; really 8, carry always set			; 2
	sta	tl_smc+1						; 4
	lda	#0							; 2
	adc	th_smc+1						; 4
	sta	th_smc+1						; 4

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

.include "hgr_table.s"

	; we could calculate these, or else build them from
	;	a 0..pi/2 table to save a lot of space

	; the alignment was there to potentially save cycles on page
	;	crossing.  Maybe not as useful that the cosine
	;	goes off the page
.align $100
sin_table_low:
	.byte	$00,$06,$0C,$12,$19,$1F,$25,$2B,$31,$38,$3E,$44,$4A,$50,$56,$5C
	.byte	$61,$67,$6D,$73,$78,$7E,$83,$88,$8E,$93,$98,$9D,$A2,$A7,$AB,$B0
	.byte	$B4,$B9,$BD,$C1,$C5,$C9,$CD,$D1,$D4,$D8,$DB,$DE,$E1,$E4,$E7,$E9
	.byte	$EC,$EE,$F0,$F3,$F4,$F6,$F8,$F9,$FB,$FC,$FD,$FE,$FE,$FF,$FF,$FF
cos_table_low:
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
cos_table_low_tail:
	.byte	$00,$06,$0C,$12,$19,$1F,$25,$2B,$31,$38,$3E,$44,$4A,$50,$56,$5C
	.byte	$61,$67,$6D,$73,$78,$7E,$83,$88,$8E,$93,$98,$9D,$A2,$A7,$AB,$B0
	.byte	$B4,$B9,$BD,$C1,$C5,$C9,$CD,$D1,$D4,$D8,$DB,$DE,$E1,$E4,$E7,$E9
	.byte	$EC,$EE,$F0,$F3,$F4,$F6,$F8,$F9,$FB,$FC,$FD,$FE,$FE,$FF,$FF,$FF

.align $100

sin_table_high:
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
cos_table_high:
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
cos_table_high_tail:
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

	; pre-calc table for R*I
	; note this would be easy to calculate at startup
	; to save space
rl:
.byte	$00,$06,$0C,$12,$19,$1F,$25,$2B
.byte	$32,$38,$3E,$45,$4B,$51,$57,$5E
.byte	$64,$6A,$71,$77,$7D,$83,$8A,$90
.byte	$96,$9D,$A3,$A9,$AF,$B6,$BC,$C2

	; which of 7 pixels to draw
	; note high bit is set to pick blue/orange palette
	; clear to get purple/green instead
log_lookup:
	.byte $81,$82,$84,$88,$90,$A0,$C0,$80

