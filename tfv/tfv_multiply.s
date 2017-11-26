; Fast mutiply
;
; The old routine took around 700 cycles for a 16bitx16bit=32bit mutiply
; This routine, at an expense of 2kB of looku tables, takes around 250
;	If you reuse a term the next time this drops closer to 200

; This routine was described by Stephen Judd and found
;	in The Fridge and in the C=Hacking magazine
; http://codebase64.org/doku.php?id=base:seriously_fast_multiplication

; The key thing to note is that
;	       (a+b)^2     (a-b)^2
;       a*b =  -------  -  --------
;                 4           4
; So if you have tables of the squares of 0..511 you can lookup and subtract
; instead of multiplying.

; Table generation: I:0..511
;                   square1_lo = <((I*I)/4)
;                   square1_hi = >((I*I)/4)
;                   square2_lo = <(((I-255)*(I-255))/4)
;                   square2_hi = >(((I-255)*(I-255))/4)

; Note: DOS3.3 starts at $9600

square1_lo	EQU	$8E00
square1_hi	EQU	$9000
square2_lo	EQU	$9200
square2_hi	EQU	$9400

;	for(i=0;i<512;i++) {
;		square1_lo[i]=((i*i)/4)&0xff;
;		square1_hi[i]=(((i*i)/4)>>8)&0xff;
;		square2_lo[i]=( ((i-255)*(i-255))/4)&0xff;
;		square2_hi[i]=(( ((i-255)*(i-255))/4)>>8)&0xff;
;	}

init_multiply_tables:

	; Build the add tables

	ldx	#$00
	txa
	.byte $c9   ; CMP #immediate - skip TYA and clear carry flag
lb1:	tya
	adc	#$00			; 0
ml1:	sta	square1_hi,x		; square1_hi[0]=0
	tay				; y=0
	cmp	#$40			; subtract 64 and update flags (c=0)
	txa				; a=0
	ror				; rotate
ml9:	adc	#$00			; add 0
	sta	ml9+1			; update add value
	inx				; x=1
ml0:	sta	square1_lo,x		; square1_lo[0]=1
	bne	lb1			; if not zero, loop
	inc	ml0+2			; increment values
	inc	ml1+2			; increment values
	clc				; c=0
	iny				; y=1
	bne	lb1			; loop

	; Build the subtract tables based on the existing one

	ldx	#$00
	ldy	#$ff
second_table:
	lda	square1_hi+1,x
	sta	square2_hi+$100,x
	lda	square1_hi,x
	sta	square2_hi,y
	lda	square1_lo+1,x
	sta	square2_lo+$100,x
	lda	square1_lo,x
	sta	square2_lo,y
	dey
	inx
	bne second_table


	rts


; Fast 16x16 bit unsigned multiplication, 32-bit result
; Input: NUM1H:NUM1L * NUM2H:NUM2L
; Result: RESULT3:RESULT2:RESULT1:RESULT0
;
; Does self-modifying code to hard-code NUM1H:NUM1L into the code
;  carry=0: re-use previous NUM1H:NUM1L
;  carry=1: reload NUM1H:NUM1L (58 cycles slower)
;
; clobbered: RESULT, X, A, C
; Allocation setup: T1,T2 and RESULT preferably on Zero-page.
;
; NUM1H (x_i), NUM1L (x_f)
; NUM2H (y_i), NUM2L (y_f)

;	NUM1L * NUM2L = AAaa
;	NUM1L * NUM2H = BBbb
;	NUM1H * NUM2L = CCcc
;	NUM1H * NUM2H = DDdd
;
;	       AAaa
;	     BBbb
;	     CCcc
;	 + DDdd
;	 ----------
;	   RESULT

fixed_16x16_mul_unsigned:

	sec	; FIXME-remove when we implement this

	bcc	num1_same_as_last_time					; 2nt/3

	;============================
	; Set up self-modifying code
	; this changes the code to be hard-coded to multiply by NUM1H:NUM1L
	;============================

	lda	NUM1L	; load the low byte				; 3
	sta	sm1a+1							; 3
	sta	sm3a+1							; 3
	sta	sm5a+1							; 3
	sta	sm7a+1							; 3
	eor	#$ff	; invert the bits for subtracting		; 2
	sta	sm2a+1							; 3
	sta	sm4a+1							; 3
	sta	sm6a+1							; 3
	sta	sm8a+1							; 3
	lda	NUM1H	; load the high byte				; 3
	sta	sm1b+1							; 3
	sta	sm3b+1							; 3
	sta	sm5b+1							; 3
	sta	sm7b+1							; 3
	eor	#$ff	; invert the bits for subtractin		; 2
	sta	sm2b+1							; 3
	sta	sm4b+1							; 3
	sta	sm6b+1							; 3
	sta	sm8b+1							; 3
								;===========
								;	 58

