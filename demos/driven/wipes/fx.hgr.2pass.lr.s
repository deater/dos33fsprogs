;license:MIT
;(c) 2018 by 4am
;

; vmw -- Convert to ca65 and de-macroed

WROW = $D0

; original was $10
LR_TIMEOUT = $40

do_wipe_lr:
	lda	#$00
	sta	h1_smc+1
	sta	h2_smc+1
outerloop1:
	lda	#$BF
	sta	WROW
loop1:
	jsr	hgr_calc
h1_smc:
	ldy	#$00
	lda	(WIPEL),Y
	sta	(GBASL),Y
	dec	WROW
	dec	WROW
	lda	WROW
	cmp	#$FF
	bne	loop1

	lda	#LR_TIMEOUT
	jsr	WaitForKeyWithTimeout
	bmi	lrexit

	inc	h1_smc+1
	lda	h1_smc+1
	cmp	#$28
	bne	outerloop1

outerloop2:
	lda	#$BE
	sta	WROW
loop2:
	jsr	hgr_calc
h2_smc:
	ldy	#$00
	lda	(WIPEL),Y
	sta	(GBASL),Y
	dec	WROW
	dec	WROW
	lda	WROW
	cmp	#$FE
	bne	loop2

	lda	#LR_TIMEOUT
	jsr	WaitForKeyWithTimeout
	bmi	lrexit

	inc	h2_smc+1
	lda	h2_smc+1
	cmp	#$28
	bne	outerloop2
lrexit:
	rts


WaitForKeyWithTimeout:
; in:    A = timeout length (like standard $FCA8 wait routine)
; out:   A clobbered (not always 0 if key is pressed, but also not the key pressed)
;        X/Y preserved
	sec
wait11:	pha
wait22:	sbc	#1
	bne	wait22
	pla
	bit	KEYPRESS
	bmi	wfk_exit
	sbc	#1
	bne	wait11
wfk_exit:
	rts
