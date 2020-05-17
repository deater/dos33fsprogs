; Fast mutiply

; Note for our purposes we only care about 8.8 x 8.8 fixed point
; with 8.8 result, which means we only care about the middle two bytes
; of the 32 bit result.  So we disable generation of the high and low byte
; to save some cycles.

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


; Fast 8x8 bit unsigned multiplication, 16-bit result
; Input: M1xM2
; Result: M2:M1
;
multiply_u8x8:
	stx	TEMP

	lda     M1
        sta     sm1a+1                                                  ; 3
        sta     sm3a+1                                                  ; 3
        eor     #$ff    ; invert the bits for subtracting               ; 2
        sta     sm2a+1                                                  ; 3
        sta     sm4a+1                                                  ; 3

	ldx	M2
	sec
sm1a:
	lda	square1_lo,X
sm2a:
	sbc	square2_lo,X
	sta	M1
sm3a:
	lda	square1_hi,X
sm4a:
	sbc	square2_hi,X
	sta	M2

	ldx	TEMP
	rts
