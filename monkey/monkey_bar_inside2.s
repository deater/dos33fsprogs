; stuff regarding 2nd room of scumm bar

	; if x<4 goto MONKEY_BAR_INSIDE1 at 34,24

bar_inside2_check_exit:

	lda	GUYBRUSH_X
	cmp	#4
	bcc	bar_inside2_to_bar_inside1
	cmp	#33
	bcs	bar_inside2_to_bar_inside3
	bcc	bar_inside2_no_exit

bar_inside2_to_bar_inside1:
	lda	GUYBRUSH_DIRECTION
	cmp	#DIR_LEFT
	bne	bar_inside2_no_exit

	lda	#MONKEY_BAR_INSIDE1
	sta	LOCATION
	lda	#34
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#24
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	bar_inside2_no_exit

bar_inside2_to_bar_inside3:
	lda	GUYBRUSH_DIRECTION
	cmp	#DIR_RIGHT
	bne	bar_inside2_no_exit

	lda	#MONKEY_BAR_INSIDE3
	sta	LOCATION
	lda	#5
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#24
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	bar_inside2_no_exit


bar_inside2_no_exit:
	rts

	;================================
	;================================
	; bar_inside2 adjust destination
	;================================
	;================================
bar_inside2_adjust_destination:
	; just make Y always 24

	lda	#24
	sta	DESTINATION_Y

;	lda	DESTINATION_X
;	cmp	#33
	bcc	done_mb2_adjust

;	lda	#33
;	sta	DESTINATION_X


done_mb2_adjust:
	rts


	;================================
	;================================
	; bar_inside2 check bounds
	;================================
	;================================
bar_inside2_check_bounds:
	; just make Y always 20

	rts


	;================================
	;================================
	; bar inside animations
	;================================
	;================================

bar_inside2_animate:

	lda	FRAMEL
	and	#$10
	beq	bar2_other_fire

	lda	#<bar2_fire1_sprite
	sta	INL
	lda	#>bar2_fire1_sprite
	jmp	bar2_draw_fire
bar2_other_fire:
	lda	#<bar2_fire2_sprite
	sta	INL
	lda	#>bar2_fire2_sprite
bar2_draw_fire:
	sta	INH

	lda	#25
	sta	XPOS
	lda	#22
	sta	YPOS

	jsr	put_sprite_crop


	lda	FRAMEL
	and	#$60
	beq	bar2_other_arm

	lda	#<bar2_pirate_mug1_sprite
	sta	INL
	lda	#>bar2_pirate_mug1_sprite
	jmp	bar2_draw_arm
bar2_other_arm:
	lda	#<bar2_pirate_mug2_sprite
	sta	INL
	lda	#>bar2_pirate_mug2_sprite
bar2_draw_arm:
	sta	INH

	lda	#7
	sta	XPOS
	lda	#26
	sta	YPOS

	jsr	put_sprite_crop


	rts

bar2_fire1_sprite:
	.byte	2,2
	.byte	$dA,$AA
	.byte	$d1,$dd

bar2_fire2_sprite:
	.byte	2,2
	.byte	$AA,$dA
	.byte	$1d,$dd

bar2_pirate_mug1_sprite:
	.byte	3,3
	.byte	$25,$00,$05
	.byte	$22,$82,$74
	.byte	$d2,$8b,$77

bar2_pirate_mug2_sprite:
	.byte	3,3
	.byte	$25,$b7,$75
	.byte	$62,$26,$84
	.byte	$d2,$88,$88



	;===================================
	;===================================
	; actions
	;===================================
	;===================================


;=============================
bar2_door_action:
bar2_door_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts


       ;=============================
fireplace_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	fireplace_actions,Y
	cmp	#$ff
	beq	fireplace_nothing

	sta	MESSAGE_L
	lda	fireplace_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

fireplace_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

fireplace_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   cant_pick_up	; pick_up
	.word   fireplace_look	; look_at
	.word   $FFFF		; talk_to
	.word   for_what	; use
	.word   icant_move	; push
	.word   icant_move	; pull

fireplace_look:
.byte 18,21,"COZY.",0


;=============================
impt_pirate_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	impt_pirate_actions,Y
	cmp	#$ff
	beq	impt_pirate_nothing

	sta	MESSAGE_L
	lda	impt_pirate_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

impt_pirate_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

impt_pirate_actions:
	.word   $FFFF		; give
	.word   $FFFF		; open
	.word   $FFFF		; close
	.word   $FFFF		; pick_up
	.word   impt_pirate_look	; look_at
	.word   impt_pirate_look	; talk_to
	.word   $FFFF		; use
	.word   $FFFF		; push
	.word   $FFFF		; pull

impt_pirate_look:
.byte 8,21,"WHAT BE YE WANTIN' BOY?",0

       ;=============================
curtain_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	curtain_actions,Y
	cmp	#$ff
	beq	curtain_nothing

	sta	MESSAGE_L
	lda	curtain_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

curtain_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

curtain_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   cant_pick_up	; pick_up
	.word   not_special	; look_at
	.word   $FFFF		; talk_to
	.word   for_what	; use
	.word   icant_move	; push
	.word   icant_move	; pull

