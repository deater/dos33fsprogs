	;=================================
	; Simple HGR box
	;=================================
	; only 1 7-bit block wide
	; (X,A) to (X,A+Y) where X is xcoord/7

hgr_box:
	; don't handle run of 0
	cpy	#0
	beq	done_hgr_box

	; get initial ROW into (GBASL)

	sta	box_row_smc+1	; save current A
	stx	box_x1_smc+1

	ldx	HGR_COLOR		; get colors
	lda	hgr_colortbl,X
	sta	HGR_BITS

	tya
	tax		; put line count into X

hgr_box_loop:

box_row_smc:
	ldy	#$dd	; get row info for Y1 into GBASL/GBASH
	lda	hposn_high,Y
hgr_box_page_smc:
	eor	#$00
	sta	GBASH
	lda	hposn_low,Y
	sta	GBASL

	lda	HGR_BITS
box_x1_smc:
	ldy	#$dd
	sta	(GBASL),Y

	inc	box_row_smc+1

	dex
	bne	hgr_box_loop

done_hgr_box:

	rts


hgr_box_page_toggle:
	lda	hgr_box_page_smc+1
	eor	#$60
	sta	hgr_box_page_smc+1
	rts
