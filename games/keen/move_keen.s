KEEN_SPEED	=	$80

YDEFAULT	=	20

HARDTOP_TILES	=	32	; start at 32
ALLHARD_TILES	=	40	; start at 40

TILE_COLS	=	20


	;=========================
	; move keen
	;=========================
move_keen:

	lda	#0
	sta	SUPPRESS_WALK		; ????

	jsr	keen_get_feet_location	; get location of feet

	jsr	check_falling		; check for/handle falling

	jsr	keen_collide		; check for right/left collision

	jsr	handle_jumping		; handle jumping


	lda	KEEN_WALKING		; if not walking, we're done
	beq	done_move_keen

	dec	KEEN_WALKING		; decrement walk count

	lda	SUPPRESS_WALK		; why????
	bne	done_move_keen

	lda	KEEN_DIRECTION		; check direction
	bmi	move_left

	;==============================
	; Move Keen Right
	;==============================
	; if (keen_x<22) || (tilemap_x>xmax-20) walk
	;	otherwise, scroll

	lda	TILEMAP_X
	cmp	#96		; 540-80 = 460/4 = 115-20 = 95
	bcs	keen_walk_right


	lda	KEEN_X			; if X more than 22
	cmp	#22			; scroll screen rather than keen
	bcc	keen_walk_right

keen_scroll_right:

	clc					; location is 8:8 fixed point
	lda	KEEN_XL
	adc	#KEEN_SPEED			; add in speed
	sta	KEEN_XL
	bcc	skip_keen_scroll_right		; if carry out we scroll

	inc	TILEMAP_X			; scroll screen to right

	jsr	copy_tilemap_subset		; update tilemap

skip_keen_scroll_right:

	jmp	done_move_keen

keen_walk_right:
	lda	KEEN_XL				; get 8:8 fixed
	clc
	adc	#KEEN_SPEED			; add in speed
	sta	KEEN_XL

	bcc	dwr_noflo			; if no overflow
	inc	KEEN_X				; otherwise update X
dwr_noflo:
	jmp	done_move_keen

move_left:

	;==============================
	; Move Keen Left
	;==============================
	; if (keen_x>=14) || (tilemap_x=0) walk
	;	otherwise, scroll

	lda	TILEMAP_X
	beq	keen_walk_left

	lda	KEEN_X				; get current X
	cmp	#14
	bcs	keen_walk_left		; bge	; if >=14 walk

keen_scroll_left:				; otherwise scroll

	sec					; 8.8 fixed point
	lda	KEEN_XL
	sbc	#KEEN_SPEED
	sta	KEEN_XL
	bcs	skip_keen_scroll_left

	dec	TILEMAP_X			; scroll left

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
keen_check_items:

	jsr	check_items

	;===================
	; collide with head
	;===================
keen_check_head:
	; only check above head if jumping
	lda	KEEN_JUMPING
	beq	collide_left_right

	; if here we are jumping

	; check if left side of head hit hard tile

	lda	KEEN_HEAD_TILE1
	; if tile# < ALLHARD_TILES then we are fine
	cmp	#ALLHARD_TILES
	bcc	collide_left_right		; blt

	lda	KEEN_HEAD_TILE2
	; if tile# < ALLHARD_TILES then we are fine
	cmp	#ALLHARD_TILES
	bcc	collide_left_right		; blt

	; o/~ I hit my head, I heard the phone ring o/~
	; o/~ I was distracted by my friend Joe o/~

	lda	#0
	sta	KEEN_JUMPING		; no longer jumping
	lda	#1
	sta	KEEN_FALLING		; now falling

;	jsr	head_noise

collide_left_right:
	;===================
	; collide left/right
	;===================

	lda	KEEN_DIRECTION
	beq	done_keen_collide	; can this happen?

	bmi	check_left_collide

check_right_collide:
	lda	KEEN_WALK_TILE_R
	; if tile# < ALLHARD_TILES then we are fine
	cmp	#ALLHARD_TILES
	bcc	done_keen_collide		; blt

	lda	#1				;
	sta	SUPPRESS_WALK
	jmp	done_keen_collide

