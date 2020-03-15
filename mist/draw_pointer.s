	;====================================
	; draw pointer
	;====================================

	lda	CURSOR_VISIBLE
	bne	draw_pointer
	jmp	no_draw_pointer

draw_pointer:


	; point sprite to right location

	lda	CURSOR_X
	sta	XPOS
        lda     CURSOR_Y
	sta	YPOS

	; see if inside special region
	ldy	#LOCATION_SPECIAL_EXIT
	lda	(LOCATION_STRUCT_L),Y
	cmp	#$ff
	beq	finger_not_special	; if $ff not special

	lda	DIRECTION
	and	#$f
	cmp	(LOCATION_STRUCT_L),Y
	bne	finger_not_special	; only special if facing right way

	; see if X1 < X < X2
	lda	CURSOR_X
	ldy	#LOCATION_SPECIAL_X1
	cmp	(LOCATION_STRUCT_L),Y
	bcc	finger_not_special	; blt

	ldy	#LOCATION_SPECIAL_X2
	cmp	(LOCATION_STRUCT_L),Y
	bcs	finger_not_special	; bge

	; see if Y1 < Y < Y2
	lda	CURSOR_Y
	ldy	#LOCATION_SPECIAL_Y1
	cmp	(LOCATION_STRUCT_L),Y
	bcc	finger_not_special	; blt

	ldy	#LOCATION_SPECIAL_Y2
	cmp	(LOCATION_STRUCT_L),Y
	bcs	finger_not_special	; bge

	; we made it this far, we are special

finger_grab:
	lda	#1
	sta	IN_SPECIAL

	lda	DIRECTION
	and	#DIRECTION_ONLY_POINT
	bne	special_but_point

	lda     #<finger_grab_sprite
	sta	INL
	lda     #>finger_grab_sprite
	jmp	finger_draw

special_but_point:
	jmp	finger_point

finger_not_special:

	; check for left/right

	lda	CURSOR_X
	cmp	#7
	bcc	check_cursor_left			; blt

	cmp	#33
	bcs	check_cursor_right			; bge

	; otherwise, finger_point

finger_point:
	lda     #<finger_point_sprite
	sta	INL
	lda     #>finger_point_sprite
	jmp	finger_draw

check_cursor_left:
	ldy	#LOCATION_BGS

check_left_north:
	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_N
	bne	check_left_south

handle_left_north:
	; check if west exists
	lda	(LOCATION_STRUCT_L),Y
	and	#BG_WEST
	beq	finger_point
	bne	finger_left

check_left_south:
	cmp	#DIRECTION_S
	bne	check_left_east

handle_left_south:
	; check if east exists
	lda	(LOCATION_STRUCT_L),Y
	and	#BG_EAST
	beq	finger_point
	bne	finger_left

check_left_east:
	cmp	#DIRECTION_E
	bne	check_left_west
handle_left_east:
	; check if north exists
	lda	(LOCATION_STRUCT_L),Y
	and	#BG_NORTH
	beq	finger_point
	bne	finger_left

check_left_west:
	; we should be only option left
handle_left_west:
	; check if south exists
	lda	(LOCATION_STRUCT_L),Y
	and	#BG_SOUTH
	beq	finger_point
	bne	finger_left


check_cursor_right:

	ldy	#LOCATION_BGS

check_right_north:
	lda	DIRECTION
	and	#$f
	cmp	#DIRECTION_N
	bne	check_right_south

handle_right_north:
	; check if east exists
	lda	(LOCATION_STRUCT_L),Y
	and	#BG_EAST
	beq	finger_point
	bne	finger_right

check_right_south:
	cmp	#DIRECTION_S
	bne	check_right_east

handle_right_south:
	; check if west exists
	lda	(LOCATION_STRUCT_L),Y
	and	#BG_WEST
	beq	finger_point
	bne	finger_right

check_right_east:
	cmp	#DIRECTION_E
	bne	check_right_west
handle_right_east:
	; check if south exists
	lda	(LOCATION_STRUCT_L),Y
	and	#BG_SOUTH
	beq	finger_point
	bne	finger_right

check_right_west:
	; we should be only option left
handle_right_west:
	; check if north exists
	lda	(LOCATION_STRUCT_L),Y
	and	#BG_NORTH
	beq	finger_point
	bne	finger_right



finger_left:
	lda	#1
	sta	IN_LEFT

	lda     #<finger_left_sprite
	sta	INL
	lda     #>finger_left_sprite
	jmp	finger_draw

finger_right:
	lda	#1
	sta	IN_RIGHT
	lda     #<finger_right_sprite
	sta	INL
	lda     #>finger_right_sprite
	jmp	finger_draw



finger_draw:
	sta	INH
	jsr	put_sprite_crop

no_draw_pointer:
	rts

