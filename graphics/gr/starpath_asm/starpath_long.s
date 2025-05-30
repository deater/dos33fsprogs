; An Apple II lores version of Hellmood's amazing 64B DOS Star Path Demo
;
;       See https://hellmood.111mb.de//starpath_is_55_bytes.html
;
;     Vince 'deater' Weaver -- vince@deater.net -- 26 April 2025

; optimization
;	329 bytes -- 8,745,584 cycles -- original code
;	326 bytes -- 8,154,511 cycles -- calculate xpos*6 by adding
;	323 bytes -- 8,015,008 cycles -- remove unneeded AL term
;	314 bytes -- 7,858,373 cycles -- redo color lookup table
;	318 bytes -- 7,867,352 cycles -- use ROM for random numbers

; ROM routines
PLOT	= $F800		; PLOT AT Y,A (A colors output, Y preserved)
PLOT1	= $F80E		; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
;SETCOL	= $F864		; COLOR=A
SETGR	= $FB40		; init lores graphics page1, clear screen, split text

; softswitches
FULLGR	= $C052		; enable full-screen (no-split text) graphics

; zero page addresses
COLOR	= $30		; color used by PLOT routines

FRAME	= $F0
YPOS	= $F1
XPOS	= $F2
DEPTH	= $F3
XPOS6   = $F4
PIXEL	= $F5
M1	= $F6
YPH	= $FA
XPL	= $FB
Q	= $FD


; Fast mutiply -- setup tables

square1_lo	=	$B000
square1_hi	=	$B200
square2_lo	=	$B400
square2_hi	=	$B600



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
	sta	PIXEL
yloop:
	lda	#0
	sta	XPOS		; start with XPOS=0

xloop:
	sta	XPOS6		; XPOS*6 is in A here, both paths
	ldx	#14		; start Depth at 14

	inc	PIXEL

depth_loop:
	stx	DEPTH

	;===============
	; YP = Y*4*DEPTH
	;===============

	lda	YPOS		;
	asl
	asl			; A is YPOS*4

	tay			; multiply Y*4*DEPTH
				; depth in X
	jsr	multiply_u8x8	; 8-bit unsigned multiply

	sta	YPH		; store out to YPH:YPL


	;========================
	; XP=(X*6)-DEPTH
	;	curve X by depth
	;=========================

	lda	XPOS6		; load XPOS*6
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

	;=====================
	; calc A=(XPOS*6)+YP


;	clc			; A=X*6+YP
;	lda	XPOS6
;	adc	M1		; YPL from previous multiply

	ldy	PIXEL
	lda	$F500,Y


	;==============
	; see if star

	ldy	#6		; set color to white
	cmp	#4		; if A&0xFF < 6 then skip, we are star
	bcc	plot_pixel_known_color

	;==============
	; not star, sky

	lda	YPOS		; Color offset=YPOS/8
	lsr
	lsr
	lsr
	tay

	jmp	plot_pixel_known_color	; bra

	;====================
	; draw path
	;====================

draw_path:
	;=================================
	; calc XP*DEPTH and get high byte

	ldy	XPL
				; depth in X
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
	txa			; depth in X
	adc	FRAME		; add depth plus frame  D+F

	and	Q		; Color Offset = Q & (D+FRAME)

	;=========================
	; increment depth

	inx			; depth in X

	;==========================
	; to create gaps

	cmp	#16		; IF C<16 THEN 3
	bcc	depth_loop

	;===========================
	; plot pixel
	;	XPOS,YPOS  COLOR OFFSET in A
plot_pixel:
	; color offset in A.  Is >16
	lsr			; divide by 2 to reduce colors in lookup
	tay
plot_pixel_known_color:
	lda	color_lookup,Y		; Lookup in color table

	;=====================
	; set color

	sta	COLOR			; if color top/bottom don't need SETCOL

	;=====================
	; plot point

	ldy	XPOS
	lda	YPOS
	jsr	PLOT			; PLOT AT Y,A (Y preserved)

	;===================
	; increment xloop

	inc	XPOS			; XPOS+=1

	lda	XPOS6			; XPOS6+=6
	clc
	adc	#6
	cmp	#240
	bne	xloop

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

	jsr	copy_to_mem

	inc	FRAME

	lda	FRAME
	and	#$1f
	sta	FRAME
	beq	oog

	jmp	next_frame

oog:

	jsr	copy_from_mem

	inc	FRAME
	lda	FRAME
	and	#$1f
	sta	FRAME

	jmp	oog



color_lookup:
sky_colors:
; 2=blue 1=magenta 3=purple 9=orange d=yellow c=l.green
.byte $22,$33,$11,$99,$DD,$CC, $FF, $00
; wall colors, offset 8 from start
.byte $00,$55,$AA,$55,$77,$EE,$FF,$FF

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

; calculate X * Y
; Result: A:M1

multiply_u8x8:
	txa
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

	rts


	;===========================

copy_from_mem:
	lda	FRAME		; 0->$10, 1->$14, 2->$18
	asl
	asl
	clc
	adc	#$10

	sta	ctm_smc1+2

	lda	#$4
	sta	ctm_smc2+2

	bne	garb

copy_to_mem:
	lda	#$4
	sta	ctm_smc1+2

	lda	FRAME		; 0->$10, 1->$14, 2->$18
	asl
	asl
	clc
	adc	#$10

	sta	ctm_smc2+2
garb:

	ldy	#0
	ldx	#4

ctm_xloop:

ctm_yloop:
ctm_smc1:
	lda	$400,Y
ctm_smc2:
	sta	$1000,Y
	iny
	bne	ctm_yloop

	inc	ctm_smc1+2
	inc	ctm_smc2+2

	dex
	bne	ctm_xloop

	rts




