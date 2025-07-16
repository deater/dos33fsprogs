	;=========================
	; take quiz2
	;=========================

take_quiz:

quiz2_loop:

	;=======================
	; check keyboard special

	jsr	check_keyboard_answer

	lda	IN_QUIZ
	beq	done_quiz2

	;========================
	; draw_scene

	jsr	update_screen

	;=======================
	; draw quiz message

	lda	WHICH_QUIZ
	cmp	#2
	beq	draw_keeper2_quiz3
	cmp	#1
	beq	draw_keeper2_quiz2

draw_keeper2_quiz1:
	lda	WRONG_KEY
	bne	draw_keeper2_quiz1_wrong
	ldx	#<cave_outer_quiz2_1
	ldy	#>cave_outer_quiz2_1
	jmp	draw_keeper2_quiz_common
draw_keeper2_quiz1_wrong:
	ldx	#<cave_outer_quiz2_1again
	ldy	#>cave_outer_quiz2_1again
	jmp	draw_keeper2_quiz_common

draw_keeper2_quiz2:
	lda	WRONG_KEY
	bne	draw_keeper2_quiz2_wrong
	ldx	#<cave_outer_quiz2_2
	ldy	#>cave_outer_quiz2_2
	jmp	draw_keeper2_quiz_common
draw_keeper2_quiz2_wrong:
	ldx	#<cave_outer_quiz2_2again
	ldy	#>cave_outer_quiz2_2again
	jmp	draw_keeper2_quiz_common

draw_keeper2_quiz3:
	lda	WRONG_KEY
	bne	draw_keeper2_quiz3_wrong
	ldx	#<cave_outer_quiz2_3
	ldy	#>cave_outer_quiz2_3
	jmp	draw_keeper2_quiz_common
draw_keeper2_quiz3_wrong:
	ldx	#<cave_outer_quiz2_3again
	ldy	#>cave_outer_quiz2_3again
draw_keeper2_quiz_common:
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

	jmp	quiz2_loop

done_quiz2:
	rts


	;======================
	; quiz2 invalid answer
	;======================

invalid_answer:
	bit	KEYRESET	; clear the keyboard buffer

	inc	WRONG_KEY
.if 0
	lda	WHICH_QUIZ
	cmp	#2		; off by 1
	beq	resay_quiz3
	cmp	#1
	beq	resay_quiz2

resay_quiz1:
	ldx	#<cave_outer_quiz2_1again
	ldy	#>cave_outer_quiz2_1again
	jmp	finish_parse_message_nowait
resay_quiz2:
	ldx	#<cave_outer_quiz2_2again
	ldy	#>cave_outer_quiz2_2again
	jmp	finish_parse_message_nowait
resay_quiz3:
	ldx	#<cave_outer_quiz2_3again
	ldy	#>cave_outer_quiz2_3again
	jmp	finish_parse_message_nowait
.endif
	rts

	;======================
	; quiz2 wrong answer
	;======================

wrong_answer:
	bit	KEYRESET	; clear the keyboard buffer

	; print WRONG! message

	ldx     #<cave_outer_quiz2_wrong
	ldy     #>cave_outer_quiz2_wrong
	jsr	finish_parse_message

	; transform to guitar guy
	; and play guitar for like 5 s

	jsr	guitar_transform

after_guitar:

	; force message to current page

	; in theory we keep playing when message shown

	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE

	ldx     #<cave_outer_quiz2_wrong_part2
	ldy     #>cave_outer_quiz2_wrong_part2

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
	; quiz2 correct answer
	;======================

right_answer:
	bit	KEYRESET	; clear the keyboard buffer
	ldx     #<cave_outer_quiz2_correct
	ldy     #>cave_outer_quiz2_correct
	jsr	finish_parse_message

	jsr	cave_outer_get_helm

	rts

quiz_answers:
	.byte 'B','B','C'


	;===============================
	; guitar transform
	;===============================
guitar_transform:

	lda	#0
	sta	GUITAR_COUNT
	sta	SUBGUITAR_COUNT

	; look down for this

	lda	#PEASANT_DIR_DOWN
	sta	PEASANT_DIR

