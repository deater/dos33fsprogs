; Bresenham Lines

; by Vince `deater` Weaver <vince@deater.net>

; based on the HGR line code from Applesoft ROM

.include "zp.inc"
.include "hardware.inc"

; 171 -- initial
; 167 -- inline init

B_X1	= $F0
B_Y1	= $F1
B_X2	= $F2
B_Y2	= $F3
B_DX	= $F4
B_DY	= $F5
B_SX	= $F6
B_SY	= $F7
B_ERR	= $F8
COUNT	= $F9

lines:

	jsr	SETGR		; set lo-res 40x40 mode
				; A=$D0 afterward


	lda	#0
	sta	COUNT
lines_loop:

	jsr	NEXTCOL

	lda	#0
	sta	B_X1
	lda	#36
;	lda	#35
	sta	B_Y2

	lda	COUNT
	cmp	#10
end:
	beq	end

	asl
	asl
	sta	B_Y1
	sta	B_X2

	jsr	draw_line

	inc	COUNT

	jmp	lines_loop



	;============================
	; draw line
	;	from x1,y1 to x2,y2
	;============================
draw_line:


init_bresenham:
	; compute DX = X2-X1
	sec
	lda	B_X2
	sbc	B_X1
	sta	B_SX	; dx sign, +=right -=left
	bcs	no_invert_dx	; get ABS
	eor	#$ff
	sec
	adc	#1
no_invert_dx:
	sta	B_DX
	sta	B_ERR

	lda	B_Y2	; get DY=Y2-Y1
	clc
	sbc	B_Y1	; actually do DY= -ABS(Y2-Y1)-1
	bcc	no_invert_dy
	eor	#$ff
	adc	#$fe
no_invert_dy:
	sta	B_DY
	ror	B_SX	; get y direction into quadrant
	sec		; count = dx - (-dy)
	sbc	B_DX


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


	jmp	line_loop

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



neg:
	eor	#$ff
	clc
	adc	#1
	rts
