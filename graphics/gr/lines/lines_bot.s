; Bresenham Lines

; by Vince `deater` Weaver <vince@deater.net>

; based on pseudo-code from
;	https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm



.include "zp.inc"
.include "hardware.inc"

; 174 -- initial
; 170 -- inline init
; 166 -- inline step
; 161 -- merge absolute_value/negative code
; 159 -- merging init X/Y paths
; 156 -- more merging X/Y init
; 154 -- note PLOT doesn't touch Y
; 152 -- merge into common_inc
; 151 -- share an RTS
; 150 -- use X when plotting
; 147 -- count down instead of up
; 144 -- mess around with how count set
; 142 -- who needs COUNT anyway
; 139 -- inline draw_line

B_X1	= $F0
B_Y1	= $F1
B_X2	= $F2
B_Y2	= $F3
B_DX	= $F4
B_DY	= $F5
B_SX	= $F6
B_SY	= $F7
B_ERR	= $F8

lines_bot:

	jsr	SETGR		; set lo-res 40x40 mode
				; A=$D0 afterward

restart:
	lda	#36
	sta	B_Y2
lines_loop:
	pha
	sta	B_X2
	sta	B_Y1

	jsr	NEXTCOL

	lda	#0
	sta	B_X1

;====================================
; inline draw_line
;====================================



	;============================
	; draw line
	;	from x1,y1 to x2,y2
	;============================
draw_line:

	; from wikipedia

	; dx =  abs(x2 - x1)
	; sx = x1 < x2 ? 1 : -1
	; dy =  -abs(y2 - y1)
	; sy = y1 < y2 ? 1 : -1
	; err = dx+dy

init_bresenham:

	; dx = abs(x2-x1)
	; sx = x1<x2 ? 1 : -1

	tax		; know this is zero from above
;	ldx	#0
	jsr	do_abs

	; dy = -abs(y2-y1)
	; sy = y1 < y2 ? 1 : -1

	inx
	jsr	do_abs
	jsr	neg			; dy = -abs(y2-y1)

	; err = dx+dy
	; B_DY is in A already
	clc
	adc	B_DX
	sta	B_ERR

	;======================
	; iterative plot points

line_loop:

	; plot X1,Y1

	ldy	B_X1
	ldx	B_Y1
	txa
	jsr	PLOT		; PLOT AT Y,A (A colors output, Y preserved)

	; check if hit end

;	ldy	B_X1
	cpy	B_X2
	bne	line_no_end

;	lda	B_Y1
	cpx	B_Y2
	beq	end_inline_draw_line
line_no_end:

	;========================
	; step bresenham
	;========================

	; err2 = 2*err
	lda	B_ERR
	asl
	pha			; save err2 for later

	ldx	#0		; setup for common_inc

	; if err2 >= dy:
	;   err = err + dy
	;   x1 = x1 + sx


	; B_ERR already in A
	cmp	B_DY		; check equal first
	beq	do_x

	clc			; signed compare
	sbc	B_DY
	bvc	blah2
	eor	#$80
blah2:
	bmi	skip_x		; ble

do_x:
	lda	B_DY
	jsr	common_inc
skip_x:



	inx			; setup common inc

	; if err2 <= dx:
	;   err = err + dx
	;   y1 = y1 + sy
	pla			; restore err2

	clc			; signed compare
	sbc	B_DX
	bvc	blah
	eor	#$80
blah:
	bpl	skip_y

do_y:
	lda	B_DX
	jsr	common_inc

skip_y:

	jmp	line_loop

;=============================
;end inline draw_line
;=============================

;	jsr	draw_line

end_inline_draw_line:

	pla
	sec
	sbc	#4		; update count

	bpl	lines_loop
	bmi	restart







	;=====================================
	; common increment
	;=====================================
common_inc:

	clc
	adc	B_ERR
	sta	B_ERR

	lda	B_X1,X
	clc
	adc	B_SX,X
	sta	B_X1,X
done_line:
	rts


	;=====================================
	; init, do the abs and sx calculations
	;	x=0, for X
	;	x=1, for Y
	;=====================================
do_abs:
	sec
	lda	B_X1,X
	sbc	B_X2,X			; A = x1 - x2

	bmi	is_neg

	ldy	#$ff
	bmi	neg_done

is_neg:
	ldy	#$1
neg:
	eor	#$ff
	clc
	adc	#1

neg_done:
	sty	B_SX,X
	sta	B_DX,X
	rts

	jmp	lines_bot
