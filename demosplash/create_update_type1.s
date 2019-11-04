
	; Autogenerates code that does interleaved Page0/Page1 lores mode
	; but leaving room for 14 pixels/line of per-scanline color

UPDATE_START = $9000

DEFAULT_COLOR	= $0

create_update_type1:
	ldx	#192
	lda	#<UPDATE_START
	sta	OUTL
	lda	#>UPDATE_START
	sta	OUTH
	lda	#<one_scanline
	sta	INL
	lda	#>one_scanline
	sta	INH
create_update_outer_loop:
	ldy	#0
create_update_inner_loop:
	lda	(INL),Y
	sta	(OUTL),Y
	iny
	cpy	#49
	bne	create_update_inner_loop

	; toggle PAGE0/PAGE1
	txa
	and	#$1	; ror?
	clc
	adc	#$54
	ldy	#1
	sta	(OUTL),Y

	clc
	lda	#49
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

	dex
	bne	create_update_outer_loop

	ldy	#0
	lda	#$60
	sta	(OUTL),Y

	rts

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

