; voodoo shop 1

	; if x<10 goto MONKEY_TOWN
	; if x>30 goto MONKEY_VOODOO2

voodoo1_check_exit:

	lda	GUYBRUSH_X
	cmp	#35
	bcs	voodoo1_to_voodoo2

	cmp	#10
	bcc	voodoo1_to_town

	bcs	voodoo1_no_exit

voodoo1_to_voodoo2:
	lda	#MONKEY_VOODOO2
	sta	LOCATION
	lda	#8
	sta	GUYBRUSH_X
	lda	#12
	sta	DESTINATION_X
	lda	#18
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	voodoo1_no_exit

voodoo1_to_town:
	lda	#MONKEY_TOWN
	sta	LOCATION
	lda	#8
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#18
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	lda	#GUYBRUSH_SMALL
	sta	GUYBRUSH_SIZE
	jsr	change_location
	jmp	voodoo1_no_exit

voodoo1_no_exit:
	rts



	;==========================
	;==========================
	; voodoo1 adjust destination
	;==========================
	;==========================
voodoo1_adjust_destination:
	; just make Y always 20

v1_check_y:
	; if x < 28, Y must be between 16 and 18
	; if x < 35, Y must be between  8 and 28

v1_y_too_small:
	lda	#20
	sta	DESTINATION_Y

done_v1_adjust:
	rts


	;==========================
	;==========================
	; voodoo1 check bounds
	;==========================
	;==========================
voodoo1_check_bounds:
	rts


	;==========================
	;==========================
	; voodoo1 draw foreground
	;==========================
	;==========================
voodoo1_draw_foreground:
	lda	#<voodoo1_fg_sprite
	sta	INL
	lda	#>voodoo1_fg_sprite
	sta	INH

	lda	#12
	sta	XPOS
	lda	#30
	sta	YPOS
	jmp	put_sprite_crop

voodoo1_fg_sprite:
	.byte	20,2
	.byte	$AA,$8A,$88,$88,$8A,$AA,$AA,$AA,$AA,$AA
	.byte	$8A,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$77,$AA
	.byte	$8A,$08,$08,$80,$80,$88,$8A,$AA,$AA,$08
	.byte	$08,$08,$AA,$AA,$AA,$AA,$AA,$AA,$87,$57


	;==========================
	;==========================
	; voodoo1 actions
	;==========================
	;==========================


voodoo1_door_action:
voodoo1_door_nothing:
        lda     #VERB_WALK
        sta     CURRENT_VERB
        rts


       ;=============================
couch_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	couch_actions,Y
	cmp	#$ff
	beq	couch_nothing

	sta	MESSAGE_L
	lda	couch_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

couch_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

couch_actions:
	.word   $FFFF		; give
	.word   creepy_voodoo	; open
	.word   creepy_voodoo	; close
	.word   creepy_voodoo	; pick_up
	.word   couch_look	; look_at
	.word   $FFFF		; talk_to
	.word   couch_use	; use
	.word   creepy_voodoo	; push
	.word   creepy_voodoo	; pull

couch_look:	.byte 0,21,"LOOKS COMFORTABLE IN A CREEPY SORTA WAY",0
couch_use:	.byte 1,21,"I CAN'T FALL ASLEEP IN STRANCE PLACES",0
creepy_voodoo:	.byte 0,21,"I'D RATHER NOT TOUCH CREEPY VOODOO STUFF",0


       ;=============================
chickens_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	chickens_actions,Y
	cmp	#$ff
	beq	chickens_nothing

	sta	MESSAGE_L
	lda	chickens_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

chickens_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

chickens_actions:
	.word   $FFFF		; give
	.word   creepy_voodoo	; open
	.word   creepy_voodoo	; close
	.word   chickens_pickup	; pick_up
	.word   chickens_look	; look_at
	.word   $FFFF		; talk_to
	.word   creepy_voodoo	; use
	.word   creepy_voodoo	; push
	.word   creepy_voodoo	; pull

chickens_pickup:	.byte 14,21,"I BETTER NOT",0
chickens_look:		.byte 12,21,"POOR CHICKENS...",0


       ;=============================
statue_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	statue_actions,Y
	cmp	#$ff
	beq	statue_nothing

	sta	MESSAGE_L
	lda	statue_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

statue_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

statue_actions:
	.word   $FFFF		; give
	.word   creepy_voodoo	; open
	.word   creepy_voodoo	; close
	.word   creepy_voodoo	; pick_up
	.word   creepy_voodoo	; look_at
	.word   $FFFF		; talk_to
	.word   creepy_voodoo	; use
	.word   creepy_voodoo	; push
	.word   creepy_voodoo	; pull


       ;=============================
