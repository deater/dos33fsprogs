
	;==================
	; check for items
	;==================
	; X holds ??
check_item:


check_red_key:
	lda	TILEMAP,X
	cmp	#31		; red key
	bne	check_blue_key

	jsr	pickup_noise
	lda	INVENTORY
	ora	#INV_RED_KEY
	sta	INVENTORY

	; erase red key (304,96)
	lda	#0
	sta	$A938	; hack

	jsr	copy_tilemap_subset

	jsr	update_status_bar

	jmp	done_check_item

check_blue_key:
	cmp	#30		; blue key
	bne	done_check_item

	jsr	pickup_noise
	lda	INVENTORY
	ora	#INV_BLUE_KEY
	sta	INVENTORY

	; erase blue key
	lda	#0
	sta	$970c	; hack

	jsr	copy_tilemap_subset

	jsr	update_status_bar

	jmp	duke_check_head

done_check_item:
	rts
