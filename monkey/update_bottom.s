	;====================================
	;====================================
	; update bottom of screen
	;====================================
	;====================================
update_bottom:

	; draw first line
	; it's verb followed by noun

	jsr	normal_text

	; first clear line
	lda	#<clear_line
	sta	OUTL
	lda	#>clear_line
	sta	OUTH
	jsr	move_and_print

	lda	CURRENT_VERB
	asl
	tay
	lda	verb_names,Y
	sta	OUTL
	lda	verb_names+1,Y
	sta	OUTH

	jsr	move_and_print


	lda	VALID_NOUN
	bmi	no_noun

	lda	NOUN_L
	sta	OUTL
	lda	NOUN_H
	sta	OUTH

	jsr	move_and_print

no_noun:


	;========================
	; draw command bars

	jsr	inverse_text

	ldx	#0

bottom_loop:
	lda	bottom_strings,X
	sta	OUTL
	lda	bottom_strings+1,X
	sta	OUTH

	jsr	move_and_print

	inx
	inx

	cpx	#18
	bne	bottom_loop

	rts

;0123456789012345678901234567890123456789
;
;GIVE  PICK UP  USE
;OPEN  LOOK AT  PUSH
;CLOSE TALK TO  PULL

bottom_strings:
.word	bottom_give
.word	bottom_open
.word	bottom_close
.word	bottom_pick_up
.word	bottom_look_at
.word	bottom_talk_to
.word	bottom_use
.word	bottom_push
.word	bottom_pull

bottom_give:	.byte 0,21,"GIVE ",0
bottom_open:	.byte 0,22,"OPEN ",0
bottom_close:	.byte 0,23,"CLOSE",0
bottom_pick_up:	.byte 6,21,"PICK UP",0
bottom_look_at:	.byte 6,22,"LOOK AT",0
bottom_talk_to:	.byte 6,23,"TALK TO",0
bottom_use:	.byte 15,21,"USE ",0
bottom_push:	.byte 15,22,"PUSH",0
bottom_pull:	.byte 15,23,"PULL",0


verb_names:

.word	verb_give
.word	verb_open
.word	verb_close
.word	verb_pick_up
.word	verb_look_at
.word	verb_talk_to
.word	verb_use
.word	verb_push
.word	verb_pull
.word	verb_walk

verb_give:	.byte 15,20,"GIVE ",0
verb_open:	.byte 15,20,"OPEN ",0
verb_close:	.byte 14,20,"CLOSE ",0
verb_pick_up:	.byte 12,20,"PICK UP ",0
verb_look_at:	.byte 12,20,"LOOK AT ",0
verb_talk_to:	.byte 12,20,"TALK TO ",0
verb_use:	.byte 16,20,"USE ",0
verb_push:	.byte 15,20,"PUSH ",0
verb_pull:	.byte 15,20,"PULL ",0
verb_walk:	.byte 12,20,"WALK TO ",0

clear_line:	.byte 12,20,"                          ",0
