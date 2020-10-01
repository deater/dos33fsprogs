; voodoo lady

	; if x<10 goto MONKEY_VOODOO1

voodoo2_check_exit:

	lda	GUYBRUSH_X
	cmp	#10
	bcc	voodoo2_to_voodoo1
	bcs	voodoo2_no_exit

voodoo2_to_voodoo1:
	lda	#MONKEY_VOODOO1
	sta	LOCATION
	lda	#30
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	voodoo2_no_exit

voodoo2_no_exit:
	rts



	;==========================
	;==========================
	; voodoo2 adjust destination
	;==========================
	;==========================
voodoo2_adjust_destination:
	; just make Y always 20

v2_check_y:
	; if x < 28, Y must be between 16 and 18
	; if x < 35, Y must be between  8 and 28

v2_y_too_small:
	lda	#20
	sta	DESTINATION_Y

done_v2_adjust:
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

voodoo2_check_bounds:
	rts
