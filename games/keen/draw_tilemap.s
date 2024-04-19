	;================================
	; draw local tilemap to screen
	;================================
	; tilemap is 20x12 grid with 2x4 (well, 2x2) tiles

draw_tilemap:
	ldx	#0		; offset in current tilemap		; 2
	stx	TILEMAP_OFFSET	;					; 3

;	ldy	#0		; current screen Ypos to draw at	; 2
	stx	TILEY		; (we draw two at a time as lores	; 3
				;	is two blocks per byte)



;	lda	#0		; init odd/even				; 2
	stx	TILE_ODD	; (tiles are two rows tall)		; 3

tilemap_outer_loop:
	ldy	TILEY		; setup output pointer to current Ypos	; 3

	lda	gr_offsets,Y	; get address of start of row		; 4+
	sta	GBASL							; 3
	lda	gr_offsets+1,Y						; 4+
	clc								; 2
	adc	DRAW_PAGE	; adjust for page			; 3
	sta	GBASH							; 3


	ldy	#0		; draw row from 0..39			; 2
				; might be faster to count backwards
				; but would have to adjust a lot

tilemap_loop:
	ldx	TILEMAP_OFFSET	; get actual tile number		; 3
	lda	small_tilemap,X	; from tilemap				; 4

	asl		; *4	; point to tile to draw (4 bytes each)	; 2
	asl								; 2
	tax								; 2

	lda	TILE_ODD	; check to see if top or bottom		; 3
	beq	not_odd_line						; 2/3
	inx			; point to bottom half of tile		; 2
	inx								; 2
not_odd_line:

	; draw two blocks
	; note we don't handle transparency in the keen engine

	lda	tiles,X							; 4
	sta	(GBASL),Y	; draw upper right			; 6

	iny								; 2

	lda	tiles+1,X						; 4
	sta	(GBASL),Y		; draw upper left		; 6

	iny								; 2

	inc	TILEMAP_OFFSET		; point to next tile		; 5

	cpy	#40			; until done			; 2
	bne	tilemap_loop						; 2/3



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

	; big tilemap is 128x80
	;	sad, was much cleaner to implement when 256x40

	; TILEMAP_X, TILEMAP_Y specify where in big

TILEMAP_X_COPY_SIZE = 20
TILEMAP_Y_COPY_SIZE = 12

copy_tilemap_subset:

	; TODO: lookup table?
	; would be sorta big


	lda	#0
	sta	tilemap_count_smc+1

	; original worse case: 23 cycles
	; lookup table: 19 cycles

	; set start

	ldx	TILEMAP_Y						; 3
	lda	tilemap_lookup_high,X					; 4
	sta	cptl1_smc+2	; set proper row in big tilemap		; 4
	lda	tilemap_lookup_low,X					; 4
	sta	cptl1_smc+1	; set proper row in big tilemap		; 4


	; set start
;	lda	TILEMAP_Y						; 3
;	lsr								; 2

	; set odd/even
;	ldx	#0							; 2
;	bcc	skip_odd_row						; 2/3
;	ldx	#$80							; 2
;skip_odd_row:
;	stx	cptl1_smc+1						; 4

;	clc			; set start				; 2
;	adc	#>big_tilemap	; each even row is a page, so adding	; 2
				; Y to top byte is indexing to row

;	sta	cptl1_smc+2	; set proper row in big tilemap		; 4



	lda	#<small_tilemap
	sta	cptl2_smc+1		; reset small tilemap to row0

cp_tilemap_outer_loop:

	ldx	TILEMAP_X
	ldy	#0
cp_tilemap_inner_loop:

	; FIXME: make cptl1 take into account X offset and use one index?
	; TODO: optimize, totally unroll?

cptl1_smc:
	lda	$9400,X							; 4
cptl2_smc:
	sta	$BC00,Y							; 5
	iny								; 2
	inx								; 2
	cpy	#TILEMAP_X_COPY_SIZE
	bne	cp_tilemap_inner_loop

	; next line
	clc
	lda	cptl1_smc+1
	adc	#$80
	sta	cptl1_smc+1

	lda	#$0
	adc	cptl1_smc+2
	sta	cptl1_smc+2

	clc
	lda	cptl2_smc+1		; increment row
	adc	#TILEMAP_X_COPY_SIZE
	sta	cptl2_smc+1

	inc	tilemap_count_smc+1
tilemap_count_smc:
	lda	#0
	cmp	#TILEMAP_Y_COPY_SIZE
	bne	cp_tilemap_outer_loop

done_tilemap_subset:

	;==========================
	; activate yorps
	;==========================

	ldx	NUM_ENEMIES
	beq	done_yorps

	clc
	lda	TILEMAP_X
	adc	#22
	sta	INL
activate_yorp_loop:

	; if TILEMAP_X+22>YORP_X

	lda	INL
	cmp	enemy_data_tilex,X
	bcc	next_yorp

	lda	#1
	sta	enemy_data_out,X

next_yorp:
	dex
	bpl	activate_yorp_loop

done_yorps:
	rts
