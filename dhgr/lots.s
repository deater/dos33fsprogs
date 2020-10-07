GBASL = $26
GBASH = $27
HGRPAGE = $E6
YPOS	= $FE
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

	lda	#$20
	sta	HGRPAGE

	lda	#0
	sta	YPOS
color_loop:
	lda	YPOS
	and	#$f
	sta	COLOR
	asl
	asl
	asl
	asl
	ora	COLOR
	sta	COLOR
	lda	YPOS
	jsr	draw_line_color

	inc	YPOS
	lda	YPOS
	cmp	#192
	bne	color_loop

forever:
	jmp	forever


	;=========================
	; draw line of color in COLOR
	;=========================
draw_line_color:
	ldx	#0
	ldy	#0
	jsr	HPOSN

	ldy	#0
loop_it:
	; set page2
	sta	$C055
	lda	COLOR
	sta	(GBASL),Y
	cmp	#$80
	rol	COLOR

	; set page1
	sta	$C054
	lda	COLOR
	sta	(GBASL),Y
	cmp	#$80
	rol	COLOR
	iny

	cpy	#40
	bne	loop_it

	rts
