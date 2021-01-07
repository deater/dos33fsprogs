	; ANGLE in our case it's 0..15?

; optimization (ANGLE=0)
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

	lda	SCALE_I
	sta	NUM1H
	lda	SCALE_F
	sta	NUM1L

	; ca = cos(theta)*scale;
	;      ca=fixed_sin[(theta+4)&0xf]

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

	sec
	jsr	multiply
	stx	CAH
	sta	CAL


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

	clc
	jsr	multiply

	stx	SAH
	sta	SAL


	; cca = -20*ca;

	lda	#-20
	sta	NUM1H
	lda	#0
	sta	NUM1L

	lda	CAL
	sta	NUM2L
	lda	CAH
	sta	NUM2H

	sec
	jsr	multiply
	stx	CCAH
	sta	CCAL


	; csa = -20*sa;

	lda	SAL
	sta	NUM2L
	lda	SAH
	sta	NUM2H

	clc
	jsr	multiply

	stx	CSAH
	sta	CSAL




;	lda	#0							; 2
;	sta	CCAL							; 3
;	sta	CCAH							; 3
;	sta	CSAL							; 3
;	sta	CSAH							; 3
								;===========
								;	14

;	ldx	#20							; 2
;mul20_loop:
;	sec								; 2
;	lda	CCAL							; 3
;	sbc	CAL							; 3
;	sta	CCAL							; 3
;	lda	CCAH							; 3
;	sbc	CAH							; 3
;	sta	CCAH							; 3
								;===========
								; 	20

;	sec								; 2
;	lda	CSAL							; 3
;	sbc	SAL							; 3
;	sta	CSAL							; 3
;	lda	CSAH							; 3
;	sbc	SAH							; 3
;	sta	CSAH							; 3
								;===========
								; 	20

;	dex								; 2
;	bne	mul20_loop						;2nt/3

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
	lsr		; get low bit in carry				; 2
	bcc	smc_even						; 2nt/3
smc_odd:
	ldy	#$2c		; bit					; 2
	jmp	smc_write						; 3
smc_even:
	ldy	#$4c		; jmp					; 2
smc_write:
	sty	rplot3_smc						; 4
	asl		; now even					; 2

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
	ldx	#0							; 2
rotozoom_xloop:
	;==========================
	; note: every cycle saved below here
	;       saves 1600 cycles
	;==========================


	; if ((xp<0) || (xp>39)) color=0;
	; else if ((yp<0) || (yp>39)) color=0;
	; else color=scrn_page(xp,yp,PAGE2);

	; we know it's never going to go *that* far out of bounds
	;	so we could avoid the Y check by just having "0"
	;	on the edges of the screen?  Tricky due to Apple II
	;	interlacing

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

	lda	c00_scrn_offsets_l,Y	; lookup low-res memory address	; 4
        sta	BASL							; 3
        lda	c00_scrn_offsets_h,Y					; 4
        sta	BASH							; 3

	; carry was set a bit before to low bit of YPH
	; hopefully nothing has cleared it

	bcs	rscrn_adjust_odd					; 3

rscrn_adjust_even:
	ldy	XPH							; 3
	; want bottom
	lda	(BASL),Y	; top/bottom color			; 5+
	and	#$f							; 2
	jmp	rscrn_done						; 3

rscrn_adjust_odd:
	ldy	XPH							; 3
	; want top
	lda	(BASL),Y	; top/bottom color			; 5+

	lsr								; 2
	lsr								; 2
	lsr								; 2
	lsr								; 2

rscrn_done:



;=============================================


rotozoom_set_color:
	; want same color in top and bottom nibbles
	sta	TEMP							; 3
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
	ora	TEMP							; 3
								;==========
								;	14

;=================================================

rplot:

	; plot(xx,yy);	(color is in A)

	; smc based on if Y is odd or even
rplot3_smc:
	jmp	rplot_even						; 3

rplot_odd:
	and	#$f0							; 2
	sta	COLOR							; 3
	lda	#$0f							; 2
	bne	rplot1_smc		; bra				; 3

rplot_even:
	and	#$0f							; 2
	sta	COLOR							; 3
	lda	#$f0							; 2

rplot1_smc:
	and	$400,X							; 4
	ora	COLOR							; 3
rplot2_smc:
	sta	$400,X							; 5


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
	inx								; 2
	cpx	#40							; 2
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
