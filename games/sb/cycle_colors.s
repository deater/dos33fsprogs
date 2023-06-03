
; used for title of strongbadzone

cycle_colors:

	lda	FRAME
	lsr
	lsr
;	lsr
	and	#$3
	tax

;	lda	color_opcodes,X
;	sta	color_change1_smc
;	sta	color_change2_smc

	lda	color_mask_odd,X
	sta	color_change1_smc+1

	lda	color_mask_even,X
	sta	color_change2_smc+1


	ldx	#77
color_loop:

	lda	hposn_high,X
	sta	OUTH
	eor	#$60
	sta	INH

	lda	hposn_low,X
	sta	OUTL
	sta	INL

	ldy	#39

color_inner_loop:

	cpx	#59
	bcc	no_were_good
	cpy	#10
	bcc	no_were_good
	cpy	#24
	bcc	skip_area

no_were_good:

	lda	(INL),Y
color_change1_smc:
	and	#$AA
	sta	(OUTL),Y
	dey

	lda	(INL),Y
color_change2_smc:
	and	#$55
	sta	(OUTL),Y

skip_area:
	dey


	bpl	color_inner_loop

	dex
	bne	color_loop


	rts


; green = 1   (10)	and $29/$55/$2A
; purple= 2   (01)	and $29/$2A/$55
; white1= 3             and $29/$7f/$7f
; orange= 5   (10)	and $29/$D5/$AA
; blue=   6   (01)	and $29/$AA/$D5
; white2= 7             and $29/$FF/$FF

;color_opcodes:
;	.byte	$29,$29,$29,$29		; and = $29  ora=$09
color_mask_odd:
	.byte	$55,$D5,$FF,$7F
color_mask_even:
	.byte	$2A,$AA,$FF,$7F
