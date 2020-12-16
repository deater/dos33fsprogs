
	; someone pressed UP

up_action:

	; check if it's a key slot
check_red_keyhole:

	; check that we have the key
	lda	INVENTORY
	and	#INV_RED_KEY
	beq	done_up_action

	; open the red wall
	; there has to be a more efficient way of doing this

	; reset smc
	lda	#>BIG_TILEMAP
	sta	rwr_smc1+2
	sta	rwr_smc2+2

remove_red_wall_outer:
	ldx	#0
remove_red_wall_loop:
rwr_smc1:
	lda	BIG_TILEMAP,X
	cmp	#49			; red key tile
	bne	not_red_tile
	lda	#2			; lblue bg tile
rwr_smc2:
	sta	BIG_TILEMAP,X
not_red_tile:
	inx
	bne	remove_red_wall_loop

	inc	rwr_smc1+2
	inc	rwr_smc2+2

	lda	rwr_smc1+2
	cmp	#(>BIG_TILEMAP)+40
	bne	remove_red_wall_outer

	; refresh local tilemap

	jsr	copy_tilemap_subset


	; check if it's the exit
check_if_exit:


done_up_action:

	rts
