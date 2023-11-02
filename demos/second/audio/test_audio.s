.include "../hardware.inc"
.include "../zp.inc"



test_audio:
	jsr	wait_until_keypress

	lda	#<transmission
	sta	BTC_L
	lda	#>transmission
	sta	BTC_H

	ldx	#11
	jsr	play_audio

	jsr	wait_until_keypress


	lda	#<atomic
	sta	BTC_L
	lda	#>atomic
	sta	BTC_H

	ldx	#16
	jsr	play_audio

	jsr	wait_until_keypress



done:
	jmp	test_audio


	.include "../audio.s"
	.include "../wait_keypress.s"
.align $100
transmission:
	.incbin "transmission.btc"
.align $100
atomic:
	.incbin "a_pboy.btc"
