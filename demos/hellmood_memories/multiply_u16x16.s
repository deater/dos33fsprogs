; Fast mutiply

; Note for our purposes we only care about 8.8 x 8.8 fixed point
; with 8.8 result, which means we only care about the middle two bytes
; of the 32 bit result.  So we disable generation of the high and low byte
; to save some cycles.

;
; The old routine took around 700 cycles for a 16bitx16bit=32bit mutiply
; This routine, at an expense of 2kB of lookup tables, takes around 250
;	If you reuse a term the next time this drops closer to 200


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

;fixed_16x16_mul_unsigned:

multiply_u16x16:

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
	sta	sm7b+1							;
	eor	#$ff	; invert the bits for subtractin		; 2
	sta	sm2b+1							; 3
	sta	sm4b+1							; 3
	sta	sm6b+1							; 3
	sta	sm8b+1							;
								;===========
								;	 52

multiply_u16x16_same_num1:

	stx	TEMP

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

	sta	RESULT0						;

sm3a:
	lda	square1_hi,x						; 4
sm4a:
	sbc	square2_hi,x						; 4
	; a is _AA
	sta	_AA+1							; 3
								;===========
								;	24

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
	lda	square1_hi,x						;
sm8b:
	sbc	square2_hi,x						;
	; a = _DD
	sta	RESULT3						;
								;===========
								; 	 13

	;===========================================
	; Add the separate multiplications together
	;===========================================

	clc								; 2
_AA:
	lda	#0		; loading _AA				; 2
_bb:
	adc	#0		; adding in _bb				; 2
	sta	RESULT1						; 3
								;==========
								;	  9
	; product[2]=_BB+_CC+c

_BB:
	lda	#0		; loading _BB				; 2
_CC:
	adc	#0		; adding in _CC				; 2
	sta RESULT2							; 3
								;===========
								;	  7

	;  product[3]=_DD+c

	bcc	dd_no_carry1						;
	inc	RESULT3						;
	clc								; 2
								;=============
								;	  2
dd_no_carry1:

	; product[1]=_AA+_bb+_cc

_cc:
	lda	#0		; load _cc				; 2
	adc	RESULT1						; 3
	sta	RESULT1						; 3

	; product[2]=_BB+_CC+_dd+c

_dd:
	lda	#0		; load _dd				; 2
	adc	RESULT2						; 3
	sta	RESULT2						; 3

								;===========
								;	 16
	; product[3]=_DD+c


	bcc	dd_no_carry2						;
	inc	RESULT3						;

								;=============
								;	 0

dd_no_carry2:
	ldx	TEMP

	rts								; 6

