; VGI Rectangle

; VGI Rectangle test

HGR_BITS	= $1C

GBASL	= $26
GBASH	= $27

USE_DITHERED	= $72
OTHER_MASK	= $73
XRUN		= $74
;COUNT		= $75

;HGR_COLOR = $E4


div7_table	= $9000
mod7_table	= $9100

USE_FAST = 1



.if (USE_FAST=0)

	; slow
	;=================================
	; Simple Rectangle
	;=================================
	VGI_RCOLOR	= P0
	VGI_RX1		= P1
	VGI_RY1		= P2
	VGI_RXRUN	= P3
	VGI_RYRUN	= P4

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
	bne	simple_rectangle_loop

	jmp	vgi_loop



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

	jmp	vgi_loop



.else




	; FAST
	;=================================
	; Simple Rectangle
	;=================================
	VGI_RCOLOR	= P0
	VGI_RX1		= P1
	VGI_RY1		= P2
	VGI_RXRUN	= P3
	VGI_RYRUN	= P4
	VGI_RCOLOR2	= P5	; only for dither

	;==================================
	; VGI Simple Rectangle
	;==================================

vgi_simple_rectangle:
	lda	#0
	sta	USE_DITHERED

simple_rectangle_loop:

	lda	USE_DITHERED
	bne	handle_dither

simple_colors:

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
	jmp	done_colors

handle_dither:

	lda	COUNT
	and	#$1
	beq	deven_color
dodd_color:
	lda	VGI_RCOLOR
	jmp	dsave_color
deven_color:
	lda	VGI_RCOLOR2
dsave_color:
	sta	HGR_COLOR

	inc	COUNT


done_colors:

	; get ROW into (GBASL)

	ldx	VGI_RX1		; X1 into X
	lda	VGI_RY1		; Y1 into A
	ldy	#0		; always 0
	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	; Y is already the RX1/7

	; copy the XRUN

	lda	VGI_RXRUN
	sta	XRUN

	inc	XRUN	; needed because we compare with beq/bne


	; get position of first block (x/7) and put into Y

	; draw leftmost
;	ldy	VGI_RX1
;	lda	div7_table,Y
;	tay

	; set up the color

;	and	#$1
;	beq	no_shift

;	lda	HGR_BITS
;	jsr	COLOR_SHIFT

;no_shift:

	; check if narrow corner case where begin and end same block
	; if RX%7 + XRUN < 8

	ldx	VGI_RX1
	lda	mod7_table,X
	clc
	adc	XRUN
	cmp	#8
	bcs	not_corner

corner:
	; want to use MASK of left_mask, MOD7 and 7-XRUN

	lda	mod7_table,X
	tax

	lda	(GBASL),Y
	eor	HGR_BITS
	and	left_masks,X
	ldx	XRUN
	and	right_masks,X
	eor	(GBASL),Y
	sta	(GBASL),Y

	jmp	done_row		; that's all

not_corner:

	; see if not starting on boundary
	ldx	VGI_RX1
	lda	mod7_table,X
	beq	draw_run

	; handle not full left border

	tax
	lda	(GBASL),Y
	eor	HGR_BITS
	and	left_masks,X
	eor	(GBASL),Y
	sta	(GBASL),Y

	iny			; move to next

	; adjust RUN length by 7- mod7
	txa			; load mod7
	eor	#$ff
	sec
	adc	#7
	eor	#$ff
	sec
	adc	XRUN
	sta	XRUN

	lda	HGR_BITS	; cycle colors for next
	jsr	COLOR_SHIFT


;no_shift:

	; draw common
draw_run:
	lda	XRUN
	cmp	#7
	bcc	draw_right	; blt

	lda	HGR_BITS	; get color
	sta	(GBASL),Y	; store out
	jsr	COLOR_SHIFT	; shift colors

	iny			; move to next block

	lda	XRUN		; take 7 off the run
	sec
	sbc	#7
	sta	XRUN

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
	jmp	vgi_loop


	;=================================
	; Dithered Rectangle
	;=================================
;	VGI_RCOLOR	= P0
;	VGI_RX1		= P1
;	VGI_RY1		= P2
;	VGI_RXRUN	= P3
;	VGI_RYRUN	= P4
;	VGI_RCOLOR2	= P5

vgi_dithered_rectangle:
	lda	#1
	sta	USE_DITHERED

	lda	#0
	sta	COUNT

	jmp	simple_rectangle_loop
.if 0
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

	jmp	vgi_loop

.endif

.endif






	;=====================
	; make /7 %7 tables
	;=====================

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










