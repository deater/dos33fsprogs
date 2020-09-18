	;===================================
	; where do we point?
	;===================================
	; check to see if cursor is in any of zones
where_do_we_point:
	ldy	#LOCATION_NUM_AREAS
	lda	(LOCATION_STRUCT_L),Y

	tax				; num areas in X

	ldy	#LOCATION_AREAS
where_loop:

	lda	CURSOR_X
	clc
	adc	#3			; center of cursor is 3 over

	cmp	(LOCATION_STRUCT_L),Y
	bcc	where_notxlow		; too far left
	iny

	cmp	(LOCATION_STRUCT_L),Y
	bcs	where_notxhigh		; too far right
	iny

	lda	CURSOR_Y
	clc
	adc	#4			; center of cursor 4 down?
	cmp	(LOCATION_STRUCT_L),Y
	bcc	where_notylow		; too far up
	iny

;	cmp	CURSOR_Y
	cmp	(LOCATION_STRUCT_L),Y
	bcs	where_notyhigh		; too far right
	iny

	; we got this far, was a match
	lda	(LOCATION_STRUCT_L),Y
	sta	NOUN_L
	iny
	lda	(LOCATION_STRUCT_L),Y
	sta	NOUN_H
	iny
	lda	(LOCATION_STRUCT_L),Y
	sta	NOUN_VECTOR_L
	iny
	lda	(LOCATION_STRUCT_L),Y
	sta	NOUN_VECTOR_H

	lda	#1
	sta	VALID_NOUN
	rts



	; update area pointer
where_notxlow:
	iny
where_notxhigh:
	iny
where_notylow:
	iny
where_notyhigh:
	iny
	iny
	iny
	iny
	iny

	dex
	bne	where_loop



point_nowhere:
	lda	#0
	sta	VALID_NOUN
	rts


lookout_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	lookout_actions,Y
	cmp	#$ff
	beq	lookout_nothing

	sta	MESSAGE_L
	lda	lookout_actions+1,Y
	sta	MESSAGE_H

	lda	#1
	sta	DISPLAY_MESSAGE

lookout_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

lookout_actions:
	.word	$FFFF		; give
	.word	doesnt_open	; open
	.word	doesnt_work	; close
	.word	$FFFF		; pick_up
	.word	lookout_look	; look_at
	.word	lookout_talk	; talk_to
	.word	doesnt_work	; use
	.word	icant_move	; push
	.word	icant_move	; pull

           ;0123456789012345678901234567890123456789
lookout_look:
.byte 7,21,"I THINK HE MIGHT BE ASLEEP.",0
lookout_talk:
.byte 16,21,"YIKES!!",0

doesnt_open:
.byte 9,21,"IT DOESN'T SEEM TO OPEN.",0
doesnt_work:
.byte 12,21,"THAT DOESN'T WORK.",0
icant_move:
.byte 12,21,"I CAN'T MOVE IT.",0
cant_pick_up:
.byte 10,21,"I CAN'T PICK THAT UP.",0
not_special:
.byte 1,21,"I DON'T SEE ANYTHING SPECIAL ABOUT IT.",0

	;=============================
	; can't do anything with path
	; real game they all make you walk there
path_action:
path_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

	;=============================
	; can't do anything with stairs
	; real game they all make you walk there
stairs_action:
stairs_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

	;======================
	; door
door_action:
	lda	CURRENT_VERB
	cmp	#VERB_OPEN
	bne	check_door_close

	lda	#1
	sta	BAR_DOOR_OPEN
	jmp	door_nothing

check_door_close:
	cmp	#VERB_CLOSE
	bne	door_common
	lda	#0
	sta	BAR_DOOR_OPEN
	jmp	door_nothing

door_common:
	asl
	tay

	lda	door_actions,Y
	cmp	#$ff
	beq	door_nothing

	sta	MESSAGE_L
	lda	door_actions+1,Y
	sta	MESSAGE_H

	lda	#1
	sta	DISPLAY_MESSAGE

door_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB

	rts


door_actions:
	.word	$FFFF		; give
	.word	$FFFF		; open
	.word	$FFFF		; close
	.word	cant_pick_up	; pick_up
	.word	not_special	; look_at
	.word	$FFFF		; talk_to
	.word	doesnt_work	; use
	.word	icant_move	; push
	.word	icant_move	; pull



	rts

moon_action:
moon_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

	;=============================
	; can't do anything with cliffside
	; real game they all make you walk there
cliffside_action:
cliffside_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

poster_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	poster_actions,Y
	cmp	#$ff
	beq	poster_nothing

	sta	MESSAGE_L
	lda	poster_actions+1,Y
	sta	MESSAGE_H

	lda	#1
	sta	DISPLAY_MESSAGE

poster_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB

	rts


poster_actions:
	.word	$FFFF		; give
	.word	doesnt_open	; open
	.word	doesnt_work	; close
	.word	cant_pick_up	; pick_up
	.word	poster_look	; look_at
	.word	$FFFF		; talk_to
	.word	doesnt_work	; use
	.word	icant_move	; push
	.word	icant_move	; pull

poster_look:
.byte 8,21,"RE-ELECT GOVERNOR MARLEY.",0

