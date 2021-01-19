setup_music:

	;===================================
	; Setup Mockingboard
	;===================================
	lda	#0
	sta	DONE_PLAYING
	lda	#1
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

	jsr	music_load_fighting
	jsr     pt3_init_song

	jmp     done_setup_sound


mockingboard_notfound:


done_setup_sound:

	rts


music_load_fighting:

	lda	#<(fighting_lzsa)
	sta	getsrc_smc+1
	lda	#>(fighting_lzsa)
	sta	getsrc_smc+2

	lda	#$AE

	jsr	decompress_lzsa2_fast
	rts


music_load_victory:

	lda	#<(victory_lzsa)
	sta	getsrc_smc+1
	lda	#>(victory_lzsa)
	sta	getsrc_smc+2

	lda	#$AE

	jsr	decompress_lzsa2_fast
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


PT3_LOC = $AE00

	.include "music/battle_music.inc"
