; fake sierpinski

; just plot X AND Y

.include "zp.inc"
.include "hardware.inc"

	;================================
	; Clear screen and setup graphics
	;================================
sier:

	jsr	SETGR		; set lo-res 40x40 mode
	bit	FULLGR		; make it 40x48


	lda	#39*2
	sta	XX

sier_xloop:

	lda	#47*2
	sta	YY
sier_yloop:

	lda	YY
	and	XX
	and	#$FE
	beq	red

black:
	lda	#00
	beq	do_color

red:
	lda	#$11
do_color:
	sta	COLOR

	lda	XX
	lsr
	tay

	lda	YY
	lsr

	jsr	PLOT		; PLOT AT Y,A

	dec	YY
	bne	sier_yloop

	dec	XX
	bne	sier_xloop

done:
	jmp	done
