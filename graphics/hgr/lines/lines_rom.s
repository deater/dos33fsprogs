; ROM lines example, to use as comparison for the bresenham version

; by Vince `deater` Weaver <vince@deater.net>

; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6


B_X1_L	= $F0
B_X1_H	= $F1
B_Y1	= $F2
B_X2_L	= $F3
B_X2_H	= $F4
B_Y2	= $F5
COUNT	= $F9
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


	;================
	; draw line
draw_line:

	lda	FRAME
;	and	#$7
	tax
;	ldx	#7
	jsr	HCOLOR1		; set color

	ldy	B_X1_H
	ldx	B_X1_L
	lda	B_Y1
	jsr	HPLOT0		; plot at (Y,X), (A)

	ldx	B_X2_H
	lda	B_X2_L
	ldy	B_Y2
	jsr	HGLIN		; line to (X,A), (Y)

	rts
