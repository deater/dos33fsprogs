

click_speaker:
	lda	SOUND_DISABLED
	bne	done_click
	bit	$c030
done_click:
	rts

	;===========================
	; BEEP (inlined)
	;===========================
beep:
	lda	SOUND_DISABLED
	bne	done_beep

	ldy     #235
	sty	tone_smc+1

	; BEEP
	; repeat 30 times
	lda	#30			; 2
tone1_loop:

tone_smc:

	ldy	#24			; 2
loopC:	ldx	#6			; 2
loopD:	dex				; 1
	bne	loopD			; 2
	dey				; 1
	bne	loopC			; 2

	bit	SPEAKER			; 3	; click speaker

	sec				; 1
	sbc	#1			; 2
	bne	tone1_loop		; 2

	; Try X=6 Y=21 cycles=757
	; Try X=6 Y=24 cycles=865
	; Try X=7 Y=235 cycles=9636
done_beep:
	rts



