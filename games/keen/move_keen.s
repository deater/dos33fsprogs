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
	sta	SUPPRESS_WALK		; if we collide we set this to stop walk

	jsr	check_falling		; check for/handle falling

	jsr	keen_collide		; check for right/left collision

	jsr	handle_jumping		; handle jumping

	lda	KEEN_WALKING		; if not walking, we're done
	beq	move_keen_early_out

	dec	KEEN_WALKING		; decrement walk count

	lda	SUPPRESS_WALK		; we hit somthing, don't walk
	bne	move_keen_early_out

	lda	KEEN_DIRECTION		; check direction
	bmi	move_left
	bpl	move_right

move_keen_early_out:
	jmp	done_move_keen

	;==============================
	; Move Keen Right
	;==============================
	; if (keen_tilex-tilemap_x<11) || (tilemap_x>96) walk
	;	otherwise, scroll
move_right:
	lda	TILEMAP_X
	cmp	#96		; 540-80 = 460/4 = 115-20 = 95
	bcs	keen_walk_right

	sec
	lda	KEEN_TILEX
	sbc	TILEMAP_X
	cmp	#11
	bcc	keen_walk_right

keen_scroll_right:
	clc                                     ; location is 8:8 fixed point
	lda     KEEN_XL
	adc     #KEEN_SPEED                     ; add in speed
	sta     KEEN_XL
	bcc     skip_keen_scroll_right          ; if carry out we scroll

	inc     TILEMAP_X                       ; scroll screen to right
	inc	KEEN_TILEX

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
	lda	KEEN_X
	cmp	#2
	bne	dwr_noflo

	lda	#0
	sta	KEEN_X

	inc	KEEN_TILEX

dwr_noflo:
	jmp	done_move_keen

move_left:

	;==============================
	; Move Keen Left
	;==============================
	; if (keen_tilex-tilemap_x>=7) || (tilemap_x=0) walk
	;	otherwise, scroll

	lda	TILEMAP_X
	beq	keen_walk_left

	sec
	lda	KEEN_TILEX
	sbc	TILEMAP_X
	cmp	#7
	bcs	keen_walk_left

keen_scroll_left:				; otherwise scroll

	sec					; 8.8 fixed point
	lda	KEEN_XL
	sbc	#KEEN_SPEED
	sta	KEEN_XL
	bcs	skip_keen_scroll_left

	dec	TILEMAP_X			; scroll left
	dec	KEEN_TILEX

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
	bpl	dwl_noflo

	; adjust tile location
	lda	#1
	sta	KEEN_X

	dec	KEEN_TILEX


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

	sec
	lda	KEEN_TILEY
	sbc	#1
	adc	#>big_tilemap
	sta	INH
	lda	#0
	sta	INL
	ldy	KEEN_TILEX

	bne	collide_head_r

collide_head_l:

	lda	(INL),Y
	; if tile# < ALLHARD_TILES then we are fine
	cmp	#ALLHARD_TILES
	bcc	collide_left_right		; blt

collide_head_r:
	iny
	lda	(INL),Y
	; if tile# < ALLHARD_TILES then we are fine
	cmp	#ALLHARD_TILES
	bcc	collide_left_right		; blt

	; o/~ I hit my head, I heard the phone ring o/~
	; o/~ I was distracted by my friend Joe o/~

	lda	#0
	sta	KEEN_JUMPING		; no longer jumping
	lda	#1
	sta	KEEN_FALLING		; now falling


	ldy	#SFX_BUMPHEADSND
	jsr	play_sfx


collide_left_right:

	;===================
	; collide left/right
	;===================

	clc
	lda	KEEN_TILEY
	adc	#1
	adc	#>big_tilemap
	sta	INH
	lda	KEEN_TILEX
	sta	INL

	lda	KEEN_DIRECTION
	beq	done_keen_collide	; can this happen?

	bmi	check_left_collide

check_right_collide:

	; if KEEN_X=0, collide +1
	; if KEEN_X=1, collide +2

	ldy	#2
	lda	KEEN_X
	beq	right_collide_noextra

;	iny
right_collide_noextra:
	lda	(INL),Y

	; if tile# < ALLHARD_TILES then we are fine
	cmp	#ALLHARD_TILES
	bcc	done_keen_collide		; blt

	lda	#1				;
	sta	SUPPRESS_WALK
	jmp	done_keen_collide

