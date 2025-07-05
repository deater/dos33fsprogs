	;==============================
	; check_keyboard_answer
	;==============================
	; for when in quiz
	; looking for just A, B, or C

check_keyboard_answer:

	lda	KEYPRESS
	bpl	no_answer

	bit	KEYRESET

	pha
	jsr	restore_parse_message

	lda	#0
	sta	REFRESH_SCREEN	; don't refresh or we draw keeper on top

	pla

	and	#$7f	; strip high bit
	and	#$df	; convert to lowercase $61 -> $41  0110 -> 0100

	cmp	#'A'
	bcc	invalid_answer		; blt
	cmp	#'D'
	bcs	invalid_answer		; bge

	ldx	WHICH_QUIZ

	cmp	quiz1_answers,X
	beq	right_answer
	bne	wrong_answer

no_answer:
	rts

	;======================
	; quiz1 invalid answer
	;======================

invalid_answer:
	bit	KEYRESET	; clear the keyboard buffer

	lda	WHICH_QUIZ
	cmp	#2		; off by 1
	beq	resay_quiz3
	cmp	#1
	beq	resay_quiz2

resay_quiz1:
	ldx	#<cave_outer_quiz1_1again
	ldy	#>cave_outer_quiz1_1again
	jmp	finish_parse_message_nowait
resay_quiz2:
	ldx	#<cave_outer_quiz1_2again
	ldy	#>cave_outer_quiz1_2again
	jmp	finish_parse_message_nowait
resay_quiz3:
	ldx	#<cave_outer_quiz1_3again
	ldy	#>cave_outer_quiz1_3again
	jmp	finish_parse_message_nowait


	;======================
	; quiz1 wrong answer
	;======================

wrong_answer:
	bit	KEYRESET	; clear the keyboard buffer

	ldx     #<cave_outer_quiz1_wrong
	ldy     #>cave_outer_quiz1_wrong
	jsr	finish_parse_message

;	jsr	draw_standing_keeper

	ldx     #<cave_outer_quiz1_wrong_part2
	ldy     #>cave_outer_quiz1_wrong_part2
	jsr	finish_parse_message

;	jsr	draw_standing_keeper

	ldx     #<cave_outer_quiz1_wrong_part3
	ldy     #>cave_outer_quiz1_wrong_part3
	jsr	finish_parse_message

	; transform to ron

	jsr	ron_transform

	ldx     #<cave_outer_quiz1_wrong_part4
	ldy     #>cave_outer_quiz1_wrong_part4
	jsr	finish_parse_message

	lda	#0
	sta	IN_QUIZ

	; game over

	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	rts

	;======================
	; quiz1 correct answer
	;======================

right_answer:
	bit	KEYRESET	; clear the keyboard buffer
	ldx     #<cave_outer_quiz1_correct
	ldy     #>cave_outer_quiz1_correct
	jsr	finish_parse_message

	jsr	cave_outer_get_shield

	; FIXME: animate keeper backing off

	rts

quiz1_answers:
	.byte 'B','A','C'


	;===============================
	; ron transform
	;===============================
ron_transform:

	lda	#0
	sta	KEEPER_COUNT

	; look down for this

	lda	#PEASANT_DIR_DOWN
	sta	PEASANT_DIR

ron1_loop:

	; play sound if needed, 2.. 12

	lda	KEEPER_COUNT
	cmp	#2
	bcc	skip_ron_sound
	cmp	#12
	bcs	skip_ron_sound

	and	#1
	beq	ron_other_note

        lda     #NOTE_F6
	beq	ron_common_note		; bra
ron_other_note:
        lda     #NOTE_E6

ron_common_note:
        sta     speaker_frequency
        lda     #8
        sta     speaker_duration
        jsr     speaker_tone

skip_ron_sound:

	; erase prev keeper

;	ldy	#3                      ; erase slot 3?
;	jsr	hgr_partial_restore_by_num

	inc	KEEPER_COUNT
	ldx	KEEPER_COUNT

	lda     #10
	sta     SPRITE_X
	lda     #60
	sta     SPRITE_Y

        ; get offset for graphics

	ldx	KEEPER_COUNT
	lda	ron_which_keeper_sprite,X
	clc
	adc	#5			; skip ron
	tax

;	ldy     #3      ; ? slot

;	jsr	hgr_draw_sprite_save
	jsr	hgr_draw_sprite_mask

	;=======================
	; see if done animation

	lda	KEEPER_COUNT
	cmp	#21		;
	beq	ron_done

	cmp	#12
	bcc	ron_peasant	; normal peasant first 12 frames

	; erase prev peasant

;	ldy	#4				; erase slot 4?
;	jsr	hgr_partial_restore_by_num

	ldx	KEEPER_COUNT

	lda     PEASANT_X
	sta     SPRITE_X
	lda     PEASANT_Y
	sta     SPRITE_Y

        ; get offset for graphics

;	ldx	KEEPER_COUNT
	lda	ron_which_ron_sprite,X
	tax

;	ldy     #4	; ? slot

;	jsr	hgr_draw_sprite_save
	jsr	hgr_draw_sprite_mask

	jmp	done_ron_peasant

ron_peasant:
	;========================
	; draw peasant

	jsr	draw_peasant


	;========================
	; increment flame

	jsr	increment_flame
done_ron_peasant:

	;=========================
	; delay

	lda	#200
	jsr	wait

	jsr	wait_vblank

	jmp	ron1_loop

ron_done:

	;===========================
        ; weep sound

        lda     #32
        sta     speaker_duration
        lda     #NOTE_E5
        sta     speaker_frequency
        jsr     speaker_tone
        lda     #64
        sta     speaker_duration
        lda     #NOTE_F5
        sta     speaker_frequency
        jsr     speaker_tone

	jsr	wait_until_keypress

	rts




;==========================================
; first keeper ron info

; flips peasant forward
; 3 (4) (u shaped)
; 5 (4) (up)
; 6 (6) (up, up)
; 7 (4) (up, down)
; 6 (4)
; 7 (4)
; 6 (4)
; 7 (4)
; 6 (4)
; 7 (4)
; 6 (4)
; 7 (4) 9? repeats, ending on down
; ron transition happens
;   (8) switches to 5 part way through first frame?
; 3 / ron next , to 1 part way through second (cloud frame)
; 5 ron (gap)
; 10 ron (tiny smoke)
; 10 full ron

ron_which_keeper_sprite:
.byte	3, 5, 6, 7
.byte	6, 7, 6, 7
.byte	6, 7, 6, 7

.byte   7, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1

ron_which_ron_sprite:
.byte	0, 0, 0, 0
.byte	0, 0, 0, 0
.byte	0, 0, 0, 0

.byte	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4

