; Hi-res Bresenham Lines

; by Vince `deater` Weaver <vince@deater.net>

; based on pseudo-code from
;	https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm

; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6


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
FRAME	= $FF

; soft-switches

KEYPRESS	= $C000
KEYRESET	= $C010

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3fff
HPLOT0		= $F457		; plot at (Y,X), (A)
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

restart:
	lda	#0
	sta	COUNT

lines_loop:
	lda	FRAME
	and	#$7
;	lda	#$7f
;	sta	HGR_COLOR


	lda	#0
	sta	B_X1
	lda	#36
	sta	B_Y2

	lda	COUNT
	cmp	#10
;end:
	beq	restart

	asl
	asl
	sta	B_Y1
	sta	B_X2

	jsr	draw_line

	inc	COUNT
	inc	FRAME

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

	;======================
	; iterative plot points

line_loop:

;	tya
;	pha
;	txa
;	pha

	; hplot X1,Y1

	ldx	B_X1
	lda	B_Y1
	ldy	#0

	jsr	HPLOT0		; plot at (Y,X), (A)

;	pla
;	tax
;	pla
;	tay

	; check if hit end

	ldy	B_X1
	cpy	B_X2
	bne	line_no_end

	lda	B_Y1
	cmp	B_Y2
	beq	done_line
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
	ldy	#$ff
	sec
	lda	B_X1,X
	sbc	B_X2,X			; A = x1 - x2

	bpl	is_pos

	ldy	#$1
neg:
	eor	#$ff
	clc
	adc	#1
is_pos:
	sty	B_SX,X
	sta	B_DX,X
	rts


