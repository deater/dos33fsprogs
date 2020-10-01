; stuff regarding the church


	; if x<4 goto MONKEY_MANSION_PATH at
	; if x>35 goto MONKEY_CHURCH at

church_check_exit:

	lda	GUYBRUSH_X
	cmp	#4
	bcc	church_to_mansion_path
	cmp	#35
	bcs	church_to_town
	bcc	church_no_exit

church_to_mansion_path:
	lda	#MONKEY_MANSION_PATH
	sta	LOCATION
	lda	#26
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#24
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	church_no_exit

church_to_town:
	lda	#MONKEY_TOWN
	sta	LOCATION
	lda	#5
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	church_no_exit

church_no_exit:
	rts



	;==========================
	;==========================
	; church adjust destination
	;==========================
	;==========================
church_adjust_destination:
	; just make Y always 32

ch_check_y:
	; if x < 28, Y must be between 16 and 18
	; if x < 35, Y must be between  8 and 28

ch_y_too_small:
	lda	#32
	sta	DESTINATION_Y

done_ch_adjust:
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

church_check_bounds:
	rts





;=============================
alley_action:
alley_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

church_door_action:
church_door_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts


