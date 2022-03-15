	;=================================
	; Simple Vertical LINE
	;=================================
	; line from (x,a) to (x,a+y)
	; todo: use Carry to say if X>255

hgr_vlin:
	; don't handle run of 0
	cpy	#0
	beq	done_hgr_vlin

	; get initial ROW into (GBASL)

	sta	current_row_smc+1	; save current A
;	sty	vlin_row_count

	lda	div7_table,X		; X is X1
	sta	x1_save_smc+1

	txa	; save X		; X is still X1
	pha

	ldx	HGR_COLOR
	lda	hgr_colortbl,X
	sta	HGR_BITS

	and	#$1			; only shift if in odd column?
	beq	vlin_no_shift_colors
	jsr	shift_colors
vlin_no_shift_colors:

	pla
	tax				; restore X is X1

	lda	mod7_table,X
	tax
	lda	vlin_masks,X		; get mask
	sta	vlin_mask_smc+1

	tya
	tax		; put line count into X

hgr_vlin_loop:

current_row_smc:
	ldy	#$dd	; get row info for Y1 into GBASL/GBASH
	lda	hposn_high,Y
	sta	GBASH
	lda	hposn_low,Y
	sta	GBASL

x1_save_smc:
	ldy	#$dd		; X1/7
	lda	(GBASL),Y
	eor	HGR_BITS
vlin_mask_smc:
	and	#$dd
	eor	(GBASL),Y
	sta	(GBASL),Y

	inc	current_row_smc+1
;	dec	vlin_row_count

	dex
	bne	hgr_vlin_loop

done_hgr_vlin:

	rts

;vlin_row_count:	.byte $00


vlin_masks:
	.byte $81,$82,$84,$88,$90,$A0,$C0


