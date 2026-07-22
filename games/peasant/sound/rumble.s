	;=======================
	;=======================
	; rumble (sound 514)
	;=======================
	;=======================
	; note we might want to break up

	; used in
	; (----)	522	location_jhonka (jhonka beat you)
	; (done)	566	location_lake_east (fish biting)

rumble_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_rumble_sound

done_rumble_sound:
        rts

