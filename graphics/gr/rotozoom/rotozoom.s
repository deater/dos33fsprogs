	; ANGLE in our case it's 0..15?


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

	; ca = cos(theta)*scale;
	;      ca=fixed_sin[(theta+4)&0xf]

	lda	ANGLE							; 3
	clc								; 2
	adc	#4							; 2
	and	#$f							; 2
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y	; load integer half			; 4
	sta	CAH							; 3
	lda	fixed_sin+1,Y	; load integer half			; 4
	sta	CAL							; 3

	; sa = sin(theta)*scale;

	lda	ANGLE							; 3
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y	; load integer half			; 4
	sta	SAH							; 3
	lda	fixed_sin+1,Y	; load integer half			; 4
	sta	SAL							; 3

	; cca = -20*ca;
	; csa = -20*sa;

	lda	#0
	sta	CCAL
	sta	CCAH
	sta	CSAL
	sta	CSAH


	ldx	#20
mul20_loop:



	dex
	bne	mul20_loop


	; yca=cca+ycenter;

	lda	CCAL
	sta	YCAL
	clc
	lda	CCAH
	adc	#20
	sta	YCAH

	; ysa=csa+xcenter;

	lda	CSAL
	sta	YSAL
	clc
	lda	CSAH
	adc	#20
	sta	YSAH

	; for(yy=0;yy<40;yy++) {

	lda	#0
	sta	YY
rotozoom_yloop:

	; xp=cca+ysa;
	clc
	lda	YSAL
	adc	CCAL
	sta	XPL
	lda	YSAH
	adc	CCAH
	sta	XPH

	; yp=yca-csa;

	sec
	lda	YCAL
	sbc	CSAL
	sta	YPL
	lda	YCAH
	sbc	CSAH
	sta	YPH

        ; for(xx=0;xx<40;xx++) {
	lda	#0
	sta	XX
rotozoom_xloop:

	; if ((xp<0) || (xp>39)) color=0;
	; else if ((yp<0) || (yp>39)) color=0;
	; else color=scrn_page(xp,yp,PAGE2);

	lda	#0
	ldx	XPH
	bmi	rotozoom_set_color
	cpx	#40
	bcs	rotozoom_set_color
	ldx	YPH
	bmi	rotozoom_set_color
	cpx	#40
	bcs	rotozoom_set_color

	; scrn(xp,yp)

	lda	XPH
	sta	XPOS
	lda	YPH
	sta	YPOS

	jsr	scrn

rotozoom_set_color:
	; color_equals(color);
	jsr	SETCOL

	; plot(xx,yy);

	lda	XX
	sta	XPOS
	lda	YY
	sta	YPOS

	jsr	plot

	; xp=xp+ca;

	clc
	lda	CAL
	adc	XPL
	sta	XPL
	lda	CAH
	adc	XPH
	sta	XPH

	; yp=yp-sa;

	sec
	lda	YPL
	sbc	SAL
	sta	YPL
	lda	YPH
	sbc	SAH
	sta	YPH


rotozoom_end_xloop:
	inc	XX
	lda	XX
	cmp	#40
	bne	rotozoom_xloop

	; yca+=ca;

	clc
	lda	YCAL
	adc	CAL
	sta	YCAL
	lda	YCAH
	adc	CAH
	sta	YCAH

	; ysa+=sa;

	clc
	lda	YSAL
	adc	SAL
	sta	YSAL
	lda	YSAH
	adc	SAH
	sta	YSAH


rotozoom_end_yloop:
	inc	YY
	lda	YY
	cmp	#40
	beq	done_rotozoom
	jmp	rotozoom_yloop	; too far

done_rotozoom:
	rts



fixed_sin:
        .byte $00,$00 ;  0.000000=00.00
        .byte $00,$61 ;  0.382683=00.61
        .byte $00,$b5 ;  0.707107=00.b5
        .byte $00,$ec ;  0.923880=00.ec
        .byte $01,$00 ;  1.000000=01.00
        .byte $00,$ec ;  0.923880=00.ec
        .byte $00,$b5 ;  0.707107=00.b5
        .byte $00,$61 ;  0.382683=00.61
        .byte $00,$00 ;  0.000000=00.00
        .byte $ff,$9f ; -0.382683=ff.9f
        .byte $ff,$4b ; -0.707107=ff.4b
        .byte $ff,$14 ; -0.923880=ff.14
        .byte $ff,$00 ; -1.000000=ff.00
        .byte $ff,$14 ; -0.923880=ff.14
        .byte $ff,$4b ; -0.707107=ff.4b
        .byte $ff,$9f ; -0.382683=ff.9f

