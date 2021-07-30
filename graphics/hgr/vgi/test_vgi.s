; VGI Tester

.include "zp.inc"
.include "hardware.inc"


vgi_test:

	jsr	SETGR
	jsr	HGR
	bit	FULLGR

	jsr	vgi_make_tables

	; get pointer to image data

	lda	#<new_data
	sta	VGIL
	lda	#>new_data
	sta	VGIH

	jsr	play_vgi

	jsr	wait_until_keypress


done:
	jmp	done

.include "./vgi_fast/vgi_common.s"

.include "new.data"


	;============================
	; WAIT UNTIL KEYPRESS
	;============================

wait_until_keypress:

	lda	KEYPRESS
	bpl	wait_until_keypress

	bit	KEYRESET

	rts

