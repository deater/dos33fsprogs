
	;==================
	; check for items
	;==================
	; X holds tile of head
check_item:


	; sneaky, transparent trigger
check_up_pipe:
	lda	TILEMAP,X
	cmp	#29		; up pipe trigger
	bne	done_check_item

	jsr	pickup_noise

	; move to 760,80 = 680,72 = 170,18
	lda	#18
	sta	DUKE_X
	lda	#20
	sta	DUKE_Y

	lda	#170-8
	sta	TILEMAP_X

	lda	#18-7
	sta	TILEMAP_Y

	jsr	copy_tilemap_subset

done_check_item:
	rts
