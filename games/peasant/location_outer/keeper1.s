	;===============================
	; handle keeper1
	;===============================
	; handle keeper1
	;	stop walking
	;	have keeper come out to talk
	;	special limited handling
	;	can't walk unless win
handle_keeper1:

	lda	#0		; stop walking
	sta	PEASANT_XADD
	sta	PEASANT_YADD
	sta	KEEPER_COUNT

	lda	#1		; start a quiz
	sta	IN_QUIZ

	;===========================
	; animate keeper coming out

	jsr	keeper1_emerge


	;===================
	; talking to keeper

keeper_talk1:
	; print the message

	ldx     #<cave_outer_keeper1_message1
	ldy     #>cave_outer_keeper1_message1
	jsr	finish_parse_message

;	jsr	draw_standing_keeper

	ldx     #<cave_outer_keeper1_message2
	ldy     #>cave_outer_keeper1_message2
	jsr     finish_parse_message

;	jsr	draw_standing_keeper

	ldx     #<cave_outer_keeper1_message3
	ldy     #>cave_outer_keeper1_message3
	jsr     finish_parse_message

;	jsr	draw_standing_keeper

	ldx     #<cave_outer_keeper1_message4
	ldy     #>cave_outer_keeper1_message4
	jsr     finish_parse_message

;	jsr	draw_standing_keeper

	;===============================================
	; if have sub print5, otherwise skip ahead

	lda	INVENTORY_2
	and	#INV2_MEATBALL_SUB
	beq	dont_have_sub

	ldx     #<cave_outer_keeper1_message5
	ldy     #>cave_outer_keeper1_message5
	jsr     finish_parse_message

;	jsr	draw_standing_keeper

dont_have_sub:

	; now we need to re-draw keeper
	; also we're in quiz mode
	; so we can't move and can only take quiz or give sub

;	lda	#1
;	sta	IN_QUIZ

	; custom common verb table the essentially does nothing
	jsr	setup_quiz_verb_table

	; respond only to take quiz and give sub
	lda	#<keeper1_verb_table
	sta	INL
	lda	#>keeper1_verb_table
	sta	INH
	jsr	load_custom_verb_table

	jmp	game_loop




	;=========================
	; keeper1 emerge
	;=========================

keeper1_emerge:
	lda	#0
	sta	KEEPER_COUNT

keeper1_emerge_loop:

	;=======================
	; move to next frame

	inc	KEEPER_COUNT

	;=======================
	; see if done animation

	lda	KEEPER_COUNT
	cmp	#20
	beq	done_keeper1_emerge

	;========================
	; draw_scene

	jsr	update_screen

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

	jmp	keeper1_emerge_loop

done_keeper1_emerge:
	rts


	;=========================
	; keeper1 retreat
	;=========================

keeper1_retreat:
	lda	#19
	sta	KEEPER_COUNT

keeper1_retreat_loop:

	;=======================
	; move to next frame

	dec	KEEPER_COUNT

	;=======================
	; see if done animation

	lda	KEEPER_COUNT
	beq	done_keeper1_retreat

	;========================
	; draw_scene

	jsr	update_screen

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

	jmp	keeper1_retreat_loop

done_keeper1_retreat:
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

	;============================
	; setup outer verb table
	;============================
	; we do this a lot so make it a function

setup_outer_verb_table:
	; setup default verb table

	jsr	setup_default_verb_table

	; local verb table

	lda	#<cave_outer_verb_table
	sta	INL
	lda	#>cave_outer_verb_table
	sta	INH
	jsr	load_custom_verb_table

	; FIXME: tail call

	rts



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





	;==========================
	; draw standing keeper
	;==========================
;draw_standing_keeper:
;
;	ldx	#19		; standing
;	stx	KEEPER_COUNT

	;==========================
	; draw keeper
	;==========================
	; which frame in KEEPER_COUNT
draw_keeper:

	ldx	KEEPER_COUNT

	lda     keeper_x,X
	sta     SPRITE_X
	lda     keeper_y,X
	sta     SPRITE_Y

        ; get offset for graphics

	lda	which_keeper_sprite,X
	clc
	adc	#5			; skip ron
	tax

	jsr	hgr_draw_sprite_mask

	rts

sprites_xsize:
	.byte  2, 2, 2, 2, 2			; ron 0..4
	.byte  2, 2, 3, 3, 3, 3, 3, 3		; keeper 0..7

sprites_ysize:
	.byte 29,30,30,30,30			; ron 0..4
	.byte 28,28,28,28,28,28,28,28		; keeper 0..7

sprites_data_l:
	.byte <ron0,<ron1,<ron2,<ron3,<ron4
	.byte <keeper_r0,<keeper_r1,<keeper_r2,<keeper_r3
	.byte <keeper_r4,<keeper_r5,<keeper_r6,<keeper_r7

sprites_data_h:
	.byte >ron0,>ron1,>ron2,>ron3,>ron4
	.byte >keeper_r0,>keeper_r1,>keeper_r2,>keeper_r3
	.byte >keeper_r4,>keeper_r5,>keeper_r6,>keeper_r7


sprites_mask_l:
	.byte <ron0_mask,<ron1_mask,<ron2_mask,<ron3_mask,<ron4_mask
	.byte <keeper_r0_mask,<keeper_r1_mask,<keeper_r2_mask,<keeper_r3_mask
	.byte <keeper_r4_mask,<keeper_r5_mask,<keeper_r6_mask,<keeper_r7_mask


sprites_mask_h:
	.byte >ron0_mask,>ron1_mask,>ron2_mask,>ron3_mask,>ron4_mask
	.byte >keeper_r0_mask,>keeper_r1_mask,>keeper_r2_mask,>keeper_r3_mask
	.byte >keeper_r4_mask,>keeper_r5_mask,>keeper_r6_mask,>keeper_r7_mask



;==========================================
; first keeper info
;
;	seems to trigger at approx peasant_x = 70 (10)
;

; 0 (4), move down/r
; 0 (4), move down/r
; 1 (4), no move
; 1 (5), move down/r

; 1 (5), move down/r
; 1 (5), move down/r
; 1 (5), move down/r
; 1 (5), move down/r

; 2 (5)
; 3 (4)
; 4 (10)
; 3 (10)

; 4 (15)
; 3 (5)
; 2 (5)
; 1 (11) ; starts talking



keeper_x:
.byte   9, 9,10,10
.byte  10,10,10,10
.byte  10,10,10,10, 10,10
.byte  10,10,10,10,10,10,10

keeper_y:
.byte	51,52,53,54
.byte   56,58,59,60
.byte	60,60,60,60, 60,60
.byte	60,60,60,60, 60,60,60

which_keeper_sprite:
.byte	0, 0, 1, 1
.byte	1, 1, 1, 1
.byte	2, 3, 4, 4, 3, 3

.byte   4, 4, 4, 3, 2, 1, 1



;==========================================
; first keeper ron

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

