	;============================
	; do the pan

do_horiz_scroll:

pan_loop:

	lda	#0
	sta	COUNT
	sta	SCROLL_SUBSCROLL
	sta	SCROLL_OFFSET

	ldy	#0

pan_outer_loop:

	lda	#$20
	sta	pol_smc1+2
	sta	pol_smc2+2
	sta	pol_smc3+2

	lda	#$40
	sta	e_smc1+2
	sta	e_smc2+2
	sta	e_smc3+2


pan_inner_loop:

pol_smc1:
	ldx	$2000,Y
	lda	left_lookup_main,X	; lookup next		; 4+

	cpy	#$27
	bne	itsgood

	; edge of screen

e_smc1:
	ldx	$4000
	ora	left_lookup_next,X				; 4+
	sta	$2000,Y			; update		; 5

	lda	left_lookup_main,X
	ldx	$4001
	ora	left_lookup_next,X
e_smc2:
	sta	$4000

	lda	left_lookup_main,X
e_smc3:
	sta	$4001

	iny
	sty	e_smc1+1
	sty	e_smc2+1
	iny
	sty	e_smc3+1
	dey

	jmp	alt

itsgood:

pol_smc2:
	ldx	$2001,Y			; odd col		; 4+
	ora	left_lookup_next,X				; 4+

pol_smc3:
	sta	$2000,Y			; update		; 5



	iny							; 2
alt:
	bne	pan_inner_loop


	inc	e_smc1+2
	inc	e_smc2+2
	inc	e_smc2+2

	inc	pol_smc1+2
	inc	pol_smc2+2
	inc	pol_smc3+2

	lda	pol_smc1+2
	cmp	#$40
	bne	pan_inner_loop

	jmp	pan_outer_loop

done_pan:
	bit	KEYRESET

	rts

.include "scroll_tables.s"
