
	;==================
	; check for items
	;==================
	; A holds tile value to check

check_item:

	cmp	#27
	bcc	done_check_item		; not an item
	cmp	#32
	bcs	done_check_item		; not an item

	sec
	sbc	#27			; subtract off to get index

	; 0 = laser gun
	; 1 = lollipop			100 pts
	; 2 = book			1000 pts
	; 3 = pizza			500 pts
	; 4 = carbonated beverage	200 pts
	; ? = bear			5000 pts

	beq	get_laser_gun

	; otherwise look up points and add it

	tay
	lda	score_lookup,Y
	jsr	inc_score
	jmp	done_item_pickup

get_laser_gun:
	lda	RAYGUNS
	clc
	sed
	adc	#$05
	sta	RAYGUNS
	cld

	jmp	done_item_pickup

	; keycards go here too...
get_keycard:

done_item_pickup:

	; erase

	; FIXME: only erases small tilemap
	;	also need to update big

	lda	#1			; plain tile
	sta	tilemap,X

	; big tilemap:
	;	tilemap

	lda	KEEN_Y			; divide by 4 as tile 4 blocks tall
	lsr
	lsr

	clc
	adc	TILEMAP_Y		; add in tilemap Y (each row 256 bytes)
	adc	#>big_tilemap		; add in offset of start
	sta	btc_smc+2

	lda	TILEMAP_X		; add in X offset of tilemap
	sta	btc_smc+1

	lda	KEEN_X
	lsr
	tay
	iny				; why add 1????

	lda	#0			; background tile
btc_smc:
	sta	$b000,Y

	; play sound
	jsr	pickup_noise

.if 0
check_red_key:
	lda	tilemap,X
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

	jmp	keen_check_head
.endif
done_check_item:
	rts


score_lookup:
	.byte $00,$01,$10,$05,$02,$50		; BCD
	; 0 = laser gun
	; 1 = lollipop			100 pts
	; 2 = book			1000 pts
	; 3 = pizza			500 pts
	; 4 = carbonated beverage	200 pts
	; ? = bear			5000 pts
