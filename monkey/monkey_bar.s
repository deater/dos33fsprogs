	; if x<5 goto DOCK at 34,20

bar_check_exit:

	lda	GUYBRUSH_X
	cmp	#5
	bcc	bar_to_dock
	bcs	bar_no_exit

bar_to_dock:
	lda	#MONKEY_DOCK
	sta	LOCATION
	lda	#34
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location

bar_no_exit:
	rts

bar_adjust_destination:

	; if x<21, y=20
	; if x<25, y=18
	; x can't go past 25

br_check_x:
	lda	DESTINATION_X
	cmp	#25
	bcs	br_x_too_big
	cmp	#21
	bcc	br_x_small
	bcs	br_x_medium

br_x_too_big:
	lda	#25
	sta	DESTINATION_X
	lda	#18
	sta	DESTINATION_Y
	bne	done_br_adjust

br_x_medium:
	lda	#18
	sta	DESTINATION_Y
	bne	done_br_adjust

br_x_small:
	lda	#20
	sta	DESTINATION_Y

done_br_adjust:
	rts




draw_bar_door:

	lda	BAR_DOOR_OPEN
	beq	done_draw_bar_door

	lda	#<door_sprite
	sta	INL
	lda	#>door_sprite
	sta	INH

	lda	#11
	sta	XPOS
	lda	#22
	sta	YPOS

	jsr	put_sprite_crop
done_draw_bar_door:
	rts

door_sprite:
	.byte 2,5
	.byte	$d2,$d2
	.byte	$88,$DD
	.byte	$88,$DD
	.byte	$88,$DD
	.byte	$5d,$5D



