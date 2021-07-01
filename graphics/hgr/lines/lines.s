; Hi-res Bresenham Lines

; by Vince `deater` Weaver <vince@deater.net>

; based on pseudo-code from
;	https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm

; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6


B_X1_L	= $F0
B_X1_H	= $F1
B_Y1	= $F2
B_X2_L	= $F3
B_X2_H	= $F4
B_Y2	= $F5
B_DX_L	= $F6
B_DX_H	= $F7
B_DY_L	= $F8
B_DY_H	= $F9
B_SX	= $FA
B_SY	= $FB
B_ERR_L	= $FC
B_ERR_H	= $FD
COUNT	= $FE
FRAME	= $FF

; soft-switches

KEYPRESS	= $C000
KEYRESET	= $C010

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
HPLOT0		= $F457		; plot at (Y,X), (A)
HGLIN           = $F53A         ; line to (X,A),(Y)
HCOLOR1		= $F6F0		; set HGR_COLOR to value in X
COLORTBL	= $F6F6
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
NEXTCOL		= $F85F		; COLOR=COLOR+3
SETCOL		= $F864		; COLOR=A
SETGR		= $FB40		; set graphics and clear LO-RES screen
BELL2		= $FBE4
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us


lines:
	jsr	HGR2

reset:
	ldx	#0
	stx	COUNT

	stx	B_X1_H
	stx	B_X1_L
	stx	B_Y1

	stx	B_X2_H
	stx	B_X2_L

	lda	#191
	sta	B_Y2

left_lines_loop:

	jsr	draw_line

	lda	B_Y1
	clc
	adc	#8
	sta	B_Y1

	lda	B_X2_L		; 280/24 = 140/12 = 70/6 = 11 
	clc
	adc	#11
	sta	B_X2_L
	bcc	noc
	inc	B_X2_H
noc:
	inc	COUNT
	inc	FRAME

	lda	COUNT
	cmp	#24
end:
	bne	left_lines_loop

	;================
	; right lines
	;================
	; at this point, count = 24
	; X1, Y1 = 0,192
	; X2, Y2 = 264,192
	; want x1,y1 to go from 264,0 to 0,0
	; want x2,y2 to go from 264,192 to 264,0

	ldx	#0
	stx	B_Y1

	ldx	B_X2_L
	stx	B_X1_L
	ldx	B_X2_H
	stx	B_X1_H

right_lines_loop:

	jsr	draw_line

	lda	B_Y2
	sec
	sbc	#8
	sta	B_Y2

	lda	B_X1_L
	sec
	sbc	#11
	sta	B_X1_L
	bcs	noc2
	dec	B_X1_H
noc2:
	dec	COUNT
	inc	FRAME

	lda	COUNT

	beq	reset

	bne	right_lines_loop


	;============================
	; draw line
	;	from x1,y1 to x2,y2
	;============================
draw_line:


;	lda	FRAME
;	and	#$7
;	tax
	ldx	#7
	jsr	HCOLOR1		; set color




	; from wikipedia

	; dx =  abs(x2 - x1)
	; sx = x1 < x2 ? 1 : -1
	; dy =  -abs(y2 - y1)
	; sy = y1 < y2 ? 1 : -1
	; err = dx+dy

init_bresenham:

	; dx = abs(x2-x1)
	; sx = x1<x2 ? 1 : -1


do_abs_x:
	ldy	#$ff

	sec
	lda	B_X1_L
	sbc	B_X2_L			; A = x1 - x2
	sta	B_DX_L
	lda	B_X1_H
	sbc	B_X2_H
	sta	B_DX_H

	bpl	xis_pos

	ldy	#$1
xneg:
	lda	B_DX_L
	eor	#$ff
	clc
	adc	#1
	sta	B_DX_L
	lda	B_DX_H
	eor	#$ff
	adc	#0
	sta	B_DX_H

xis_pos:
	sty	B_SX


	; dy = -abs(y2-y1)
	; sy = y1 < y2 ? 1 : -1

do_abs_y:
	ldy	#$1

	sec
	lda	B_Y1
	sbc	B_Y2			; A = y1 - y2
	sta	B_DY_L
	lda	#0
	sbc	#0
	sta	B_DY_H

	bmi	yis_neg

	ldy	#$ff
yneg:
	lda	B_DY_L
	eor	#$ff
	clc
	adc	#1
	sta	B_DY_L
	lda	B_DY_H
	adc	#0
	sta	B_DY_H

yis_neg:
	sty	B_SY

					; FIXME: just reverse earlier
;	eor	#$ff			; dy = -abs(y2-y1)
;	clc
;	adc	#1

	; err = dx+dy

	clc
	lda	B_DY_L
	adc	B_DX_L
	sta	B_ERR_L
	lda	B_DY_H
	adc	B_DX_H
	sta	B_ERR_H

	;======================
	; iterative plot points

line_loop:

	; hplot X1,Y1

	ldy	B_X1_H
	ldx	B_X1_L
	lda	B_Y1

	jsr	HPLOT0		; plot at (Y,X), (A)

	; check if hit end

	ldy	B_X1_H
	cpy	B_X2_H
	bne	line_no_end

	ldy	B_X1_L
	cpy	B_X2_L
	bne	line_no_end

	lda	B_Y1
	cmp	B_Y2
	beq	done_line

line_no_end:

	;========================
	; step bresenham
	;========================

	; err2 = 2*err
	lda	B_ERR_L
	asl
	rol	B_ERR_H

	; if err2 >= dy:
	;   err = err + dy
	;   x1 = x1 + sx

	; 16 bit signed compare
	lda	B_ERR_L		; ERR2-DY
	cmp	B_DY_L
	lda	B_ERR_H
	sbc	B_DY_H
	bvc	blah
	eor	#$80		; N eor V
blah:
	bmi	check_dx

	; FIXME: convert ERR2 back to ERR

	clc
	lda	B_ERR_L
	adc	B_DY_L
	sta	B_ERR_L
	lda	B_ERR_H
	adc	B_DY_H
	sta	B_ERR_H

	lda	B_X1_L
	adc	B_SX
	sta	B_X1_L
	lda	B_X1_H
	adc	#0
	sta	B_X1_H

check_dx:
	; if err2 <= dx:
	;   err = err + dx
	;   y1 = y1 + sy

	; 16 bit signed compare
	lda	B_ERR_L		; ERR2-DX
	cmp	B_DX_L
	lda	B_ERR_H
	sbc	B_DX_H
	bvc	blah2
	eor	#$80		; N eor V
blah2:
	bmi	skip_y

	clc
	lda	B_ERR_L
	adc	B_DX_L
	sta	B_ERR_L
	lda	B_ERR_H
	adc	B_DX_H
	sta	B_ERR_H

	lda	B_Y1
	adc	B_SY
	sta	B_Y1
;	lda	B_Y1_H
;	adc	#0
;	sta	B_Y1_H


skip_y:

	jmp	line_loop

done_line:
	rts


