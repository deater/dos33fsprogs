
	; Autogenerates code that does interleaved Page0/Page1 lores mode
	; but leaving room for 14 pixels/line of per-scanline color

	; originally 183,589
	; takes roughly 12 + 192*((49*16)+2+38)	+ 15 = 158,235!!!!
	; want to play sound every 15787 cycles (10.0)

	; so every 19.2 times through loop?  is 16 close enough?

	; 11 times should update???

UPDATE_START = $9800

DEFAULT_COLOR	= $0

create_update_type1:
	ldx	#192						; 2
	lda	#<UPDATE_START					; 2
	sta	OUTL						; 3
	lda	#>UPDATE_START					; 2
	sta	OUTH						; 3
							;===========
							;        12
create_update_outer_loop:
	ldy	#48						; 2

create_update_inner_loop:
	lda	one_scanline,Y					; 4+
	sta	(OUTL),Y					; 6
	dey							; 2
	bpl	create_update_inner_loop			; 3
							;============
							;        16

								; -1
	; toggle PAGE0/PAGE1
	txa							; 2
	and	#$1	; ror?					; 2
	clc							; 2
	adc	#$54						; 2
	ldy	#1						; 2
	sta	(OUTL),Y					; 6

	clc							; 2
	lda	#49						; 2
	adc	OUTL						; 3
	sta	OUTL						; 3
	lda	OUTH						; 3
	adc	#0						; 2
	sta	OUTH						; 3

	dex							; 2
	bne	create_update_outer_loop			; 3
							;===========
							;	38

								; -1
	ldy	#0						; 2
	lda	#$60						; 2
	sta	(OUTL),Y					; 6

	rts							; 6
							;=============
							;         15

BARS_START = 46

	;===========================
	; from 40 to 168?
setup_rasterbars:

	lda	#4		; which page
	sta	RASTER_PAGE

	ldx	#BARS_START
	lda	#<(UPDATE_START+(BARS_START*49))
	sta	OUTL
	lda	#>(UPDATE_START+(BARS_START*49))
	sta	OUTH
setup_rasterbars_outer_loop:
	ldy	#6
	lda	#13
	sta	RASTER_X
setup_rasterbars_inner_loop:
	txa
	pha
	inx
	txa				; start one earlier
	lsr
	lsr
	and	#$fe
	tax
	clc
	lda	gr_offsets,X
	adc	RASTER_X
	inc	RASTER_X
	sta	(OUTL),Y
	iny
	clc
	lda	gr_offsets+1,X
	adc	RASTER_PAGE
	sta	(OUTL),Y
	iny
	iny
	pla
	tax

	cpy	#48
	bne	setup_rasterbars_inner_loop

	clc
	lda	#49
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH


	lda	RASTER_PAGE
	eor	#$04
	sta	RASTER_PAGE

	inx
	cpx	#184
	bne	setup_rasterbars_outer_loop

	rts

one_scanline:
.byte	$2C,$54,$C0	; bit	PAGE0	; 4
.byte	$A9,DEFAULT_COLOR		; lda	#$0b	; 2
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$A5,$FA		; lda	TEMP    ; 3

