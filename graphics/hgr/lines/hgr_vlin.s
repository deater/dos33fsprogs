	;=================================
	; Simple Vertical LINE
	;=================================
	; line from (x,a) to (x,a+y)
	; todo: use Carry to say if X>255

hgr_vlin:
	; don't handle run of 0
	cpy	#0
	beq	done_hgr_vlin


	; get initial ROW into (GBASL)

	sta	current_row_smc+1	; save current A
	sty	vlin_row_count

	lda	div7_table,X
	sta	x1_save_smc+1

	lda	mod7_table,X
	tax
	lda	vlin_masks,X
	sta	vlin_mask_smc+1

hgr_vlin_loop:

current_row_smc:
	lda	#$dd
	ldx	#0		; doesn't matter
	ldy	#0		; always 0
	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)
				; important part is row is in GBASL/GBASH
	; HPOSN also shifts color odd/even for us
	; HPOSN also puts X1/7 into Y

x1_save_smc:
	ldy	#$dd
	lda	(GBASL),Y
	eor	HGR_BITS
vlin_mask_smc:
	and	#$dd
	eor	(GBASL),Y
	sta	(GBASL),Y

	inc	current_row_smc+1
	dec	vlin_row_count

	bne	hgr_vlin_loop

done_hgr_vlin:

	rts

vlin_row_count:	.byte $00


vlin_masks:
	.byte $81,$82,$84,$88,$90,$A0,$C0


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
	lda	COLORTBL,X
	sta	HGR_COLOR
	rts


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
