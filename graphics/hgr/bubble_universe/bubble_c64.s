; bubble universe -- Apple II Hires

; by Vince `deater` Weaver
; based roughly on the BASIC code posted on the pouet forum
; original effect by yuruyrau on twitter

; this version based on fast c64 code

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


IC		= $D0
J		= $D1
XL		= $D2
XH		= $D3
;VL		= $D4
;VH		= $D5
;TL		= $D6
T		= $D7
U		= $D8
V		= $D9

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
	sta	U
	sta	V
	sta	T


	;=========================
	;=========================
	; main loop
	;=========================
	;=========================

next_frame:

	;===========================
	; "fast" clear screen

.include "hgr_clear_part.s"

	lda	T
	sta	IT1
	sta	IT2
	lda	#0
	sta	IS1
	sta	IS2
	lda	#24	; 40
	sta	IC
	ldx	U
	ldy	V
i_loop:
	lda	#24	; 200
	sta	J
j_loop:
	clc			; 2
IS1 = *+1
	lda	sin_t,Y		; 4+
IT1 = *+1
	adc	sin_t,X		; 4+
	sta	U		; 3
IS2 = *+1
	lda	cos_t,Y		; 4+
IT2 = *+1
	adc	cos_t,X		; 4+
	tay			; 2 = 23-27 cycles

	sty	V

	;===========================================================
	; HPLOT 32*U+140,32*V+96


	lda	U
	clc								; 2
	adc	#140							; 2
	tax								; 2

	; calculate Ypos

	lda	V
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

	dec	J
	bne	j_loop

;	dec	J							; 5
;	bmi	done_j							; 2/3
;	jmp	inner_loop						; 3
;	bpl	inner_loop
done_j:

	lda	IS1
	clc
	adc	#41
	sta	IS1
	sta	IS2
	dec	IC
	bne	i_loop





;	inc	I							; 5
;	lda	I							; 3
;	cmp	#NUM							; 2
;	beq	done_i							; 2/3
;	jmp	outer_loop						; 3
;done_i:

	; t=t+(1.0/32.0);
	;  1/2 1/4 1/8 1/16 | 1/32 1/64 1/128 1/256
	;	$0x08

	; carry always set here as we got here from a BEQ
	; 	(bcs=bge, bcc=blt)

;	lda	tl_smc+1						; 4
;	adc	#$7	; really 8, carry always set			; 2
;	sta	tl_smc+1						; 4
;	lda	#0							; 2
;	adc	th_smc+1						; 4
;	sta	th_smc+1						; 4

	sty	V
	inc	T
;	jmp	new_frame

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


	; which of 7 pixels to draw
	; note high bit is set to pick blue/orange palette
	; clear to get purple/green instead
log_lookup:
	.byte $81,$82,$84,$88,$90,$A0,$C0,$80

sin_t:
	.byte	$0F,$0E,$0D,$0D,$0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08,$08,$07
	.byte	$07,$07,$06,$06,$06,$06,$06,$06,$05,$05,$05,$05,$05,$05,$05,$05
	.byte	$05,$06,$06,$06,$06,$06,$06,$07,$07,$07,$08,$08,$08,$09,$09,$0A
	.byte	$0A,$0B,$0B,$0C,$0C,$0D,$0D,$0E,$0F,$0F,$10,$10,$11,$12,$13,$13
	.byte	$14,$15,$16,$17,$17,$18,$19,$1A,$1B,$1C,$1D,$1D,$1E,$1F,$20,$21
	.byte	$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F,$30,$31
	.byte	$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$3F,$40
	.byte	$41,$42,$43,$44,$45,$45,$46,$47,$48,$49,$49,$4A,$4B,$4C,$4C,$4D
	.byte	$4D,$4E,$4F,$4F,$50,$50,$51,$51,$52,$52,$53,$53,$54,$54,$54,$55
	.byte	$55,$55,$56,$56,$56,$56,$56,$56,$57,$57,$57,$57,$57,$57,$57,$57
	.byte	$57,$56,$56,$56,$56,$56,$56,$55,$55,$55,$54,$54,$54,$53,$53,$52
	.byte	$52,$51,$51,$50,$50,$4F,$4F,$4E,$4D,$4D,$4C,$4C,$4B,$4A,$49,$49
	.byte	$48,$47,$46,$45,$45,$44,$43,$42,$41,$40,$3F,$3F,$3E,$3D,$3C,$3B
	.byte	$3A,$39,$38,$37,$36,$35,$34,$33,$32,$31,$30,$2F,$2E,$2D,$2C,$2B
	.byte	$2A,$29,$28,$27,$26,$25,$24,$23,$22,$21,$20,$1F,$1E,$1D,$1D,$1C
	.byte	$1B,$1A,$19,$18,$17,$17,$16,$15,$14,$13,$13,$12,$11,$10,$10,$0F
cos_t:
	.byte	$14,$15,$16,$17,$17,$18,$19,$1A,$1B,$1C,$1D,$1D,$1E,$1F,$20,$21
	.byte	$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F,$30,$31
	.byte	$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$3F,$40
	.byte	$41,$42,$43,$44,$45,$45,$46,$47,$48,$49,$49,$4A,$4B,$4C,$4C,$4D
	.byte	$4D,$4E,$4F,$4F,$50,$50,$51,$51,$52,$52,$53,$53,$54,$54,$54,$55
	.byte	$55,$55,$56,$56,$56,$56,$56,$56,$57,$57,$57,$57,$57,$57,$57,$57
	.byte	$57,$56,$56,$56,$56,$56,$56,$55,$55,$55,$54,$54,$54,$53,$53,$52
	.byte	$52,$51,$51,$50,$50,$4F,$4F,$4E,$4D,$4D,$4C,$4C,$4B,$4A,$49,$49
	.byte	$48,$47,$46,$45,$45,$44,$43,$42,$41,$40,$3F,$3F,$3E,$3D,$3C,$3B
	.byte	$3A,$39,$38,$37,$36,$35,$34,$33,$32,$31,$30,$2F,$2E,$2D,$2C,$2B
	.byte	$2A,$29,$28,$27,$26,$25,$24,$23,$22,$21,$20,$1F,$1E,$1D,$1D,$1C
	.byte	$1B,$1A,$19,$18,$17,$17,$16,$15,$14,$13,$13,$12,$11,$10,$10,$0F
	.byte	$0F,$0E,$0D,$0D,$0C,$0C,$0B,$0B,$0A,$0A,$09,$09,$08,$08,$08,$07
	.byte	$07,$07,$06,$06,$06,$06,$06,$06,$05,$05,$05,$05,$05,$05,$05,$05
	.byte	$05,$06,$06,$06,$06,$06,$06,$07,$07,$07,$08,$08,$08,$09,$09,$0A
	.byte	$0A,$0B,$0B,$0C,$0C,$0D,$0D,$0E,$0F,$0F,$10,$10,$11,$12,$13,$13
