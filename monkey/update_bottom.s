	;====================================
	;====================================
	; update bottom of screen
	;====================================
	;====================================
update_bottom:
	jsr	normal_text

	jsr	clear_bottom


	lda	LOCATION
	cmp	#MONKEY_MAP
	bne	not_the_map

	;===================================
	; draw map footer
	; you don't have actions on the map?
	;===================================
map_noun:
	lda	VALID_NOUN
	beq	done_map_noun

	lda	NOUN_L
	sta	OUTL
	lda	NOUN_H
	sta	OUTH

	jsr	move_and_print

done_map_noun:
	rts

not_the_map:
	;===========================================================
	; if footer is disable and instead we are printing a message
	; then print the message
	;===========================================================

	lda	DISPLAY_MESSAGE
	beq	no_message

	lda	MESSAGE_L
	sta	OUTL
	lda	MESSAGE_H
	sta	OUTH
	jsr	move_and_print

	rts

no_message:
	;===============================================
	; draw the standard footer
	;===============================================

	; draw first line
	; it's verb followed by noun
	; we go through a lot of trouble to center it

	; text is not inverse

	jsr	normal_text

	; first clear line
	lda	#<clear_line
	sta	OUTL
	lda	#>clear_line
	sta	OUTH
	jsr	move_and_print

	; set up temp line
	; already here as we're immediately after clear line?

	lda	#<(temp_line+2)
	sta	OUTL
	lda	#>(temp_line+2)
	sta	OUTH

	; concatenate verb

	lda	CURRENT_VERB
	asl
	tay

	lda	verb_names,Y
	sta	INL
	lda	verb_names+1,Y
	sta	INH

	jsr	strcat

	; concatenate noun if applicable

	lda	VALID_NOUN
	beq	no_noun

	lda	NOUN_L
	sta	INL
	lda	NOUN_H
	sta	INH

	jsr	strcat

no_noun:

	; stick zero at end
	lda	#0
	tay
	sta	(OUTL),Y

	; center it
	lda	#<(temp_line+2)
	sta	INL
	lda	#>(temp_line+2)
	sta	INH

	jsr	strlen
	sty	temp_line
	lda	#40
	sec
	sbc	temp_line
	lsr
	sta	temp_line

	; now print it

	lda	#<temp_line
	sta	OUTL
	lda	#>temp_line
	sta	OUTH

	jsr	move_and_print



	;========================
	; draw command bars
draw_command_bars:
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

verb_give:	.byte "GIVE ",0
verb_open:	.byte "OPEN ",0
verb_close:	.byte "CLOSE ",0
verb_pick_up:	.byte "PICK UP ",0
verb_look_at:	.byte "LOOK AT ",0
verb_talk_to:	.byte "TALK TO ",0
verb_use:	.byte "USE ",0
verb_push:	.byte "PUSH ",0
verb_pull:	.byte "PULL ",0
verb_walk:	.byte "WALK TO ",0

clear_line:	.byte 0,20,"                                        ",0
temp_line:	.byte 0,20,"                                        ",0

	;====================================
	; concatenate (INL) to end of (OUTL)
	; update (OUTL) to point to end when done
strcat:
	ldy	#0
strcat_loop:
	lda	(INL),Y
	beq	strcat_done
	sta	(OUTL),Y
	iny
	bne	strcat_loop
strcat_done:
	tya
	clc
	adc	OUTL
	sta	OUTL
	lda	#0
	adc	OUTH
	sta	OUTH
	rts

	;====================================
	; calculate length of string in (INL)
	; returns value in Y
strlen:
	ldy	#0
strlen_loop:
	lda	(INL),Y
	beq	strlen_done
	iny
	bne	strlen_loop
strlen_done:
	rts
