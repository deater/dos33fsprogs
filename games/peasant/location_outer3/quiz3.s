	;=========================
	; take quiz3
	;=========================

take_quiz:

quiz3_loop:

	;=======================
	; check keyboard special

	jsr	check_keyboard_answer

	lda	IN_QUIZ
	beq	done_quiz3

	;========================
	; draw_scene

	jsr	update_screen

	;=======================
	; draw quiz message

	lda	WHICH_QUIZ
	cmp	#2
	beq	draw_keeper3_quiz3
	cmp	#1
	beq	draw_keeper3_quiz2

draw_keeper3_quiz1:
	ldx	#<cave_outer_quiz3_1
	ldy	#>cave_outer_quiz3_1
	jmp	draw_keeper3_quiz_common

draw_keeper3_quiz2:
	ldx	#<cave_outer_quiz3_2
	ldy	#>cave_outer_quiz3_2
	jmp	draw_keeper3_quiz_common

draw_keeper3_quiz3:
	ldx	#<cave_outer_quiz3_3
	ldy	#>cave_outer_quiz3_3
draw_keeper3_quiz_common:
	stx	OUTL
	sty	OUTH
	jsr     print_text_message


	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; increment flame

	jsr	increment_flame


	;=======================
	; flip page

;       jsr     wait_vblank

	jsr	hgr_page_flip

	jmp	quiz3_loop

done_quiz3:
	rts



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

	pla

	and	#$7f	; strip high bit
	and	#$df	; convert to lowercase $61 -> $41  0110 -> 0100

	cmp	#'A'
	bcc	invalid_answer		; blt
	cmp	#'D'
	bcs	invalid_answer		; bge

	ldx	WHICH_QUIZ

	cmp	quiz3_answers,X
	beq	right_answer
	bne	wrong_answer

no_answer:
	rts

	;======================
	; quiz3 invalid answer
	;======================

invalid_answer:
	bit	KEYRESET	; clear the keyboard buffer

	lda	WHICH_QUIZ
	cmp	#2		; off by 1
	beq	resay_quiz3
	cmp	#1
	beq	resay_quiz2

resay_quiz1:
	ldx	#<cave_outer_quiz3_1again
	ldy	#>cave_outer_quiz3_1again
	jmp	finish_parse_message_nowait
resay_quiz2:
	ldx	#<cave_outer_quiz3_2again
	ldy	#>cave_outer_quiz3_2again
	jmp	finish_parse_message_nowait
resay_quiz3:
	ldx	#<cave_outer_quiz3_3again
	ldy	#>cave_outer_quiz3_3again
	jmp	finish_parse_message_nowait


	;======================
	; quiz3 wrong answer
	;======================

wrong_answer:
	bit	KEYRESET	; clear the keyboard buffer

	ldx     #<cave_outer_quiz3_wrong
	ldy     #>cave_outer_quiz3_wrong
	jsr	finish_parse_message

	; transform to skeleton

	jsr	skeleton_transform

after_skeleton:

	; force message to current page

	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE

	ldx     #<cave_outer_quiz3_wrong_part2
	ldy     #>cave_outer_quiz3_wrong_part2

	; hack so still displayed for message

	stx     OUTL
        sty     OUTH
        jsr     print_text_message
 ;       jsr     hgr_page_flip
        bit     KEYRESET
        jsr     wait_until_keypress




;	jsr	finish_parse_message


	lda	#0
	sta	IN_QUIZ

	; game over

	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER

	rts

	;======================
	; quiz3 correct answer
	;======================

right_answer:
	bit	KEYRESET	; clear the keyboard buffer

	ldx     #<cave_outer_quiz3_correct
	ldy     #>cave_outer_quiz3_correct
	jsr	finish_parse_message

	ldx     #<cave_outer_quiz3_correct_part2
	ldy     #>cave_outer_quiz3_correct_part2
	jsr	finish_parse_message

	ldx     #<cave_outer_quiz3_correct_part3
	ldy     #>cave_outer_quiz3_correct_part3
	jsr	finish_parse_message

	jsr	cave_outer_get_sword

	rts

quiz3_answers:
	.byte 'C','C','A'


	;===============================
	; skeleton transform
	;===============================
skeleton_transform:

	lda	#0
	sta	RON_COUNT

	; look down for this

	lda	#PEASANT_DIR_DOWN
	sta	PEASANT_DIR

ron1_loop:
	;=============================
	; copy page (note this is going to mess with sound)

	; FIXME: instead just copy from BG like climb code?

	jsr	hgr_copy_faster


	; play sound if needed, 2.. 12

	lda	RON_COUNT
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


	inc	RON_COUNT
	ldx	RON_COUNT

	lda     #10
	sta     SPRITE_X
	lda     #60
	sta     SPRITE_Y

        ; get offset for graphics

	ldx	RON_COUNT
	lda	ron_which_keeper_sprite,X
	clc
	adc	#5			; skip ron
	tax

	jsr	hgr_draw_sprite_mask

	;=======================
	; see if done animation
blurgh:
	lda	RON_COUNT
	cmp	#21		;
	beq	ron_done

	cmp	#12
	bcc	ron_peasant	; normal peasant first 12 frames

	ldx	RON_COUNT

	lda     PEASANT_X
	sta     SPRITE_X
	lda     PEASANT_Y
	sta     SPRITE_Y

        ; get offset for graphics

;	ldx	RON_COUNT
	lda	ron_which_ron_sprite,X
	tax

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

;	lda	#200
;	jsr	wait

	;=========================
	; flip page

	jsr	hgr_page_flip

;	jsr	wait_vblank

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

