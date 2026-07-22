	;=======================
	;=======================
	; baby lady gone
	;=======================
	;=======================
	; beep boop bop

	; used in
	;	425
	; (done)	haystack blows away
	; (done)	lady_cottage: when lady goes away after give riches

baby_lady_gone_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_baby_lady_sound

done_baby_lady_sound:
        rts

