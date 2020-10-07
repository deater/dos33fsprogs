GBASL = $26
GBASH = $27
HGRPAGE = $E6
YPOS	= $FD
LINE	= $FE
COLOR	= $FF

HGR = $F3E2
HGR2 = $F3D8
HPOSN = $F411

raster:
	jsr	HGR
	jsr	HGR2
;	sta	$C050		; set graphics
;	sta	$C057		; set hires
;	sta	$C052		; set fullscreen
	sta	$C05E		; set double hires
	sta	$C00D		; 80 column
	sta	$C001		; 80 store

	sta	$C055		; set page2

	lda	#$20
	sta	HGRPAGE

bit_rain:
	; blue

	lda	#$0
	sta	COLOR
bit_rain_smc:
	lda	#100
	sta	YPOS
	jsr	draw_raster_bit

	; red

	lda	#$8
	sta	COLOR
bit_rain2_smc:
	lda	#50
	sta	YPOS
	jsr	draw_raster_bit


	lda	bit_rain_smc+1
	clc
	adc	#1
	and	#$7f
	sta	bit_rain_smc+1

	lda	bit_rain2_smc+1
	clc
	adc	#1
	and	#$7f
	sta	bit_rain2_smc+1

	jmp	bit_rain


	;=========================
	; draw line of color in COLOR
	;=========================
draw_raster_bit:

	ldx	#0
	stx	LINE

draw_raster_bit_loop:

	ldx	#0
	ldy	#0
	lda	YPOS
	jsr	HPOSN

	clc
	lda	LINE
	adc	COLOR
	tax
	lda	color_table,X

	ldy	#0
inside_loop:
	sta	(GBASL),Y
	iny
	iny
	cpy	#40
	bne	inside_loop

	inc	YPOS

	inc	LINE
	ldx	LINE
	cpx	#9
	bne	draw_raster_bit_loop

	rts

color_table:
	.byte $0
	.byte $1,$3,$B,$F,$B,$3,$1,$0
	.byte $8,$9,$D,$F,$D,$9,$8,$0

