	;=================
	; draw the door
	;=================

draw_door:

	lda	FRAMEL
	lsr
	and	#$3
	tay

	lda	door_l,Y
	sta	INL
	lda	door_h,Y
	sta	INH

	ldx	DOOR_X		; 63
        stx     XPOS
	lda	DOOR_Y
	sta	YPOS

	jsr	hgr_draw_sprite

	jsr	hgr_sprite_page_toggle

	lda	FRAMEL
	lsr
	and	#$3
	tay

	lda	door_l,Y
	sta	INL
	lda	door_h,Y
	sta	INH

	ldx	DOOR_X		; 63
        stx     XPOS
	lda	DOOR_Y
	sta	YPOS

	jsr	hgr_draw_sprite

	jsr	hgr_sprite_page_toggle

	lda	FRAMEL
	cmp	#7
	bne	not_door_done

	inc	DOOR_OPEN
	cli	; start music

not_door_done:

	rts


door_l:
.byte	<door1_sprite,<door2_sprite,<door3_sprite,<door4_sprite

door_h:
.byte	>door1_sprite,>door2_sprite,>door3_sprite,>door4_sprite







	;=================
	; draw the door L5
	;=================

draw_door_5:

	lda	FRAMEL
	lsr
	and	#$3
	tay

	lda	bdoor_l,Y
	sta	INL
	lda	bdoor_h,Y
	sta	INH

	ldx	DOOR_X		; 63
        stx     XPOS
	lda	DOOR_Y
	sta	YPOS

	jsr	hgr_draw_sprite

	jsr	hgr_sprite_page_toggle

	ldx	#9		; 63
        stx     XPOS
	lda	#24
	sta	YPOS

	jsr	hgr_draw_sprite

	jsr	hgr_sprite_page_toggle



	lda	FRAMEL
	cmp	#7
	bne	not_bdoor_done

	inc	DOOR_OPEN
	cli	; start music

not_bdoor_done:

	rts


bdoor_l:
.byte	<bdoor1_sprite,<bdoor2_sprite,<bdoor3_sprite,<bdoor4_sprite

bdoor_h:
.byte	>bdoor1_sprite,>bdoor2_sprite,>bdoor3_sprite,>bdoor4_sprite

