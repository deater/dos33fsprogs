; stuff regarding 3d room of scumm bar

	; if x<4 goto MONKEY_BAR_INSIDE2 at 34,24

bar_inside3_check_exit:

	lda	GUYBRUSH_X
	cmp	#4
	bcc	bar_inside3_to_bar_inside2
;	cmp	#35
;	bcs	bar_inside3_to_bar
	bcs	bar_inside3_no_exit


bar_inside3_to_bar_inside2:
	lda	GUYBRUSH_DIRECTION
	cmp	#DIR_LEFT
	bne	bar_inside3_no_exit

	lda	#MONKEY_BAR_INSIDE2
	sta	LOCATION
	lda	#34
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#24
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	bar_inside3_no_exit

bar_inside3_no_exit:
	rts

	;================================
	;================================
	; bar_inside3 adjust destination
	;================================
	;================================
bar_inside3_adjust_destination:
	; just make Y always 24

	lda	#24
	sta	DESTINATION_Y

	lda	DESTINATION_X
	cmp	#33
	bcc	done_mb3_adjust

	lda	#33
	sta	DESTINATION_X


done_mb3_adjust:
	rts


	;================================
	;================================
	; bar_inside3 check bounds
	;================================
	;================================
bar_inside3_check_bounds:
	; just make Y always 20

	rts


	;================================
	;================================
	; draw meat
	;================================
	;================================
draw_meat:
	lda	ITEMS_PICKED_UP
	and	#IPU_ITEM_MEAT
	bne	done_draw_meat

	lda	#<meat_sprite
	sta	INL
	lda	#>meat_sprite
	sta	INH

	lda	#9
	sta	XPOS
	lda	#26
	sta	YPOS

	jsr	put_sprite_crop
done_draw_meat:
	rts

meat_sprite:
	.byte	3,2
	.byte	$3A,$8A,$AA
	.byte	$A3,$A8,$Af


	;===================================
	;===================================
	; actions
	;===================================
	;===================================


;=============================
bar3_door_action:
bar3_door_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts


       ;=============================
barrel_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	barrel_actions,Y
	cmp	#$ff
	beq	barrel_nothing

	sta	MESSAGE_L
	lda	barrel_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

barrel_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

barrel_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   cant_pick_up	; pick_up
	.word   barrel_look	; look_at
	.word   $FFFF		; talk_to
	.word   $FFFF		; use
	.word   icant_move	; push
	.word   icant_move	; pull

barrel_look:
.byte 1,21,"FULL OF THAT FOUL STUFF PIRATES DRINK",0



       ;=============================
table_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	table_actions,Y
	cmp	#$ff
	beq	table_nothing

	sta	MESSAGE_L
	lda	table_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

table_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

table_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   cant_pick_up	; pick_up
	.word   not_special	; look_at
	.word   $FFFF		; talk_to
	.word   $FFFF		; use
	.word   icant_move	; push
	.word   icant_move	; pull



       ;=============================
meat_action:
	lda	CURRENT_VERB
	cmp	#VERB_PICK_UP
	bne	meat_not_pickup

	; pick up the meat
	lda	ITEMS_PICKED_UP
	ora	#IPU_ITEM_MEAT
	sta	ITEMS_PICKED_UP

	; add to inventory
	lda	#INV_ITEM_MEAT
	ldx	INVENTORY_NEXT_SLOT
	sta	INVENTORY,X
	inc	INVENTORY_NEXT_SLOT

	; decrement object count in room

	ldy	#LOCATION_NUM_AREAS
	lda	location14,Y
	sec
	sbc	#1
	sta	location14,Y

	rts

meat_not_pickup:
	asl
	tay

	lda	meat_actions,Y
	cmp	#$ff
	beq	meat_nothing

	sta	MESSAGE_L
	lda	meat_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

meat_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

meat_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   $FFFF		; pick_up
	.word   meat_look	; look_at
	.word   $FFFF		; talk_to
	.word   $FFFF		; use
	.word   icant_move	; push
	.word   icant_move	; pull

meat_look:	.byte 0,21,"SOME SORT OF MEAT OR MEAT-LIKE SUBSTANCE",0


       ;=============================
stew_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	stew_actions,Y
	cmp	#$ff
	beq	stew_nothing

	sta	MESSAGE_L
	lda	stew_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

stew_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

stew_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   stew_pick	; pick_up
	.word   stew_pick	; look_at
	.word   $FFFF		; talk_to
	.word   $FFFF		; use
	.word   stew_pick	; push
	.word   stew_pick	; pull

stew_pick:	.byte 12,21,"IT'S BOILING HOT",0

