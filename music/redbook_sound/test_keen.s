
SOUND_OFFSET = $F0

KEYPRESS        =       $C000
KEYRESET        =       $C010

test_keen:

	ldy	#0
	sty	SOUND_OFFSET
play_loop:
	ldy	SOUND_OFFSET
	lda	LVLDONESND,Y
	sta	speaker_frequency
	iny
	lda	LVLDONESND,Y
	cmp	#$FF
	beq	play_done

	asl
	clc
	adc	LVLDONESND,Y

	sta	speaker_duration
	iny
	sty	SOUND_OFFSET

	jsr	speaker_tone

	jmp	play_loop


play_done:
	lda	KEYPRESS
	bpl	play_done

	bit	KEYRESET

	jmp	test_keen



.include "redbook_sound.s"
.include "lvldone.inc"

