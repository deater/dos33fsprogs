

draw_tilemap:
	ldy	#0			; Y on screen currently drawing
	sty	tiley			; we draw two at a time

	ldx	#1			; offset in current screen
	stx	tilemap_offset		; tilemap

	lda	#0			; init odd/even
	sta	tile_odd

tilemap_outer_loop:
	ldy	tiley			; setup pointer to current Y
	lda	gr_offsets,Y
	sta	GBASL
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	#6			; we draw in window 6->34
tilemap_loop:
	ldx	tilemap_offset		; get actual tile
	lda	tilemap,X

	asl			; *4	; get offset in tile
	asl
	tax

	lda	tile_odd
	beq	not_odd_line
	inx
	inx
not_odd_line:

	lda	tiles,X			; draw two tiles
	cmp	#$AA			; transparency
	beq	skip_tile1
	sta	(GBASL),Y
skip_tile1:

	iny
	lda	tiles+1,X
	cmp	#$AA
	beq	skip_tile2
	sta	(GBASL),Y
skip_tile2:
	iny

	inc	tilemap_offset

	cpy	#34			; until done
	bne	tilemap_loop

	; move to next line
	lda	tile_odd		; toggle odd/even
	eor	#$1			; (should we just add/mask?)
	sta	tile_odd
	bne	move_to_odd_line

move_to_even_line:
	lda	tilemap_offset
	clc
	adc	#2
	jmp	done_move_to_line

move_to_odd_line:
	lda	tilemap_offset
	sec
	sbc	#14

done_move_to_line:
	sta	tilemap_offset

	ldy	tiley				; move to next line
	iny
	iny
	sty	tiley

	cpy	#40				; check if at end
	bne	tilemap_outer_loop

	rts

tilemap_offset:	.byte $00
tile_odd:	.byte $00
tiley:		.byte $00
