	; if x<3 goto MONKEY_POSTER at 28,30 with destination 28,24
        ; if x>35 goto MONKEY_DOCK at 5,20

poster_check_exit:
	lda	GUYBRUSH_X
	cmp	#3
	bcc	poster_to_lookout
	cmp	#35
	bcs	poster_to_dock
	bcc	poster_no_exit

poster_to_lookout:
	lda	#MONKEY_LOOKOUT
	sta	LOCATION
	lda	#28
	sta	GUYBRUSH_X
	lda	#26
	sta	GUYBRUSH_Y
	lda	#28
	sta	DESTINATION_X
	lda	#18
	sta	DESTINATION_Y
	lda	#DIR_UP
	sta	GUYBRUSH_DIRECTION
	jsr	change_location
	jmp	poster_no_exit

poster_to_dock:
	lda	#MONKEY_DOCK
	sta	LOCATION
	lda	#5
	sta	DESTINATION_X
	sta	GUYBRUSH_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location

poster_no_exit:
	rts

poster_adjust_destination:

ps_check_x:
	; can be any X

ps_check_y:
	; if x>5 Y should be 20

	lda	#20
	sta	DESTINATION_Y

done_ps_adjust:
	rts




draw_house:

	lda	#<house_sprite
	sta	INL
	lda	#>house_sprite
	sta	INH

	lda	#9
	sta	XPOS
	lda	#20
	sta	YPOS

	jsr	put_sprite_crop

	rts

house_sprite:
	.byte 18,7
	;line 1
	.byte $AA,$5A,$55,$55,$55,$55,$55,$55,$55,$55
	.byte $55,$55,$55,$57,$7A,$7A,$AA,$AA

	.byte $00,$00,$00,$00,$00,$00,$00,$05,$05,$05
	.byte $05,$05,$05,$05,$05,$05,$07,$7A

	.byte $22,$22,$22,$22,$20,$80,$80,$00,$80,$80
	.byte $22,$72,$A7,$AA,$AA,$AA,$77,$AA

	.byte $22,$22,$22,$22,$22,$88,$d8,$00,$d8,$88
	.byte $22,$77,$AA,$AA,$AA,$77,$AA,$AA

	.byte $22,$22,$22,$22,$22,$08,$0d,$00,$0d,$22
	.byte $22,$77,$AA,$AA,$AA,$77,$AA,$AA

	.byte $22,$22,$22,$22,$22,$88,$dd,$00,$dd,$22
	.byte $22,$77,$7A,$7A,$7A,$77,$AA,$AA

	.byte $22,$22,$22,$22,$22,$28,$20,$2d,$28,$22
	.byte $77,$AA,$77,$AA,$77,$AA,$AA,$AA


