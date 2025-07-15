
	; new location

	; pick which outer based on items

	; setup X/Y


	lda	#2
	sta	PEASANT_X
	lda	#100
	sta	PEASANT_Y

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD


	; if we have troghelm -> outer3
	; if we have trogshield -> outer2
	; else, outer1

check_troghelm:
	lda	INVENTORY_2
	and	#INV2_TROGHELM
	beq	check_trogshield

	lda	#LOCATION_TROGDOR_OUTER3
	jsr	update_map_location
	jmp	right_location

check_trogshield:
	lda	INVENTORY_2
	and	#INV2_TROGSHIELD
	beq	right_location

	lda	#LOCATION_TROGDOR_OUTER2
	jsr	update_map_location

right_location:



