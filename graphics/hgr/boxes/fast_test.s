; VGI Rectangle test

HGR_BITS	= $1C

GBASL	= $26
GBASH	= $27


XRUN	= $74
COUNT	= $75

HGR_COLOR = $E4

P0	= $F0
P1	= $F1
P2	= $F2
P3	= $F3
P4	= $F4
P5	= $F5

HGR2            = $F3D8         ; clear PAGE2 to 0
BKGND0          = $F3F4         ; clear current page to A
HPOSN           = $F411         ; (Y,X),(A)  (values stores in HGRX,XH,Y)
HPLOT0          = $F457         ; plot at (Y,X), (A)
COLOR_SHIFT	= $F47E
HLINRL          = $F530         ; (X,A),(Y)
HGLIN           = $F53A         ; line to (A,X),(Y)
COLORTBL        = $F6F6

div7_table	= $9000
mod7_table	= $9100

	;=================================
	; Simple Rectangle
	;=================================
	VGI_RCOLOR	= P0
	VGI_RX1		= P1
	VGI_RY1		= P2
	VGI_RXRUN	= P3
	VGI_RYRUN	= P4

test:
	jsr	make_tables

	; clear to white

	jsr	HGR2
	lda	#$ff
	jsr	BKGND0

	; draw first

	lda	#$23
	sta	VGI_RCOLOR

	lda	#15
	sta	VGI_RX1
	lda	#230
	sta	VGI_RXRUN

	lda	#0
	sta	VGI_RY1
	lda	#191
	sta	VGI_RYRUN

	jsr	vgi_simple_rectangle

	; draw second

	lda	#$00
	sta	VGI_RCOLOR

	lda	#100
	sta	VGI_RX1
	lda	#1
	sta	VGI_RXRUN

	lda	#0
	sta	VGI_RY1
	lda	#191
	sta	VGI_RYRUN

	jsr	vgi_simple_rectangle


end:
	jmp	end



vgi_simple_rectangle:

simple_rectangle_loop:



	lda	VGI_RCOLOR

	asl		; nibble swap by david galloway
	adc	#$80
	rol
	asl
	adc	#$80
	rol

	sta	VGI_RCOLOR

	and	#$f
	tax

	lda	COLORTBL,X
	sta	HGR_COLOR

	; get ROW into (GBASL)

	ldx	#0		; X1 into X
	lda	VGI_RY1		; Y1 into A
	ldy	#0		; always 0
	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	; copy the XRUN

	lda	VGI_RXRUN
	sta	XRUN

	inc	XRUN	; needed because we compare with beq/bne


	; get position of first block (x/7) and put into Y

	; draw leftmost
	ldy	VGI_RX1
	lda	div7_table,Y
	tay

	; set up the color

	and	#$1
	beq	no_shift

	lda	HGR_BITS
	jsr	COLOR_SHIFT

	; check if narrow case where in same

	; see if not starting on boundary
	ldx	VGI_RX1
	lda	mod7_table,X
	beq	draw_run

	tax
	lda	(GBASL),Y
	eor	HGR_BITS
	and	left_masks,X
	eor	(GBASL),Y
	sta	(GBASL),Y

	iny			; move to next

	txa			; adjust RUN length
	eor	#$ff
	clc
	adc	#1
	adc	XRUN
	sta	XRUN

no_shift:


	; draw common
draw_run:
	lda	XRUN
	cmp	#7
	bcc	draw_right	; blt

	lda	HGR_BITS
	sta	(GBASL),Y
	iny

	lda	XRUN
	sec
	sbc	#7
	sta	XRUN

	lda	HGR_BITS
	jsr	COLOR_SHIFT

	jmp	draw_run

	; draw rightmost
draw_right:

	beq	done_row

;	lda	HGR_BITS
;	jsr	COLOR_SHIFT

	; see if not starting on boundary
	ldx	XRUN

	tax
	lda	(GBASL),Y
	eor	HGR_BITS
	and	right_masks,X
	eor	(GBASL),Y
	sta	(GBASL),Y

done_row:

	inc	VGI_RY1
	dec	VGI_RYRUN
	;bne	simple_rectangle_loop
	beq	done_done
	jmp	simple_rectangle_loop

done_done:
	rts





	;=================================
	; Dithered Rectangle
	;=================================
;	VGI_RCOLOR	= P0
;	VGI_RX1		= P1
;	VGI_RY1		= P2
;	VGI_RXRUN	= P3
;	VGI_RYRUN	= P4
	VGI_RCOLOR2	= P5

vgi_dithered_rectangle:

dithered_rectangle_loop:
	lda	COUNT
	and	#$1
	beq	even_color
odd_color:
	lda	VGI_RCOLOR
	jmp	save_color
even_color:
	lda	VGI_RCOLOR2
save_color:
	sta	HGR_COLOR

	inc	COUNT

	ldx	VGI_RX1		; X1 into X
	lda	VGI_RY1		; Y1 into A
	ldy	#0		; always 0
	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)


	lda	VGI_RXRUN	; XRUN into A
	ldx	#0		; always 0
	ldy	#0		; relative Y is 0
	jsr	HLINRL		; (X,A),(Y)

	inc	VGI_RY1
	dec	VGI_RYRUN
	bne	dithered_rectangle_loop

	rts


make_tables:

	ldy	#0
	lda	#0
	ldx	#0
div7_loop:
	sta	div7_table,Y

	inx
	cpx	#7
	bne	div7_not7

	clc
	adc	#1
	ldx	#0
div7_not7:
	iny
	bne	div7_loop


	ldy	#0
	lda	#0
mod7_loop:
	sta	mod7_table,Y
	clc
	adc	#1
	cmp	#7
	bne	mod7_not7
	lda	#0
mod7_not7:
	iny
	bne	mod7_loop

	rts

left_masks:
	.byte $FF,$FE,$FC,$F8, $F0,$E0,$C0

right_masks:
	.byte $81,$83,$87, $8F,$9F,$BF,$FF
