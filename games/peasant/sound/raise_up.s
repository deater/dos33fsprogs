	;=======================
	;=======================
	; raise_up (sound 323)
	;=======================
	;=======================

	; used in
	; (----)	425	kerrek1/kerrek2: raise up belt
	; (done)		outer3: raise up sword

raise_up_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_raise_up_sound

done_raise_up_sound:
        rts

