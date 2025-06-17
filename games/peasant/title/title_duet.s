
	;===========================
	;===========================
	; Electric Duet Title Screen
	;===========================
	;===========================

	; The music takes all the CPU
	;	so we can only do very minimal
	;	title action

duet_title:


	lda	#<peasant_ed
	sta	MADDRL
	lda	#>peasant_ed
	sta	MADDRH

duet_loop_again:
	jsr	play_ed

	lda	#1
	sta	peasant_ed+24
	lda	#0
	sta	peasant_ed+25
	sta	peasant_ed+26


	lda	#<(peasant_ed+24)
	sta	MADDRL
	lda	#>(peasant_ed+24)
	sta	MADDRH

	lda	duet_done
	beq	duet_loop_again

duet_finished:
	bit	KEYRESET

	rts


