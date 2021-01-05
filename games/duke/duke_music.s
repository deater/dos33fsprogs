setup_music:

	;===================================
	; Setup Mockingboard
	;===================================
	lda	#0
	sta	DONE_PLAYING
	sta	LOOP

	; detect mockingboard
	jsr	mockingboard_detect

	bcc	mockingboard_notfound

mockingboard_found:
;       jsr     mockingboard_patch      ; patch to work in slots other than 4?

	lda	SOUND_STATUS
	ora	#SOUND_MOCKINGBOARD
	sta	SOUND_STATUS

	;=======================
	; Set up 50Hz interrupt
	;========================

	jsr	mockingboard_init
	jsr	mockingboard_setup_interrupt

	;============================
	; Init the Mockingboard
	;============================

	jsr	reset_ay_both
	jsr	clear_ay_both

	;==================
	; init song
	;==================

	jsr     pt3_init_song

	jmp     done_setup_sound


mockingboard_notfound:


done_setup_sound:

	rts


	;==========================
	; includes
	;==========================

	; pt3 player
	.include "pt3_lib_core.s"
	.include "pt3_lib_init.s"
	.include "interrupt_handler.s"
	.include "pt3_lib_mockingboard_detect.s"
	.include "pt3_lib_mockingboard_setup.s"


PT3_LOC = bg_music

.align $100
bg_music:
.incbin "music/theme.pt3"

