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
	lda	#5
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	mansion_no_exit

mansion_no_exit:
	rts



	;==========================
	;==========================
	; mansion adjust destination
	;==========================
	;==========================
mansion_adjust_destination:
	; just make Y always 20

mn_check_y:
	; if x < 28, Y must be between 16 and 18
	; if x < 35, Y must be between  8 and 28

mn_y_too_small:
	lda	#20
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

