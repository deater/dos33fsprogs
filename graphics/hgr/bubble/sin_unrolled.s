
	;=======================
;sin:

	; / 6.28	is roughly the same as *0.16
	;               = .5 .25 .125 .0625 .03125
	; 1/6.28 = 0.16 =  0 0    1   0       1 0 0 0 = 0x28

	; i=(i*0x28)>>8;

;	lda	IVL,Y		; note, uses absolute as no ZP equiv	; 4
;	sta	STEMP1L							; 3
;	lda	IVH,Y							; 4

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

;	lda	sin_table_low,X						; 4+
;	sta	OUT1L,Y							; 5
;	lda	sin_table_high,X					; 4+
;	sta	OUT1H,Y							; 5

