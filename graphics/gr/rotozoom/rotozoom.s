	; ANGLE in our case it's 0..15?

; optimization (ANGLE=0)
;	$6BD76=441,718=2.26fps	initial code with external plot and scrn
;	$62776=403,318=2.48fps	inline plot
;	$597b6=366,518=2.73fps	inline scrn
;	$45496=324,758=3.08fps	move plot line calc outside of inner loop

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
								;===========
								;	27
	; sa = sin(theta)*scale;

	lda	ANGLE							; 3
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y	; load integer half			; 4
	sta	SAH							; 3
	lda	fixed_sin+1,Y	; load integer half			; 4
	sta	SAL							; 3
								;==========
								;	21
	; cca = -20*ca;
	; csa = -20*sa;

	lda	#0							; 2
	sta	CCAL							; 3
	sta	CCAH							; 3
	sta	CSAL							; 3
	sta	CSAH							; 3
								;===========
								;	14

	ldx	#20							; 2
mul20_loop:
	sec								; 2
	lda	CCAL							; 3
	sbc	CAL							; 3
	sta	CCAL							; 3
	lda	CCAH							; 3
	sbc	CAH							; 3
	sta	CCAH							; 3
								;===========
								; 	20

	sec								; 2
	lda	CSAL							; 3
	sbc	SAL							; 3
	sta	CSAL							; 3
	lda	CSAH							; 3
	sbc	SAH							; 3
	sta	CSAH							; 3
								;===========
								; 	20

	dex								; 2
	bne	mul20_loop						;2nt/3

							;===================
							; total=2+(45*20)-1
							; 	901 cycles

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

	; for(yy=0;yy<40;yy++) {

	lda	#0							; 2
	sta	YY							; 3
rotozoom_yloop:

	; xp=cca+ysa;
	clc								; 2
	lda	YSAL							; 3
	adc	CCAL							; 3
	sta	XPL							; 3
	lda	YSAH							; 3
	adc	CCAH							; 3
	sta	XPH							; 3
								;==========
								;	20

	; yp=yca-csa;

	sec								; 2
	lda	YCAL							; 3
	sbc	CSAL							; 3
	sta	YPL							; 3
	lda	YCAH							; 3
	sbc	CSAH							; 3
	sta	YPH							; 3
								;===========
								;	20


	; setup self-modifying code for plot
	lda	YY							; 3
	and	#$fe	; make even					; 2
	tay								; 2

	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	sta	rplot1_smc+1						; 4
	sta	rplot2_smc+1						; 4

	clc								; 2
	lda	gr_offsets+1,Y						; 4
	adc	DRAW_PAGE	; add in draw page offset		; 3
	sta	rplot1_smc+2						; 4
	sta	rplot2_smc+2						; 4

        ; for(xx=0;xx<40;xx++) {
	lda	#0							; 2
	sta	XX							; 3
rotozoom_xloop:

	; if ((xp<0) || (xp>39)) color=0;
	; else if ((yp<0) || (yp>39)) color=0;
	; else color=scrn_page(xp,yp,PAGE2);

	lda	#0							; 2

	ldx	XPH							; 3
	bmi	rotozoom_set_color					; 2nt/3
	cpx	#40							; 2
	bcs	rotozoom_set_color					; 2nt/3

	ldx	YPH							; 3
	bmi	rotozoom_set_color					; 2nt/3
	cpx	#40							; 2
	bcs	rotozoom_set_color					; 2nt/3

	; scrn(xp,yp)

;==================================================

	lda	YPH							; 3

	and	#$fe		; make even				; 2
	tay								; 2

	lda	gr_offsets,Y	; lookup low-res memory address		; 4
        clc								; 2
        adc	XPH							; 3
        sta	BASL							; 3

        lda	gr_offsets+1,Y						; 4
        adc	#$8	; assume reading from $c0			; 3
        sta	BASH							; 3

	ldy	#0							; 2

	lda	YPH							; 3
	lsr								; 2
	bcs	rscrn_adjust_even					;2nt/3t

rscrn_adjust_odd:
	lda	(BASL),Y	; top/bottom color			; 5+
	jmp	rscrn_done						; 3

rscrn_adjust_even:
	lda	(BASL),Y	; top/bottom color			; 5+

	lsr								; 2
	lsr								; 2
	lsr								; 2
	lsr								; 2

rscrn_done:

	and	#$f							; 2

;=============================================


rotozoom_set_color:
	; color_equals(color);
	jsr	SETCOL							; 6+??


;=================================================

	; plot(xx,yy);

	lda	YY							; 3

	lsr			; shift bottom bit into carry		; 2

	bcc	rplot_even						; 2nt/3
rplot_odd:
	ldx	#$f0							; 2
	bcs	rplot_c_done		;bra				; 3
rplot_even:
	ldx	#$0f							; 2
rplot_c_done:
	stx	MASK							; 3

rplot_write:

	ldy	XX							; 3

	lda	MASK							; 3
	eor	#$ff							; 2

rplot1_smc:
	and	$400,Y							; 4+
	sta	COLOR_MASK						; 3

	lda	COLOR							; 3
	and	MASK							; 3
	ora	COLOR_MASK						; 3
rplot2_smc:
	sta	$400,Y							; 5+


;=======================

	; xp=xp+ca;

	clc								; 2
	lda	CAL							; 3
	adc	XPL							; 3
	sta	XPL							; 3
	lda	CAH							; 3
	adc	XPH							; 3
	sta	XPH							; 3

	; yp=yp-sa;

	sec								; 2
	lda	YPL							; 3
	sbc	SAL							; 3
	sta	YPL							; 3
	lda	YPH							; 3
	sbc	SAH							; 3
	sta	YPH							; 3


rotozoom_end_xloop:
	inc	XX							; 5
	lda	XX							; 3
	cmp	#40							; 2
	beq	rotozoom_xloop_done					; 2nt/3
	jmp	rotozoom_xloop						; 3
rotozoom_xloop_done:

	; yca+=ca;

	clc								; 2
	lda	YCAL							; 3
	adc	CAL							; 3
	sta	YCAL							; 3
	lda	YCAH							; 3
	adc	CAH							; 3
	sta	YCAH							; 3
								;===========
								;	20

	; ysa+=sa;

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
	lda	YY							; 3
	cmp	#40							; 2
	beq	done_rotozoom						; 2nt/3
	jmp	rotozoom_yloop	; too far				; 3

done_rotozoom:
	rts								; 6



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