voodoo_knicknacks_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	voodoo_knicknacks_actions,Y
	cmp	#$ff
	beq	voodoo_knicknacks_nothing

	sta	MESSAGE_L
	lda	voodoo_knicknacks_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

voodoo_knicknacks_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

voodoo_knicknacks_actions:
	.word   $FFFF		; give
	.word   creepy_voodoo	; open
	.word   creepy_voodoo	; close
	.word   creepy_voodoo	; pick_up
	.word   voodoo_knicknacks_look	; look_at
	.word   $FFFF		; talk_to
	.word   creepy_voodoo	; use
	.word   creepy_voodoo	; push
	.word   creepy_voodoo	; pull

voodoo_knicknacks_look:	.byte 3,21,"THERE'S A BAG OF BAT DRIPPINGS",0

       ;=============================
baskets_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	baskets_actions,Y
	cmp	#$ff
	beq	baskets_nothing

	sta	MESSAGE_L
	lda	baskets_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

baskets_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

baskets_actions:
	.word   $FFFF		; give
	.word   baskets_open	; open
	.word   creepy_voodoo	; close
	.word   creepy_voodoo	; pick_up
	.word   baskets_look	; look_at
	.word   $FFFF		; talk_to
	.word   creepy_voodoo	; use
	.word   creepy_voodoo	; push
	.word   creepy_voodoo	; pull

baskets_open:	.byte 10,21,"I'M NOT THAT CURIOUS",0
baskets_look:	.byte 1,21,"GEE, I WONDER WHAT'S IN THESE BASKETS",0


       ;=============================
basket_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	basket_actions,Y
	cmp	#$ff
	beq	basket_nothing

	sta	MESSAGE_L
	lda	basket_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

basket_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

basket_actions:
	.word   $FFFF		; give
	.word   basket_open	; open
	.word   creepy_voodoo	; close
	.word   creepy_voodoo	; pick_up
	.word   basket_look	; look_at
	.word   $FFFF		; talk_to
	.word   creepy_voodoo	; use
	.word   creepy_voodoo	; push
	.word   creepy_voodoo	; pull

basket_open:	.byte 4,21,"SOMETHING WOULD PROBABLY JUMP OUT",0
basket_look:	.byte 0,21,"HMMM.. I THINK I HEAR SLITHERING INSIDE",0


       ;=============================
bones_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	bones_actions,Y
	cmp	#$ff
	beq	bones_nothing

	sta	MESSAGE_L
	lda	bones_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

bones_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

bones_actions:
	.word   $FFFF		; give
	.word   creepy_voodoo	; open
	.word   creepy_voodoo	; close
	.word   creepy_voodoo	; pick_up
	.word   bones_look	; look_at
	.word   $FFFF		; talk_to
	.word   creepy_voodoo	; use
	.word   creepy_voodoo	; push
	.word   creepy_voodoo	; pull

bones_look:	.byte 3,21,"POOR LITTLE THING, WHATEVER IT WAS",0

       ;=============================
chalice_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	chalice_actions,Y
	cmp	#$ff
	beq	chalice_nothing

	sta	MESSAGE_L
	lda	chalice_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

chalice_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

chalice_actions:
	.word   $FFFF		; give
	.word   creepy_voodoo	; open
	.word   creepy_voodoo	; close
	.word   creepy_voodoo	; pick_up
	.word   chalice_look	; look_at
	.word   $FFFF		; talk_to
	.word   creepy_voodoo	; use
	.word   creepy_voodoo	; push
	.word   creepy_voodoo	; pull

chalice_look:	.byte 3,21,"NOW THIS IS THE CUP OF A CARPENTER",0

       ;=============================
trunk_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	trunk_actions,Y
	cmp	#$ff
	beq	trunk_nothing

	sta	MESSAGE_L
	lda	trunk_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

trunk_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

trunk_actions:
	.word   $FFFF		; give
	.word   creepy_voodoo	; open
	.word   creepy_voodoo	; close
	.word   creepy_voodoo	; pick_up
	.word   trunk_look	; look_at
	.word   $FFFF		; talk_to
	.word   creepy_voodoo	; use
	.word   creepy_voodoo	; push
	.word   creepy_voodoo	; pull

trunk_look:	.byte 8,21,"PROBABLY HAS A BODY IN IT",0

       ;=============================
chicken_pulley_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	chicken_pulley_actions,Y
	cmp	#$ff
	beq	chicken_pulley_nothing

	sta	MESSAGE_L
	lda	chicken_pulley_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

chicken_pulley_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

chicken_pulley_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   $FFFF		; pick_up
	.word   chicken_pulley_look	; look_at
	.word   $FFFF		; talk_to
	.word   $FFFF		; use
	.word   icant_move	; push
	.word   icant_move	; pull

chicken_pulley_look:	.byte 2,21,"A RUBBER CHICKEN WITH A PULLEY IN IT",0


