; An Apple II lores version of Hellmood's amazing 64B DOS Star Path Demo
;
;       See https://hellmood.111mb.de//starpath_is_55_bytes.html
;
;     Vince 'deater' Weaver -- vince@deater.net -- 26 April 2025

; uses no multiply by using large lookup tables
;	we do lose some precision?

; optimization
;	318 bytes -- 7,867,352 cycles -- STARPATH_LONG code
;	238 bytes -- 7,852,906 cycles -- rip out save frames code
;	291 bytes -- 3,439,410 cycles -- no multiplies
;	291 bytes -- 2,980,116 cycles -- put ysmc outside critical loop
;	287 bytes -- 2,728,792 cycles -- get rid of unneeded YPH
;	286 bytes -- 2,645,188 cycles -- avoid writing out DEPTH
;	286 bytes -- 2,212,118 cycles -- move xsmc outside critical loop
;	262 bytes -- 2,212,118 cycles -- optimize table generation
;	252 bytes -- 2,212,118 cycles -- optimize table generation more
;	323 bytes -- 2,212,118 cycles -- add back memory copy code
;	311 bytes -- 2,212,118 cycles -- optimize memory copy code
;	337 bytes -- 2,212,118 cycles -- add in old multiply routine
;	316 bytes -- 2,212,118 cycles -- convert square table to mul
;	313 bytes -- 2,212,118 cycles -- convert xpos and ypos tables to mul
;	317 bytes -- 2,212,118 cycles -- back to functional completeness
;	312 bytes -- 2,212,118 cycles -- make mul8 A*X rather than A*Y
;	294 bytes -- 2,212,118 cycles -- combine xpos and ypos table gen


; TODO: sound?
;	show HGR when building lookup tables?
;	run loops backwards?


; ROM routines
PLOT	= $F800		; PLOT AT Y,A (A colors output, Y preserved)
PLOT1	= $F80E		; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
;SETCOL	= $F864		; COLOR=A
SETGR	= $FB40		; init lores graphics page1, clear screen, split text

; softswitches
FULLGR	= $C052		; enable full-screen (no-split text) graphics

; zero page addresses
COLOR	= $30		; color used by PLOT routines

SRCL	= $F0
SRCH	= $F1
DESTL	= $F2
DESTH	= $F3
FRAME	= $F4
YPOS	= $F5
XPOS	= $F6
XPOS6   = $F7
PIXEL	= $F8
Q	= $F9
FACTOR2	= $FA
PRODLO	= $FB
TEMPY	= $FC

; Lookup Tables

xpos_lookup	= $1000	; ...$3fff	$30 long
ypos_lookup	= $1080	; ...$3fff	(offset in top half)
squares_lookup	= $f00

; stored frames, 32 of them so 32k
frame_location	= $4000 ; ... $c000


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

init_tables:

	;===========================
	; first init X*6*DEPTH table
	; 40*6*128 = 30720 max
	;	in bottom half of pages

	; modify and do Y table
	; init Y*4*DEPTH table
	; 48*4*128 = 24576 = max
	;	in top half of pages

	;   y  0 4  8 12 16 20 24
	; d=0, 0 0  0  0  0  0  0
	; d=1, 0 4  8 12 16 20 24
	; d=2, 0 8 16 24 32 40 48


	ldy	#0		; for(x=0;x<48;x++) {
xpos_table_x_loop:


	tya			; self-modify the destination of the tables
	clc
	adc	#>xpos_lookup
	sta	xpos_smc+2
	sta	ypos_smc+2


	ldx	#0		; for(d=0;d<128;d++) {
xpos_table_d_loop:

	sty	TEMPY		; save Y

	; calculate XX*6*DEPTH

	tya			; XX in A
	asl
	adc	TEMPY		; A is now XX*3
	asl			; A is now XX*6

				; calculate XX*6*DEPTH
	jsr	mul8		; A*X -> high in A

xpos_smc:
	sta	xpos_lookup,X	; xpos_depth_lookup[y][d]=(x*6*d)>>8;


	; calculate YY*4*DEPTH

	lda	TEMPY		; get YY
	asl
	asl			; A is YY*4

	jsr	mul8		; mul X*A, high byte of result in A
				; calc YY*4*DEPTH

ypos_smc:
	sta	ypos_lookup,X	; ypos_depth_lookup[y][d]=(y*4*d)>>8;

	ldy	TEMPY		; restore YY

	inx
	cpx	#128
	bne	xpos_table_d_loop

	iny
	cpy	#48			; 48 lines (does unneeded work for x)
	bne	xpos_table_x_loop


	;==============================
	; init squares table

	; could save 5 bytes at expense of slowdown by putting
	; this in the previous init loop

	ldx	#0
