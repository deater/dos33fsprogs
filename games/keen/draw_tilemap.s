	;================================
	; draw local tilemap to screen
	;================================
	; tilemap is 20x12 grid with 2x4 (well, 2x2) tiles

draw_tilemap:
	ldy	#0			; current screen Ypos to draw at
	sty	TILEY			; (we draw two at a time as lores
					;	is two blocks per byte)

	ldx	#0			; offset in current tilemap
	stx	TILEMAP_OFFSET		;

	lda	#0			; init odd/even
	sta	TILE_ODD		; (tiles are two rows tall)

tilemap_outer_loop:
	ldy	TILEY			; setup output pointer to current Ypos

	lda	gr_offsets,Y		; get address of start of row
	sta	GBASL
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE		; adjust for page
	sta	GBASH


	ldy	#0			; draw row from 0..39
					; might be faster to count backwards
					; but would have to adjust a lot

tilemap_loop:
	ldx	TILEMAP_OFFSET		; get actual tile number
	lda	tilemap,X		; from tilemap

	asl			; *4	; point to tile to draw (4 bytes each)
	asl
	tax

	lda	TILE_ODD		; check to see if top or bottom
	beq	not_odd_line
	inx				; point to bottom half of tile
	inx
not_odd_line:

	; draw two blocks
	; note we don't handle transparency in the keen engine

	lda	tiles,X
	sta	(GBASL),Y		; draw upper right

	iny

	lda	tiles+1,X
	sta	(GBASL),Y		; draw upper left

	iny

	inc	TILEMAP_OFFSET		; point to next tile

	cpy	#40			; until done
	bne	tilemap_loop



	; row is done, move to next line
	lda	TILE_ODD		; toggle odd/even
	eor	#$1			; (should we just add/mask?)
	sta	TILE_ODD
	beq	move_to_even_line

	; move ahead to next row

	; for even line we're already pointing to next
;move_to_even_line:
;	lda	TILEMAP_OFFSET
;	clc
;	adc	#0
;	jmp	done_move_to_line

	; reset back to beginning of line to display it again
move_to_odd_line:
	lda	TILEMAP_OFFSET
	sec
	sbc	#TILE_COLS		; subtract off length of row
	sta	TILEMAP_OFFSET

move_to_even_line:			; no need, already points to
					; right place

done_move_to_line:


	ldy	TILEY				; move to next output line
	iny					; each row is two lines
	iny
	sty	TILEY

	cpy	#48				; check if at end
	bne	tilemap_outer_loop

	rts


	;===================================
	; copy tilemap
	;===================================
	; local tilemap subset is 20x12 tiles = 240 bytes
	;	nicely fits in one page
	;
	; big tilemap is 256*40
	;	so each row is a page

	; TILEMAP_X, TILEMAP_Y specify where in big

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
