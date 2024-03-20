; Draw Status Bar

	;===========================
	; inc_score
	;===========================
	; make sure any interrupt routine handles d flag properly
	; value to add by in A (BCD/100)
	; for Keen assume always a multiple of 100
inc_score:

	sed

	clc
	adc	SCORE0
	sta	SCORE0

	lda	SCORE1
	adc	#0
	sta	SCORE1

	lda	SCORE2
	adc	#0
	sta	SCORE2

	cld

	rts


	;===========================
	; update rayguns
	;===========================
	; remove leading zeros
	; leftmost is score_string+26
update_rayguns:

update_raygun_l:
	lda	RAYGUNS
	lsr
	lsr
	lsr
	lsr

	beq	update_raygun_r

	ora	#$b0		; 0 -> $b0
	sta	score_string+26

update_raygun_r:
	lda	RAYGUNS
	and	#$f

	ora	#$b0		; 0 -> $b0
	sta	score_string+27

	rts

	;===========================
	; update score
	;===========================
	; remove leading zeros
	; leftmost is score_string+4 (it's +2 due to x,y coord at begin)
update_score:
	lda	#0
	sta	LEADING_ZERO

update_score2_l:
	lda	SCORE2
	lsr
	lsr
	lsr
	lsr

	beq	update_score2_r

	ora	#$b0		; 0 -> $b0
	sta	score_string+3
	inc	LEADING_ZERO

update_score2_r:

	lda	SCORE2
	and	#$f
	bne	write_score2_r
	ldx	LEADING_ZERO
	beq	update_score_1_l

write_score2_r:
	ora	#$b0		; 0 -> $b0
	sta	score_string+4
	inc	LEADING_ZERO

update_score_1_l:
	lda	SCORE1
	lsr
	lsr
	lsr
	lsr

	bne	write_score1_l
	ldx	LEADING_ZERO
	beq	update_score_1_r

write_score1_l:
	ora	#$b0		; 0 -> $b0
	sta	score_string+5
	inc	LEADING_ZERO

update_score_1_r:
	lda	SCORE1
	and	#$f

	bne	write_score1_r
	ldx	LEADING_ZERO
	beq	update_score_0_l
write_score1_r:
	ora	#$b0		; 0 -> $b0
	sta	score_string+6
	inc	LEADING_ZERO

update_score_0_l:
	lda	SCORE0
	lsr
	lsr
	lsr
	lsr

	bne	write_score0_l
	ldx	LEADING_ZERO
	beq	update_score_0_r

write_score0_l:

	ora	#$b0		; 0 -> $b0
	sta	score_string+7
	inc	LEADING_ZERO

update_score_0_r:
	lda	SCORE0
	and	#$f

	bne	write_score0_r
	ldx	LEADING_ZERO
	beq	done_write_score
write_score0_r:
	ora	#$b0		; 0 -> $b0
	sta	score_string+8

	lda	#$b0		; after first string, this digit always 0
	sta	score_string+9

done_write_score:


	rts



	;===========================
	; update items
	;===========================

update_items:

	lda	KEYCARDS

	and	#INV_RED_KEY
	beq	done_red_key

	lda	#'R'&$3f
	sta	score_string+33

done_red_key:

	lda	KEYCARDS

	and	#INV_BLUE_KEY
	beq	done_blue_key

	lda	#'B'&$3f
	sta	score_string+35

done_blue_key:

	rts




	;===========================
	; update the status bar
	;===========================
;update_status_bar:
;
;	jsr	update_score
;
;	jsr	update_health
;
;	jsr	update_items
;
;	lda	#2
;	sta	UPDATE_STATUS
;
;	rts

	;===========================
	; draw the status bar
	;===========================
	; only draw when ENTER pressed, not always
draw_status_bar:

	jsr	update_score
	jsr	update_rayguns

	bit	TEXTGR			; split graphics/text

	; draw to visible frame
	lda	DRAW_PAGE
	eor	#$4
	sta	DRAW_PAGE

	; draw white box

	ldx	#30
draw_box_loop:
	lda	gr_offsets,X
	sta	OUTL
	lda	gr_offsets+1,X
	clc
	adc	DRAW_PAGE
	sta	OUTH

	ldy	#39
	lda	#$FF
draw_box_inner:
	sta	(OUTL),Y
	dey
	bpl	draw_box_inner

	inx
	inx
	cpx	#40
	bne	draw_box_loop


	;============
	; draw keens

	ldx	KEENS
	cpx	#7			; max out at 7
	bcc	draw_keens
	ldx	#7
draw_keens:
	dex
	stx	TEMP_STATUS

	beq	done_draw_keens		; if 0, don't draw any

draw_keens_loop:


	ldx	#<keen_sprite_stand_right
	stx	INL
	lda	#>keen_sprite_stand_right
	sta	INH

	; XPOS, YPOS

	lda	TEMP_STATUS
	asl
	asl

;	clc
;	adc	#1
	sta	XPOS
	lda	#32
	sta	YPOS

	jsr	put_sprite_crop

	dec	TEMP_STATUS
	bpl	draw_keens_loop

done_draw_keens:

	; TODO: draw keycards

	; TODO: draw parts

	; draw text at bottom

	jsr	inverse_text
	lda	#<status_string
	sta	OUTL
	lda	#>status_string
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	; wait for keypress

	bit	KEYRESET
wait_status_bar:
	lda	KEYPRESS
	bpl	wait_status_bar
	bit	KEYRESET

	; back to original page

	lda	DRAW_PAGE
	eor	#$4
	sta	DRAW_PAGE

	bit	FULLGR

	rts


status_string:
	;           0123456789012345678901234567890123456789
	.byte 0,20," KEENS             KEYCARDS    PARTS    ",0
	.byte 0,21,"                                        ",0
	.byte 0,22,"  SCORE     NEXT KEEN  RAYGUN   POGO    ",0
score_string:
	.byte 0,23,"        0       20000    0       N      ",0

