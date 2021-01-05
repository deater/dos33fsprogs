;
;

chapter1_transition:

	;===================================
	; show chpater screen and play music
	;===================================

	lda	#<part1_lzsa
	sta	LZSA_SRC_LO
	lda	#>part1_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	; copy over background
	jsr	gr_copy_to_current

	 ; flip page
	jsr	page_flip


	;=============================
	; play music if mockingboard
	;=============================

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	skip_start_music
	cli

skip_start_music:

	ldx	#$D0
	jsr	wait_a_bit


	; turn off music
	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	skip_turn_off_music

	sei                             ; disable interrupts

	jsr     clear_ay_both

skip_turn_off_music:

	rts
