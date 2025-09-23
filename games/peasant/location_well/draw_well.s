	;===================
	; draw well
	;===================

draw_well:

	; draw bucket

	ldx	BUCKET_STATE

	lda	#8		; 56/7=8
	sta	SPRITE_X

	lda	#88
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_mask

draw_crank:

	; draw crank

	lda	CRANK_STATE
	clc
	adc	#8
	tax

	lda	#13		; 92/7=13
	sta	SPRITE_X

	lda	#93
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_mask

	rts



	;===================
	; lower bucket
	;===================

lower_bucket:
	lda	#$0
	sta	BUCKET_COUNT

lower_bucket_loop:
	ldy	BUCKET_COUNT
	ldx	lower_bucket_animation,Y
	stx	BUCKET_STATE

	ldx	lower_crank_animation,Y
	stx	CRANK_STATE

	jsr	update_screen

	jsr	hgr_page_flip

	inc	BUCKET_COUNT
	lda	BUCKET_COUNT
	cmp	#11
	bne	lower_bucket_loop

done_lower_bucket:

	rts


	;===================
	; raise bucket
	;===================

raise_bucket:
	lda	#$0
	sta	BUCKET_COUNT

raise_bucket_loop:
	ldy	BUCKET_COUNT
	ldx	raise_bucket_animation,Y
	stx	BUCKET_STATE

	ldx	raise_crank_animation,Y
	stx	CRANK_STATE

	jsr	update_screen

	jsr	hgr_page_flip

	inc	BUCKET_COUNT
	lda	BUCKET_COUNT
	cmp	#10
	bne	raise_bucket_loop

done_raise_bucket:

	rts


	;===================
	; raise bucket mask
	;===================

raise_bucket_mask:
	lda	#$0
	sta	BUCKET_COUNT

raise_bucket_mask_loop:
	ldy	BUCKET_COUNT
	ldx	raise_mask_bucket_animation,Y
	stx	BUCKET_STATE

	ldx	raise_mask_crank_animation,Y
	stx	CRANK_STATE

	jsr	update_screen

	jsr	hgr_page_flip

	inc	BUCKET_COUNT
	lda	BUCKET_COUNT
	cmp	#15
	bne	raise_bucket_mask_loop

done_raise_bucket_mask:

	lda	#0
	sta	BUCKET_STATE
	sta	CRANK_STATE

	rts


	;===================
	; lower bucket baby
	;===================
	; TODO

lower_bucket_baby:

	lda	#3
	sta	BUCKET_STATE

	rts

	;===================
	; raise bucket baby
	;===================
	; TODO

raise_bucket_baby:

	lda	#0
	sta	BUCKET_STATE

	rts


lower_bucket_animation:
	.byte	0,0,0	; up
	.byte	1,1	; part down
	.byte	2,2	; more down
	.byte	3,3,3,3	; all down
lower_crank_animation:
	.byte	0,1,2	; up, level, down
	.byte	1,0	; level, up
	.byte	1,2	; level, down
	.byte	1,1,2,1	; level (slightly lower?), down, level

raise_bucket_animation:
	.byte	3,3,3,3	; all down
	.byte	2,2
	.byte	1,1
	.byte	0,0

raise_crank_animation:
	.byte	1,1,1,1	; level (slightly lower?), level, level
	.byte	0,1	; up,level
	.byte	2,1	; down,level
	.byte	1,0	; level, up

raise_mask_bucket_animation:
	.byte	3,3,3,3	; all down
	.byte	4,4	; part down mask
	.byte	5,5	; mid down mask
	.byte	6,6	; near top mask
	.byte	7,7,7,7,7	; top

raise_mask_crank_animation:
	.byte	1,1,1,1	; level (slightly lower?), level, level
	.byte	0,0	; up
	.byte	1,1	; level
	.byte	2,2	; down
	.byte	1,0,1,2,1	; level,up,level,down,level

sprites_xsize:
	.byte	5, 5, 5, 5	; bucket0,bucket1,bucket2,bucket3
	.byte	5, 5, 5, 5	; mask0,mask1,mask2,mask3
	.byte	2, 2, 2		; crank0,crank1,crank2

sprites_ysize:
	.byte	20, 20, 20, 20	; bucket0,bucket1,bucket2,bucket3
	.byte	20, 20, 20, 20	; mask0,mask1,mask2,mask3
	.byte	12, 12, 12	; crank0,crank1,crank2

sprites_data_l:
	.byte <bucket0_sprite,<bucket1_sprite,<bucket2_sprite,<bucket3_sprite
	.byte <mask0_sprite,<mask1_sprite,<mask2_sprite,<mask3_sprite
	.byte <crank0_sprite,<crank1_sprite,<crank2_sprite

sprites_data_h:
	.byte >bucket0_sprite,>bucket1_sprite,>bucket2_sprite,>bucket3_sprite
	.byte >mask0_sprite,>mask1_sprite,>mask2_sprite,>mask3_sprite
	.byte >crank0_sprite,>crank1_sprite,>crank2_sprite

sprites_mask_l:
	.byte <bucket0_mask,<bucket1_mask,<bucket2_mask,<bucket3_mask
	.byte <mask0_mask,<mask1_mask,<mask2_mask,<mask3_mask
	.byte <crank0_mask,<crank1_mask,<crank2_mask

sprites_mask_h:
	.byte >bucket0_mask,>bucket1_mask,>bucket2_mask,>bucket3_mask
	.byte >mask0_mask,>mask1_mask,>mask2_mask,>mask3_mask
	.byte >crank0_mask,>crank1_mask,>crank2_mask
