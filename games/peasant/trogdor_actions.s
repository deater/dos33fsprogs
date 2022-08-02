.include "tokens.inc"

	;=======================
	;=======================
	;=======================
	; trogdor inner
	;=======================
	;=======================
	;=======================

trogdor_inner_verb_table:
	.byte VERB_ATTACK
	.word trogdor_attack-1
	.byte VERB_KILL
	.word trogdor_attack-1
	.byte VERB_SLAY
	.word trogdor_attack-1
	.byte VERB_LOOK
	.word trogdor_look-1
	.byte VERB_WAKE
	.word trogdor_wake-1
	.byte VERB_TALK
	.word trogdor_talk-1
	.byte VERB_THROW
	.word trogdor_throw-1
	.byte 0


trogdor_look:

	lda     CURRENT_NOUN
	cmp	#NOUN_NONE
	beq	trogdor_look_at
	cmp	#NOUN_DRAGON
	beq	trogdor_look_trogdor
	cmp	#NOUN_TROGDOR
	beq	trogdor_look_trogdor

	jmp	parse_common_look

trogdor_look_at:
	ldx	#<trogdor_look_message
	ldy	#>trogdor_look_message
	jmp	finish_parse_message

trogdor_look_trogdor:
	ldx	#<trogdor_look_trogdor_message
	ldy	#>trogdor_look_trogdor_message
	jmp	finish_parse_message


trogdor_wake:

	lda     CURRENT_NOUN
	cmp	#NOUN_DRAGON
	beq	trogdor_wake_trogdor
	cmp	#NOUN_TROGDOR
	beq	trogdor_wake_trogdor

	jmp	parse_common_unknown

trogdor_wake_trogdor:
	ldx	#<trogdor_wake_message
	ldy	#>trogdor_wake_message
	jmp	finish_parse_message

trogdor_attack:
	lda     CURRENT_NOUN
	cmp	#NOUN_DRAGON
	beq	trogdor_attack_trogdor
	cmp	#NOUN_TROGDOR
	beq	trogdor_attack_trogdor

	jmp	parse_common_unknown

trogdor_attack_trogdor:
	ldx	#<trogdor_attack_message
	ldy	#>trogdor_attack_message
	jmp	finish_parse_message


trogdor_talk:
	lda     CURRENT_NOUN
	cmp	#NOUN_DRAGON
	beq	trogdor_talk_trogdor
	cmp	#NOUN_TROGDOR
	beq	trogdor_talk_trogdor

	jmp	parse_common_talk

trogdor_talk_trogdor:
	ldx	#<trogdor_talk_message
	ldy	#>trogdor_talk_message
	jmp	finish_parse_message


trogdor_throw:
	lda     CURRENT_NOUN
	cmp	#NOUN_SWORD
	beq	trogdor_throw_sword

	jmp	parse_common_unknown

trogdor_throw_sword:
	ldx	#<trogdor_throw_sword_message
	ldy	#>trogdor_throw_sword_message
	jsr	partial_message_step

	lda	#7
	jsr	score_points

	ldx	#<trogdor_throw_sword_message2
	ldy	#>trogdor_throw_sword_message2
	jsr	partial_message_step

	ldx	#<trogdor_throw_sword_message3
	ldy	#>trogdor_throw_sword_message3
	jsr	partial_message_step

	ldx	#<trogdor_throw_sword_message4
	ldy	#>trogdor_throw_sword_message4
	jsr	partial_message_step

	;==============================
	; now we can no longer move
	;	you have about 10s or so to say "look" or "talk"
	;	otherwise it continues to the ending

	jsr	clear_bottom
	lda	#$60			; modify parse input to return
	sta	parse_input_smc		; rather than verb-jump


	lda	#$FF
	sta	BABY_COUNT

trogdor_awake_loop:

	lda	#120
	jsr	wait

	lda	KEYPRESS
	bpl	awake_no_keypress

	jsr	clear_bottom
	jsr	hgr_input

        jsr     parse_input

        lda     CURRENT_VERB
        cmp     #VERB_LOOK
	bne     awake_check_talk