check_left_collide:

	lda	KEEN_WALK_TILE_L
	; if tile# < ALLHARD_TILES then we are fine
	cmp	#ALLHARD_TILES
	bcc	done_keen_collide	; blt

	lda	#1
	sta	SUPPRESS_WALK
	jmp	done_keen_collide

done_keen_collide:
	rts



	;=========================
	; handle_jumping
	;=========================
handle_jumping:

	lda	KEEN_JUMPING
	beq	done_handle_jumping	; skip if not actually jumping

	;===================================================
	; scroll but only if KEEN_Y<20 (YDEFAULT)
	;	and TILEMAP_Y >0

	lda	TILEMAP_Y		; if tilemap=0, scroll keen
	cmp	#0			; instead of scrolling screen
	beq	keen_rising

	; check if hit top of screen

	lda	KEEN_Y			;
	cmp	#2			; if hit top of screen, start falling
	bcc	start_falling

	cmp	#YDEFAULT		; compare to middle of screen
	bcc	scroll_rising		; blt

	; move keen
keen_rising:
	dec	KEEN_Y
	dec	KEEN_Y
	jmp	done_check_rising


scroll_rising:
	dec	TILEMAP_Y

	jsr	copy_tilemap_subset
	jmp	done_check_rising

done_check_rising:

	dec	KEEN_JUMPING		; slow jump
	bne	done_handle_jumping	; if positive still going up

start_falling:
					; otherwise hit peak, start falling
	lda	#1			; avoid gap before falling triggered
	sta	KEEN_FALLING


done_handle_jumping:
	rts






	;=========================
	; check_falling
	;=========================
check_falling:

	lda	KEEN_JUMPING
	bne	done_check_falling	; don't check falling if jumping

	lda	KEEN_FOOT_BELOW1

	; if tile# > HARDTOP_TILES then we stop falling
	cmp	#HARDTOP_TILES
	bcs	feet_on_ground		; bge

	lda	KEEN_FOOT_BELOW2

	; if tile# > HARDTOP_TILES then we stop falling
	cmp	#HARDTOP_TILES
	bcs	feet_on_ground		; bge


	;=======================
	; falling

	lda	#1
	sta	KEEN_FALLING

	;===================================================
	; scroll but only if KEEN_Y>=20 (YDEFAULT)
	;	and TILEMAP_Y < MAX_TILE_Y

	lda	TILEMAP_Y
	cmp	#MAX_TILE_Y
	bcs	keen_fall	; bge

	lda	KEEN_Y
	cmp	#YDEFAULT
	bcs	scroll_fall	; bge

keen_fall:
	inc	KEEN_Y			; this must be +2
	inc	KEEN_Y			; as we only draw sprites on even lines
	jmp	done_check_falling


scroll_fall:
	inc	TILEMAP_Y

	jsr	copy_tilemap_subset

	jmp	done_check_falling

feet_on_ground:

	;===========================
	; if had been falling
	; make noise
	; stop walking?

	lda	KEEN_FALLING
	beq	was_not_falling

	; clear falling
	lda	#0
	sta	KEEN_FALLING
	sta	KEEN_WALKING

;	jsr	land_noise

	rts

was_not_falling:
	; check to see if Y still hi, if so scroll back down
;	lda	KEEN_Y
;	cmp	#YDEFAULT
;	bcs	done_check_falling	; bge

	; too high up on screen, adjust down and also adjust tilemap down

;	inc	KEEN_Y
;	inc	KEEN_Y
;	inc	TILEMAP_Y		; share w above?
;	jsr	copy_tilemap_subset

done_check_falling:
	rts




	;=======================
	; keen_get_feet_location
	;=======================
	; sets ? values
	;	they are actually the tile values, not offsets
	;	KEEN_HEAD_TILE1, KEEN_HEAD_TILE2
	;		tile values of row containing keen's head
	;	KEEN_FOOT_TILE1, KEEN_FOOT_TILE2
	;		tile values of row containing keen's feet
	;	KEEN_FOOT_BELOW1, KEEN_FOOT_BELOW2
	;		tile values of row below  keen's feet (he can span 2)
	;	KEEN_WALK_TILE_L,KEEN_WALK_TILE_R
	;		tile value of what walking into


; keen sprite is 4 wide, but only the "core" is 2 wide

; so in theory 2 possibilities

