	;=======================
	;=======================
	;=======================
	; trogdor inner
	;=======================
	;=======================
	;=======================

trogdor_inner_verb_table:
;	.byte VERB_LOOK
;	.word cliff_base_look-1
	.byte 0



trogdor_cave:

	lda	#<trogdor_cave_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_cave_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	;======================
	; draw rather dashing

	lda	#12
	sta	CURSOR_X
	lda	#142
	sta	CURSOR_Y

	lda	#<dashing0_sprite
	sta	INL
	lda	#>dashing0_sprite
	sta	INH

	jsr	hgr_draw_sprite


	jsr	update_top

	jsr	wait_until_keypress

	;==============================
	;==============================
	; print honestly say message
	;==============================
	;==============================

	ldx	#<trogdor_honestly_message
	ldy	#>trogdor_honestly_message
	jsr	finish_parse_message_nowait

	;==================================
	; text to speech, where available!

	lda	SOUND_STATUS
	and	#SOUND_SSI263
	beq	skip_speech

speech_loop:

        ; trogdor

	lda	#4			; assume slot #4 for now
	jsr	ssi263_speech_init

        lda     #<trogdor_honestly
        sta     SPEECH_PTRL
        lda     #>trogdor_honestly
        sta     SPEECH_PTRH

        jsr     ssi263_speak

wait_for_speech:
	lda	speech_busy
	bmi	wait_for_speech
	bpl	done_speech

skip_speech:
	jsr	wait_until_keypress

done_speech:
	jsr	hgr_partial_restore


	;==============================
	;==============================
	; print nice of him message
	;==============================
	;==============================

	ldx	#<trogdor_honestly_message2
	ldy	#>trogdor_honestly_message2
	jsr	finish_parse_message


	; UPDATE SCORE

	lda	#$10		; it's BCD
	jsr	score_points

trogdor_open:

	lda	#<trogdor_open_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_open_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	;======================
	; draw rather dashing

	lda	#12
	sta	CURSOR_X
	lda	#142
	sta	CURSOR_Y

	lda	#<dashing0_sprite
	sta	INL
	lda	#>dashing0_sprite
	sta	INH

	jsr	hgr_draw_sprite

	jsr	update_top

;	jsr	wait_until_keypress


trogdor_flame1:

	lda	#<trogdor_flame1_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_flame1_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

trogdor_flame2:

	lda	#<trogdor_flame2_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_flame2_lzsa
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast


	ldx	#32
	stx	BABY_COUNT

burninate_loop:
	bit	PAGE1

	lda     #16
        sta     speaker_duration
        lda     #NOTE_C3
        sta     speaker_frequency
        jsr     speaker_beep

;	jsr	wait_until_keypress

	bit	PAGE2

	lda     #16
        sta     speaker_duration
        lda     #NOTE_D3
        sta     speaker_frequency
        jsr     speaker_beep

;	jsr	wait_until_keypress

	dec	BABY_COUNT
	bne	burninate_loop


	;=====================
	;=====================
	; stop fire
	; open mouth
	; charred
	; smoke

	lda	#<trogdor_cave_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_cave_lzsa
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	jsr	update_top

	;======================
	; draw rather dashing

	lda	#12
	sta	CURSOR_X
	lda	#142
	sta	CURSOR_Y

	lda	#1
	sta	BABY_COUNT

dashing_loop:

	ldy	BABY_COUNT
	lda	dashing_progress_l,Y
	sta	INL
	lda	dashing_progress_h,Y
	sta	INH

	jsr	hgr_draw_sprite

	lda	#220
	jsr	wait

	ldy	BABY_COUNT
	cpy	#7
	bne	no_boom

	lda     #64
        sta     speaker_duration
        lda     #NOTE_C3
        sta     speaker_frequency
        jsr     speaker_beep

no_boom:

	inc	BABY_COUNT
	lda	BABY_COUNT
	cmp	#9
	bne	dashing_loop


	; collapse with boom

	;==================
	; message

	ldx	#<trogdor_honestly_message3
	ldy	#>trogdor_honestly_message3
	jsr	finish_parse_message

game_over:

	; go to end credits

	lda     #LOAD_ENDING
        sta     WHICH_LOAD

        rts

dashing_progress_l:
	.byte <dashing0_sprite,<dashing1_sprite,<dashing2_sprite
	.byte <dashing3_sprite,<dashing4_sprite,<dashing5_sprite
	.byte <dashing6_sprite,<dashing7_sprite,<dashing8_sprite

dashing_progress_h:
	.byte >dashing0_sprite,>dashing1_sprite,>dashing2_sprite
	.byte >dashing3_sprite,>dashing4_sprite,>dashing5_sprite
	.byte >dashing6_sprite,>dashing7_sprite,>dashing8_sprite


.include "dialog_trogdor.inc"
