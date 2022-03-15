	;=================================
	; Simple Horizontal LINE
	;=================================
	; line from (x,a) to (x+y,a)
	; todo: use Carry to say if X>255

hgr_hlin:

	; get ROW into (GBASL)

	sty	xrun_save
	stx	x1_save

	; X1 already in X
	; Y1 already in A	; Y1 into A
	;ldy	#0		; always 0
	;jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)
				; important part is row is in GBASL/GBASH
	; HPOSN also shifts color odd/even for us
	; HPOSN also puts X1/7 into Y

	tay			; get row info for Y1 into GBASL/GBASH
	lda	hposn_high,Y
	sta	GBASH
	lda	hposn_low,Y
	sta	GBASL

	lda	div7_table,X	; put X1/7 into Y
	tay

	; reset color bits
	ldx	HGR_COLOR
	lda	hgr_colortbl,X
	sta	HGR_BITS

	and	#$1			; only shift if in odd column?
	beq	hlin_no_shift_colors
	jsr	shift_colors
hlin_no_shift_colors:

	; check if narrow corner case where begin and end same block
	; if RX%7 + XRUN < 7

	ldx	x1_save
	lda	mod7_table,X
	clc
	adc	xrun_save
	cmp	#7
	bcs	not_same_block

	;====================================
	; special case if all in one block
same_block:
	; want to use MASK of left_mask (MOD7) ANDed with ~left_mask (MOD7+XRUN)


	lda	mod7_table,X		; get x1%7
	tax				; put in X
	lda	left_masks,X		; get left mask
	sta	same_block_mask_smc+1

	txa				; x1%7
	clc
	adc	xrun_save		; (x1%7)+xrun
	tax
	lda	left_masks,X		; get left mask

	eor	#$7f
	and	same_block_mask_smc+1
	sta	same_block_mask_smc+1

	lda	(GBASL),Y
	eor	HGR_BITS
same_block_mask_smc:
	and	#$dd
	eor	(GBASL),Y
	sta	(GBASL),Y

	rts

not_same_block:

	; see if not starting on boundary
	; X still has X1 in it
	lda	mod7_table,X
	beq	draw_run

	; handle not full left border
handle_ragged_left:
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
	adc	xrun_save
	sta	xrun_save

	jsr	shift_colors

	; draw run of same values
draw_run:
	lda	xrun_save
	tax
	lda	mod7_table,X	; get right partial value
	sta	right_mask_smc+1
	lda	div7_table,X	; get run length
	tax
;	cmp	#7
;	bcc	draw_right	; blt

draw_run_loop:
	beq	draw_right
	lda	HGR_BITS	; get color
	sta	(GBASL),Y	; store out

	iny			; move to next block

	jsr	shift_colors

	dex
	jmp	draw_run_loop

	; draw rightmost
draw_right:

right_mask_smc:
	ldx	#$dd
	beq	done_hgr_hlin

	; see if not starting on boundary
;	ldx	xrun_save
;	tax

	lda	(GBASL),Y
	eor	HGR_BITS
;right_mask_smc:
;	and	#$dd
	and	right_masks,X
	eor	(GBASL),Y
	sta	(GBASL),Y

done_hgr_hlin:

	rts



x1_save:	.byte $00
xrun_save:	.byte $00


;right_masks:
;	.byte $80,$81,$83,$87, $8F,$9F,$BF

;left_masks:
;	.byte $FF,$FE,$FC,$F8, $F0,$E0,$C0


	;==========================
	; shift colors
	;==========================
	; 00000000 and 10000000 => no change (black)
	; 01111111 and 11111111 => no change? (white)
	; 01010101 => invert 00101010
shift_colors:
	lda	HGR_BITS
	asl
	cmp	#$C0
	bpl	done_shift_colors
	lda	HGR_BITS
	eor	#$7f
	sta	HGR_BITS
done_shift_colors:
	rts

	;==========================
	; set color
	;==========================
	; color in X
set_hcolor:
	lda	hgr_colortbl,X
	sta	HGR_BITS
	rts

	; lives at $F6F6 in Applesoft ROM
hgr_colortbl:
	.byte $00,$2A,$55,$7F
	.byte $80,$AA,$D5,$FF

; notes
	; 4+3
	; 0000 CCCC	0000 1111
	; 0000 000C     0000 0001

; 4000 = 80			80
; 4400 = 81			81
; 4800 = 83			83
; 4C00 = 87			87
; 5000 = 8F			8F
; 5400 = 9F			9F
; 5800 = BF			BF
;----
; 5C00 = FF			FF
; 4080 = ff 81			FF 81
; 4480 = ff 83
; 4880 = ff 87
; 4c80 = ff 8F
; 5080 = ff 9f
; 5480 = ff bf
;-----------
; 5880 = ff ff
; 5c80 = ff ff 81
