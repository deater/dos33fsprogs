; stuff regarding 2nd room of scumm bar

	; if x<4 goto MONKEY_POSTER at 28,20
	; if x>35 goto MONKEY_BAR at 5,20

bar_inside2_check_exit:

	lda	GUYBRUSH_X
	cmp	#4
	bcc	bar_inside2_to_poster
	cmp	#35
	bcs	bar_inside2_to_bar
	bcc	bar_inside2_no_exit

bar_inside2_to_poster:
	lda	#MONKEY_POSTER
	sta	LOCATION
	lda	#34
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	bar_inside2_no_exit

bar_inside2_to_bar:
	lda	#MONKEY_BAR
	sta	LOCATION
	lda	#5
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	bar_inside2_no_exit

bar_inside2_no_exit:
	rts



	;==========================
	;==========================
	; bar_inside2 adjust destination
	;==========================
	;==========================
bar_inside2_adjust_destination:
	; just make Y always 20

mb2_check_y:
	; if x < 28, Y must be between 16 and 18
	; if x < 35, Y must be between  8 and 28

mb2_y_too_small:
	lda	#20
	sta	DESTINATION_Y

done_mb2_adjust:
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

