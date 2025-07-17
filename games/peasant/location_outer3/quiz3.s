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
	lda	WRONG_KEY
	bne	draw_keeper3_quiz1_again
	ldx	#<cave_outer_quiz3_1
	ldy	#>cave_outer_quiz3_1
	jmp	draw_keeper3_quiz_common
draw_keeper3_quiz1_again:
	ldx	#<cave_outer_quiz3_1again
	ldy	#>cave_outer_quiz3_1again
	jmp	draw_keeper3_quiz_common

draw_keeper3_quiz2:
	lda	WRONG_KEY
	bne	draw_keeper3_quiz2_again
	ldx	#<cave_outer_quiz3_2
	ldy	#>cave_outer_quiz3_2
	jmp	draw_keeper3_quiz_common
draw_keeper3_quiz2_again:
	ldx	#<cave_outer_quiz3_2again
	ldy	#>cave_outer_quiz3_2again
	jmp	draw_keeper3_quiz_common

draw_keeper3_quiz3:
	lda	WRONG_KEY
	bne	draw_keeper3_quiz3_again
	ldx	#<cave_outer_quiz3_3
	ldy	#>cave_outer_quiz3_3
	jmp	draw_keeper3_quiz_common
draw_keeper3_quiz3_again:
	ldx	#<cave_outer_quiz3_3again
	ldy	#>cave_outer_quiz3_3again
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




	;======================
	; quiz3 invalid answer
	;======================

invalid_answer:
	bit	KEYRESET	; clear the keyboard buffer

	inc	WRONG_KEY
	rts
.if 0
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
.endif

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
	sta	DRAW_PAGE_SAVE
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

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

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

quiz_answers:
	.byte 'C','A','C'


	;===============================
	; skeleton transform
	;===============================
skeleton_transform:

	lda	#0
	sta	SKELETON_COUNT

	; look down for this

	lda	#PEASANT_DIR_DOWN
	sta	PEASANT_DIR

skeleton_loop:
	;=============================
	; copy page (note this is going to mess with sound)

	; FIXME: instead just copy from BG like climb code?

	jsr	hgr_copy_faster


	; play sound if needed, 2.. 12

	lda	SKELETON_COUNT
	cmp	#2
	bcc	skip_skeleton_sound
	cmp	#12
	bcs	skip_skeleton_sound

	and	#1
	beq	skeleton_other_note

        lda     #NOTE_F6
	beq	skeleton_common_note		; bra
skeleton_other_note:
        lda     #NOTE_E6

skeleton_common_note:
        sta     speaker_frequency
        lda     #8
        sta     speaker_duration
        jsr     speaker_tone

skip_skeleton_sound:


	inc	SKELETON_COUNT
	ldx	SKELETON_COUNT

	; draw keeper

	lda     #28
	sta     SPRITE_X
	lda     #67
	sta     SPRITE_Y

        ; get offset for graphics

	ldx	SKELETON_COUNT
	lda	skeleton_which_keeper_sprite,X
	clc
	adc	#5			; skip skeleton
	tax

	jsr	hgr_draw_sprite_mask

	;=======================
	; see if done animation

	lda	SKELETON_COUNT
	cmp	#21		;
	beq	skeleton_done

	cmp	#12
	bcc	skeleton_peasant	; normal peasant first 12 frames

	ldx	SKELETON_COUNT

	lda     PEASANT_X
	sta     SPRITE_X
	lda     PEASANT_Y
	sta     SPRITE_Y

        ; get offset for graphics

	lda	skeleton_which_skeleton_sprite,X
	tax

	jsr	hgr_draw_sprite_mask

	jmp	done_skeleton_peasant

skeleton_peasant:
	;========================
	; draw peasant

	jsr	draw_peasant

	;========================
	; increment flame

	jsr	increment_flame

done_skeleton_peasant:

	;=========================
	; delay

;	lda	#200
;	jsr	wait

	;=========================
	; flip page

	jsr	hgr_page_flip

;	jsr	wait_vblank

	jmp	skeleton_loop

skeleton_done:

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
; first keeper skeleton info

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
; skeleton transition happens
;   (8) switches to 5 part way through first frame?
; 3 / skeleton next , to 1 part way through second (cloud frame)
; 5 skeleton (gap)
; 10 skeleton (tiny smoke)
; 10 full skeleton

skeleton_which_keeper_sprite:
.byte	3, 5, 6, 7
.byte	6, 7, 6, 7
.byte	6, 7, 6, 7

.byte   7, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1

skeleton_which_skeleton_sprite:
.byte	0, 0, 0, 0
.byte	0, 0, 0, 0
.byte	0, 0, 0, 0

.byte	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4

