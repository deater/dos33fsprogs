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

	; from wikipedia

	; dx =  abs(x2 - x1)
	; sx = x1 < x2 ? 1 : -1
	; dy =  -abs(y2 - y1)
	; sy = y1 < y2 ? 1 : -1
	; err = dx+dy

init_bresenham:

	; dx = abs(x2-x1)
	; sx = x1<x2 ? 1 : -1

	ldx	#0
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

line_loop:

	; plot X1,Y1

	ldy	B_X1
	lda	B_Y1
	jsr	PLOT		; PLOT AT Y,A

	; check if hit end

	ldy	B_X1
	cpy	B_X2
	bne	line_no_end

	lda	B_Y1
	cmp	B_Y2
	beq	done_line
line_no_end:

	;========================
	; step
	;========================

step_bresenham:

	; err2 = 2*err
	lda	B_ERR
	asl
	pha			; push err2

	; if err2 >= dy:
	;   err = err + dy
	;   x1 = x1 + sx
				; signed compare
	clc
	cmp	B_DY
	beq	do_x

	sbc	B_DY
	bvc	blah2
	eor	#$80
blah2:
	bmi	skip_x		; ble

do_x:
	lda	B_ERR
	clc
	adc	B_DY
	sta	B_ERR
	lda	B_X1

	clc
	adc	B_SX
	sta	B_X1
skip_x:

	; if err2 <= dx:
	;   err = err + dx
	;   y1 = y1 + sy
	pla			; pop err2

	clc			; signed compare
	sbc	B_DX
	bvc	blah
	eor	#$80
blah:
	bpl	skip_y

do_inc_y:
	clc
	lda	B_ERR
	adc	B_DX
	sta	B_ERR

	clc
	lda	B_Y1
	adc	B_SY
	sta	B_Y1

skip_y:

	jmp	line_loop

done_line:
	rts


	; take just subtracted value
	; if negative, negate it, X=-1
	; if positive, fine, X=1
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



;B_X1	= $F0	00
;B_Y1	= $F1	00
;B_X2	= $F2	00
;B_Y2	= $F3	$23 = 35
;B_DX	= $F4	$00
;B_DY	= $F5	$DD = -35
;B_SX	= $F6	$FF = -1
;B_SY	= $F7	$01 = 1
;B_ERR	= $F8	$DD = -35

; E2=2*ERR = 1101 1101    1011 1010 = 0100 0110 = $46 = -70
; if -70 >= -35 .... no
; if -70 <= 0 ... yes, err=err+dx, -35+0=-35 
