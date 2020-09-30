	; if x<5 goto DOCK at 34,20

	;===========================
	; check if exit bar screen
	;===========================
	; if x<5 goto DOCK at 34,20
	; if x>35 goto TOWN
	; if 9<x<14 and y<20 and door open, BAR_INSIDE1

bar_check_exit:

	lda	GUYBRUSH_X
	cmp	#5
	bcc	bar_to_dock
	cmp	#35
	bcs	bar_to_town

	cmp	#9
	bcc	bar_no_exit
	cmp	#14
	bcs	bar_no_exit

bar_to_inside:
	lda	GUYBRUSH_Y
	cmp	#20
	bcs	bar_no_exit

	lda	BAR_DOOR_OPEN
	beq	bar_no_exit

	lda	#MONKEY_BAR_INSIDE1
	sta	LOCATION
	lda	#5
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	bar_no_exit

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
	jmp	bar_no_exit

bar_to_town:
	lda	#MONKEY_TOWN
	sta	LOCATION
	lda	#34
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	lda	#26
	sta	DESTINATION_Y
	lda	#DIR_DOWN
	sta	GUYBRUSH_DIRECTION
	jsr	change_location


bar_no_exit:
	rts


	;===========================
	; adjust bounds
	;===========================
bar_keep_in_bounds:

br_force_x:
	lda	GUYBRUSH_X
	cmp	#25
	bcs	br_gb_x_far_right
	cmp	#21
	bcs	br_gb_x_right
	cmp	#9
	bcc	br_gb_x_left
	cmp	#14
	bcc	br_gb_doorway
	bcs	br_gb_x_left

br_gb_doorway:
	lda	GUYBRUSH_Y
	cmp	#20
	bcc	br_gb_x_right
	bcs	br_gb_x_left

br_gb_x_far_right:
	lda	#16
	bne	done_br_gb_adjust

br_gb_x_right:
	lda	#18
	bne	done_br_gb_adjust

br_gb_x_left:
	lda	#20

done_br_gb_adjust:
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	rts



	;===========================
	; adjust walking destination
	;===========================

bar_adjust_destination:

	; just keep Y whatever is in bounds
	; *except* in doorway 9<x<14
	; then allow it to be 18

	lda	GUYBRUSH_X
	cmp	#9
	bcc	bar_adjust_force_y
	cmp	#14
	bcs	bar_adjust_force_y

	lda	CURSOR_X
	cmp	#9
	bcc	done_br_adjust
	cmp	#14
	bcs	done_br_adjust

	lda	CURSOR_Y
	cmp	#28
	bcs	done_br_adjust

	lda	#18
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y

bar_adjust_force_y:
	lda	GUYBRUSH_Y
	sta	DESTINATION_Y


done_br_adjust:
	rts





	;=====================
	; draw bar door
	;=====================
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


draw_bar_fg_building:

	; only draw it if we're that side of screeen
	lda	GUYBRUSH_X
	cmp	#24
	bcc	done_draw_bar_fg_building

	lda	#<building_sprite
	sta	INL
	lda	#>building_sprite
	sta	INH

	lda	#27
	sta	XPOS
	lda	#16
	sta	YPOS

	jsr	put_sprite_crop

done_draw_bar_fg_building:
	rts

building_sprite:
	.byte 13,7
	.byte $77,$22,$9d,$00,$9d,$00,$22,$22,$22,$00,$00,$00,$0A
	.byte $77,$25,$25,$25,$25,$25,$22,$22,$22,$00,$00,$00,$00
	.byte $77,$22,$22,$22,$22,$22,$22,$22,$02,$00,$00,$90,$90
	.byte $A7,$72,$02,$02,$02,$00,$00,$00,$00,$00,$00,$09,$09
	.byte $AA,$77,$00,$00,$00,$00,$00,$00,$00,$60,$60,$d9,$dd
	.byte $AA,$77,$00,$00,$00,$00,$60,$00,$60,$06,$00,$66,$dd
	.byte $AA,$77,$00,$60,$26,$66,$02,$06,$00,$00,$60,$22,$00
