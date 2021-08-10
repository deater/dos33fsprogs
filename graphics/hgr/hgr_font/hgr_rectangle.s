; HGR Rectangle

; VGI Rectangle test

COLOR_MODE	= TEMP0
OTHER_MASK	= TEMP1
XRUN		= TEMP2

div7_table	= $B000
mod7_table	= $B100


	; FAST
	;=================================
	; Simple Rectangle
	;=================================
;	VGI_RCOLOR	= P0
;	VGI_RX1		= P1
;	VGI_RY1		= P2
;	VGI_RXRUN	= P3
;	VGI_RYRUN	= P4
;	VGI_RCOLOR2	= P5	; only for dither

	;==================================
	; VGI Simple Rectangle
	;==================================

vgi_simple_rectangle:
	lda	#0
	sta	COLOR_MODE

simple_rectangle_loop:

	lda	COLOR_MODE
	beq	simple_colors
	bmi	striped_colors
	bpl	handle_dither


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
	jmp	done_colors
striped_colors:

	; don't need to do anything here?

done_colors:

	; get ROW into (GBASL)

	ldx	VGI_RX1		; X1 into X
	lda	VGI_RY1		; Y1 into A
	ldy	#0		; always 0
	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)

	; Y is already the RX1/7

	; adjust color if in striped mode
	lda	COLOR_MODE
	bpl	not_striped

	jsr	swap_colors

not_striped:

	; copy the XRUN

	lda	VGI_RXRUN
	sta	XRUN

	inc	XRUN	; needed because we compare with beq/bne


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

;	lda	HGR_BITS	; cycle colors for next
;	jsr	COLOR_SHIFT

	jsr	swap_colors

;no_shift:

	; draw common
draw_run:
	lda	XRUN
	cmp	#7
	bcc	draw_right	; blt

	lda	HGR_BITS	; get color
	sta	(GBASL),Y	; store out
;	jsr	COLOR_SHIFT	; shift colors

	iny			; move to next block

	jsr	swap_colors

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
	rts


	;==========================
	; swap colors
	;==========================
swap_colors:

	lda	COLOR_MODE
	bmi	swap_colors_striped

	lda	HGR_BITS	; get color
	jsr	COLOR_SHIFT	; shift colors

	rts

swap_colors_striped:

	tya
	and	#1
	bne	swap_odd

	lda	VGI_RCOLOR
	jmp	swap_done

swap_odd:
	lda	VGI_RCOLOR2
swap_done:
	sta	HGR_BITS

	rts







	;=====================
	; make /7 %7 tables
	;=====================

vgi_init:

vgi_make_tables:

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










