; Hi-res Bresenham Lines

; by Vince `deater` Weaver <vince@deater.net>

; based on pseudo-code from
;	https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm

; goal: ROM is 120 bytes 43c3/44a4/4599

; 361 bytes / D799/D23A/CE55 -- first working code
; 346 bytes / D7D6/D17C/CCE7 -- make X2 always > X1
; 347 bytes / D718/D0C6/CC39 -- make B_SY self modifying code

; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

X1_L	= $A0
X1_H	= $A1
Y1	= $A2
X2_L	= $A3
X2_H	= $A4
Y2	= $A5
B_ERR2_L = $EE
B_ERR2_H = $EF
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
;B_SX	= $FA
;B_SY	= $FB
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

	stx	X1_H		; 0:0,0
	stx	X1_L
	stx	Y1

	stx	X2_H		; 0:0,191
	stx	X2_L

	lda	#191
	sta	Y2

left_lines_loop:

	lda	FRAME
	and	#$7
	tax
;	ldx	#7
	jsr	HCOLOR1		; set color

	jsr	draw_line

	lda	Y1
	clc
	adc	#8
	sta	Y1

	lda	X2_L		; 280/24 = 140/12 = 70/6 = 11
	clc
	adc	#11
	sta	X2_L
	bcc	noc
	inc	X2_H
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
	stx	Y1

	ldx	X2_L
	stx	X1_L
	ldx	X2_H
	stx	X1_H

right_lines_loop:

	jsr	draw_line

	lda	Y2
	sec
	sbc	#8
	sta	Y2

	lda	X1_L
	sec
	sbc	#11
	sta	X1_L
	bcs	noc2
	dec	X1_H
noc2:
	dec	COUNT
	inc	FRAME

	lda	COUNT

	beq	reset

	bne	right_lines_loop





	;=========================================
	; draw line
	;	from x1,y1 to x2,y2
	;=========================================
	; note: x1,y1 points to x2,y2 at the end?
	;	x2,y2 unchanged
draw_line:

	lda	X1_L
	sta	B_X1_L
	lda	X1_H
	sta	B_X1_H
	lda	Y1
	sta	B_Y1

	lda	X2_L
	sta	B_X2_L
	lda	X2_H
	sta	B_X2_H
	lda	Y2
	sta	B_Y2

	; from wikipedia

	; dx =  abs(x2 - x1)
	; sx = x1 < x2 ? 1 : -1
	; dy =  -abs(y2 - y1)
	; sy = y1 < y2 ? 1 : -1
	; err = dx+dy

init_bresenham:

	; dx = abs(x2-x1)
	; sx = x1<x2 ? 1 : -1

	; we force x2 to always be greater than x1
	; now dx=x2-x1, sx fixed at 1

	; 16 bit unsigned compare x1 vs x2

	ldx	B_X1_H
	ldy	B_X1_L

	cpx	B_X2_H		; compare high bytes
	bne	dx_done_check
	cpy	B_X2_L
dx_done_check:

	bcc	calc_dx		; blt skip swap if x1<x2

	; swap X1/X2, Y1/Y2

	lda	B_X2_H
	sta	B_X1_H

	lda	B_X2_L
	sta	B_X1_L

	stx	B_X2_H
	sty	B_X2_L

	ldx	B_Y1
	ldy	B_Y2
	stx	B_Y2
	sty	B_Y1

calc_dx:
	sec
	lda	B_X2_L
	sbc	B_X1_L			; x2 - x1
	sta	B_DX_L
	lda	B_X2_H
	sbc	B_X1_H
	sta	B_DX_H


	; dy = -abs(y2-y1)
	; sy = y1 < y2 ? 1 : -1

do_abs_y:
	ldy	#$1

	sec
	lda	B_Y1
	sbc	B_Y2			; A = y1 - y2
	sta	B_DY_L
	lda	#0			; need to sign extend?
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
	eor	#$ff
	adc	#0
	sta	B_DY_H

yis_neg:
	sty	b_sy_smc+1		; B_SY


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
	sta	B_ERR2_L
	lda	B_ERR_H
	sta	B_ERR2_H

	clc
	rol	B_ERR2_L
	rol	B_ERR2_H

	; if err2 >= dy:
	;   err = err + dy
	;   x1 = x1 + sx

	; http://6502.org/tutorials/compare_beyond.html#5
	; 16 bit signed compare
	lda	B_ERR2_L	; ERR2-DY
	cmp	B_DY_L
	lda	B_ERR2_H
	sbc	B_DY_H
	bvc	blah
	eor	#$80		; N eor V
blah:
	bmi	check_dx	; branch if less than

	;   err = err + dy

	clc
	lda	B_ERR_L
	adc	B_DY_L
	sta	B_ERR_L
	lda	B_ERR_H
	adc	B_DY_H
	sta	B_ERR_H

	; SX is always 1
	;   x1 = x1 + sx

	inc	B_X1_L
	bne	done_inc_x1
	inc	B_X1_H
done_inc_x1:

check_dx:
	; if err2 <= dx:
	;   err = err + dx
	;   y1 = y1 + sy

	lda	B_DX_L
	cmp	B_ERR2_L
	bne	check_less
	lda	B_DX_H
	cmp	B_ERR2_H
	beq	doit

check_less:

	; 16 bit signed compare
	lda	B_DX_L
	cmp	B_ERR2_L
	lda	B_DX_H
	sbc	B_ERR2_H
	bvc	blah2
	eor	#$80		; N eor V
blah2:
	bmi	skip_y		; if minus than dx<err2 (i.e. err2>=dx)

	;   err = err + dx
doit:
	clc
	lda	B_ERR_L
	adc	B_DX_L
	sta	B_ERR_L
	lda	B_ERR_H
	adc	B_DX_H
	sta	B_ERR_H

	;   y1 = y1 + sy
	clc
	lda	B_Y1
b_sy_smc:
	adc	#0
	sta	B_Y1

skip_y:

	jmp	line_loop

done_line:
	rts


