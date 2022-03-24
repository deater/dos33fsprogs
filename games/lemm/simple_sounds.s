
	;============================
	; click the speaker
	;============================
	; FIXME: make it last longer?

click_speaker:
	pha
	lda	SOUND_STATUS
	bmi	done_click
	bit	$c030
	pla
done_click:
	rts


long_beep:
	ldy	#235
	bne	do_beep

short_beep:
	ldy	#40
	bne	do_beep

	;===========================
	; BEEP (inlined)
	;===========================
do_beep:
	lda	SOUND_STATUS
	bmi	done_beep

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



