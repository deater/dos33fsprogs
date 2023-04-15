GBASL = $26
GBASH = $27
HGRPAGE = $E6
COLOR = $ff

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

	lda	#$20
	sta	HGRPAGE

	lda	#$0
	sta	COLOR
	lda	#100
	jsr	draw_line_color

	lda	#$4
	sta	COLOR
	lda	#99
	jsr	draw_line_color

	lda	#$4
	sta	COLOR
	lda	#101
	jsr	draw_line_color

	lda	#$8
	sta	COLOR
	lda	#98
	jsr	draw_line_color

	lda	#$8
	sta	COLOR
	lda	#102
	jsr	draw_line_color



forever:
	jmp	forever


	;=========================
	; draw line of color in COLOR
	; at location A
	;=========================
draw_line_color:
	ldx	#0
	ldy	#0
	jsr	HPOSN

	; set page2
	sta	$C055

	; page2 first
	ldx	COLOR
	lda	color_table,X

	ldy	#0
aux_part1_loop:
	sta	(GBASL),Y
	iny
	iny
	cpy	#40
	bcc	aux_part1_loop

	; page2 first
	ldx	COLOR
	lda	color_table+1,X

	ldy	#1
aux_part2_loop:
	sta	(GBASL),Y
	iny
	iny
	cpy	#40
	bcc	aux_part2_loop

	; set page1
	sta	$C054

	; page1 next
	ldx	COLOR
	lda	color_table+2,X

	ldy	#0
main_part1_loop:
	sta	(GBASL),Y
	iny
	iny
	cpy	#40
	bcc	main_part1_loop

	; page1 next
	ldx	COLOR
	lda	color_table+3,X

	ldy	#1
main_part2_loop:
	sta	(GBASL),Y
	iny
	iny
	cpy	#40
	bcc	main_part2_loop

	rts

color_table:
	.byte $FF,$FF,$FF,$FF		; white
	.byte $3B,$6E,$77,$5D		; 0xB = light blue
	.byte $33,$4C,$66,$19		; 0x3 = medium blue

