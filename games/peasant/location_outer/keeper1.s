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

	;==============================
	; initial keeper conversation

keeper_talk1:
	; print the message

	ldx     #<cave_outer_keeper1_message1
	ldy     #>cave_outer_keeper1_message1
	jsr	finish_parse_message

	ldx     #<cave_outer_keeper1_message2
	ldy     #>cave_outer_keeper1_message2
	jsr     finish_parse_message

	ldx     #<cave_outer_keeper1_message3
	ldy     #>cave_outer_keeper1_message3
	jsr     finish_parse_message

	ldx     #<cave_outer_keeper1_message4
	ldy     #>cave_outer_keeper1_message4
	jsr     finish_parse_message

	;===============================================
	; if have sub print part5, otherwise skip ahead

	lda	INVENTORY_2
	and	#INV2_MEATBALL_SUB
	beq	dont_have_sub

	ldx     #<cave_outer_keeper1_message5
	ldy     #>cave_outer_keeper1_message5
	jsr     finish_parse_message

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