check_left_collide:

	ldy	#0
	lda	(INL),Y

;	lda	KEEN_WALK_TILE_L
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

actually_jumping:

	;===================================================
	; if more than 4 tiles down the screen
	;	if (tilemap_y-keen_tiley)>4 then move keen
	; otherwise, scroll screen, but only if tilemap_y>0

	;=====================
	; check if hit top of screen (shouldn't happen if collision working)

	lda	KEEN_TILEY			;
	cmp	#1			; if hit top of screen, start falling
	bcc	start_falling

	lda	TILEMAP_Y		; if tilemap==0, scroll keen
	cmp	#0			; instead of scrolling screen
	beq	keen_rising

	sec
	lda	TILEMAP_Y
	sbc	KEEN_TILEY

	cmp	#4			; compare to middle of screen
	bcc	scroll_rising		; blt

	; move keen
keen_rising:

	lda	KEEN_Y
	beq	keen_rising_not2
keen_rising2:
	lda	#0
	sta	KEEN_Y
	jmp	done_check_rising

keen_rising_not2:
	dec	KEEN_TILEY
	lda	#2
	sta	KEEN_Y

	jmp	done_check_rising


scroll_rising:
	dec	TILEMAP_Y
	dec	KEEN_TILEY

	jsr	copy_tilemap_subset
	jmp	done_check_rising

done_check_rising:

	dec	KEEN_JUMPING		; slow jump
	bne	done_handle_jumping	; if positive still going up

start_falling:
					; otherwise hit peak, start falling
	lda	#1			; avoid gap before falling triggered
	sta	KEEN_FALLING
	lda	#0
	sta	KEEN_JUMPING

done_handle_jumping:
	rts


	;=========================
	; check_falling
	;=========================
check_falling:

	lda	KEEN_JUMPING
	bne	done_check_falling	; don't check falling if jumping

	;=========================
	; check below feet
	;	if KEEN_X=0 check below and below+1
	;	if KEEN_X=1 check below+1

	clc
	lda	KEEN_TILEY
	adc	#2				; point below feet

	adc	#>big_tilemap
	sta	INH
	lda	#0
	sta	INL

	ldy	KEEN_TILEX

	lda	KEEN_X
	bne	check_below_plus1

check_below:
	lda	(INL),Y
        cmp     #HARDTOP_TILES
        bcs     feet_on_ground			; if hardtop tile, don't fall

check_below_plus1:
	iny
	lda	(INL),Y
        cmp     #HARDTOP_TILES
        bcs     feet_on_ground			; if hardtop tile, don't fall


	;=======================
	; falling
no_ground_were_falling:
	lda	#1
	sta	KEEN_FALLING

	; if y==0, just bump to 2, no need to check
	; if y==2 need to check scrolling

	lda	KEEN_Y
	bne	do_full_falling_check

keeny_was_zero:
	lda	#2
	sta	KEEN_Y
	jmp	done_check_falling

do_full_falling_check:
	;===================================================
	; if ((tilemap_y>max_tile_y) || ((keen_tiley-tilemap_y)<10) keen_fall
	;	else scoll_fall
	; scroll but only if (KEEN_TILEY-TILEMAP_Y)>=10 (YDEFAULT/2)
	;	and TILEMAP_Y < MAX_TILE_Y


	; if (keen_tiley-tilemap_y)<10, keen_fall
	sec
	lda	KEEN_TILEY
	sbc	TILEMAP_Y
	cmp	#8
	bcc	keen_fall	; bge



	; if tilemap_y >= max_tile, keen_fall
	lda	TILEMAP_Y
	cmp	#MAX_TILE_Y
	bcs	keen_fall	; bge


	jmp	scroll_fall	; FIXME, rearrange logic so this falls through

keen_fall:
	; KEEN_Y is known to be 2 here
	; if KEEN_Y==2, KEEN_Y->0, INC KEEN_TILEY


	lda	#0
	sta	KEEN_Y
	inc	KEEN_TILEY
	jmp	done_check_falling


scroll_fall:
	; KEEN_Y is known to be 2 here
	; if KEEN_Y==2, KEEN_Y->0, scroll
	lda	#0
	sta	KEEN_Y
	inc	TILEMAP_Y
	inc	KEEN_TILEY
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

	ldy	#SFX_KEENLANDSND
	jsr	play_sfx

	rts

was_not_falling:

done_check_falling:
	rts



.if 0
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

.endif
