; right side of downtown village

	;=======================
	; check exit
	;=======================
	;

town_check_exit:

	lda	GUYBRUSH_X
	cmp	#5		; temporary
	bcc	town_to_church

	cmp	#32
	bcc	town_no_exit

	lda	GUYBRUSH_Y
	cmp	#22
	bcs	town_no_exit

	lda	GUYBRUSH_DIRECTION
	cmp	#DIR_UP
	bne	town_no_exit

town_to_bar:
	lda	#MONKEY_BAR
	sta	LOCATION
	lda	#34
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y

	lda	#DIR_LEFT
	sta	GUYBRUSH_DIRECTION
	jsr	change_location
	jmp	town_no_exit

town_to_church:
	lda	#MONKEY_CHURCH
	sta	LOCATION
	lda	#34
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#30
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y

	lda	#DIR_LEFT
	sta	GUYBRUSH_DIRECTION
	jsr	change_location

town_no_exit:
	rts

	;=======================
	; adjust destination
	;=======================

town_adjust_destination:

	; if x<32, y must be >22
	; if 32<x<40, y must be  > 18
	; x can't go past 25

tn_check_x:
	lda	DESTINATION_X
	cmp	#32
	bcs	tn_x_right
	bcc	tn_x_left

tn_x_left:
	lda	DESTINATION_Y
	cmp	#22
	bcs	done_tn_adjust
	lda	#22
	sta	DESTINATION_Y
	jmp	done_tn_adjust
tn_x_right:
	lda	DESTINATION_Y
	cmp	#18
	bcs	done_tn_adjust
	lda	#18
	sta	DESTINATION_Y
	jmp	done_tn_adjust


done_tn_adjust:
	rts


	;=======================
	; adjust bounds
	;=======================
town_check_bounds:
	rts


;draw_town_door:
;
;	lda	BAR_DOOR_OPEN
;	beq	done_draw_town_door

;	lda	#<door_sprite
;	sta	INL
;	lda	#>door_sprite
;	sta	INH

;	lda	#11
;	sta	XPOS
;	lda	#22
;	sta	YPOS

;	jsr	put_sprite_crop
;done_draw_town_door:
;	rts