;            EVEN      ODD       EVEN      ODD
;             .KK.       .KK.       .KK.       .KK.
;             001122    001122    001122    00112233
;FOOT_BELOW    0/1       1/1         1/2       2/2
;FOOT_WALK(R)  1          2           2        3
;FOOT_WALK(L)  0          0           1        1


	; if KEEN_X = even
	; 	KEEN_FOOT_BELOW1 = (KEEN_X>>1)
	;	KEEN_FOOT_BELOW2 = (KEEN_X>>1)+1)
	;	KEEN_FOOT_WALK_R = (KEEN_X>>1)+1)
	;	KEEN_FOOT_WALK_L = (KEEN_X>>1)
	; if KEEN_X = odd
	;	KEEN_FOOT_BELOW1 = ((KEEN_X>>1)+1)
	;	KEEN_FOOT_BELOW2 = ((KEEN_X>>1)+1)
	;	KEEN_FOOT_WALK_R = ((KEEN_X>>1)+2)
	;	KEEN_FOOT_WALK_L = (KEEN_X>>1)
keen_get_feet_location:

	lda	KEEN_X
	lsr

	bcs	keen_get_feet_odd
keen_get_feet_even:
	; carry is clear
	ldx	KEEN_Y
	adc	head_lookup,X
	tax				; X is now pointer to tile of head

	lda	tilemap,X		; put tilemap value in place
	sta	KEEN_HEAD_TILE1
	stx	KEEN_HEAD_POINTER_L
	lda	tilemap+1,X
	sta	KEEN_HEAD_TILE2
	txa
	inx
	stx	KEEN_HEAD_POINTER_R
					; restore pointer to tile of head
	clc
	adc	#TILE_COLS		; one row down, now at foot
	tax

	lda	tilemap,X		; put tilemap value in place
	sta	KEEN_FOOT_TILE1
	sta	KEEN_WALK_TILE_L
	stx	KEEN_FOOT_POINTER_L

	lda	tilemap+1,X
	sta	KEEN_FOOT_TILE2
	sta	KEEN_WALK_TILE_R
	txa
	inx
	stx	KEEN_FOOT_POINTER_R
					; restore pointer to tile of foot
	clc
	adc	#TILE_COLS		; one row down
	tax

	lda	tilemap,X
	sta	KEEN_FOOT_BELOW1
	lda	tilemap+1,X
	sta	KEEN_FOOT_BELOW2

	rts


keen_get_feet_odd:
	; carry is set
	clc
	ldx	KEEN_Y
	adc	head_lookup,X
	tax				; X is now pointer to tilemap of head

	lda	tilemap+1,X		; put tilemap value in place
	sta	KEEN_HEAD_TILE1
	sta	KEEN_HEAD_TILE2
	stx	KEEN_HEAD_POINTER_L
	stx	KEEN_HEAD_POINTER_R

	txa
	clc
	adc	#TILE_COLS		; one row down
	tax				; X is now pointer to tilemap of feet

	lda	tilemap,X		; put tilemap value in place
	sta	KEEN_WALK_TILE_L
	lda	tilemap+1,X
	sta	KEEN_FOOT_TILE1
	sta	KEEN_FOOT_TILE2
	lda	tilemap+2,X
	sta	KEEN_WALK_TILE_R
	stx	KEEN_FOOT_POINTER_L
	stx	KEEN_FOOT_POINTER_R

	txa
	clc
	adc	#TILE_COLS		; one row down
	tax

	lda	tilemap+1,X
	sta	KEEN_FOOT_BELOW1
	sta	KEEN_FOOT_BELOW2

	rts


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

	; INT((y)/4)*20
head_lookup:
	.byte	0,0,0,0
	.byte	20,20,20,20	; 3
	.byte	40,40,40,40	; 7
	.byte	60,60,60,60	; 11
	.byte	80,80,80,80	; 15
	.byte	100,100,100,100	; 19
	.byte	120,120,120,120	; 23
	.byte	140,140,140,140	; 27
	.byte	160,160,160,160	; 31
	.byte	180,180,180,180	; 35
	.byte	200,200,200,200	; 39
	.byte	220,220,220,220	; 43
	.byte	240,240,240,240	; 47

