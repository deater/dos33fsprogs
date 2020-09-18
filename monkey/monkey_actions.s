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

	lda	#0
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
	bpl	where_loop



point_nowhere:
	lda	#$ff
	sta	VALID_NOUN
	rts


lookout_action:
	rts

path_action:
	rts

stairs_action:
	rts

door_action:
	rts

moon_action:
	rts

cliffside_action:
	rts

poster_action:
	rts
