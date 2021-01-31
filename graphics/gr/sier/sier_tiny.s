; fake sierpinski

; just plot X AND Y


; 51 initial
; 46, put YY in X
; 39, optimized to death?

.include "zp.inc"
.include "hardware.inc"

	;================================
	; Clear screen and setup graphics
	;================================
sier:

	jsr	SETGR		; set lo-res 40x40 mode
	bit	FULLGR		; make it 40x48

	lda	#39
	sta	XX

sier_xloop:

	ldx	#47

sier_yloop:

	txa
	and	XX

	bne	black
	lda	#$11	; red

	.byte	$2C	; bit trick
black:
	lda	#$00
	sta	COLOR

	ldy	XX
	txa
	jsr	PLOT		; PLOT AT Y,A


	dex
	bpl	sier_yloop

	dec	XX
	bpl	sier_xloop

done:
	bmi	done
