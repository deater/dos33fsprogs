	; 11, 22 = lookout
	; 10, 24 = poster
	; 25, 4  = zipline

map_check_exit:
	lda	GUYBRUSH_X
	cmp	#11
	beq	check_lookout
	cmp	#10
	beq	check_poster
	cmp	#25
	beq	check_zipline

	rts

check_lookout:
	lda	GUYBRUSH_Y
	cmp	#22
	bne	map_no_exit
map_to_lookout:
	lda	#MONKEY_LOOKOUT
	sta	LOCATION
	lda	#30
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#14
	sta	GUYBRUSH_Y
	lda	#22
	sta	DESTINATION_Y
	lda	#DIR_DOWN
	sta	GUYBRUSH_DIRECTION
	jsr	change_location

check_poster:
	lda	GUYBRUSH_Y
	cmp	#24
	bne	map_no_exit
map_to_poster:
	lda	#MONKEY_POSTER
	sta	LOCATION
	lda	#4
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	lda	#DIR_DOWN
	sta	GUYBRUSH_DIRECTION
	jsr	change_location

check_zipline:
	lda	GUYBRUSH_Y
	cmp	#4
	bne	map_no_exit
map_to_zipline:
	lda	#MONKEY_ZIPLINE
	sta	LOCATION
	lda	#4
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#26
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	lda	#DIR_RIGHT
	sta	GUYBRUSH_DIRECTION
	jsr	change_location

map_no_exit:
	rts






map_adjust_destination:

	; x between 6 and 30

	; y between 2 and 32

mp_check_x:
	lda	DESTINATION_X
	cmp	#6
	bcc	mp_too_left
	cmp	#30
	bcc	mp_check_y

	lda	#30
	sta	DESTINATION_X
	jmp	mp_check_y
mp_too_left:
	lda	#6
	sta	DESTINATION_X

mp_check_y:

	lda	DESTINATION_Y
	cmp	#2
	bcc	mp_too_up
	cmp	#32
	bcc	done_mp_adjust

	lda	#32
	sta	DESTINATION_Y
	jmp	done_mp_adjust
mp_too_up:
	lda	#2
	sta	DESTINATION_Y

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

map_check_bounds:
	rts
