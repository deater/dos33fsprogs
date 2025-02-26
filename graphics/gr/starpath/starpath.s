PLOT	= $F800		; PLOT AT Y,A (A colors output, Y preserved)
PLOT1	= $F80E		; PLOT at (GBASL),Y (need MASK to be $0f or $f0)

SETCOL	= $F864		; COLOR=A
SETGR	= $FB40

FULLGR	= $C052

FRAME	= $F0
YPOS	= $F1
XPOS	= $F2
DEPTH	= $F3
C	= $F4
AL	= $F5
;AH	= $F6
PRODLO	= $F7
FACTOR2	= $F8
YPL	= $F9
YPH	= $FA
XPL	= $FB
XPH	= $FC
Q	= $FD

	;=============================
	;=============================
	; star path
	;=============================
	;=============================

starpath:
	;=============================
	; setup graphics
	;=============================

	jsr	SETGR			; set graphics
	bit	$C052			; set full-screen graphics

	;=============================
	; initialize
	;=============================

	lda	#0
	sta	FRAME

next_frame:
	lda	#0		; start with YPOS=0
	sta	YPOS
yloop:
	lda	#0		; start with XPOS=0
	sta	XPOS
xloop:
	lda	#14
	sta	DEPTH		; start Depth at 14

depth_loop:
	;===============
	; YP = Y*4*DEPTH
	;===============

	lda	YPOS		;
	asl
	asl			; A is YPOS*4

	tay			; multiply Y*4*DEPTH
	lda	DEPTH
	jsr	mul8		; 8-bit unsigned multiply

	sta	YPH		; store out to YPH:YPL
	lda	PRODLO
	sta	YPL

	;========================
	; XP=(X*6)-DEPTH
	;	curve X by depth
	;=========================

	lda	XPOS		; load XPOS
	asl
	sta	XPL
	asl
	;clc			; carry always 0 as x never more than 40?
	adc	XPL
	sta	XPL		; XPL=XPOS*6

	sta	AL		; AL also is XPOS*6

	sec			; Subtract DEPTH
	sbc	DEPTH
	sta	XPL		; XP=(XPOS*6)-DEPTH

				; if carry set means not negative
				; and draw path
				; otherwise we draw the sky
	bcs	draw_path

	;========================
	; draw the sky
	;========================
draw_sky:

	;================================
	; set color to white for star?

	lda	#31		; C=31
	sta	C

	;=====================
	; calc A=(XPOS*6)+YP

	; ??? used to see if star

	clc
	lda	AL
	adc	YPL		; A=X*6+YP

	;==============
	; see if star

	cmp	#6		; if A&0xFF < 6 then skip, we are star
	bcc	plot_pixel

	;==============
	; not star, sky

	lda	YPOS		; C=Y/4+32
	lsr
	lsr
	clc
	adc	#32
	sta	C

	bne	plot_pixel	; bra

	;====================
	; draw path
	;====================

draw_path:
	;=================================
	; calc XP*DEPTH and get high byte

	ldy	XPL
	lda	DEPTH
	jsr	mul8		; A=XP*DEPTH

	;===================================
	; calc Q= (XP*DEPTH)/256 | (YP/256)
	;	for texture pattern

	ora	YPH		; Q=(XP*DEPTH)/256 | YP/256
	sta	Q

	;==============================
	; calc C = Q & (Depth + Frame)
	; 	mask geometry by time shifted depth

	clc
	lda	DEPTH
	adc	FRAME		; add depth plus frame  D+F

	and	Q		; C = Q & (D+FRAME)
	sta	C

	;=========================
	; increment depth

	inc	DEPTH		; DEPTH=DEPTH+1

	;==========================
	; to create gaps

	cmp	#16		; IF C<16 THEN 3
	bcc	depth_loop

	;===========================
	; plot pixel
	;	XPOS,YPOS  COLOR=LOOKUP(C/2-8)
plot_pixel:
	lda	C
	lsr
	sec
	sbc	#8			; A is C/2-8

	tax
	lda	color_lookup,X		; Lookup in color table

	;=====================
	; set color

	jsr	SETCOL			; Set COLOR with ROM routine (mul*17)

	;=====================
	; plot point

	ldy	XPOS
	lda	YPOS
	jsr	PLOT			; PLOT AT Y,A (Y preserved)

	;===================
	; increment xloop

	inc	XPOS
	lda	XPOS
	cmp	#40
	bne	xloop
;	beq	xloop_done
;	jmp	xloop
xloop_done:

	;===================
	; increment yloop

	inc	YPOS
	lda	YPOS
	cmp	#48
;	bne	yloop
	beq	yloop_done
	jmp	yloop
yloop_done:
	inc	FRAME

	jmp	next_frame

color_lookup:
.byte	0,5,10,5,10,7,15,15,2,1,3,9,13,12


; Russian Peasant multiply by Thwaite
; https://www.nesdev.org/wiki/8-bit_Multiply
;
; Multiplies two 8-bit factors to produce a 16-bit product
; in about 153 cycles.
; @param A one factor
; @param Y another factor
; @return high 8 bits in A; low 8 bits in PRODLO
;         Y and FACTOR2 are trashed; X is untouched

mul8:
	; Factor 1 is stored in the lower bits of prodlo; the low byte of
	; the product is stored in the upper bits.

	lsr			; prime the carry bit for the loop
	sta	PRODLO
	sty	FACTOR2
	lda	#0
	ldy	#8
mul8_loop:
	; At the start of the loop, one bit of prodlo has already been
	; shifted out into the carry.
	bcc	mul8_noadd
	clc
	adc	FACTOR2
mul8_noadd:
	ror
	ror	PRODLO		; pull another bit out for the next iteration
	dey		; inc/dec don't modify carry; only shifts and adds do
	bne	mul8_loop
	rts

