	;=========================
	; update bg based on gary

	; FIXME: draw broken fence if necessary
	; FIXME: update fence in collision layer if necessary

gary_update_bg:
	; see if gary out

	lda	GAME_STATE_0
	and	#GARY_SCARED
	beq	no_gary_update_bg	; if 0, means gary is there

make_hole_in_fence:

	;===========================
	; make hole in fence
	;===========================

	; save current draw page

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; means draw to $6000
	sta	DRAW_PAGE

	; draw new fence in background

	lda	#0
	sta	CURSOR_X
	lda	#101
	sta	CURSOR_Y

	lda	#<gary_bg_sprite
	sta	INL
	lda	#>gary_bg_sprite
	sta	INH

	jsr	hgr_draw_sprite

	; restore draw page

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

	;========================================================
	; actually make hole in fence and erase gary collisions
	;========================================================

	; 7B 0b->0e

	; A2 1E->00
	; A3 e0->00
	; A9,AA,AB,AC 18->00

	; C0 07->03

	lda	#$0e
	sta	collision_location+$7B

	lda	#$03
	sta	collision_location+$C0

	lda	#0
	sta	collision_location+$A2
	sta	collision_location+$A3
	sta	collision_location+$A9
	sta	collision_location+$AA
	sta	collision_location+$AB
	sta	collision_location+$AC

	;========================================================
	; remove gary priority
	;========================================================

	; 458,459,45a,45b,45c,45d AA->11
	; 4d8,4d9,4da,4db,4dc AA -> 11
	; 559,55A,55B,55C  AA->11
	; 7b4,7b5 AA->11

	lda	#$11
	sta	priority_location+$58
	sta	priority_location+$59
	sta	priority_location+$5A
	sta	priority_location+$5B
	sta	priority_location+$5C
	sta	priority_location+$5D
	sta	priority_location+$D8
	sta	priority_location+$D9
	sta	priority_location+$DA
	sta	priority_location+$DB
	sta	priority_location+$DC
	sta	priority_location+$159
	sta	priority_location+$15A
	sta	priority_location+$15B
	sta	priority_location+$15C
	sta	priority_location+$3B4
	sta	priority_location+$3B5

no_gary_update_bg:

	rts
