GBASL	= $26
GBASH	= $27
HGRPAGE = $E6
YPOS	= $FE
COLOR	= $FF

HGR	= $F3E2
HGR2	= $F3D8
HPOSN	= $F411

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

outer_loop:
	lda	#0
	sta	YPOS

color_loop:
	lda	#$22
	inc	COLOR
	lda	YPOS
	jsr	draw_line_color

	inc	YPOS
	lda	YPOS
	cmp	#192
	bne	color_loop

forever:
	jmp	outer_loop


	;=============================
	; draw line of color in COLOR
	;=============================
draw_line_color:
	ldx	#0
	ldy	#0
	jsr	HPOSN

	ldy	#39
loop_it:
	; set page2
	sta	$C055
	jsr	next_pixel

	; set page1
	sta	$C054
	jsr	next_pixel
	dey

	bpl	loop_it

	rts

next_pixel:
	lda	COLOR		; 2
	sta	(GBASL),Y	; 3
	cmp	#$80		; 2
	rol	COLOR		; 2
	rts			; 1
