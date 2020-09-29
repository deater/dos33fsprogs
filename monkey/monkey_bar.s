	; if x<5 goto DOCK at 34,20

	;===========================
	; check if exit bar screen
	;===========================
	; if x<5 goto DOCK at 34,20
	; if x>35 goto TOWN

bar_check_exit:

	lda	GUYBRUSH_X
	cmp	#5
	bcc	bar_to_dock
	cmp	#35
	bcs	bar_to_town
	bcc	bar_no_exit

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
	; adjust walking destination
	;===========================
bar_keep_in_bounds:

br_force_x:
	lda	GUYBRUSH_X
	cmp	#25
	bcs	br_gb_x_too_big
	cmp	#21
	bcc	br_gb_x_small
	bcs	br_gb_x_medium

br_gb_x_too_big:
	lda	#16
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	bne	done_br_gb_adjust

br_gb_x_medium:
	lda	#18
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	bne	done_br_gb_adjust

br_gb_x_small:
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y

done_br_gb_adjust:
	rts



	;===========================
	; adjust walking destination
	;===========================

bar_adjust_destination:

	; if x<21, y=20
	; if x<25, y=18
	; else y=16

	; also adjust actual Y

	lda	GUYBRUSH_Y
	sta	DESTINATION_Y

br_check_x:
;	lda	DESTINATION_X
;	cmp	#25
;	bcs	br_x_too_big
;	cmp	#21
;	bcc	br_x_small
;	bcs	br_x_medium

br_x_too_big:
;	lda	#16
;	sta	DESTINATION_Y
;	bne	done_br_adjust

br_x_medium:
;	lda	#18
;	sta	DESTINATION_Y
;	bne	done_br_adjust

br_x_small:
;	lda	#20
;	sta	DESTINATION_Y

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
