; stuff regarding the governor's mansion

	; if x>35 goto MONKEY_MANSION_PATH at

mansion_check_exit:

	lda	GUYBRUSH_X
	cmp	#35
	bcs	mansion_to_mansion_path
	bcc	mansion_no_exit

mansion_to_mansion_path:
	lda	#MONKEY_MANSION_PATH
	sta	LOCATION
	lda	#11
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#10
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y

	lda	#GUYBRUSH_SMALL
	sta	GUYBRUSH_SIZE

	jsr	change_location
	jmp	mansion_no_exit

mansion_no_exit:
	rts



	;============================
	;============================
	; mansion adjust destination
	;============================
	;============================
mansion_adjust_destination:
	; just make Y always 24

mn_check_y:

mn_y_too_small:
	lda	#24
	sta	DESTINATION_Y

done_mn_adjust:
	rts


;draw_house:

;	lda	#<wall_sprite
;	sta	INL
;	lda	#>wall_sprite
;	sta	INH

;	lda	#18
;	sta	XPOS
;	lda	#22
;	sta	YPOS

;	jsr	put_sprite_crop

;	rts

;house_sprite:

	; can't be too far left (poodles)
mansion_check_bounds:

	lda	GUYBRUSH_X
	cmp	#20
	bcs	done_mansion_check_bounds

	lda	#20
	sta	GUYBRUSH_X
	sta	DESTINATION_X

	lda	#<near_them
	sta	MESSAGE_L
	lda	#>near_them
	sta	MESSAGE_H

	jmp	do_display_message


done_mansion_check_bounds:
	rts


;=============================
trail_action:
trail_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

;=============================
poodles_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	poodles_actions,Y
	cmp	#$ff
	beq	poodles_nothing

	sta	MESSAGE_L
	lda	poodles_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

poodles_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

poodles_actions:
	.word 	$FFFF		; give
	.word	doesnt_open	; open
	.word	doesnt_work	; close
	.word	cant_pick_up	; pick_up
	.word	poodles_look	; look_at
	.word	poodles_talk	; talk_to
	.word	for_what	; use
	.word	icant_move	; push
	.word	icant_move	; pull

poodles_look:
.byte 3,21,"I DON'T THINK I CAN GET PAST THEM",0

poodles_talk:
.byte 18,21,"WOOF",0

near_them:
.byte 8,21,"I'M NOT GOING NEAR THEM",0
