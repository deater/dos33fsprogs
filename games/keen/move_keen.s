KEEN_SPEED	=	$80

YDEFAULT	=	20

HARD_TILES	=	32	; start at 32

TILE_COLS	=	20


	;=========================
	; move keen
	;=========================
move_keen:

	lda	#0
	sta	SUPPRESS_WALK

	jsr	keen_get_feet_location	; get location of feet

	jsr	check_falling		; check for/handle falling

	jsr	keen_collide		; check for right/left collision

	jsr	handle_jumping		; handle jumping

	lda	KEEN_WALKING
	beq	done_move_keen

	lda	SUPPRESS_WALK
	bne	done_move_keen

	lda	KEEN_DIRECTION
	bmi	move_left

	lda	KEEN_X
	cmp	#22
	bcc	keen_walk_right

keen_scroll_right:

	clc
	lda	KEEN_XL
	adc	#KEEN_SPEED
	sta	KEEN_XL
	bcc	skip_keen_scroll_right

	inc	TILEMAP_X

	jsr	copy_tilemap_subset

skip_keen_scroll_right:

	jmp	done_move_keen

keen_walk_right:
	lda	KEEN_XL
	clc
	adc	#KEEN_SPEED
	sta	KEEN_XL
	bcc	dwr_noflo
	inc	KEEN_X
dwr_noflo:
	jmp	done_move_keen

move_left:

	lda	KEEN_X
	cmp	#14
	bcs	keen_walk_left

keen_scroll_left:

	sec
	lda	KEEN_XL
	sbc	#KEEN_SPEED
	sta	KEEN_XL
	bcs	skip_keen_scroll_left

	dec	TILEMAP_X

	jsr	copy_tilemap_subset

skip_keen_scroll_left:

	jmp	done_move_keen

keen_walk_left:

	lda	KEEN_XL
	sec
	sbc	#KEEN_SPEED
	sta	KEEN_XL
	bcs	dwl_noflo
	dec	KEEN_X
dwl_noflo:
	jmp	done_move_keen

done_move_keen:

	rts



	;=========================
	; keen collide
	;=========================

keen_collide:
	;==================
	; check for item
	;==================
keen_check_item:
	lda	KEEN_FOOT_OFFSET
	sec
	sbc	#TILE_COLS		; look at body
	tax

	jsr	check_item


	;===================
	; collide with head
	;===================
keen_check_head:
	; only check above head if jumping
	lda	KEEN_JUMPING
	beq	collide_left_right

	lda	KEEN_FOOT_OFFSET
	sec
	sbc	#TILE_COLS			; above head is -2 rows
	tax

	lda	tilemap,X

	; if tile# < HARD_TILES then we are fine
	cmp	#HARD_TILES
	bcc	collide_left_right		; blt

	lda	#0
	sta	KEEN_JUMPING
	lda	#1
	sta	KEEN_FALLING

	jsr	head_noise

collide_left_right:
	;===================
	; collide left/right
	;===================

	lda	KEEN_DIRECTION
	beq	done_keen_collide

	bmi	check_left_collide

check_right_collide:
	lda	KEEN_FOOT_OFFSET
	clc
	adc	#1			; right is one to right

	tax
	lda	tilemap,X

	; if tile# < HARD_TILES then we are fine
	cmp	#HARD_TILES
	bcc	done_keen_collide		; blt

	lda	#1				;
	sta	SUPPRESS_WALK
	jmp	done_keen_collide

check_left_collide:

	lda	KEEN_FOOT_OFFSET
	sec
	sbc	#2			; left is one to left
					; +1 fudge factor
	tax
	lda	tilemap,X

	; if tile# < HARD_TILES then we are fine
	cmp	#HARD_TILES
	bcc	done_keen_collide	; blt

	lda	#1
	sta	SUPPRESS_WALK
	jmp	done_keen_collide

done_keen_collide:
	rts



	;=========================
	; check_jumping
	;=========================
handle_jumping:

	lda	KEEN_JUMPING
	beq	done_handle_jumping

	lda	KEEN_Y
	beq	dont_wrap_jump

	dec	KEEN_Y
	dec	KEEN_Y

