	;=======================
	;=======================
	; mud splat
	;=======================
	;=======================

	; used in

	; (done)   60	target: arrow miss at bullseye
	; (done)  425	location_gary: kicked by gary
	; (done)	location_hidden_glen: arrow to head
	;		location_puddle: fall in mud
	;         675	location_kerrek1/2: kerrek hit on head
	;         961	?
	;        1118	save game?
	;        1181	fall off cliff?

mud_splat_sound:
arrow_miss_sound:

	; based on the arrow miss sound

        lda     #NOTE_G3
        sta     speaker_frequency

        lda     #30
        sta     speaker_duration

        jsr     speaker_tone

        rts

