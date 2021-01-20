
	; rotozoomer!
	; takes a lores-formatted image in $c00 and rotozooms it
	;	by ANGLE and SCALE_I/SCALE_F and draws it to the
	;	lo-res page in DRAW_PAGE

	; ANGLE in our case is 0..31
	; SCALE_I/SCALE_F is 8.8 fixed point scale multiplier

; optimization (cycles measured at ANGLE=0)
;	$6BD76=441,718=2.26fps	initial code with external plot and scrn
;	$62776=403,318=2.48fps	inline plot
;	$597b6=366,518=2.73fps	inline scrn
;	$4F496=324,758=3.08fps	move plot line calc outside of inner loop
;	$49d16=302,358=3.31fps	do color*17 ourselves
;	$4645e=287,838=3.47fps	move XX into X
;	$3ef7e=257,918=3.87fps	optimize plot
;	$3c9fe=248,318=4.03fps	optimize scrn
;	$39e3e=237,118=4.22fps	add scrn address lookup table
;	$39fdf=237,535		add two scale multiplies
;	$39e17=237,079=4.22fps	change the init to also use multiply
;	$39dc9=237,001=		change to use common lookup table (outside inner loop)
;	$3399f=211,359=4.73fps	unroll the Y loop by one
;	$2BA83=178,819=5.59fps	optimize unrolled loop
;	$2B14B=176,459=5.66fps	avoid extra jump (qkumba)

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
	adc	#8							; 2
	and	#$1f							; 2
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

	; if ((xp<0) || (xp>39)) color=0;
	; else if ((yp<0) || (yp>39)) color=0;
	; else color=scrn_page(xp,yp,PAGE2);

	; we know it's never going to go *that* far out of bounds
	;	so we could avoid the Y check by just having "0"
	;	on the edges of the screen?  Tricky due to Apple II
	;	interlacing

roto_color_even_smc:
	lda	#0	; default color					; 2

	ldy	XPH							; 3
	bmi	rplot							; 2nt/3
	cpy	#40							; 2
	bcs	rplot							; 2nt/3

	ldy	YPH							; 3
	bmi	rplot							; 2nt/3
	cpy	#40							; 2
	bcs	rplot							; 2nt/3



;==================================================

	; scrn(xp,yp)

	tya	; YPH							; 2

	lsr		; divide to get index, also low bit in carry	; 2
	tay								; 2

	; TODO: put these in zero page?
	;	also we can share low bytes with other lookup

	lda	common_offsets_l,Y	; lookup low-res memory address	; 4
        sta	BASL							; 3
        lda	scrn_c00_offsets_h,Y					; 4
        sta	BASH							; 3


	ldy	XPH							; 3
	lda	(BASL),Y	; top/bottom color			; 5+

	; carry was set a bit before to low bit of YPH
	; hopefully nothing has cleared it

	bcc	rscrn_adjust_even					; 2nt/3

rscrn_adjust_odd:
	; YP was odd so want top nibble
	lsr								; 2
	lsr								; 2
	lsr								; 2
	lsr								; 2

	; fall through

rscrn_adjust_even:

	; YP was even so want bottom nibble
	and	#$f							; 2

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

	clc								; 2
	lda	CAL							; 3
	adc	XPL							; 3
	sta	XPL							; 3
	lda	CAH							; 3
	adc	XPH							; 3
	sta	XPH							; 3

	; yp=yp-sa;	fixed point 8.8

	sec								; 2
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

roto_color_odd_smc:
	lda	#0	; default color					; 2

	ldy	XPH							; 3
	bmi	rplot2							; 2nt/3
	cpy	#40							; 2
	bcs	rplot2							; 2nt/3

	ldy	YPH							; 3
	bmi	rplot2							; 2nt/3
	cpy	#40							; 2
	bcs	rplot2							; 2nt/3



;==================================================

	; scrn(xp,yp)

	tya	; YPH							; 2

	lsr		; divide to get index, also low bit in carry	; 2
	tay								; 2

	; TODO: put these in zero page?
	;	also we can share low bytes with other lookup

	lda	common_offsets_l,Y	; lookup low-res memory address	; 4
        sta	BASL							; 3
        lda	scrn_c00_offsets_h,Y					; 4
        sta	BASH							; 3


	ldy	XPH							; 3
	lda	(BASL),Y	; top/bottom color			; 5+

	; carry was set a bit before to low bit of YPH
	; hopefully nothing has cleared it

	bcs	rscrn_adjust_odd2					; 3

rscrn_adjust_even2:

	; want bottom color, but put it in top of A
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2

	jmp	rscrn_done2						; 3

rscrn_adjust_odd2:
	; want top color alone

	and	#$f0							; 2

rscrn_done2:



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

	clc								; 2
	lda	CAL							; 3
	adc	XPL							; 3
	sta	XPL							; 3
	lda	CAH							; 3
	adc	XPH							; 3
	sta	XPH							; 3

	; yp=yp-sa;	8.8 fixed point

	sec								; 2
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
	cpy	#20							; 2
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
