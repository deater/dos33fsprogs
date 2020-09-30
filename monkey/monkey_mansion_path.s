; stuff regarding path to mansion


	; if x<4 goto MONKEY_MANSION
	; if x>35 goto MONKEY_CHURCH

mansion_path_check_exit:

	lda	GUYBRUSH_X
	cmp	#4
	bcc	mansion_path_to_mansion
	cmp	#35
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
	jsr	change_location
	jmp	mansion_path_no_exit

mansion_path_to_church:
	lda	#MONKEY_CHURCH
	sta	LOCATION
	lda	#5
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
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
	lda	#20
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

