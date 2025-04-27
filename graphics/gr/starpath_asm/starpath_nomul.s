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
XPOS6   = $F3
PIXEL	= $F4
Q	= $F5
DIFF	= $F6
SQUAREL = $F7
SQUAREH = $F8
SHORTL	= $F7
SHORTH	= $F8




; Lookup Tables


ypos_lookup	= $2000	; ...$4fff	$30 long
xpos_lookup	= $5000 ; ...$77ff 	$28 long
squares_lookup	= $8000

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

	jsr	combined_init

	;===========================
	; modify and do Y table
	; init Y*4*DEPTH table
	; 48*4*128 = 24576 = max

	lda	#>ypos_lookup
	sta	table_change_smc+1

	lda	#$18		; clc
	sta	mul_smc

	jsr	combined_init


.if 0
	;===========================
	; init X*6*DEPTH table

	; 40*6*128 = 30720 max

	ldy	#0	; for(x=0;x<40;x++) {

xpos_table_x_loop:
	lda	#0
	sta	SHORTL	; shortx=0;
	sta	SHORTH

	tya
	sta	DIFF
	asl
	adc	DIFF
	asl
	sta	DIFF	; dadd=x*6;

	tya
	clc
	adc	#>xpos_lookup
	sta	xpos_smc+2

	ldx	#0	; for(d=0;d<128;d++) {
xpos_table_d_loop:

	clc			; short+=diff
	lda	SHORTL
	adc	DIFF
	sta	SHORTL
	lda	#0
	adc	SHORTH
	sta	SHORTH
xpos_smc:
	sta	xpos_lookup,X	; ypos_depth_lookup[y][d]=(y*d)>>8;

	inx
	cpx	#128
	bne	xpos_table_d_loop

	iny
	cpy	#40
	bne	xpos_table_x_loop
.endif




	;==============================
	; init squares table

	lda	#1
	sta	DIFF

	lda	#0
	sta	SQUAREL
	sta	SQUAREH

	; 0, 1, 4, 9, 16, 25, 36
	;  1   3  5  7  9   11

	ldx	#0
square_loop:
	lda	SQUAREH
	sta	squares_lookup,X	; squares_lookup[X]=(square)>>8

	clc				; square+=diff
	lda	SQUAREL
	adc	DIFF
	sta	SQUAREL
	lda	#0
	adc	SQUAREH
	sta	SQUAREH

	inc	DIFF			; diff+=2;
	inc	DIFF

	inx
	cpx	#128
	bne	square_loop

	;============================
	;============================
	; start drawing loop
	;============================
	;============================

	ldx	#0
	stx	FRAME

next_frame:
	lda	#0		; start with YPOS=0
	sta	YPOS
	sta	PIXEL
yloop:

	lda	YPOS
	clc
	adc	#>ypos_lookup
	sta	yp_smc+2

	lda	#0
	sta	XPOS		; start with XPOS=0

xloop:
	sta	XPOS6		; XPOS*6 is in A here, both paths
	ldx	#14		; start Depth at 14

	lda	XPOS
	clc
	adc	#>xpos_lookup
	sta	xp_smc+2

	inc	PIXEL

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
	;	same as (XPOS*6*DEPTH)-(DEPTH*DEPTH)

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

	inc	FRAME

	jmp	next_frame


color_lookup:
sky_colors:
; 2=blue 1=magenta 3=purple 9=orange d=yellow c=l.green
.byte $22,$33,$11,$99,$DD,$CC, $FF, $00
; wall colors, offset 8 from start
.byte $00,$55,$AA,$55,$77,$EE,$FF,$FF






	;   y  0 4  8 12 16 20 24
	; d=0, 0 0  0  0  0  0  0
	; d=1, 0 4  8 12 16 20 24
	; d=2, 0 8 16 24 32 40 48



	;===========================
	; combined init

combined_init:


	ldy	#0	; for(x=0;x<48;x++) {

xpos_table_x_loop:
	lda	#0
	sta	SHORTL	; shortx=0;
	sta	SHORTH

	tya

mul_smc:
	sec
	bcs	mul6

	; multiply by 4
mul4:
	asl
	jmp	mul_common

	; multiply by 6
mul6:
	sta	DIFF
	asl
	adc	DIFF
mul_common:
	asl
	sta	DIFF

	tya
	clc
table_change_smc:
	adc	#>xpos_lookup
	sta	xpos_smc+2

	ldx	#0	; for(d=0;d<128;d++) {
xpos_table_d_loop:

	clc			; short+=diff
	lda	SHORTL
	adc	DIFF
	sta	SHORTL
	lda	#0
	adc	SHORTH
	sta	SHORTH
xpos_smc:
	sta	xpos_lookup,X	; ypos_depth_lookup[y][d]=(y*d)>>8;

	inx
	cpx	#128
	bne	xpos_table_d_loop

	iny
	cpy	#48
	bne	xpos_table_x_loop

	rts

.if 0

	ldy	#0	; for(y=0;y<48;y++) {
ypos_table_y_loop:


	; init Y*4*DEPTH table

	lda	#0
	sta	SHORTYL	; shorty=0;
	sta	SHORTYH

	tya
	asl
	asl
	sta	DIFFY	; dadd=y*4;

	tya
	clc
	adc	#>ypos_lookup
	sta	ypos_smc+2

	ldx	#0	; for(d=0;d<128;d++) {
ypos_table_d_loop:

	clc			; short+=diff
	lda	SHORTL
	adc	DIFF
	sta	SHORTL
	lda	#0
	adc	SHORTH
	sta	SHORTH
ypos_smc:
	sta	ypos_lookup,X	; ypos_depth_lookup[y][d]=(y*d)>>8;

	inx
	cpx	#128
	bne	ypos_table_d_loop

	iny
	cpy	#48
	bne	ypos_table_y_loop

	rts
.endif
