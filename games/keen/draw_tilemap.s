	;================================
	; draw local tilemap to screen
	;================================
	; tilemap is 20x12 grid with 2x4 (well, 2x2) tiles

draw_tilemap:
	ldy	#0			; current screen Ypos to draw at
	sty	tiley			; (we draw two at a time as lores
					;	is two blocks per byte)

	ldx	#1			; offset in current screen
					; FIXME: why is this 1?

	stx	tilemap_offset		; tilemap

	lda	#0			; init odd/even
	sta	tile_odd		; (tiles are two rows tall)

tilemap_outer_loop:
	ldy	tiley			; setup output pointer to current Ypos

	lda	gr_offsets,Y		; get address of start of row
	sta	GBASL
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE		; adjust for page
	sta	GBASH


	ldy	#0			; draw row from 0..40

;	ldy	#6			; we draw in window 6->34

tilemap_loop:
	ldx	tilemap_offset		; get actual tile number
	lda	tilemap,X		; from tilemap

	asl			; *4	; point to tile to draw (4 bytes each)
	asl
	tax

	lda	tile_odd		;
	beq	not_odd_line
	inx
	inx
not_odd_line:

	lda	tiles,X			; draw two tiles

;	cmp	#$AA			; transparency
;	beq	skip_tile1

	sta	(GBASL),Y		; draw upper right

;skip_tile1:

	iny
	lda	tiles+1,X
;	cmp	#$AA			; transparency
;	beq	skip_tile2
	sta	(GBASL),Y		; draw upper left
;skip_tile2:
	iny

	inc	tilemap_offset

	cpy	#40			; until done
;	cpy	#34			; until done
	bne	tilemap_loop


	; row is done, move to next line
	lda	tile_odd		; toggle odd/even
	eor	#$1			; (should we just add/mask?)
	sta	tile_odd
	bne	move_to_odd_line

	; move ahead to next row
move_to_even_line:
	lda	tilemap_offset
	clc
	adc	#0
	jmp	done_move_to_line

	; reset back to beginning of line to display it again
move_to_odd_line:
	lda	tilemap_offset
	sec
;	sbc	#14
	sbc	#20			; ?

done_move_to_line:
	sta	tilemap_offset

	ldy	tiley				; move to next output line
	iny
	iny
	sty	tiley

	cpy	#48				; check if at end
;	cpy	#40				; check if at end
	bne	tilemap_outer_loop

	rts

	; these should probably be in the zero page
tilemap_offset:	.byte $00
tile_odd:	.byte $00
tiley:		.byte $00


	;===================================
	; copy tilemap
	;===================================
	; want to copy a 16x10 area from global tileset to local

	; originally 16x10				16x10 = 160 bytes
	;	extend to 20x12 for full screen?	20x12 = 240 bytes

	; big tilemap is 256*40
	;	so each row is a page

	; TILEMAP_X, TILEMAP_Y specify where in big

	; copy to tilemap

TILEMAP_X_COPY_SIZE = 20
TILEMAP_Y_COPY_SIZE = 12

copy_tilemap_subset:

	; set start
	lda	TILEMAP_Y
	clc				; set start
	adc	#>big_tilemap		; each row is a page, so adding
					; Y to top byte is indexing to row

	sta	cptl1_smc+2		; set proper row in big tilemap
	adc	#TILEMAP_Y_COPY_SIZE
	sta	cptl3_smc+1		; set loop limit (end)

	; reset row
	lda	#<tilemap
	sta	cptl2_smc+1		; set small tilemap to row0

cp_tilemap_outer_loop:

	ldx	TILEMAP_X
	ldy	#0
cp_tilemap_inner_loop:

cptl1_smc:
	lda	$9400,X
cptl2_smc:
	sta	$BC00,Y
	iny
	inx
	cpy	#TILEMAP_X_COPY_SIZE
	bne	cp_tilemap_inner_loop

	; next line
	inc	cptl1_smc+2		; incremement page
	clc
	lda	cptl2_smc+1		; increment row
	adc	#TILEMAP_X_COPY_SIZE
	sta	cptl2_smc+1

	lda	cptl1_smc+2
cptl3_smc:
	cmp	#TILEMAP_Y_COPY_SIZE
	bne	cp_tilemap_outer_loop

	rts
