
	;=============================
	; Setup
	;=============================
pt3_setup:

	;===============
	; init variables
	;===============

	lda	#0
	sta	DONE_PLAYING
	sta	LOOP

	;=======================
	; Detect mockingboard
	;========================

	; Note, we do this, but then ignore it, as sometimes
	; the test fails and then you don't get music.
	; In theory this could do bad things if you had something
	; easily confused in slot4, but that's probably not an issue.

	jsr	mockingboard_detect_slot4

	;=========================
	; Setup Interrupt Handler
	;=========================

	jsr	mockingboard_init
	jsr	pt3_setup_interrupt

	;============================
	; Reset the Mockingboard
	;============================


	jsr	reset_ay_both
	jsr	clear_ay_both

	;==================
	; init song
	;==================

	jsr	pt3_init_song

	rts
