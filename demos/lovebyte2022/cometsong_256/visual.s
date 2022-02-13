;XX = $FE
;YY = $FC



visual:
				; 4	; colors

	ldx	#3		; 2
comet_loop:
	lda	colors,X	; 2
comet_smc:
	sta	$403,X		; 3
	dex			; 1
	bpl	comet_loop	; 2
	inc	comet_smc+1	; 2
			;==============
			;	16

;	nop
;	nop
;	nop
;	nop
;	nop

;	lda	AY_REGS+4		; 2
;star_smc:
;	sta	$500			; 3


	inc	star_smc+1		; 2





