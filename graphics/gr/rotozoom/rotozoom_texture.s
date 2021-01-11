
	; rotozoomer!
	; with 16x16 texture

	; takes a lores-formatted image in $c00 and rotozooms it
	;	by ANGLE and SCALE_I/SCALE_F and draws it to the
	;	lo-res page in DRAW_PAGE

	; ANGLE in our case is 0..31
	; SCALE_I/SCALE_F is 8.8 fixed point scale multiplier


; $2E7CF = 190,415 = 5.25fps	first merging
; $2D8CF = 186,575 = 5.35fps	move mask to rotate not draw
; $29CCF = 171,215 = 5.84fps	do color conversion outside of loop
; $28DCF = 167,375 = 5.97fps	two lookup tables for hi/low
; $26FCF = 159,695 = 6.26fps	remove carry set/clear for fixed point adds

CAL	= $B0
CAH	= $B1
SAL	= $B2
SAH	= $B3
YPL	= $B4
YPH	= $B5
XPL	= $B6
XPH	= $B7
;YY
;XX
CCAL	= $B8
CCAH	= $B9
CSAL	= $BA
CSAH	= $BB
YCAL	= $BC
YCAH	= $BD
YSAL	= $BE
YSAH	= $BF

rotozoom:

	; setup scale for multiply

	lda	SCALE_I							; 3
	sta	NUM1H							; 3
	lda	SCALE_F							; 3
	sta	NUM1L							; 3

	; ca = cos(theta)*scale;
	;      (we use equiv ca=fixed_sin[(theta+8)&0xf] )

	lda	ANGLE							; 3
	clc								; 2
	adc	#16							; 2
	and	#$3f							; 2
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y	; load integer half			; 4
	sta	NUM2H							; 3
	lda	fixed_sin+1,Y	; load float half			; 4
	sta	NUM2L							; 3
								;===========
								;	27

	sec			; reload NUM1H/NUM1L			; 2
	jsr	multiply						; 6+???
	stx	CAH							; 3
	sta	CAL							; 3


	; sa = sin(theta)*scale;

	lda	ANGLE							; 3
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y	; load integer half			; 4
	sta	NUM2H							; 3
	lda	fixed_sin+1,Y	; load integer half			; 4
	sta	NUM2L							; 3
								;==========
								;	21


	clc			; NUM1H/NUM1L same as last time		; 2
	jsr	multiply						; 6+???

	stx	SAH							; 3
	sta	SAL							; 3


	; cca = -20*ca;

	lda	#-20							; 2
	sta	NUM1H							; 3
	lda	#0							; 2
	sta	NUM1L							; 3

	lda	CAL							; 3
	sta	NUM2L							; 3
	lda	CAH							; 3
	sta	NUM2H							; 3

	sec			; reload NUM1H/NUM1L			; 2
	jsr	multiply						; 6+???
	stx	CCAH							; 3
	sta	CCAL							; 3


	; csa = -20*sa;

	lda	SAL							; 3
	sta	NUM2L							; 3
	lda	SAH							; 3
	sta	NUM2H							; 3

	clc			; same NUM1H/NUM1L as las time		; 2
	jsr	multiply						; 6+???

	stx	CSAH							; 3
	sta	CSAL							; 3


	; yca=cca+ycenter;

	lda	CCAL							; 3
	sta	YCAL							; 3
	clc								; 2
	lda	CCAH							; 3
	adc	#20							; 2
	sta	YCAH							; 3
								;===========
								;	16
	; ysa=csa+xcenter;

	lda	CSAL							; 3
	sta	YSAL							; 3
	clc								; 2
	lda	CSAH							; 3
	adc	#20							; 2
	sta	YSAH							; 3
								;===========
								;	16

	; yloop, unrolled once
	;===================================================================
	; for(yy=0;yy<40;yy++) {
	;===================================================================

	ldy	#0							; 2
	sty	YY							; 3

rotozoom_yloop:

	; setup self-modifying code for plot
	; YY already in Y from end of loop
;	ldy	YY							; 3

	lda	common_offsets_l,Y	; lookup low-res memory address	; 4
	sta	rplot2_smc+1						; 4
	sta	rplot12_smc+1						; 4
	sta	rplot22_smc+1						; 4

	clc								; 2
	lda	gr_400_offsets_h,Y					; 4
	adc	DRAW_PAGE	; add in draw page offset		; 3
	sta	rplot2_smc+2						; 4
	sta	rplot12_smc+2						; 4
	sta	rplot22_smc+2						; 4



;=====================
; unroll 0, even line
;=====================


	; xp=cca+ysa;	8.8 fixed point
	clc								; 2
	lda	YSAL							; 3
	adc	CCAL							; 3
	sta	XPL							; 3
	lda	YSAH							; 3
	adc	CCAH							; 3
	sta	XPH							; 3
								;==========
								;	20

	; yp=yca-csa;	8.8 fixed point

	sec								; 2
	lda	YCAL							; 3
	sbc	CSAL							; 3
	sta	YPL							; 3
	lda	YCAH							; 3
	sbc	CSAH							; 3
	sta	YPH							; 3
								;===========
								;	20



        ; for(xx=0;xx<40;xx++) {
	ldx	#0							; 2
rotozoom_xloop:



	;===================================================================
	;===================================================================
	; note: every cycle saved below here
	;       saves 1600 cycles
	;===================================================================
	;===================================================================


	lda	XPH			; 3
	and	#$f			; 2
	sta	CTEMP			; 3

	lda	YPH			; 3
	asl				; 2
	asl				; 2
	asl				; 2
	asl				; 2
	clc				; 2
	adc	CTEMP			; 3
	tay				; 2

	lda	low_lookup,Y		; 4

				;============
				;	30
rscrn_done:



;=============================================


; always even, want A in bottom of nibble
; so we are all set

rotozoom_set_color:
	; want same color in top and bottom nibbles
								;==========
								;	0

;=================================================

rplot:

	; plot(xx,yy);	(color is in A)

	; we are in loop unroll0 so always even line here

	; meaning we want to load old color, save top nibble, and over-write
	; bottom nibble with our value

	; but! we don't need to save old as we are re-drawing whole screen!

rplot_even:

rplot2_smc:
	sta	$400,X							; 5
								;============
								;	5

;=======================

	; xp=xp+ca;	fixed point 8.8

; always set?  also low importance LSB
;	clc								; 2
	lda	CAL							; 3
	adc	XPL							; 3
	sta	XPL							; 3
	lda	CAH							; 3
	adc	XPH							; 3
	sta	XPH							; 3

	; yp=yp-sa;	fixed point 8.8

; low importance LSB?
;	sec								; 2
	lda	YPL							; 3
	sbc	SAL							; 3
	sta	YPL							; 3
	lda	YPH							; 3
	sbc	SAH							; 3
	sta	YPH							; 3

rotozoom_end_xloop:
	inx								; 2
	cpx	#40							; 2
	bne	rotozoom_xloop						; 2nt/3
rotozoom_xloop_done:



	; yca+=ca;	8.8 fixed point

	clc								; 2
	lda	YCAL							; 3
	adc	CAL							; 3
	sta	YCAL							; 3
	lda	YCAH							; 3
	adc	CAH							; 3
	sta	YCAH							; 3
								;===========
								;	20

	; ysa+=sa;	8.8 fixed point

	clc								; 2
	lda	YSAL							; 3
	adc	SAL							; 3
	sta	YSAL							; 3
	lda	YSAH							; 3
	adc	SAH							; 3
	sta	YSAH							; 3
								;==========
								;	20


;===============
; loop unroll 1
;===============

;rotozoom_yloop:

	; xp=cca+ysa;	8.8 fixed point
	clc								; 2
	lda	YSAL							; 3
	adc	CCAL							; 3
	sta	XPL							; 3
	lda	YSAH							; 3
	adc	CCAH							; 3
	sta	XPH							; 3
								;==========
								;	20

	; yp=yca-csa;	8.8 fixed point

	sec								; 2
	lda	YCAL							; 3
	sbc	CSAL							; 3
	sta	YPL							; 3
	lda	YCAH							; 3
	sbc	CSAH							; 3
	sta	YPH							; 3
								;===========
								;	20

        ; for(xx=0;xx<40;xx++) {
	ldx	#0							; 2
rotozoom_xloop2:



	;===================================================================
	;===================================================================
	; note: every cycle saved below here
	;       saves 1600 cycles
	;===================================================================
	;===================================================================

	; if ((xp<0) || (xp>39)) color=0;
	; else if ((yp<0) || (yp>39)) color=0;
	; else color=scrn_page(xp,yp,PAGE2);

	; we know it's never going to go *that* far out of bounds
	;	so we could avoid the Y check by just having "0"
	;	on the edges of the screen?  Tricky due to Apple II
	;	interlacing

	lda	XPH
	and	#$f
	sta	CTEMP

	lda	YPH
	asl
	asl
	asl
	asl
	clc
	adc	CTEMP
	tay

	lda	high_lookup,Y
;	and	#$f0

;=============================================


rotozoom_set_color2:
	; always odd
	; want color in top, which it is from above
								;==========
								;	0

;=================================================

rplot2:

	; plot(xx,yy);	(color is in A)

	; always odd, so place color in top

	; note!  since we are drawing whole screen, we know the top of
	; the value is already clear from loop=0 so we don't have to mask

rplot_odd:
rplot12_smc:
	ora	$400,X							; 4
rplot22_smc:
	sta	$400,X							; 5

								;============
								;	9

;=======================

	; xp=xp+ca;	8.8 fixed point

;	clc								; 2
	lda	CAL							; 3
	adc	XPL							; 3
	sta	XPL							; 3
	lda	CAH							; 3
	adc	XPH							; 3
	sta	XPH							; 3

	; yp=yp-sa;	8.8 fixed point

;	sec								; 2
	lda	YPL							; 3
	sbc	SAL							; 3
	sta	YPL							; 3
	lda	YPH							; 3
	sbc	SAH							; 3
	sta	YPH							; 3

rotozoom_end_xloop2:
	inx								; 2
	cpx	#40							; 2
	bne	rotozoom_xloop2						; 3
rotozoom_xloop_done2:

	; yca+=ca;		8.8 fixed point

	clc								; 2
	lda	YCAL							; 3
	adc	CAL							; 3
	sta	YCAL							; 3
	lda	YCAH							; 3
	adc	CAH							; 3
	sta	YCAH							; 3
								;===========
								;	20

	; ysa+=sa;		8.8 fixed point

	clc								; 2
	lda	YSAL							; 3
	adc	SAL							; 3
	sta	YSAL							; 3
	lda	YSAH							; 3
	adc	SAH							; 3
	sta	YSAH							; 3
								;==========
								;	20

rotozoom_end_yloop:
	inc	YY							; 5
	ldy	YY							; 3
	cpy	#24							; 2
	beq	done_rotozoom						; 2nt/3
	jmp	rotozoom_yloop	; too far				; 3

done_rotozoom:
	rts								; 6



fixed_sin:
;	.byte $00,$00 ;  0.000000=00.00
;	.byte $00,$61 ;  0.382683=00.61
;	.byte $00,$b5 ;  0.707107=00.b5
;	.byte $00,$ec ;  0.923880=00.ec
;	.byte $01,$00 ;  1.000000=01.00
;	.byte $00,$ec ;  0.923880=00.ec
;	.byte $00,$b5 ;  0.707107=00.b5
;	.byte $00,$61 ;  0.382683=00.61
;	.byte $00,$00 ;  0.000000=00.00
;	.byte $ff,$9f ; -0.382683=ff.9f
;	.byte $ff,$4b ; -0.707107=ff.4b
;	.byte $ff,$14 ; -0.923880=ff.14
;	.byte $ff,$00 ; -1.000000=ff.00
;	.byte $ff,$14 ; -0.923880=ff.14
;	.byte $ff,$4b ; -0.707107=ff.4b
;	.byte $ff,$9f ; -0.382683=ff.9f

.if 0
	.byte $00,$00 ; 0.000000
	.byte $00,$31 ; 0.195090
	.byte $00,$61 ; 0.382683
	.byte $00,$8E ; 0.555570
	.byte $00,$B5 ; 0.707107
	.byte $00,$D4 ; 0.831470
	.byte $00,$EC ; 0.923880
	.byte $00,$FB ; 0.980785
	.byte $01,$00 ; 1.000000
	.byte $00,$FB ; 0.980785
	.byte $00,$EC ; 0.923880
	.byte $00,$D4 ; 0.831470
	.byte $00,$B5 ; 0.707107
	.byte $00,$8E ; 0.555570
	.byte $00,$61 ; 0.382683
	.byte $00,$31 ; 0.195090
	.byte $00,$00 ; 0.000000
	.byte $FF,$CF ; -0.195090
	.byte $FF,$9F ; -0.382683
	.byte $FF,$72 ; -0.555570
	.byte $FF,$4B ; -0.707107
	.byte $FF,$2C ; -0.831470
	.byte $FF,$14 ; -0.923880
	.byte $FF,$05 ; -0.980785
	.byte $FF,$00 ; -1.000000
	.byte $FF,$05 ; -0.980785
	.byte $FF,$14 ; -0.923880
	.byte $FF,$2C ; -0.831470
	.byte $FF,$4B ; -0.707107
	.byte $FF,$72 ; -0.555570
	.byte $FF,$9F ; -0.382683
	.byte $FF,$CF ; -0.195090
.endif

	.byte $00,$00 ; 0.000000
	.byte $00,$19 ; 0.098017
	.byte $00,$31 ; 0.195090
	.byte $00,$4A ; 0.290285
	.byte $00,$61 ; 0.382683
	.byte $00,$78 ; 0.471397
	.byte $00,$8E ; 0.555570
	.byte $00,$A2 ; 0.634393
	.byte $00,$B5 ; 0.707107
	.byte $00,$C5 ; 0.773010
	.byte $00,$D4 ; 0.831470
	.byte $00,$E1 ; 0.881921
	.byte $00,$EC ; 0.923880
	.byte $00,$F4 ; 0.956940
	.byte $00,$FB ; 0.980785
	.byte $00,$FE ; 0.995185
	.byte $01,$00 ; 1.000000
	.byte $00,$FE ; 0.995185
	.byte $00,$FB ; 0.980785
	.byte $00,$F4 ; 0.956940
	.byte $00,$EC ; 0.923880
	.byte $00,$E1 ; 0.881921
	.byte $00,$D4 ; 0.831470
	.byte $00,$C5 ; 0.773010
	.byte $00,$B5 ; 0.707107
	.byte $00,$A2 ; 0.634393
	.byte $00,$8E ; 0.555570
	.byte $00,$78 ; 0.471397
	.byte $00,$61 ; 0.382683
	.byte $00,$4A ; 0.290285
	.byte $00,$31 ; 0.195090
	.byte $00,$19 ; 0.098017
	.byte $00,$00 ; 0.000000
	.byte $FF,$E7 ; -0.098017
	.byte $FF,$CF ; -0.195090
	.byte $FF,$B6 ; -0.290285
	.byte $FF,$9F ; -0.382683
	.byte $FF,$88 ; -0.471397
	.byte $FF,$72 ; -0.555570
	.byte $FF,$5E ; -0.634393
	.byte $FF,$4B ; -0.707107
	.byte $FF,$3B ; -0.773010
	.byte $FF,$2C ; -0.831470
	.byte $FF,$1F ; -0.881921
	.byte $FF,$14 ; -0.923880
	.byte $FF,$0C ; -0.956940
	.byte $FF,$05 ; -0.980785
	.byte $FF,$02 ; -0.995185
	.byte $FF,$00 ; -1.000000
	.byte $FF,$02 ; -0.995185
	.byte $FF,$05 ; -0.980785
	.byte $FF,$0C ; -0.956940
	.byte $FF,$14 ; -0.923880
	.byte $FF,$1F ; -0.881921
	.byte $FF,$2C ; -0.831470
	.byte $FF,$3B ; -0.773010
	.byte $FF,$4B ; -0.707107
	.byte $FF,$5E ; -0.634393
	.byte $FF,$72 ; -0.555570
	.byte $FF,$88 ; -0.471397
	.byte $FF,$9F ; -0.382683
	.byte $FF,$B6 ; -0.290285
	.byte $FF,$CF ; -0.195090
	.byte $FF,$E7 ; -0.098017
