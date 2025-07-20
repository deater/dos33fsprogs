	;===============================
	; handle keeper3
	;===============================
	; handle keeper3
	;	stop walking
	;	have keeper come out to talk
	;	special limited handling
	;	can't walk unless win
handle_keeper3:

	lda	#0		; stop walking
	sta	PEASANT_XADD
	sta	PEASANT_YADD
	sta	KEEPER_COUNT

	lda	#1		; start a quiz
	sta	IN_QUIZ

	;===========================
	; animate keeper coming out

	jsr	keeper3_emerge

	;==============================
	; initial keeper conversation

keeper_talk2:
	; print the message

	ldx     #<cave_outer_keeper3_message1
	ldy     #>cave_outer_keeper3_message1
	jsr	finish_parse_message


	;===============================================
	; if have soda print part2, otherwise skip ahead

	lda	INVENTORY_2
	and	#INV2_SODA
	beq	dont_have_soda

	ldx     #<cave_outer_keeper3_message2
	ldy     #>cave_outer_keeper3_message2
	jsr     finish_parse_message

dont_have_soda:

	; custom common verb table the essentially does nothing
	jsr	setup_quiz_verb_table

	; respond only to take quiz and give sub
	lda	#<keeper3_verb_table
	sta	INL
	lda	#>keeper3_verb_table
	sta	INH
	jsr	load_custom_verb_table

	rts


	;=========================
	; keeper3 emerge
	;=========================

keeper3_emerge:
	lda	#0
	sta	KEEPER_COUNT

keeper3_emerge_loop:

	;=======================
	; move to next frame

	inc	KEEPER_COUNT

	;=======================
	; see if done animation

	lda	KEEPER_COUNT
	cmp	#20
	beq	done_keeper3_emerge

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

	jmp	keeper3_emerge_loop

done_keeper3_emerge:
	rts



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


	;==========================
	; draw keeper
	;==========================
	; which frame in KEEPER_COUNT
draw_keeper:

	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_KEEPER
	bne	done_draw_keeper

	ldx	KEEPER_COUNT

	lda     keeper_x,X
	sta     SPRITE_X
	lda     keeper_y,X
	sta     SPRITE_Y

        ; get offset for graphics

	lda	which_keeper_sprite,X
	clc
	adc	#5			; skip skeleton sprites
	tax

	jsr	hgr_draw_sprite_mask

done_draw_keeper:
	rts


sprites_xsize:
	.byte  2, 2, 2, 2, 2			; skeleton 0..4
	.byte  3, 3, 3, 3, 3, 3, 3, 3		; keeper 0..7
	.byte  3				; sword base
	.byte  2, 2, 2, 2, 2, 2, 2, 3, 3	; sword 0..8

sprites_ysize:
	.byte 30,30,30,30,30			; skeleton 0..4
	.byte 28,28,28,28,28,28,28,28		; keeper 0..7
	.byte 30				; sword base
	.byte 24,14,14,18,21,21,24,26,28	; sword 0..8

sprites_data_l:
	.byte <skeleton0,<skeleton1,<skeleton2,<skeleton3
	.byte <skeleton4
	.byte <keeper_l0,<keeper_l1,<keeper_l2,<keeper_l3
	.byte <keeper_l4,<keeper_l5,<keeper_l6,<keeper_l7
	.byte <sword_base_sprite
	.byte <sword0_sprite,<sword1_sprite,<sword2_sprite
	.byte <sword3_sprite,<sword4_sprite,<sword5_sprite
	.byte <sword6_sprite,<sword7_sprite,<sword8_sprite

sprites_data_h:
	.byte >skeleton0,>skeleton1,>skeleton2,>skeleton3
	.byte >skeleton4
	.byte >keeper_l0,>keeper_l1,>keeper_l2,>keeper_l3
	.byte >keeper_l4,>keeper_l5,>keeper_l6,>keeper_l7
	.byte >sword_base_sprite
	.byte >sword0_sprite,>sword1_sprite,>sword2_sprite
	.byte >sword3_sprite,>sword4_sprite,>sword5_sprite
	.byte >sword6_sprite,>sword7_sprite,>sword8_sprite


sprites_mask_l:
	.byte <skeleton0_mask,<skeleton1_mask,<skeleton2_mask,<skeleton3_mask
	.byte <skeleton4_mask
	.byte <keeper_l0_mask,<keeper_l1_mask,<keeper_l2_mask,<keeper_l3_mask
	.byte <keeper_l4_mask,<keeper_l5_mask,<keeper_l6_mask,<keeper_l7_mask
	.byte <sword_base_mask
	.byte <sword0_mask,<sword1_mask,<sword2_mask
	.byte <sword3_mask,<sword4_mask,<sword5_mask
	.byte <sword6_mask,<sword7_mask,<sword8_mask

sprites_mask_h:
	.byte >skeleton0_mask,>skeleton1_mask,>skeleton2_mask,>skeleton3_mask
	.byte >skeleton4_mask
	.byte >keeper_l0_mask,>keeper_l1_mask,>keeper_l2_mask,>keeper_l3_mask
	.byte >keeper_l4_mask,>keeper_l5_mask,>keeper_l6_mask,>keeper_l7_mask
	.byte >sword_base_mask
	.byte >sword0_mask,>sword1_mask,>sword2_mask
	.byte >sword3_mask,>sword4_mask,>sword5_mask
	.byte >sword6_mask,>sword7_mask,>sword8_mask

;==========================================
; third keeper info
;
;	seems to trigger at approx peasant_x = 210 (30)
;

; starts 	sprite x y
;		0	203,61	(29)	; start
;		0	203,63		; move down/l
;		1	203,63		; no move (light up)

	; 6 before moving arms
	; also, moving sprites actually slither a bit
	; ends at 196,67	(28)

keeper_x:
.byte  29,29,29,29
.byte  28,28,28,28
.byte  28,28,28,28, 28,28
.byte  28,28,28,28,28,28,28

keeper_y:
.byte	61,62,62,63
.byte   64,65,66,67
.byte	67,67,67,67, 67,67
.byte	67,67,67,67, 67,67,67

which_keeper_sprite:
.byte	0, 0, 1, 1
.byte	1, 1, 1, 1
.byte	2, 3, 4, 4, 3, 3

.byte   4, 4, 4, 3, 2, 1, 1

