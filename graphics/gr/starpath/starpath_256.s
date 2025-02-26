; An Apple II lores version of Hellmood's amazing 64B DOS Star Path Demo
;
;       See https://hellmood.111mb.de//starpath_is_55_bytes.html
;
;     deater -- Vince Weaver -- vince@deater.net -- 25 February 2025


PLOT	= $F800		; PLOT AT Y,A (A colors output, Y preserved)
PLOT1	= $F80E		; PLOT at (GBASL),Y (need MASK to be $0f or $f0)

SETCOL	= $F864		; COLOR=A
SETGR	= $FB40

FULLGR	= $C052

COLOR	= $30

FRAME	= $F0
YPOS	= $F1
XPOS	= $F2
DEPTH	= $F3
C	= $F4
AL	= $F5
M1	= $F6
M2	= $F7
TEMP	= $F8
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


init_multiply_tables:

	; Build the add tables

	ldx	#$00
	txa
	.byte $c9   ; CMP #immediate - skip TYA and clear carry flag
lb1:	tya
	adc	#$00			; 0
ml1:	sta	square1_hi,x		; square1_hi[0]=0
	tay				; y=0
	cmp	#$40			; subtract 64 and update flags (c=0)
	txa				; a=0
	ror				; rotate
ml9:	adc	#$00			; add 0
	sta	ml9+1			; update add value
	inx				; x=1
ml0:	sta	square1_lo,x		; square1_lo[0]=1
	bne	lb1			; if not zero, loop
	inc	ml0+2			; increment values
	inc	ml1+2			; increment values
	clc				; c=0
	iny				; y=1
	bne	lb1			; loop

	; Build the subtract tables based on the existing one

	ldx	#$00
	ldy	#$ff
second_table:
	lda	square1_hi+1,x
	sta	square2_hi+$100,x
	lda	square1_hi,x
	sta	square2_hi,y
	lda	square1_lo+1,x
	sta	square2_lo+$100,x
	lda	square1_lo,x
	sta	square2_lo,y
	dey
	inx
	bne second_table

;	lda	#0
	stx	FRAME

next_frame:
	lda	#0		; start with YPOS=0
	sta	YPOS
yloop:
	lda	#0		; start with XPOS=0
	sta	XPOS
xloop:
	ldx	#14		; start Depth at 14

depth_loop:
	stx	DEPTH


	;===============
	; YP = Y*4*DEPTH
	;===============

	lda	YPOS		;
	asl
	asl			; A is YPOS*4

	tay			; multiply Y*4*DEPTH
;	lda	DEPTH
	txa
	jsr	multiply_u8x8	; 8-bit unsigned multiply

	sta	YPH		; store out to YPH:YPL

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

	clc			; A=X*6+YP
	lda	AL
	adc	M1		; YPL from previous multiply

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
;	lda	DEPTH
	txa
	jsr	multiply_u8x8	; 8-bit unsigned multiply

	;===================================
	; calc Q= (XP*DEPTH)/256 | (YP/256)
	;	for texture pattern

	ora	YPH		; Q=(XP*DEPTH)/256 | YP/256
	sta	Q

	;==============================
	; calc C = Q & (Depth + Frame)
	; 	mask geometry by time shifted depth

	clc
;	lda	DEPTH
	txa
	adc	FRAME		; add depth plus frame  D+F

	and	Q		; C = Q & (D+FRAME)
	sta	C

	;=========================
	; increment depth

;	inc	DEPTH		; DEPTH=DEPTH+1
	inx

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

	tay
	lda	color_lookup,Y		; Lookup in color table

	;=====================
	; set color

	sta	COLOR

;	jsr	SETCOL			; Set COLOR with ROM routine (mul*17)

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
	bne	yloop
;	beq	yloop_done
;	jmp	yloop
yloop_done:
	inc	FRAME

	jmp	next_frame

color_lookup:
.byte	$00,$55,$AA,$55,$AA,$77,$FF,$FF,$22,$11,$33,$99,$DD,$CC


; Fast mutiply

; Note for our purposes we only care about 8.8 x 8.8 fixed point
; with 8.8 result, which means we only care about the middle two bytes
; of the 32 bit result.  So we disable generation of the high and low byte
; to save some cycles.

;
; The old routine took around 700 cycles for a 16bitx16bit=32bit mutiply
; This routine, at an expense of 2kB of looku tables, takes around 250
;	If you reuse a term the next time this drops closer to 200

; This routine was described by Stephen Judd and found
;	in The Fridge and in the C=Hacking magazine
; http://codebase64.org/doku.php?id=base:seriously_fast_multiplication

; The key thing to note is that
;	       (a+b)^2     (a-b)^2
;       a*b =  -------  -  --------
;                 4           4
; So if you have tables of the squares of 0..511 you can lookup and subtract
; instead of multiplying.

; Table generation: I:0..511
;                   square1_lo = <((I*I)/4)
;                   square1_hi = >((I*I)/4)
;                   square2_lo = <(((I-255)*(I-255))/4)
;                   square2_hi = >(((I-255)*(I-255))/4)


; Fast 8x8 bit unsigned multiplication, 16-bit result

; input AxY
; Result: M2,A:M1
;

multiply_u8x8:
        sta     sm1a+1                                                  ; 3
        sta     sm3a+1                                                  ; 3
        eor     #$ff    ; invert the bits for subtracting               ; 2
        sta     sm2a+1                                                  ; 3
        sta     sm4a+1                                                  ; 3

	sec
sm1a:
	lda	square1_lo,Y
sm2a:
	sbc	square2_lo,Y
	sta	M1
sm3a:
	lda	square1_hi,Y
sm4a:
	sbc	square2_hi,Y
;	sta	M2

	rts


; Fast mutiply -- setup tables

.ifndef square1_lo
square1_lo	=	$2000
square1_hi	=	$2200
square2_lo	=	$2400
square2_hi	=	$2600
.endif

;	for(i=0;i<512;i++) {
;		square1_lo[i]=((i*i)/4)&0xff;
;		square1_hi[i]=(((i*i)/4)>>8)&0xff;
;		square2_lo[i]=( ((i-255)*(i-255))/4)&0xff;
;		square2_hi[i]=(( ((i-255)*(i-255))/4)>>8)&0xff;
;	}



