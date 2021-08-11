; o/~ Burnintating the Peasants o/~


	;************************
	; Title
	;************************
title:
	lda	#<(title_lzsa)
	sta	getsrc_smc+1
	lda	#>(title_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	wait_until_keypress

	rts
