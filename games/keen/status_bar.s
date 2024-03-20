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
	; update score
	;===========================

update_score:

	lda	SCORE0
	and	#$f
	ora	#$b0		; 0 -> $b0
	sta	score_string+6

	lda	SCORE0
	lsr
	lsr
	lsr
	lsr
	ora	#$b0		; 0 -> $b0
	sta	score_string+5

	lda	SCORE1
	and	#$f
	ora	#$b0		; 0 -> $b0
	sta	score_string+4

	lda	SCORE1
	lsr
	lsr
	lsr
	lsr
	ora	#$b0		; 0 -> $b0
	sta	score_string+3

	lda	SCORE2
	and	#$f
	ora	#$b0		; 0 -> $b0
	sta	score_string+2

	rts


	;===========================
	; update health
	;===========================

.if 0
update_health:

	ldx	#0
update_health_loop:
	cpx	HEALTH
	bcc	health_on
	lda	#'_'|$80
	bne	done_health
health_on:
	lda	#' '
done_health:
	sta	score_string+9,X

	inx
	cpx	#8
	bne	update_health_loop

	rts
.endif

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


	; draw keens

	ldx	#<keen_sprite_stand_right
	stx	INL
	lda	#>keen_sprite_stand_right
	sta	INH

	; XPOS, YPOS

	lda	#2
	sta	XPOS
	lda	#32
	sta	YPOS

	jsr	put_sprite_crop



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
	.byte 0,23," 00000000       20000    0       N      ",0