awake_looking:
	ldx	#<trogdor_look_awake_message
	ldy	#>trogdor_look_awake_message
	jsr	partial_message_step
	jmp	awake_try_again

awake_check_talk:
        cmp     #VERB_TALK
        beq     awake_talk_trogdor

awake_default:
	ldx	#<trogdor_awake_message
	ldy	#>trogdor_awake_message
	jsr	partial_message_step

awake_try_again:
	jsr	clear_bottom

awake_no_keypress:
	dec	BABY_COUNT
	bne	trogdor_awake_loop


	; we timed out!  Skip to burnination
	jmp	burninate_rather_dashing


awake_talk_trogdor:

	lda	#<trogdor_cave_zx02
	sta	zx_src_l+1
	lda	#>trogdor_cave_zx02
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp

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


	;========================
	;

	ldx	#<end_talk_message
	ldy	#>end_talk_message
	jsr	partial_message_step

	;==============================
	;==============================
	; print sup message
	;==============================
	;==============================

	ldx	#<trogdor_sup_message
	ldy	#>trogdor_sup_message
	jsr	finish_parse_message_nowait

        lda     #<trogdor_sup
        sta     SPEECH_PTRL
        lda     #>trogdor_sup
        sta     SPEECH_PTRH

	jsr	trogdor_talks


	;==============================
	;==============================
	; print surprised message
	;==============================
	;==============================

	ldx	#<trogdor_surprised_message
	ldy	#>trogdor_surprised_message
	jsr	finish_parse_message_nowait

        lda     #<trogdor_surprised
        sta     SPEECH_PTRL
        lda     #>trogdor_surprised
        sta     SPEECH_PTRH

	jsr	trogdor_talks



	;==============================
	;==============================
	; print honestly say message
	;==============================
	;==============================

	ldx	#<trogdor_honestly_message
	ldy	#>trogdor_honestly_message
	jsr	finish_parse_message_nowait



        lda     #<trogdor_honestly
        sta     SPEECH_PTRL
        lda     #>trogdor_honestly
        sta     SPEECH_PTRH

	jsr	trogdor_talks


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

burninate_rather_dashing:

trogdor_open:

	lda	#<trogdor_open_zx02
	sta	zx_src_l+1
	lda	#>trogdor_open_zx02
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp

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

	lda	#<trogdor_flame1_zx02
	sta	zx_src_l+1
	lda	#>trogdor_flame1_zx02
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp

trogdor_flame2:

	lda	#<trogdor_flame2_zx02
	sta	zx_src_l+1
	lda	#>trogdor_flame2_zx02
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp


	ldx	#32
	stx	BABY_COUNT

burninate_loop:
	bit	PAGE1

	lda     #16
        sta     speaker_duration
        lda     #NOTE_C3
        sta     speaker_frequency
        jsr     speaker_beep

	bit	PAGE2

	lda     #16
        sta     speaker_duration
        lda     #NOTE_D3
        sta     speaker_frequency
        jsr     speaker_beep

	dec	BABY_COUNT
	bne	burninate_loop


	;=====================
	;=====================
	; stop fire
	; open mouth
	; charred
	; smoke

	lda	#<trogdor_cave_zx02
	sta	zx_src_l+1
	lda	#>trogdor_cave_zx02
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp

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

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	lda     #LOAD_ENDING
        sta     WHICH_LOAD

        rts



	;============================
	; trogdor talks
	;============================

trogdor_talks:

	;==================================
	; text to speech, where available!

	lda	SOUND_STATUS
	and	#SOUND_SSI263
	beq	skip_speech

	lda	MOCKINGBOARD_SLOT		; assume slot #4 for now
	jsr	ssi263_speech_init

        jsr     ssi263_speak

	bit	KEYRESET
wait_for_speech:
	lda	KEYPRESS
	bmi	cancel_speech

	lda	speech_busy
	bmi	wait_for_speech
	bpl	done_speech

cancel_speech:
	bit	KEYRESET

	jsr	ssi263_speech_shutdown

	jmp	done_speech


skip_speech:
	jsr	wait_until_keypress

done_speech:
	lda	#0
	ldx	#39
	jsr	hgr_partial_restore

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

