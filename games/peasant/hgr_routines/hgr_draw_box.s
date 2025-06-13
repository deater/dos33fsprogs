	;========================
	; draw dialog box
	;========================
	; with purple border

	; TODO: is right edge a bit too small?
	; TODO: is bottom line not low enough?

	; draw to DRAW_PAGE
	; from X1L/7,Y1 to X2L/7,Y2

	; purple line roughly 5+6 at top and -5,-6 at bottom
	;	6789 on side

draw_box:

	; setup limits

	clc
	lda	BOX_Y1
	adc	#5
	sta	box_top_smc+1
	adc	#2
	sta	box_horiz_top_smc+1

	sec
	lda	BOX_Y2
	sbc	#5
	sta	box_bottom_smc+1
	sbc	#2
	sta	box_horiz_bottom_smc+1

draw_box_yloop:

	ldx	BOX_Y1
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	GBASH

	; if (ypos<y1+5) || (ypos>=Y2-6)	all white
box_top_smc:
	cpx	#5
	bcc	draw_all_white
box_bottom_smc:
	cpx	#$FF
	bcs	draw_all_white

	; if (ypos<y1+7) || (ypos>=Y2-5)	purple line
box_horiz_top_smc:
	cpx	#7
	bcc	draw_box_horiz
box_horiz_bottom_smc:
	cpx	#$FF
	bcs	draw_box_horiz


	;===============
	; box_bars
	;===============
draw_box_bars:
	ldy	BOX_X1L
	jsr	box_wall

box_bar_xloop:
	lda	#$7f
	sta	(GBASL),Y

	iny
	cpy	BOX_X2L
	bne	box_bar_xloop

	; right
	dey
	dey
	jsr	box_wall
	jmp	done_box_row		; bra


	;===============
	; box_all_white
	;===============
draw_all_white:
	ldy	BOX_X1L
all_white_xloop:
	lda	#$7f
	sta	(GBASL),Y
	iny
	cpy	BOX_X2L
	bne	all_white_xloop
	beq	done_box_row		; bra


	;===============
	; box_horizontal
	;===============
draw_box_horiz:
	ldy	BOX_X1L

	; left edge

	tya
	and	#$1
	tax
	lda	left_edge_lookup,X
	sta	(GBASL),Y
	iny

	; creamy center

horiz_purple_loop:

	tya
	and	#$1
	tax
	lda	purple_lookup,X
	sta	(GBASL),Y

	iny
	cpy	BOX_X2L
	bne	horiz_purple_loop

	; right edge

	dey				; backtrack

	tya
	and	#$1
	tax
	lda	right_edge_lookup,X
	sta	(GBASL),Y

	jmp	done_box_row		; bra

	;=======================
	; done box row

done_box_row:
	inc	BOX_Y1
	lda	BOX_Y1
	cmp	BOX_Y2

	bne	draw_box_yloop

done_draw_box:
	rts

	;=====================
	; box wall
	;=====================

box_wall:
	tya
	and	#$01
	tax
	lda	left_edge_lookup,X
	sta	(GBASL),Y
	iny
	lda	bar_lookup,X
	sta	(GBASL),Y

	iny

	rts

; even		7f	   7a
;	11.11.11.1 0 10 11 11
;	ww.ww.ww.p|p.pp.ww.ww
; odd           3f         7d
;	11.11.11.0 1 01 11 11
;	xw.ww.wp.p|p.pw.ww.ww

left_edge_lookup:	; even/odd
	.byte $7f,$3f
right_edge_lookup:	; even/odd
	.byte $7d,$7a
bar_lookup:		; even/odd
	.byte $7a,$7d

	; green    $2A              $55
	; 0 01 01 01 0     0 1 01 01 01
	; purple   $55              $2A
	; 0 10 10 10 1     0 0 10 10 10

purple_lookup:	; even/odd
	.byte $55,$2A
