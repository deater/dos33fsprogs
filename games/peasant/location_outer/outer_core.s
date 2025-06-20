; Peasant's Quest

; Trogdor's Outer Sanctum

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = cave_outer_verb_table

outer_core:

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME
	sta	FLAME_COUNT
	sta	KEEPER_COUNT
	sta	IN_QUIZ

.include "../location_common/common_core.s"

	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET


	;===========================
	;===========================
	;===========================
	; main loop
	;===========================
	;===========================
	;===========================
game_loop:

	;===================
	; move peasant

	jsr	move_peasant

	;====================
	; check if done level

	lda	LEVEL_OVER
	bmi	oops_new_location
	beq	level_good

	jmp	level_over

level_good:

	;===========================
	; copy bg to current screen

;	lda	#$60
	jsr	hgr_copy_faster



	;=====================
	; see if keeper triggered

	lda     MAP_LOCATION
	cmp	#LOCATION_TROGDOR_OUTER
	bne	done_check_keeper

	lda	IN_QUIZ
	bne	done_check_keeper

check_keeper1:
	lda	INVENTORY_2
	and	#INV2_TROGSHIELD	; only if not have shield
	bne	check_keeper2

	lda	PEASANT_X		; only if ourx > 9
	cmp	#10
	bcc	check_keeper2

	jsr	handle_keeper1

check_keeper2:




done_check_keeper:


	;=================================
	; draw keeper if we need refresh

	lda	REFRESH_SCREEN
	beq	no_draw_keeper

	lda	#0
	sta	REFRESH_SCREEN

	lda	IN_QUIZ		; need to draw keeper if quizzing
	beq	no_draw_keeper

	jsr	draw_standing_keeper

no_draw_keeper:

	;=====================
	; always draw peasant

	jsr	draw_peasant

	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; increment flame

	jsr	increment_flame

	;======================
	; check keyboard

	lda	IN_QUIZ
	cmp	#2		; means waiting for answer
	bne	normal_keyboard_check

	jsr	check_keyboard_answer
	jmp	done_keyboard_check

normal_keyboard_check:

	;====================
	; check keyboard

	lda	PEASANT_DIR
	sta	OLD_DIR

	jsr	check_keyboard

;	jsr	wait_vblank

	jsr	hgr_page_flip

done_keyboard_check:



	;===================================
	; keep from moving if being quizzed
	;===================================

	lda	IN_QUIZ
	beq	not_in_quiz

	lda	#0		; keep from moving
	sta	PEASANT_XADD
	sta	PEASANT_YADD

	lda	OLD_DIR		; keep from changing dir
	sta	PEASANT_DIR

not_in_quiz:

	jsr	wait_vblank

	jmp	game_loop

oops_new_location:

not_outer:
just_go_there:


	;========================
	; exit level
	;========================
level_over:

	cmp	#NEW_FROM_LOAD		; see if loading save game
	beq	exiting_outer

	; new location

	lda	MAP_LOCATION
	cmp	#LOCATION_CLIFF_HEIGHTS
	bne 	not_cliff
was_cliff:
	lda	#32
	sta	PEASANT_X
	lda	#120
	bne	done_outer_pos		; bra
not_cliff:
	; trogdor

	lda	#4
	sta	PEASANT_X
	lda	#170
done_outer_pos:
	sta	PEASANT_Y

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
exiting_outer:
	rts




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

	ldy     #3      ; ? slot

;	jsr	hgr_draw_sprite_save
	jsr	hgr_draw_sprite

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

	ldy     #4	; ? slot

;	jsr	hgr_draw_sprite_save
	jsr	hgr_draw_sprite

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

	;===========================
	; animate keeper coming out


keeper1_loop:

	; erase prev keeper

;	ldy	#3                      ; erase slot 3?
;	jsr	hgr_partial_restore_by_num

	inc	KEEPER_COUNT
	ldx	KEEPER_COUNT

	lda     keeper_x,X
	sta     SPRITE_X
	lda     keeper_y,X
	sta     SPRITE_Y

        ; get offset for graphics

	ldx	KEEPER_COUNT
	lda	which_keeper_sprite,X
	clc
	adc	#5			; skip ron
	tax

	ldy     #3      ; ? slot

