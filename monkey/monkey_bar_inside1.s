; stuff regarding 1st room in scumm bar

	; if x<5 goto MONKEY_BAR at 10,20
	; if x>35 goto MONKEY_BAR_INSIDE2 at 5,20

bar_inside1_check_exit:

	lda	GUYBRUSH_X
	cmp	#5
	bcc	bar_inside1_to_bar
	cmp	#35
	bcs	bar_inside1_to_bar_inside2
	bcc	bar_inside1_no_exit

bar_inside1_to_bar:
	lda	#MONKEY_BAR
	sta	LOCATION
	lda	#10
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	lda	#DIR_DOWN
	sta	GUYBRUSH_DIRECTION
	jsr	change_location
	jmp	bar_inside1_no_exit

bar_inside1_to_bar_inside2:
	lda	#MONKEY_BAR_INSIDE2
	sta	LOCATION
	lda	#3
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	lda	#24
	sta	DESTINATION_Y
	jsr	change_location
	jmp	bar_inside1_no_exit

bar_inside1_no_exit:
	rts



	;=================================
	;=================================
	; bar_inside1 adjust destination
	;=================================
	;=================================
bar_inside1_adjust_destination:
	; just make Y always 22

mb1_check_y:
	; if x < 28, Y must be between 16 and 18
	; if x < 35, Y must be between  8 and 28

mb1_y_too_small:
	lda	#24
	sta	DESTINATION_Y

done_mb1_adjust:
	rts



	;=================================
	;=================================
	; bar_inside1 draw foreground
	;=================================
	;=================================

bar_inside1_foreground:

	lda	GUYBRUSH_X
	cmp	#12
	bcs	bar_inside_rightside

bar_inside_leftside:

	lda	#<bar1_table_sprite
	sta	INL
	lda	#>bar1_table_sprite
	sta	INH

	lda	#4
	sta	XPOS
	lda	#32
	sta	YPOS

	jsr	put_sprite_crop

	jmp	bar_animate_ceiling

bar_inside_rightside:

	lda	#<bar1_table2_sprite
	sta	INL
	lda	#>bar1_table2_sprite
	sta	INH

	lda	#20
	sta	XPOS
	lda	#26
	sta	YPOS

	jsr	put_sprite_crop

	; I can't spell chandelier
bar_animate_ceiling:

bar_inside_done:
	rts



bar1_table_sprite:
	.byte 6,3
	.byte $8A,$8A,$1A,$8A,$AA,$AA
	.byte $b8,$00,$0b,$b8,$88,$88
	.byte $88,$90,$00,$88,$8b,$A8

bar1_table2_sprite:
	.byte 11,6
	.byte $AA,$AA,$0A,$0A,$AA,$AA,$9A,$9A,$AA,$AA,$AA
	.byte $AA,$00,$0b,$AA,$AA,$AA,$99,$bb,$AA,$b2,$0A
	.byte $AA,$0A,$6b,$0A,$7A,$5A,$b2,$62,$AA,$9b,$00
	.byte $8A,$00,$b5,$20,$67,$dd,$db,$7b,$db,$d0,$A0
	.byte $A8,$88,$26,$66,$db,$d2,$db,$d7,$8d,$8b,$AA
	.byte $AA,$88,$22,$26,$2b,$88,$A8,$08,$00,$88,$AA


	;===================================
	;===================================
	; actions
	;===================================
	;===================================

;=============================
bar1_pirate_action:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

;=============================
bar1_door_action:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

;=============================
bar1_dog_action:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts


bar_inside1_check_bounds:
	rts
