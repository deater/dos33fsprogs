; Bresenham Lines

; by Vince `deater` Weaver <vince@deater.net>

; based on code from https://gist.github.com/petrihakkinen/

.include "zp.inc"
.include "hardware.inc"

B_Y1	= $F0
B_Y2	= $F1
B_X1	= $F2
B_X2	= $F3
B_DY	= $F4
B_DX	= $F5
B_SY	= $F6
B_SX	= $F7
B_ERR	= $F8

lines:

	jsr	SETGR		; set lo-res 40x40 mode
				; A=$D0 afterward


	lda	#6
	jsr	SETCOL

	lda	#10
	sta	B_X1
	sta	B_Y1
	lda	#30
	sta	B_X2
	sta	B_Y2

	jsr	draw_line

end:
	jmp	end



draw_line:

	jsr	init_bresenham

line_loop:

	ldy	B_X1
	lda	B_Y1

	jsr	PLOT		; PLOT AT Y,A

	ldy	B_X1
	cpy	B_X2
	bne	line_no_end

	lda	B_Y1
	cmp	B_Y2
	beq	done_line
line_no_end:

	jsr	step_bresenham


	jmp	draw_line

done_line:
	rts

	;========================
	; step
	;========================

step_bresenham:
	; err2 = err
	lda	B_ERR
	pha			; push err2

	; if err2 > -dx:
	;   err = err - dy
	;   x = x + sx
	clc
	adc	B_DX		; skip if err2 + dx <= 0
	bmi	skip_x
	beq	skip_x
	lda	B_ERR
	sec
	sbc	B_DY
	sta	B_ERR
	lda	B_X1
	clc
	adc	B_SX
	sta	B_X1
skip_x:
	; if err2 < dy:
	;   err = err + dx
	;   y = y + sy
	pla			; pop err2
	cmp	B_DY		; skip if err2 - dy >= 0
	bpl	skip_y
	lda	B_ERR
	clc
	adc	B_DX
	sta	B_ERR
	lda	B_Y1
	clc
	adc	B_SY
	sta	B_Y1
skip_y:
	rts

	;========================
	; init
	;========================

init_bresenham:
	; dx = abs(x2 - x1)
	; dy = abs(y2 - y1)
	; sx = x1 < x2 ? 1 : -1
	; sy = y1 < y2 ? 1 : -1
	; err = dx > dy ? dx : -dy
	; dx = dx * 2
	; dy = dy * 2

	; if y1 < y2:
	; 	sy = 1
	; 	dy = y2 - y1
	; else:
	; 	sy = -1
	; 	dy = y1 - y2

	ldx	#$ff			; X = -1
	lda	B_Y1
	sec
	sbc	B_Y2			; A = y1 - y2
	bpl	yskip
	ldx	#1			; X = 1
	jsr	neg			; A = y2 - y1
yskip:
	sta	B_DY
	stx	B_SY

	; if x1 < x2:
	; 	sx = 1
	; 	dx = x2 - x1
	; else:
	; 	sx = -1
	; 	dx = x1 - x2
	ldx	#$ff			; X = -1
	lda	B_X1
	sec
	sbc	B_X2			; A = x1 - x2
	bpl	xskip
	ldx	#1			; X = 1
	jsr	neg			; A = x2 - x1
xskip:
	sta	B_DX
	stx	B_SX


	; err = dx > dy ? dx : -dy
	; lda	B_DX
	cmp	B_DY			; dx - dy > 0
	beq	errneg
	bpl	skiperr
errneg:
	lda	B_DY
	jsr	neg
skiperr:
	sta	B_ERR

	; dx = dx * 2
	; dy = dy * 2
	asl	B_DX
	asl	B_DY
	rts

neg:
	eor	#$ff
	clc
	adc	#1
	rts
