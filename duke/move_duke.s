
DUKE_SPEED	=	$80

YDEFAULT	=	20

HARD_TILES	=	32	; start at 32

	;=========================
	; move duke
	;=========================
move_duke:

	lda	#0
	sta	SUPPRESS_WALK

	jsr	duke_get_feet_location	; get location of feet

	jsr	check_falling		; check for/handle falling

	jsr	duke_collide		; check for right/left collision

	jsr	handle_jumping		; handle jumping

	lda	DUKE_WALKING
	beq	done_move_duke

	lda	SUPPRESS_WALK
	bne	done_move_duke

	lda	DUKE_DIRECTION
	bmi	move_left

	lda	DUKE_X
	cmp	#22
	bcc	duke_walk_right

duke_scroll_right:

	clc
	lda	DUKE_XL
	adc	#DUKE_SPEED
	sta	DUKE_XL
	bcc	skip_duke_scroll_right

	inc	TILEMAP_X

	jsr	copy_tilemap_subset

skip_duke_scroll_right:

	jmp	done_move_duke

duke_walk_right:
	lda	DUKE_XL
	clc
	adc	#DUKE_SPEED
	sta	DUKE_XL
	bcc	dwr_noflo
	inc	DUKE_X
dwr_noflo:
	jmp	done_move_duke

move_left:

	lda	DUKE_X
	cmp	#14
	bcs	duke_walk_left

duke_scroll_left:

	sec
	lda	DUKE_XL
	sbc	#DUKE_SPEED
	sta	DUKE_XL
	bcs	skip_duke_scroll_left

	dec	TILEMAP_X

	jsr	copy_tilemap_subset

skip_duke_scroll_left:

	jmp	done_move_duke

duke_walk_left:

	lda	DUKE_XL
	sec
	sbc	#DUKE_SPEED
	sta	DUKE_XL
	bcs	dwl_noflo
	dec	DUKE_X
dwl_noflo:
	jmp	done_move_duke

done_move_duke:

	rts



	;=========================
	; duke collide
	;=========================

duke_collide:
	;==================
	; check for item
	;==================
duke_check_item:
	lda	DUKE_FOOT_OFFSET
	sec
	sbc	#16
	tax

	jsr	check_item


	;===================
	; collide with head
	;===================
duke_check_head:
	; only check above head if jumping
	lda	DUKE_JUMPING
	beq	collide_left_right

	lda	DUKE_FOOT_OFFSET
	sec
	sbc	#16			; above head is -2 rows
	tax

	lda	TILEMAP,X

	; if tile# < HARD_TILES then we are fine
	cmp	#HARD_TILES
	bcc	collide_left_right		; blt

	lda	#0
	sta	DUKE_JUMPING
	lda	#1
	sta	DUKE_FALLING

	jsr	head_noise

collide_left_right:
	;===================
	; collide left/right
	;===================

	lda	DUKE_DIRECTION
	beq	done_duke_collide

	bmi	check_left_collide

check_right_collide:
	lda	DUKE_FOOT_OFFSET
	clc
	adc	#1			; right is one to right

	tax
	lda	TILEMAP,X

	; if tile# < HARD_TILES then we are fine
	cmp	#HARD_TILES
	bcc	done_duke_collide		; blt

	lda	#1				;
	sta	SUPPRESS_WALK
	jmp	done_duke_collide

check_left_collide:

	lda	DUKE_FOOT_OFFSET
	sec
	sbc	#2			; left is one to left
					; +1 fudge factor
	tax
	lda	TILEMAP,X

	; if tile# < HARD_TILES then we are fine
	cmp	#HARD_TILES
	bcc	done_duke_collide	; blt

	lda	#1
	sta	SUPPRESS_WALK
	jmp	done_duke_collide

done_duke_collide:
	rts



	;=========================
	; check_jumping
	;=========================
