; hgr fast hlin


HGR_BITS	= $1C
GBASL		= $26
GBASH		= $27
HGR_COLOR	= $E4
HGR_PAGE	= $E6

div7_table	= $9000
mod7_table	= $9100

KEYPRESS        =       $C000
KEYRESET        =       $C010

HGR2            = $F3D8         ; clear PAGE2 to 0
HGR             = $F3E2         ; set hires page1 and clear $2000-$3fff
HPOSN           = $F411         ; (Y,X),(A)  (values stores in HGRX,XH,Y)
COLOR_SHIFT     = $F47E
COLORTBL        = $F6F6



main:
	; set graphics

	jsr	HGR


	; init tables

	jsr	vgi_init

	; draw lines
	ldy	#0
loop1:
	tya
	lsr
	and	#$7
	tax
	jsr	set_hcolor

	tya
	pha

	ldx	#10
;	lda	#10
;	ldy	#100
	jsr	hgr_hlin

	pla
	tay

	iny
	iny
	cpy	#190
	bne	loop1

	jsr	wait_until_keypress


; test 2


	jsr	HGR2

	; draw lines
	ldy	#0
loop2:
	ldx	#7			; draw white
	jsr	set_hcolor

	tya				; save y on stack
	pha

	tya				; line
	lsr
	sec
	eor	#$ff
	adc	#96
	tax

	tya

	jsr	hgr_hlin

	pla
	tay

	iny
	iny
	cpy	#192
	bne	loop2

	jsr	wait_until_keypress

; test 3


	jsr	HGR2

	; draw lines
	ldy	#0
loop3:
	ldx	#7			; draw white
	jsr	set_hcolor

	tya
	pha
	ldx	#0

	jsr	hgr_hlin

	pla
	tay

	iny
	cpy	#192
	bne	loop3

	jsr	wait_until_keypress

; test 4

	jsr	HGR2

	; draw lines
	ldy	#0
loop4:
	ldx	#3			; draw white1
	jsr	set_hcolor

	tya
	pha

	eor	#$ff
	sec
	adc	#192
	tax

	tya

	jsr	hgr_hlin

	pla
	tay

	iny
	cpy	#192
	bne	loop4

	jsr	wait_until_keypress



done:
	jmp	main

wait_until_keypress:
	bit	KEYRESET
keypress_loop:
	lda	KEYPRESS
	bpl	keypress_loop

	rts


	;=================================
	; Simple Horizontal LINE
	;=================================
	; line from (x,a) to (x+y,a)
	; todo: use Carry to say if X>255

hgr_hlin:

	; get ROW into (GBASL)

	sty	xrun_save
	stx	x1_save

	;ldx	VGI_RX1		; X1 into X
	; lda	VGI_RY1		; Y1 into A
	ldy	#0		; always 0
	jsr	HPOSN		; (Y,X),(A)  (values stores in HGRX,XH,Y)
				; important part is row is in GBASL/GBASH
				; also shifts color for us

	; Y is already the RX1/7

;	inc	xrun_save	; needed because we compare with beq/bne

	; check if narrow corner case where begin and end same block
	; if RX%7 + XRUN < 8

	ldx	x1_save
	lda	mod7_table,X
	clc
	adc	xrun_save
	cmp	#7
	bcs	not_same_block

same_block:
	; want to use MASK of left_mask (MOD7) ORed with
	;				right_mask (7-(mod7+xrun7)

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
; 4080 = ff 83			FF 81
; 4480 = ff 87
; 4880 = ff 8F

	lda	mod7_table,X		; get x1%7
	tax				; put in X
	lda	left_masks,X
	sta	$10

	txa				; x1%7
	clc
	adc	xrun_save		; (x1%7)+xrun
	tax
	lda	left_masks,X
	eor	#$7f
	and	$10
	sta	$10

	lda	(GBASL),Y
	eor	HGR_BITS
	and	$10
	eor	(GBASL),Y

;	lda	(GBASL),Y		; get current pattern
;	eor	HGR_BITS
;	and	left_masks,X


;	ldx	xrun_save
;	and	right_masks,X
;	eor	(GBASL),Y

	sta	(GBASL),Y

	rts

not_same_block:

	; see if not starting on boundary
;	ldx	x1_save
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

;	lda	HGR_BITS	; cycle colors for next
;	jsr	COLOR_SHIFT

	jsr	shift_colors


	; draw common
draw_run:
	lda	xrun_save
	cmp	#7
	bcc	draw_right	; blt

	lda	HGR_BITS	; get color
	sta	(GBASL),Y	; store out
;	jsr	COLOR_SHIFT	; shift colors

	iny			; move to next block

	jsr	shift_colors

	lda	xrun_save	; take 7 off the run
	sec
	sbc	#7
	sta	xrun_save

	jmp	draw_run

	; draw rightmost
draw_right:

	beq	done_row

;	lda	HGR_BITS
;	jsr	COLOR_SHIFT

	; see if not starting on boundary
	ldx	xrun_save
	tax

	lda	(GBASL),Y
	eor	HGR_BITS
	and	right_masks,X
	eor	(GBASL),Y
	sta	(GBASL),Y

done_row:


done_done:
	rts



x1_save:	.byte $00
xrun_save:	.byte $00







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
	;	CCCCCCC
	;	0CCCCCC
	;	00CCCCC
	;	000CCCC
	;	0000CCC
	;	00000CC
	;	000000C
right_masks:
;	.byte $81,$83,$87, $8F,$9F,$BF,$FF
	.byte $80,$81,$83,$87, $8F,$9F,$BF,$FF
	;	C000000
	;	CC00000
	;	CCC0000
	;	CCCC000
	;	CCCCC00
	;	CCCCCC0
	;	CCCCCCC

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
