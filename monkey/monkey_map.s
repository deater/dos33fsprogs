
map_check_exit:
	jmp	map_no_exit
	lda	GUYBRUSH_X
	cmp	#5
	bcc	map_to_dock
	bcs	map_no_exit

map_to_dock:
	lda	#MONKEY_DOCK
	sta	LOCATION
	lda	#34
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location

map_no_exit:
	rts

map_adjust_destination:

	; if x<28, y must be >30
	; if 28<x<40, y must be  > 26
	; x can't go past 25

mp_check_x:
	lda	DESTINATION_X
	cmp	#28
	bcs	mp_x_left
	bcc	mp_x_right

mp_x_left:
	lda	DESTINATION_Y
	cmp	#30
	bcs	done_mp_adjust
	lda	#30
	sta	DESTINATION_Y
	jmp	done_mp_adjust
mp_x_right:
	lda	DESTINATION_Y
	cmp	#26
	bcs	done_mp_adjust
	lda	#26
	sta	DESTINATION_Y
	jmp	done_mp_adjust


done_mp_adjust:
	rts




;draw_map_door:
;
;	lda	BAR_DOOR_OPEN
;	beq	done_draw_map_door

;	lda	#<door_sprite
;	sta	INL
;	lda	#>door_sprite
;	sta	INH

;	lda	#11
;	sta	XPOS
;	lda	#22
;	sta	YPOS

;	jsr	put_sprite_crop
;done_draw_map_door:
;	rts