square_loop:
	txa
	jsr	mul8			; mul A*X, high byte result in A
	sta	squares_lookup,X	; squares_lookup[X]=(square)>>8

	inx
	bne	square_loop

	;============================
	;============================
	; start drawing loop
	;============================
	;============================

;	ldx	#0
	stx	FRAME
	stx	DESTL
	stx	SRCL

next_frame:
	lda	#0		; start with YPOS=0
	sta	YPOS
	sta	PIXEL		; needs reset each frame
yloop:

	lda	YPOS		; setup YPOS lookup pointer
	clc
	adc	#>ypos_lookup
	sta	yp_smc+2

	lda	#0
	sta	XPOS		; start with XPOS=0

xloop:
	sta	XPOS6		; XPOS*6 is in A here, both paths
	ldx	#14		; start Depth at 14

	lda	XPOS		; setup XPOS lookup pointer
	clc
	adc	#>xpos_lookup
	sta	xp_smc+2

	inc	PIXEL		; pixel count for PRNG

depth_loop:

	;========================
	; XP=(X*6)-DEPTH
	;	curve X by depth
	;=========================

	txa			; DEPTH in A
	eor	#$FF
	sec			; two's complement (-DEPTH in A)
	adc	XPOS6		; add to XPOS6

				; if carry set means not negative
				; and draw path
				; otherwise we draw the sky
	bcs	draw_path


	;========================
	; draw the sky
	;========================
draw_sky:

	; fake random number to draw stars

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
	; calc (XPOS*6-DEPTH)*DEPTH and get high byte
	;	same as (XPOS*6*DEPTH)-(DEPTH*DEPTH)h

xp_smc:
	lda	xpos_lookup,X	; XPOS
	sec
	sbc	squares_lookup,X

	; A now (XPOS*6*DEPTH - DEPTH*DEPTH)>>8

	;===================================
	; calc Q= ((XP*DEPTH) | (YPH))>>8
	;	for texture pattern

yp_smc:
	ora	ypos_lookup,X	; YPH = YPOS*4*DEPTH

	; A now XPH|YPH

	sta	Q		; Q=(XP*DEPTH)/256 | YP/256

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

yloop_done:

	;===================
	; end of frame
end_of_frame:
					; FIXME: this draws an extra frame

	lda	FRAME			; if 32, done pre-calc
	cmp	#32
	beq	done_precalc

	ldy	#2			; copy from screen to off-screen
	jsr     copy_1k			; save image off-screen
					; also increments frame
					; will always be non-zero here?

;	bne	next_frame

	jmp	next_frame
done_precalc:

	ldy	#0			; copy from off-screen to screen
	jsr	copy_1k			; also increments frame

	jmp	done_precalc



color_lookup:
sky_colors:
; 2=blue 1=magenta 3=purple 9=orange d=yellow c=l.green
.byte $22,$33,$11,$99,$DD,$CC, $FF, $00
; wall colors, offset 8 from start
.byte $00,$55,$AA,$55,$77,$EE,$FF,$FF




	;===========================
	;===========================
	; copy 1k
	;	if Y=2, copies from $400 -> FRAME*4+frame_offset
	;	if Y=0, copies from FRAME*4+frame_offset -> $400
	;===========================
	;===========================

copy_1k:
	ldx	#4			; copy 4 pages (1k)
	stx	SRCH
	stx	DESTH			; overwrite both just in case

	lda	FRAME			; 0->$10, 1->$14, 2->$18
	and	#$1F
	sta	FRAME

	asl
	asl
	adc	#>frame_location	; start location
	sta	SRCH,Y			; 0 or 2 for src or dest

	ldy	#0			; start at 0
c1k_loop:

	lda	(SRCL),Y		; load src
	sta	(DESTL),Y		; store to destination
	iny				; increment pointer
	bne	c1k_loop		; continue until 256 bytes

	inc	SRCH			; increment src page
	inc	DESTH			; increment dest_page

	dex				; go for required number of pages
	bne	c1k_loop

	inc	FRAME			; doesn't belong here, saves room

	rts				; return
	inc	FRAME

	jmp	next_frame


; Russian Peasant multiply by Thwaite
; https://www.nesdev.org/wiki/8-bit_Multiply
;
; Multiplies two 8-bit factors to produce a 16-bit product
; in about 153 cycles.
; @param A one factor
; @param X another factor
; @return high 8 bits in A; low 8 bits in PRODLO
;         Y and FACTOR2 are trashed; X is untouched

mul8:
	; Factor 1 is stored in the lower bits of prodlo; the low byte of
	; the product is stored in the upper bits.

	lsr			; prime the carry bit for the loop
	sta	PRODLO
	stx	FACTOR2
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