num1_same_as_last_time:

	;==========================
	; Perform NUM1L * NUM2L = AAaa
	;==========================

	ldx	NUM2L	; (low le)					; 3
	sec								; 2
sm1a:
	lda	square1_lo,x						; 4
sm2a:
	sbc	square2_lo,x						; 4

	; a is _aa

	sta	RESULT+0						; 3

sm3a:
	lda	square1_hi,x						; 4
sm4a:
	sbc	square2_hi,x						; 4
	; a is _AA
	sta	_AA+1							; 3
								;===========
								;	27

	; Perform NUM1H * NUM2L = CCcc
	sec								; 2
sm1b:
	lda	square1_lo,x						; 4
sm2b:
	sbc	square2_lo,x						; 4
	; a is _cc
	sta	_cc+1							; 3
sm3b:
	lda	square1_hi,x						; 4
sm4b:
	sbc square2_hi,x						; 4
	; a is _CC
	sta	_CC+1							; 3
								;===========
								;	 24

	;==========================
	; Perform NUM1L * NUM2H = BBbb
	;==========================
	ldx	NUM2H							; 3
	sec								; 2
sm5a:
	lda	square1_lo,x						; 4
sm6a:
	sbc	square2_lo,x						; 4
	; a is _bb
	sta	_bb+1							; 3

sm7a:
	lda	square1_hi,x						; 4
sm8a:
	sbc	square2_hi,x						; 4
	; a is _BB
	sta	_BB+1							; 3
								;===========
								;	 27

	;==========================
	; Perform NUM1H * NUM2H = DDdd
	;==========================
	sec								; 2
sm5b:
	lda	square1_lo,x						; 4
sm6b:
	sbc	square2_lo,x						; 4
	; a is _dd
	sta	_dd+1							; 3
sm7b:
	lda	square1_hi,x						; 4
sm8b:
	sbc	square2_hi,x						; 4
	; a = _DD
	sta	RESULT+3						; 3
								;===========
								; 	 24

	;===========================================
	; Add the separate multiplications together
	;===========================================

	clc								; 2
_AA:
	lda	#0		; loading _AA				; 2
_bb:
	adc	#0		; adding in _bb				; 2
	sta	RESULT+1						; 3

	; product[2]=_BB+_CC+c

_BB:
	lda	#0		; loading _BB				; 2
_CC:
	adc	#0		; adding in _CC				; 2
	sta RESULT+2							; 3
								;===========
								;	 19

	;  product[3]=_DD+c

	bcc	dd_no_carry1						; ^2nt/3
	inc	RESULT+3						; 5
	clc								; 2
								;=============
								;	  6
dd_no_carry1:

	; product[1]=_AA+_bb+_cc

_cc:
	lda	#0		; load _cc				; 2
	adc	RESULT+1						; 3
	sta	RESULT+1						; 3

	; product[2]=_BB+_CC+_dd+c

_dd:
	lda	#0		; load _dd				; 2
	adc	RESULT+2						; 3
	sta	RESULT+2						; 3

								;===========
								;	 19
	; product[3]=_DD+c


	bcc	dd_no_carry2						; ^2nt/3
	inc	RESULT+3						; 5

								;=============
								;	 4

dd_no_carry2:

;	*z_i=product[1];
;	*z_f=product[0];

	rts								; 6


	;=================
	; Signed multiply
	;=================

multiply:

	jsr fixed_16x16_mul_unsigned					; 6

	lda	NUM1H		; x_i					; 3
								;===========
								;	 12


	bpl	x_positive						;^3/2nt

	sec								; 2
	lda	RESULT+2						; 3
	sbc	NUM2L							; 3
	sta	RESULT+2						; 3
	lda	RESULT+3						; 3
	sbc	NUM2H							; 3
	sta	RESULT+3						; 3
								;============
								;	 19

x_positive:

	lda	NUM2H		; y_i					; 3
								;============
								;	; 6
	bpl	y_positive						; 3/2nt


	sec								; 2
	lda	RESULT+2						; 3
	sbc	NUM1L							; 3
	sta	RESULT+2						; 3
	lda	RESULT+3						; 3
	sbc	NUM1H							; 3
	sta	RESULT+3						; 3
								;===========
								;	 19

y_positive:
;	*z_i=product[2];
;	*z_f=product[1];

	rts								; 6