dont_wrap_jump:
	dec	KEEN_JUMPING
	bne	done_handle_jumping
	lda	#1			; avoid gap before falling triggered
	sta	KEEN_FALLING


done_handle_jumping:
	rts




	;=======================
	; keen_get_feet_location
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
keen_get_feet_location:

	; + 1 is because sprite is 4 pixels wide?

	; screen is TILE_COLS wide, but offset 4 in

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

;	lda	KEEN_Y
;	clc
;	adc	#4		; +4

;	lsr			; / 4 (INT)
;	lsr

;	asl			; *4
;	asl
;	asl
;	asl

	ldx	KEEN_Y
	lda	feet_lookup,X

	sta	KEEN_FOOT_OFFSET

;	lda	KEEN_DIRECTION
;	bmi	foot_left

foot_right:

	lda	KEEN_X
	clc
	adc	#2
;	jmp	foot_done

;foot_left:
;	lda	KEEN_X
;	sec
;	sbc	#1

foot_done:
	lsr

	; offset by two block at edge of screen
;	sec
;	sbc	#2

	clc
	adc	KEEN_FOOT_OFFSET
	sta	KEEN_FOOT_OFFSET

	rts


	;=========================
	; check_falling
	;=========================
check_falling:

	lda	KEEN_JUMPING
	bne	done_check_falling	; don't check falling if jumping

	lda	KEEN_FOOT_OFFSET
	clc
	adc	#TILE_COLS		; underfoot is on next row (+16)

	tax
	lda	tilemap,X

	; if tile# < HARD_TILES then we fall
	cmp	#HARD_TILES
	bcs	feet_on_ground		; bge

	;=======================
	; falling

	lda	#1
	sta	KEEN_FALLING

	; scroll but only if Y>=20 (YDEFAULT)

	lda	KEEN_Y
	cmp	#YDEFAULT
	bcs	scroll_fall	; bge

	inc	KEEN_Y
	inc	KEEN_Y
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

	lda	KEEN_FALLING
	beq	was_not_falling

	; clear falling
	lda	#0
	sta	KEEN_FALLING

	lda	#2
	sta	KICK_UP_DUST

	lda	#0
	sta	KEEN_WALKING

	jsr	land_noise

was_not_falling:
	; check to see if Y still hi, if so scroll back down

	lda	KEEN_Y
	cmp	#YDEFAULT
	bcs	done_check_falling	; bge

	; too high up on screen, adjust down and also adjust tilemap down

	inc	KEEN_Y
	inc	KEEN_Y
	dec	TILEMAP_Y		; share w above?
	jsr	copy_tilemap_subset

done_check_falling:
	rts



	; INT((y+4)/4)*20
feet_lookup:
	.byte	20	; 0
	.byte	20	; 1
	.byte	20	; 2
	.byte	20	; 3
	.byte	40	; 4
	.byte	40	; 5
	.byte	40	; 6
	.byte	40	; 7

	.byte	60	; 8
	.byte	60	; 9
	.byte	60	; 10
	.byte	60	; 11
	.byte	80	; 12
	.byte	80	; 13
	.byte	80	; 14
	.byte	80	; 15

	.byte	100	; 16
	.byte	100	; 17
	.byte	100	; 18
	.byte	100	; 19
	.byte	120	; 20
	.byte	120	; 21
	.byte	120	; 22
	.byte	120	; 23

	.byte	140	; 24
	.byte	140	; 25
	.byte	140	; 26
	.byte	140	; 27
	.byte	160	; 28
	.byte	160	; 29
	.byte	160	; 30
	.byte	160	; 31

	.byte	180	; 32
	.byte	180	; 33
	.byte	180	; 34
	.byte	180	; 35
	.byte	200	; 36
	.byte	200	; 37
	.byte	200	; 38
	.byte	200	; 39

	.byte	220	; 40
	.byte	220	; 41
	.byte	220	; 42
	.byte	220	; 43
	.byte	240	; 44
	.byte	240	; 45
	.byte	240	; 46
	.byte	240	; 47
