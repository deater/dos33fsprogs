	;============================
	; do the pan

horiz_pan:

pan_loop:

	lda	#0
	sta	COUNT

pan_outer_outer_loop:

	ldx	#191
pan_outer_loop:

	lda	hposn_high,X
	sta	pil_smc1+2
	sta	pil_smc2+2
	sta	pil_smc3+2

;	sta	pil_smc4+2
;	eor	#$60


	lda	hposn_low,X
	sta	pil_smc1+1
	sta	pil_smc2+1
	sta	pil_smc3+1
	inc	pil_smc3+1

;	clc
;	adc	COUNT
;	sta	pil_smc3+1
;	sta	pil_smc4+1
	stx	XSAVE


	ldy	#0

	; original: 36*39 = ??
	; updated:  34*39

pil_smc1:
	ldx	$2000,Y					; 4+
pan_inner_loop:

	lda	left_lookup_main,X			; 4+
	sta	TEMPY					; 3

pil_smc3:
	ldx	$2000+1,Y				; 4+
	lda	left_lookup_next,X			; 4+
	ora	TEMPY					; 3

pil_smc2:
	sta	$2000,Y					; 5

	iny						; 2
	cpy	#39					; 2
	bne	pan_inner_loop				; 2/3

; leftover

;pil_smc3:
;	lda	$4000
;pil_smc4:
;	sta	$2000,Y

	ldx	XSAVE

	dex
	cpx	#$ff
	bne	pan_outer_loop

	lda	KEYPRESS
	bmi	done_pan

	inc	COUNT
	lda	COUNT
	cmp	#139

	bne	pan_outer_outer_loop

done_pan:
	bit	KEYRESET

	rts

.include "scroll_tables.s"
