	;=======================
	; animate gary of applicable


flies_check_gary_out:
	; see if gary out
	lda	GAME_STATE_0
	and	#GARY_SCARED
	beq	do_draw_gary_flies
	jmp	no_draw_gary_flies

	;=====================
	; draw the flies
do_draw_gary_flies:
	; flies on 32 frame loop
	; odd = fly1
	; even= fly2
	; 12/14 = tail1
	; 13/15 = tail2

	lda	FRAME
	and	#$3f			; 63 = $3f
	lsr
	cmp	#12
	beq	draw_tail1
	cmp	#13
	beq	draw_tail2
	cmp	#14
	beq	draw_tail1
	cmp	#15
	beq	draw_tail2

	; else normal
	and	#1
	beq	draw_fly1
	bne	draw_fly2

draw_tail1:
	lda	#<gary_tail1_sprite
	sta	INL
	lda	#>gary_tail1_sprite
	jmp	draw_flies

draw_tail2:
	lda	#<gary_tail2_sprite
	sta	INL
	lda	#>gary_tail2_sprite
	jmp	draw_flies

draw_fly2:
	lda	#<gary_fly2_sprite
	sta	INL
	lda	#>gary_fly2_sprite
	jmp	draw_flies

draw_fly1:
	lda	#<gary_fly1_sprite
	sta	INL
	lda	#>gary_fly1_sprite

draw_flies:
	sta	INH

	lda	#7
	sta	CURSOR_X
	lda	#120
	sta	CURSOR_Y

	jsr	hgr_draw_sprite


	;=====================
	; draw the foot
do_draw_gary_foot:
	; foot on 32 frame loop
	; 28/29 = foot1
	; 30/31 = foot2

	lda	FRAME
	and	#$3f			; 63 = $3f
	lsr
	cmp	#28
	beq	draw_foot1
	cmp	#29
	beq	draw_foot2
	cmp	#30
	beq	draw_foot1
	cmp	#31
	beq	draw_foot2

draw_foot0:
	lda	#<gary_foot0_sprite
	sta	INL
	lda	#>gary_foot0_sprite
	jmp	draw_foot

draw_foot1:
	lda	#<gary_foot1_sprite
	sta	INL
	lda	#>gary_foot1_sprite
	jmp	draw_foot

draw_foot2:
	lda	#<gary_foot2_sprite
	sta	INL
	lda	#>gary_foot2_sprite
	jmp	draw_foot

draw_foot:
	sta	INH

	lda	#11
	sta	CURSOR_X
	lda	#136
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

done_draw_foot:


no_draw_gary_flies:

