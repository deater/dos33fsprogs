; HGR Rectangle

; Note: based on VGI code, but stripped out all the fancy features
;	like dithering


OTHER_MASK	= TEMP1
XRUN		= TEMP2

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
	; Simple Rectangle
	;==================================
	; assume solid color

vgi_simple_rectangle:

simple_rectangle_loop:

	lda	VGI_RCOLOR

	and	#$f
	tax

	lda	colortbl,X

	sta	HGR_COLOR

	; get ROW into (GBASL)
	; fast_hposn shifts color for us too

	jsr	fast_hposn

	; Y is already the RX1/7


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
	; left=(RX1 MOD 7) right=(RX1 MOD 7)+XRUN
	; mask is left AND right

	ldx	VGI_RX1
	lda	mod7_table,X
	tax
	lda	left_masks,X
	sta	OTHER_MASK

	txa
	clc
	adc	XRUN
	tax
	lda	right_masks,X
	and	OTHER_MASK
	sta	OTHER_MASK

	; actual

	lda	(GBASL),Y
	eor	HGR_BITS

	and	OTHER_MASK

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

	jsr	swap_colors

	; draw common
draw_run:
	lda	XRUN
	cmp	#7
	bcc	draw_right	; blt

	lda	HGR_BITS	; get color
	sta	(GBASL),Y	; store out

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
;	bne	simple_rectangle_loop
	beq	done_done
	jmp	simple_rectangle_loop

done_done:
	rts


	;==========================
	; swap colors
	;==========================
swap_colors:

	lda	HGR_BITS	; get color

	; based on code from the ROM at F47F
colorshift:
	asl			; shift to fix even/odd
	cmp	#$c0
	bpl	done_colorshift

	lda	HGR_BITS
	eor	#$7f		; invert bottom bits
	sta	HGR_BITS
done_colorshift:
	rts

	;===========================
	; colortbl
	;===========================
	; lives in ROM at F6F6 but we might have that swapped out
colortbl:
	; black1, green, purple, white1
	; black2, orange, blue, white2
.byte	$00,$2A,$55,$7F,$80,$aa,$D5,$FF



	;========================
	; fast hposn
	;========================
	; like HPOSN but faster (uses lookup tables)
	; need to set up lookup tables before using
fast_hposn:

	lda	VGI_RY1
	tax
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH

	lda	VGI_RX1
	tax
	ldy	div7_table,X

	tya
	lsr

	lda	HGR_COLOR	; if on odd byte rotate bits
	sta	HGR_BITS
	bcc	done_hposn

	jsr	colorshift

done_hposn:
	rts

