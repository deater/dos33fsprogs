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

; Note: DOS3.3 starts at $9600
; I/O starts at $c000

square1_lo	=	$1600
square1_hi	=	$1800
square2_lo	=	$1A00
square2_hi	=	$1C00


;	for(i=0;i<512;i++) {
;		square1_lo[i]=((i*i)/4)&0xff;
;		square1_hi[i]=(((i*i)/4)>>8)&0xff;
;		square2_lo[i]=( ((i-255)*(i-255))/4)&0xff;
;		square2_hi[i]=(( ((i-255)*(i-255))/4)>>8)&0xff;
;	}


	; note, don't run these more than once?
	; why not?	oh, smc that we don't reset

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


