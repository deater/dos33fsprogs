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
	lda	#10
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	voodoo1_no_exit

voodoo1_to_town:
	lda	#MONKEY_TOWN
	sta	LOCATION
	lda	#10
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
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

voodoo1_check_bounds:
	rts
