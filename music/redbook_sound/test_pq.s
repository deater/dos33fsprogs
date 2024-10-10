; try to test peasant quest sound effects

SOUND_OFFSET	= $F0
WHICH_SOUND	= $F1
INL		= $FE
INH		= $FF

KEYPRESS        = $C000
KEYRESET        = $C010

test_pq:
	lda	#0
	sta	WHICH_SOUND

next_sound:
	ldy	WHICH_SOUND
	lda	sounds_low,Y
	sta	INL
	lda	sounds_high,Y
	cmp	#$FF
	beq	test_pq		; reset

	sta	INH

	ldy	#0
	sty	SOUND_OFFSET
play_loop:
	ldy	SOUND_OFFSET
	lda	(INL),Y
	sta	speaker_frequency

	iny
	lda	(INL),Y
	cmp	#$FF
	beq	play_done

;	asl
;	clc
;	adc	(INL),Y

	sta	speaker_duration
	iny
	bne	no_wrap
	inc	INH
no_wrap:

	sty	SOUND_OFFSET

	jsr	speaker_tone

	jmp	play_loop


play_done:
	lda	KEYPRESS
	bpl	play_done

	bit	KEYRESET

	inc	WHICH_SOUND

	jmp	next_sound



;.include "redbook_sound.s"
.include "longer_sound.s"
.include "pq_sounds.inc"


sounds_low:
	.byte <THUMP
	.byte <THUMP2
	.byte $FF

sounds_high:
	.byte >THUMP
	.byte >THUMP2
	.byte $FF
