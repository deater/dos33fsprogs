; stuff regarding the church


	; if x<4 goto MONKEY_POSTER at 28,20
	; if x>35 goto MONKEY_BAR at 5,20

church_check_exit:

	lda	GUYBRUSH_X
	cmp	#4
	bcc	church_to_poster
	cmp	#35
	bcs	church_to_bar
	bcc	church_no_exit

church_to_poster:
	lda	#MONKEY_POSTER
	sta	LOCATION
	lda	#34
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	church_no_exit

church_to_bar:
	lda	#MONKEY_BAR
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
	; just make Y always 20

ch_check_y:
	; if x < 28, Y must be between 16 and 18
	; if x < 35, Y must be between  8 and 28

ch_y_too_small:
	lda	#20
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