handle_jumping:

	lda	DUKE_JUMPING
	beq	done_handle_jumping

	dec	DUKE_Y
	dec	DUKE_Y
	dec	DUKE_JUMPING
	bne	done_handle_jumping
	lda	#1			; avoid gap before falling triggered
	sta	DUKE_FALLING


done_handle_jumping:
	rts




	;=======================
	; duke_get_feet_location
	;=======================

	;		xx	0
	;		xx	1
	;------		-----
	; xx	0	xx	2
	; xx	1	xx	3
	; xx	2	xx	4
	; xx	3	xx	5
	;------		-------
	; xx	4	xx	6
	; xx	5	xx	7
	; xx    6
	; xx	7
	;-----------------------


	; YY = block
	;========================
	;     YYYY            YYYY
	;        -XX-      -XX-
	;         -XX-    -XX-
	; left, foot = (X+1)/2
	; right, foot = (X+2)/2
duke_get_feet_location:

	; + 1 is because sprite is 4 pixels wide?

	; screen is 16 wide, but offset 4 in

	; to get to feet add 6 to Y?

	; block index of foot is (feet approximately 6 lower than Y)
	; INT((y+4)/4)*16 + (x-4+1/2)

	; FIXME: if 18,18 -> INT(26/4)*16 = 96 + 7 = 103 = 6R7

	; 0 = 32 (2)
	; 1 = 32 (2)
	; 2 = 32 (2)
	; 3 = 32 (2)
	; 4 = 48 (3)
	; 5 = 48 (3)
	; 6 = 48 (3)
	; 7 = 48 (3)

	lda	DUKE_Y

	clc
	adc	#4		; +4

	lsr			; / 4 (INT)
	lsr

	asl			; *4
	asl
	asl
	asl

	sta	DUKE_FOOT_OFFSET

;	lda	DUKE_DIRECTION
;	bmi	foot_left

foot_right:

	lda	DUKE_X
	clc
	adc	#2
;	jmp	foot_done

;foot_left:
;	lda	DUKE_X
;	sec
;	sbc	#1

foot_done:
	lsr

	; offset by two block at edge of screen
	sec
	sbc	#2

	clc
	adc	DUKE_FOOT_OFFSET
	sta	DUKE_FOOT_OFFSET

	rts


	;=========================
	; check_falling
	;=========================
check_falling:

	lda	DUKE_JUMPING
	bne	done_check_falling	; don't check falling if jumping

	lda	DUKE_FOOT_OFFSET
	clc
	adc	#16			; underfoot is on next row (+16)

	tax
	lda	TILEMAP,X

	; if tile# < HARD_TILES then we fall
	cmp	#HARD_TILES
	bcs	feet_on_ground		; bge

	;=======================
	; falling

	lda	#1
	sta	DUKE_FALLING

	; scroll but only if Y>=20 (YDEFAULT)

	lda	DUKE_Y
	cmp	#YDEFAULT
	bcs	scroll_fall	; bge

	inc	DUKE_Y
	inc	DUKE_Y
	jmp	done_check_falling


scroll_fall:
	inc	TILEMAP_Y

	jsr	copy_tilemap_subset
	jmp	done_check_falling

feet_on_ground:

	;===========================
	; if had been falling
	; kick up dust, make noise
	; stop walking?

	lda	DUKE_FALLING
	beq	was_not_falling

	; clear falling
	lda	#0
	sta	DUKE_FALLING

	lda	#2
	sta	KICK_UP_DUST

	lda	#0
	sta	DUKE_WALKING

	jsr	land_noise

was_not_falling:
	; check to see if Y still hi, if so scroll back down

	lda	DUKE_Y
	cmp	#YDEFAULT
	bcs	done_check_falling	; bge

	; too high up on screen, adjust down and also adjust tilemap down

	inc	DUKE_Y
	inc	DUKE_Y
	dec	TILEMAP_Y		; share w above?
	jsr	copy_tilemap_subset

done_check_falling:
	rts



