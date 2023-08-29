detect_aux_ram:

	; if Apple IIgs or IIc assume 128k
	; FIXME: Apple IIgs there are routines to get more accurate count

	lda	APPLEII_MODEL
	cmp	#'g'
	beq	return_64k
	cmp	#'c'
	beq	return_64k

	cmp	#'e'
	bne	return_0k	; assume none if not IIe

	; enable AUX zp
	sta	$C009

	; write $AA to $FF		FF:AUX = AA, FF:MAIN=??
	lda	#$AA
	sta	$FF

	; disable AUX zp
	sta	$C008

	; write $55 to $FF		FF:AUX=AA, FF:MAIN=55
	lda	#$55
	sta	$FF

	; enable AUX zp
	sta	$C009
	ldx	$FF

	; disable AUX zp		; if aux, then X=AA, else X=55
	sta	$C008

	cpx	#$AA
	bne	return_0k

return_64k:
	lda	#64
	rts

return_1k:
	lda	#1
	rts

return_0k:
	lda	#0
	rts


