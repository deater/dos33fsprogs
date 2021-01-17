	;=====================
	;=====================
	; long(er) wait
	; waits approximately 10ms * X
	;=====================
	;=====================
long_wait:
	lda	#64
	jsr	WAIT		; delay 1/2(26+27A+5A^2) us, 11,117
	dex
	bne	long_wait
	rts




