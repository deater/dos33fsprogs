	;=======================
	;=======================
	; mud slip
	;=======================
	;=======================

	; used in
	;	425
	; (done)	location_puddle: slip in mud
	; (done)	location_lake_west: baby throw
	; (done)	location_outer: question wrong
	; (done)	location_outer2: question wrong
	; (done)	location_outer3: question wrong



mud_slip_sound:

	lda	SOUND_STATUS		; if sound disabled
	bmi	done_mud_slip_sound

done_mud_slip_sound:
        rts

