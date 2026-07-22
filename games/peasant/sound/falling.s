	;=======================
	;=======================
	; falling (sound 662)
	;=======================
	;=======================
	; note we might want to break up

	; used in
	; (----)	676	location_kerrek1/2 (jhonka falling)
	; (----)	957	trogdor (flames, while sleeping)

falling_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_falling_sound

done_falling_sound:
        rts

