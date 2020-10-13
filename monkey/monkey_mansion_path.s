; stuff regarding path to mansion


	; if x<4 goto MONKEY_MANSION
	; if x>29 goto MONKEY_CHURCH

mansion_path_check_exit:

	lda	GUYBRUSH_X
	cmp	#10
	bcc	mansion_path_to_mansion
	cmp	#29
	bcs	mansion_path_to_church
	bcc	mansion_path_no_exit

mansion_path_to_mansion:
	lda	#MONKEY_MANSION
	sta	LOCATION
	lda	#34
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y

	lda	#GUYBRUSH_BIG
	sta	GUYBRUSH_SIZE

	jsr	change_location
	jmp	mansion_path_no_exit

mansion_path_to_church:
	lda	#MONKEY_CHURCH
	sta	LOCATION
	lda	#5
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#32
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y

	lda	#GUYBRUSH_SMALL
	sta	GUYBRUSH_SIZE

	jsr	change_location
	jmp	mansion_path_no_exit

mansion_path_no_exit:
	rts



	;==========================
	;==========================
	; mansion_path adjust destination
	;==========================
	;==========================
mansion_path_adjust_destination:
	; just make Y always 20

mh_check_y:
	; if x < 28, Y must be between 16 and 18
	; if x < 35, Y must be between  8 and 28

mh_y_too_small:
	lda	GUYBRUSH_Y
	sta	DESTINATION_Y

done_mh_adjust:
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

;=========================
mansion_path_check_bounds:
;=========================

	; 11 < x < 12, Y=10
	; 12 < x < 13, Y=12
	; 13 < x < 17, Y=14
	; x==17		Y=18
	; x==18		Y=20
	; x==19		Y=22
	; else		Y=24


	lda	GUYBRUSH_X
	cmp	#13
	bcc	mp_set_12
	cmp	#17
	bcc	mp_set_14
	beq	mp_set_18
	cmp	#18
	beq	mp_set_20
	cmp	#19
	beq	mp_set_22

	lda	#24
	bcs	done_mansion_path_check_bounds

mp_set_12:
	lda	#12
	bne	done_mansion_path_check_bounds
mp_set_14:
	lda	#14
	bne	done_mansion_path_check_bounds
mp_set_18:
	lda	#18
	bne	done_mansion_path_check_bounds
mp_set_20:
	lda	#20
	bne	done_mansion_path_check_bounds
mp_set_22:
	lda	#22
	bne	done_mansion_path_check_bounds

done_mansion_path_check_bounds:
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y

	rts

;=============================
town_action:
town_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

;=============================
mansion_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	mansion_actions,Y
	cmp	#$ff
	beq	mansion_nothing

	sta	MESSAGE_L
	lda	mansion_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

mansion_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

mansion_actions:
	.word 	$FFFF		; give
	.word	doesnt_open	; open
	.word	doesnt_work	; close
	.word	cant_pick_up	; pick_up
	.word	not_special	; look_at
	.word	$FFFF		; talk_to
	.word	for_what	; use
	.word	icant_move	; push
	.word	icant_move	; pull

