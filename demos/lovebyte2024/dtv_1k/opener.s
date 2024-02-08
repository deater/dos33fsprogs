; draws a circle pattern

opener:
	; A=0 from HGR


	lda	#$20
	sta	HGR_SCALE

	jsr	HGR
	sta	HGR_ROTATION

	; A and Y are 0 here.
	; X is left behind by the boot process?

tiny_loop:
	tay
;	ldy	#0
	ldx	#140
	lda	#96
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??

	ldx	#<our_shape		; load $E2 into A, X, and Y
	ldy	#>our_shape		; 	our shape table is in ROM at $E2E2
	inc	HGR_ROTATION
	lda	HGR_ROTATION
	cmp	#$40
	beq	done_circle

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	beq	tiny_loop	; bra

done_circle:

	lda	#250
	jsr	WAIT

;	rts

our_shape = $E2E2