guitar_loop:
	;=============================
	; copy page (note this is going to mess with sound)

	; FIXME: instead just copy from BG like climb code?

	jsr	hgr_copy_faster


	; play sound if needed, 2.. 12

	lda	GUITAR_COUNT
	cmp	#2
	bcc	skip_guitar_sound
	cmp	#12
	bcs	skip_guitar_sound

	and	#1
	beq	guitar_other_note

        lda     #NOTE_F6
	beq	guitar_common_note		; bra
guitar_other_note:
        lda     #NOTE_E6

guitar_common_note:
        sta     speaker_frequency
        lda     #8
        sta     speaker_duration
        jsr     speaker_tone

skip_guitar_sound:


	inc	GUITAR_COUNT
	ldx	GUITAR_COUNT

	;=========================
	; draw the keeper

	lda     #19
	sta     SPRITE_X
	lda     #49
	sta     SPRITE_Y

	lda	#1			; default

	ldx	GUITAR_COUNT		; if <22 then animated
	cpx	#22
	bcs	use_default_keeper

	lda	guitar_which_keeper_sprite,X
use_default_keeper:
	clc
	adc	#8			; skip guitar
	tax

	jsr	hgr_draw_sprite_mask

	;=============================
	; draw peasant/guitar


	; is <22 then transform
	lda	GUITAR_COUNT
	cmp	#150
	bcs	guitar_done		; finish after playing a bit

	cmp	#22
	bcc	do_transformation	; blt

	;==========================
	; play guitar a bit
play_guitar:
	ldx	SUBGUITAR_COUNT
	lda     PEASANT_X
	sta     SPRITE_X
	lda     PEASANT_Y
	sta     SPRITE_Y

        ; get offset for graphics

	lda	guitar_playing_sprites,X
	tax

	jsr	hgr_draw_sprite_mask

	inc	SUBGUITAR_COUNT
	lda	SUBGUITAR_COUNT
	cmp	#5
	bne	done_play_guitar
	lda	#0
	sta	SUBGUITAR_COUNT

done_play_guitar:
	jmp	done_draw_scene


do_transformation:

	;============================
	; first 12 frames just draw peasant

	cmp	#12
	bcc	guitar_peasant	; normal peasant first 12 frames

draw_transformation:
	ldx	GUITAR_COUNT

	lda     PEASANT_X
	sta     SPRITE_X
	lda     PEASANT_Y
	sta     SPRITE_Y

        ; get offset for graphics

	lda	guitar_which_guitar_sprite,X
	tax

	jsr	hgr_draw_sprite_mask

	jmp	done_draw_scene

guitar_peasant:
	;========================
	; draw peasant

	jsr	draw_peasant

	;========================
	; increment flame

	jsr	increment_flame

done_draw_scene:
	;=========================
	; delay

;	lda	#200
;	jsr	wait

	;=========================
	; flip page

	jsr	hgr_page_flip

;	jsr	wait_vblank

	jmp	guitar_loop

guitar_done:

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

;	jsr	wait_until_keypress

	rts




;==========================================
; second keeper guitar info

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
; guitar transition happens
;   (8) 

; 5 start smoke switches to () 5 part way through first frame?
; 5 full smoke siwtches to UU
; 5 guitar sticking out, hands down
; 5 smoke starts to clear
; 5 smoke not cleared but hand moved
; 5 smoke mstly clear
; 5 smoke mostly, hand move
; 5 smoke all clear
; R, M, L, M, R

guitar_which_keeper_sprite:
.byte	3, 5, 6, 7
.byte	6, 7, 6, 7
.byte	6, 7, 6, 7

.byte   7, 5, 5, 1, 1, 1, 1, 1, 1, 1, 1

guitar_which_guitar_sprite:
.byte	0, 0, 0, 0
.byte	0, 0, 0, 0
.byte	0, 0, 0, 0

.byte	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4

guitar_playing_sprites:
.byte	5,6,7,6,5
