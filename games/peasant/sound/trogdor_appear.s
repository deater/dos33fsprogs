	;=======================
	;=======================
	; trogdor_appear (sound 927)
	;=======================
	;=======================
	; used in
	;	954		trogdor

trogdor_appear_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_trogdor_appear_sound


done_trogdor_appear_sound:
        rts