;	jsr	hgr_draw_sprite_save
	jsr	hgr_draw_sprite

	;=======================
	; see if done animation

	lda	KEEPER_COUNT
	cmp	#20		;
	beq	keeper_talk1



	;========================
	; increment flame

	jsr	draw_peasant

	;========================
	; increment flame

	jsr	increment_flame

	;=========================
	; delay

	lda	#200
	jsr	wait

	jsr	wait_vblank

	jmp	keeper1_loop

	rts


keeper_talk1:
	; print the message

	ldx     #<cave_outer_keeper1_message1
	ldy     #>cave_outer_keeper1_message1
	jsr	finish_parse_message

	jsr	draw_standing_keeper

	ldx     #<cave_outer_keeper1_message2
	ldy     #>cave_outer_keeper1_message2
	jsr     finish_parse_message

	jsr	draw_standing_keeper

	ldx     #<cave_outer_keeper1_message3
	ldy     #>cave_outer_keeper1_message3
	jsr     finish_parse_message

	jsr	draw_standing_keeper

	ldx     #<cave_outer_keeper1_message4
	ldy     #>cave_outer_keeper1_message4
	jsr     finish_parse_message

	jsr	draw_standing_keeper

	;===============================================
	; if have sub print5, otherwise skip ahead

	lda	INVENTORY_2
	and	#INV2_MEATBALL_SUB
	beq	dont_have_sub

	ldx     #<cave_outer_keeper1_message5
	ldy     #>cave_outer_keeper1_message5
	jsr     finish_parse_message

	jsr	draw_standing_keeper

dont_have_sub:

	; now we need to re-draw keeper
	; also we're in quiz mode
	; so we can't move and can only take quiz or give sub

	lda	#1
	sta	IN_QUIZ

	; custom common verb table the essentially does nothing
	jsr	setup_quiz_verb_table

	; respond only to take quiz and give sub
	lda	#<keeper1_verb_table
	sta	INL
	lda	#>keeper1_verb_table
	sta	INH
	jsr	load_custom_verb_table

	jmp	game_loop


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

	jsr	draw_standing_keeper

	ldx     #<cave_outer_quiz1_wrong_part2
	ldy     #>cave_outer_quiz1_wrong_part2
	jsr	finish_parse_message

	jsr	draw_standing_keeper

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
.if 0
setup_outer_verb_table:
	; setup default verb table

	jsr	setup_default_verb_table

	; local verb table

	lda     MAP_LOCATION
	sec
	sbc     #LOCATION_BASE
	tax

	lda	verb_tables_low,X
	sta	INL
	lda	verb_tables_hi,X
	sta	INH
	jsr	load_custom_verb_table

	rts
.endif

	;==========================
	; draw standing keeper
	;==========================
draw_standing_keeper:

	; erase prev keeper

;	ldy	#3                      ; erase slot 3?
;	jsr	hgr_partial_restore_by_num

	ldx	#19

	lda     keeper_x,X
	sta     SPRITE_X
	lda     keeper_y,X
	sta     SPRITE_Y

        ; get offset for graphics

	ldx	#19
	lda	which_keeper_sprite,X
	clc
	adc	#5			; skip ron
	tax

	ldy     #3      ; ? slot

;	jsr	hgr_draw_sprite_save
	jsr	hgr_draw_sprite

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

.if 0

.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"

;.include "../hgr_routines/hgr_page_flip.s"
.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"
.endif

.include "../location_common/include_bottom.s"

.include "../hgr_routines/hgr_sprite.s"

.include "outer_actions.s"

.include "sprites_outer/keeper1_sprites.inc"
.include "sprites_outer/ron_sprites.inc"
.include "sprites_outer/keeper2_sprites.inc"
.include "sprites_outer/guitar_sprites.inc"

