; stuff regarding the church


	; if x<4 goto MONKEY_MANSION_PATH at
	; if x>35 goto MONKEY_CHURCH at

church_check_exit:

	lda	GUYBRUSH_X
	cmp	#4
	bcc	church_to_mansion_path
	cmp	#35
	bcs	church_to_town
	bcc	church_no_exit

church_to_mansion_path:
	lda	#MONKEY_MANSION_PATH
	sta	LOCATION
	lda	#26
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#24
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	church_no_exit

church_to_town:
	lda	#MONKEY_TOWN
	sta	LOCATION
	lda	#1
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	lda	#30
	sta	DESTINATION_Y

	lda	#GUYBRUSH_SMALL
	sta	GUYBRUSH_SIZE

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
	; just make Y always 32

ch_check_y:
	; if x < 28, Y must be between 16 and 18
	; if x < 35, Y must be between  8 and 28

ch_y_too_small:
	lda	#32
	sta	DESTINATION_Y

done_ch_adjust:
	rts


	;=======================
	;=======================
	; draw church foreground
	;=======================
	;=======================
draw_church_foreground:

	lda	GUYBRUSH_X
	cmp	#19
	bcc	draw_church_left_sprite

	cmp	#24
	bcs	draw_church_right_sprite

	bcc	draw_church_no_sprite

draw_church_right_sprite:

	lda	#25
	sta	XPOS

	lda	#<church_right_sprite
	sta	INL
	lda	#>church_right_sprite
	jmp	draw_church_sprite

draw_church_left_sprite:
	lda	#9
	sta	XPOS

	lda	#<church_left_sprite
	sta	INL
	lda	#>church_left_sprite

draw_church_sprite:
	sta	INH

	lda	#32
	sta	YPOS

	jsr	put_sprite_crop


draw_church_no_sprite:
	rts

church_right_sprite:
	.byte	14,2
	.byte	$30,$33,$AA,$AA,$55,$00,$AA,$AA,$AA,$05,$55,$55,$55,$55
	.byte	$bb,$b3,$33,$55,$55,$50,$00,$AA,$AA,$00,$d2,$25,$55,$55

church_left_sprite:
	.byte	8,2
	.byte	$0A,$50,$77,$57,$07,$77,$00,$AA
	.byte	$00,$55,$07,$55,$00,$07,$00,$55


	;=============================
	;=============================
	; church check bounds
	;=============================
	;=============================

church_check_bounds:
	rts





;=============================
alley_action:
alley_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

church_door_action:
church_door_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts


