; Draw Status Bar

	;===========================
	; inc_score_by_10
	;===========================
	; FIXME: make sure interrupt routine handles d flag properly
inc_score_by_10:

	sed
	lda	SCORE0
	clc
	adc	#$10
	sta	SCORE0

	lda	SCORE1
	adc	#0
	sta	SCORE1

	lda	SCORE2
	adc	#0
	sta	SCORE2
	cld

	jsr	update_score

	rts

	;===========================
	; update score
	;===========================

update_score:

	lda	SCORE0
	and	#$f
	ora	#$b0		; 0 -> $b0
	sta	status_string+6

	lda	SCORE0
	lsr
	lsr
	lsr
	lsr
	ora	#$b0		; 0 -> $b0
	sta	status_string+5

	lda	SCORE1
	and	#$f
	ora	#$b0		; 0 -> $b0
	sta	status_string+4

	lda	SCORE1
	lsr
	lsr
	lsr
	lsr
	ora	#$b0		; 0 -> $b0
	sta	status_string+3

	lda	SCORE2
	and	#$f
	ora	#$b0		; 0 -> $b0
	sta	status_string+2

	lda	#2
	sta	UPDATE_STATUS

	rts


	;===========================
	; update health
	;===========================

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
	sta	status_string+9,X

	inx
	cpx	#8
	bne	update_health_loop

	rts

	;===========================
	; update items
	;===========================

update_items:

	lda	INVENTORY

	and	#INV_RED_KEY
	beq	done_red_key

	lda	#'R'&$3f
	sta	status_string+33

done_red_key:

	lda	INVENTORY

	and	#INV_BLUE_KEY
	beq	done_blue_key

	lda	#'B'&$3f
	sta	status_string+35

done_blue_key:

	rts




	;===========================
	; update the status bar
	;===========================
update_status_bar:

	jsr	update_score

	jsr	update_health

	jsr	update_items

	rts

	;===========================
	; draw the status bar
	;===========================
draw_status_bar:

	; to improve frame rate, only draw if update status set?
	; not implemented yet

	jsr	inverse_text	; print help node
	lda	#<help_string
	sta	OUTL
	lda	#>help_string
	sta	OUTH
	jsr	move_and_print

	jsr	normal_text	; (normal)
	jsr	move_and_print	; print explain text
	jsr	raw_text
	jsr	move_and_print	; print status line
	rts


help_string:
	.byte 3,20,"        PRESS 'H' FOR HELP        ",0

score_string:
	;           012456789012345678901234567890123456789
	.byte 0,22,"SCORE   HEALTH   FIREPOWER    INVENTORY",0
status_string:
;	.byte 0,23,"ZZZZZ  XXXXXXXX  =-                    ",0
	.byte 0,23,"ZZZZZ"
	.byte ' '|$80,' '|$80
	.byte "XXXXXXXX"
	.byte ' '|$80,' '|$80
	.byte '='|$80,'-'|$80,' '|$80,' '|$80,' '|$80,' '|$80,' '|$80,' '|$80,' '|$80,' '|$80
	.byte ' '|$80,' '|$80,' '|$80,' '|$80,' '|$80,' '|$80,' '|$80,' '|$80,' '|$80,' '|$80,' '|$80,' '|$80,0

