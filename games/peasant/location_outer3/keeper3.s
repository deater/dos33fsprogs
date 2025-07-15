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


	;=========================
	; keeper3 retreat
	;=========================

keeper3_retreat:
	lda	#19
	sta	KEEPER_COUNT

keeper3_retreat_loop:

	;=======================
	; move to next frame

	dec	KEEPER_COUNT

	;=======================
	; see if done animation

	lda	KEEPER_COUNT
	beq	done_keeper3_retreat

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

	jmp	keeper3_retreat_loop

done_keeper3_retreat:
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

	ldx	KEEPER_COUNT

	lda     keeper_x,X
	sta     SPRITE_X
	lda     keeper_y,X
	sta     SPRITE_Y

        ; get offset for graphics

	lda	which_keeper_sprite,X
	clc
	adc	#8			; skip guitar sprites
	tax

	jsr	hgr_draw_sprite_mask

	rts


sprites_xsize:
	.byte  2, 2, 3, 4, 4, 4, 4, 4		; guitar 0..7
	.byte  3, 3, 3, 3, 3, 3, 3, 3		; keeper 0..7

sprites_ysize:
	.byte 30,30,30,30,30,30,30,30		; guitar 0..7
	.byte 28,28,28,28,28,28,28,28		; keeper 0..7

sprites_data_l:
	.byte <guitar0,<guitar1,<guitar2,<guitar3
	.byte <guitar4,<guitar5,<guitar6,<guitar7
	.byte <keeper_l0,<keeper_l1,<keeper_l2,<keeper_l3
	.byte <keeper_l4,<keeper_l5,<keeper_l6,<keeper_l7

sprites_data_h:
	.byte >guitar0,>guitar1,>guitar2,>guitar3
	.byte >guitar4,>guitar5,>guitar6,>guitar7
	.byte >keeper_l0,>keeper_l1,>keeper_l2,>keeper_l3
	.byte >keeper_l4,>keeper_l5,>keeper_l6,>keeper_l7


sprites_mask_l:
	.byte <guitar0_mask,<guitar1_mask,<guitar2_mask,<guitar3_mask
	.byte <guitar4_mask,<guitar5_mask,<guitar6_mask,<guitar7_mask
	.byte <keeper_l0_mask,<keeper_l1_mask,<keeper_l2_mask,<keeper_l3_mask
	.byte <keeper_l4_mask,<keeper_l5_mask,<keeper_l6_mask,<keeper_l7_mask


sprites_mask_h:
	.byte >guitar0_mask,>guitar1_mask,>guitar2_mask,>guitar3_mask
	.byte >guitar4_mask,>guitar5_mask,>guitar6_mask,>guitar7_mask
	.byte >keeper_l0_mask,>keeper_l1_mask,>keeper_l2_mask,>keeper_l3_mask
	.byte >keeper_l4_mask,>keeper_l5_mask,>keeper_l6_mask,>keeper_l7_mask


;==========================================
; second keeper info
;
;	seems to trigger at approx peasant_x = 126 (18)
;

; starts 	sprite x y
;		0	140,43		; start
;		0	140,45		; move down/l
;		1	140,45		; no move (light up)

	; 6 before moving arms
	; also, moving sprites actually slither a bit
	; ends at 133,49

keeper_x:
.byte  20,20,20,20
.byte  19,19,19,19
.byte  19,19,19,19, 19,19
.byte  19,19,19,19,19,19,19

keeper_y:
.byte	43,44,44,45
.byte   46,47,48,49
.byte	49,49,49,49, 49,49
.byte	49,49,49,49, 49,49,49

which_keeper_sprite:
.byte	0, 0, 1, 1
.byte	1, 1, 1, 1
.byte	2, 3, 4, 4, 3, 3

.byte   4, 4, 4, 3, 2, 1, 1

