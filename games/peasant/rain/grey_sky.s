BACKGROUND_LOCATION = $6000

MAX_GREY_LINE = 30

	;=====================
	; make the sky grey
	;	make $FF/$7F to be black/white pattern?

	;	$55/$2A = purple?	need $55 to be in even column?
	;	$D5/$aa = blue

grey_sky:
	lda	RAIN_COUNT		; see if raining
	cmp	#2
	bcs	do_grey_sky		; bge (we decrement later
					; so 1 means end, not 0)
	rts

do_grey_sky:

	ldx	MAP_LOCATION

	lda	sky_rows,X		; set max row
	sta	max_grey_smc+1

	lda	sky_color,X
	bne	do_grey_sky_blue
do_grey_sky_purple:
	lda	#$55
	sta	color_smc1+1
	lda	#$2a
	sta	color_smc2+1
	bne	do_grey			; bra

do_grey_sky_blue:

	lda	#$d5
	sta	color_smc1+1
	lda	#$aa
	sta	color_smc2+1


do_grey:
	ldx	#0			; init row count

grey_outer:
	lda	hposn_low,X		; get row address
	sta	GBASL
	lda	hposn_high,X
	clc
	adc	#>(BACKGROUND_LOCATION-$2000)	; update for bg location
	sta	GBASH

	ldy	#0			; column counter
grey_loop:

	tya				; do $55/$2a based if odd or even
	lsr
color_smc1:
	lda	#$55
	bcc	skip_col
color_smc2:
	lda	#$2a
skip_col:

	cmp	(GBASL),Y		; see if match color
	bne	grey_continue

	; make it checkered by alternating row/column
grey_swap:
	tya				; put column in A, save for later
	pha
	and	#$3			; mask bottom two bits?
	tay
	txa
	and	#$1			; get row, see if odd event
	bne	grey_row_odd

grey_row_even:
	iny				; skip 14 pixels
	iny
	tya
	and	#$3
	tay

grey_row_odd:

	lda	grey_lookup,Y
	sta	TEMP
	pla
	tay

	lda	(GBASL),Y
	eor	TEMP			; 0 011 0011	$33
					; 0 110 0110	$66
					; 0 100 1100	$4C
					; 0 001 1001	$19
	sta	(GBASL),Y
grey_continue:
	iny
	cpy	#40
	bne	grey_loop

	inx
max_grey_smc:
	cpx	#MAX_GREY_LINE
	bne	grey_outer

	rts



grey_lookup:
	.byte $33,$66,$4C,$19


; Sky Color (blue/purple)
; purple=0, blue=1
sky_color:
.byte	0	; LOCATION_POOR_GARY	=	0
.byte	0	; LOCATION_KERREK_1	=	1
.byte	0	; LOCATION_OLD_WELL	=	2
.byte	0	; LOCATION_YELLOW_TREE	=	3
.byte	0	; LOCATION_WATERFALL	=	4
.byte	0	; LOCATION_HAY_BALE	=	5
.byte	1	; LOCATION_MUD_PUDDLE	=	6
.byte	0	; LOCATION_ARCHERY	=	7
.byte	0	; LOCATION_RIVER_STONE	=	8
.byte	0	; LOCATION_MOUNTAIN_PASS	=	9
.byte	0	; LOCATION_JHONKA_CAVE	=	10
.byte	0	; LOCATION_YOUR_COTTAGE	=	11
.byte	0	; LOCATION_LAKE_WEST	=	12
.byte	0	; LOCATION_LAKE_EAST	=	13
.byte	1	; LOCATION_OUTSIDE_INN	=	14
.byte	0	; LOCATION_OUTSIDE_NN	=	15
.byte	0	; LOCATION_WAVY_TREE	=	16
.byte	0	; LOCATION_KERREK_2	=	17
.byte	0	; LOCATION_OUTSIDE_LADY	=	18
.byte	0	; LOCATION_BURN_TREES	=	19

.byte	0	; LOCATION_CLIFF_BASE	=	20
.byte	0	; LOCATION_CLIFF_HEIGHTS	=	21
.byte	0	; LOCATION_TROGDOR_OUTER	=	22
.byte	0	; LOCATION_TROGDOR_LAIR	=	23
.byte	0	; LOCATION_HIDDEN_GLEN	=	24
.byte	0	; LOCATION_INSIDE_LADY	=	25
.byte	0	; LOCATION_INSIDE_NN	=	26
.byte	0	; LOCATION_INSIDE_INN	=	27
.byte	0	; LOCATION_ARCHERY_GAME	=	28
.byte	0	; LOCATION_MAP		=	29
.byte	0	; LOCATION_CLIMB		=	30
.byte	0	; LOCATION_TROGDOR_OUTER2	=	31
.byte	0	; LOCATION_TROGDOR_OUTER3	=	32
.byte	0	; LOCATION_INSIDE_INN_NIGHT=	33
.byte	0	; LOCATION_KERREK_FALL	=	34

; Sky Rows
sky_rows:
.byte	41	; LOCATION_POOR_GARY	=	0
.byte	30	; LOCATION_KERREK_1	=	1
.byte	30	; LOCATION_OLD_WELL	=	2
.byte	35	; LOCATION_YELLOW_TREE	=	3
.byte	34	; LOCATION_WATERFALL	=	4
.byte	52	; LOCATION_HAY_BALE	=	5
.byte	54	; LOCATION_MUD_PUDDLE	=	6
.byte	35	; LOCATION_ARCHERY	=	7
.byte	52	; LOCATION_RIVER_STONE	=	8
.byte	50	; LOCATION_MOUNTAIN_PASS	=	9
.byte	32	; LOCATION_JHONKA_CAVE	=	10
.byte	32	; LOCATION_YOUR_COTTAGE	=	11
.byte	36	; LOCATION_LAKE_WEST	=	12
.byte	41	; LOCATION_LAKE_EAST	=	13
.byte	40	; LOCATION_OUTSIDE_INN	=	14
.byte	26	; LOCATION_OUTSIDE_NN	=	15
.byte	50	; LOCATION_WAVY_TREE	=	16
.byte	28	; LOCATION_KERREK_2	=	17
.byte	48	; LOCATION_OUTSIDE_LADY	=	18
.byte	32	; LOCATION_BURN_TREES	=	19
.byte	10	; LOCATION_CLIFF_BASE	=	20
.byte	10	; LOCATION_CLIFF_HEIGHTS	=	21
.byte	10	; LOCATION_TROGDOR_OUTER	=	22
.byte	10	; LOCATION_TROGDOR_LAIR	=	23
.byte	48	; LOCATION_HIDDEN_GLEN	=	24
.byte	10	; LOCATION_INSIDE_LADY	=	25
.byte	10	; LOCATION_INSIDE_NN	=	26
.byte	10	; LOCATION_INSIDE_INN	=	27
.byte	10	; LOCATION_ARCHERY_GAME	=	28
.byte	10	; LOCATION_MAP		=	29
.byte	10	; LOCATION_CLIMB		=	30
.byte	10	; LOCATION_TROGDOR_OUTER2	=	31
.byte	10	; LOCATION_TROGDOR_OUTER3	=	32
.byte	10	; LOCATION_INSIDE_INN_NIGHT=	33
.byte	10	; LOCATION_KERREK_FALL	=	34

