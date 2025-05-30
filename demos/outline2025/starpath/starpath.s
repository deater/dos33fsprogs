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
;	262 bytes -- ?         cycles -- optimize table generation
;	252 bytes -- ?         cycles -- optimize table generation more
;	323 bytes -- ?         cycles -- add back memory copy code
;	311 bytes -- ?         cycles -- optimize memory copy code
;	337 bytes -- ?         cycles -- add in old multiply routine
;	316 bytes -- ?         cycles -- convert square table to mul
;	313 bytes -- ?         cycles -- convert xpos and ypos tables to mul
;	317 bytes -- ?         cycles -- back to functional completeness
;	312 bytes -- ?         cycles -- make mul8 A*X rather than A*Y
;	294 bytes -- ?         cycles -- combine xpos and ypos table gen
;	289 bytes -- ?         cycles -- use bpl for 0..127 loop
;	283 bytes -- 2,384,780 cycles -- move to zero page
;	277 bytes -- ?         cycles -- hard code xpos/ypos in table gen
;	273 bytes -- ?         cycles -- remove TEMPY
;	268 bytes --           cycles -- stray instructions before copy 1k?
;	268 bytes -- 2,298,542 cycles -- eliminate Q
;	267 bytes --           cycles -- bne instead of jmp
;	265 bytes -- 2,288,961 cycles -- init xpos/ypos ptrs outside loops
;	264 bytes -- 2,201,310 cycles -- remove extraneous SEC
;	264 bytes -- 2,107,401 cycles -- move more ZP vars to innerloop consts
;	262 bytes -- ?         cycles -- optimize color selection
;	256 bytes -- ?         cycles -- inline memory copy
;	259 bytes -- ?         cycles -- HACK! offset xpos by 1 to avoid glitch
;	258 bytes -- ?         cycles -- use Y to save byte in hack
;	255 bytes -- ?         cycles -- calc square table with rest of precalc
;	249 bytes -- ?         cycles -- merge SRC/DST on top of init code
;	255 bytes -- ?         cycles -- have hi-res during initial init
;	261 bytes -- ?         cycles -- add sound effects
;	258 bytes -- ?         cycles -- use HGR at start
;	256 bytes -- ?         cycles -- find another 0 to put DST at

; TODO: page flipping: how many pages?
;	running YPOS backward saves 2 bytes, but is ugly drawing up screen

; ROM routines
PLOT	= $F800		; PLOT AT Y,A (A colors output, Y preserved)
PLOT1	= $F80E		; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
;SETCOL	= $F864		; COLOR=A
SETGR	= $FB40		; init lores graphics page1, clear screen, split text
HGR2	= $F3D8		; destroy $1A/$1B/$1C/$E6
HGR	= $F3E2

; softswitches
SET_GR	= $C050		; enable graphics mode
FULLGR	= $C052		; enable full-screen (no-split text) graphics
LORES	= $C056		; Enable LORES graphics
HIRES	= $C057		; Enable HIRES graphics

; zero page addresses
COLOR	= $30		; color used by PLOT routines

;SRCL	= $5A
;SRCH	= $5B
;DESTL	= $5C
;DESTH	= $5D
FACTOR2	= $5A
PRODLO	= $5B

; Lookup Tables

xpos_lookup	= $1000	; ...$3fff	$30 long
ypos_lookup	= $1080	; ...$3fff	(offset in top half)
squares_lookup	= $f00

; stored frames, 32 of them so 32k ($80)
frame_location	= $4000 ; ... $c000

; run from zeropage

.zeropage
.globalzp xp_smc
.globalzp yp_smc
.globalzp pixel_smc
.globalzp ypos_lu_smc
.globalzp xpos_lu_smc
.globalzp tempy
.globalzp qsmc
.globalzp frame_smc
.globalzp xpos6_smc
.globalzp ypos_smc
.globalzp xpos_smc
.globalzp srcdest

	;=============================
	;=============================
	; star path
	;=============================
	;=============================

starpath:
	;=============================
	; setup graphics
	;=============================

	jsr	HGR			; set hi-res for visuals during
					; table pre-calc

					; destroys $E6
					; it stores $20 so we manipulate
					;    load address so it over-writes
					;    a JSR ($20) instruction

	bit	FULLGR			; full-screen graphics


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

				; count 47 down to 0 for(x=0;x<48;x++) {
				; does minor extra work for XX case (40)
				; we actually optimized this away
				; and don't need to set in advance anymore
xpos_table_x_loop:

	; decrement page (high address byte) of both tables

	dec	xpos_lu_smc+2
	dec	ypos_lu_smc+2

srcdest:
	ldx	#0		; for(d=0;d<128;d++) {

SRCL	= srcdest+1		; use this later as SRCL/SRCH but with
SRCH	= srcdest+2		; 0 set already so we don't have to

xpos_table_d_loop:

	; calculate XX*6*DEPTH

	ldy	tempy+1		; tempy1+1 location holds XX

	iny			; HACK HACK HACK
	tya			; offset by 1 avoids glitch in output
				; at right edge of sky

	asl
	adc	tempy+1		; A is now XX*3
	asl			; A is now XX*6

				; calculate XX*6*DEPTH
	jsr	mul8		; A*X -> high in A

	; xpos_depth_lookup[y][d]=(x*6*d)>>8;
xpos_lu_smc:
	sta	xpos_lookup+(48<<8),X


	; calculate YY*4*DEPTH

tempy:
	lda	#47		; get YY (XX/YY actually stored here)
	asl
	asl			; A is YY*4

	jsr	mul8		; mul X*A, high byte of result in A
				; calc YY*4*DEPTH

	; ypos_depth_lookup[y][d]=(y*4*d)>>8;
ypos_lu_smc:
	sta	ypos_lookup+(48<<8),X

	;==============================
	; init squares table
	;	this slows down precalc a decent amount because
	;	it does it 48 times
	;	but it saves 5 bytes

	txa
	jsr	mul8			; mul A*X, high byte result in A
dest_smc:
	sta	squares_lookup,X	; squares_lookup[X]=(square)>>8

	; this is $9D $00 $0F

DESTL	= dest_smc+1			; as before, use the existing 0
DESTH	= dest_smc+2			; later when precalc done

	;===================

	inx
	bpl	xpos_table_d_loop	; run until 128

	dec	tempy+1			; countdown YY to 0
	bpl	xpos_table_x_loop

	;============================
	;============================
	; setup drawing loop
	;============================
	;============================

	;=======================================
	; switch to LORES for drawing frames

	bit	LORES

	;============================
	;============================
	; main drawing loop
	;============================
	;============================

next_frame:
;	lda	#47

	lda	#0		; start with YPOS=0
	sta	pixel_smc+1	; needs reset each frame
	sta	ypos_smc+1

;	lda	#(>ypos_lookup)+47	; reset ypos lookup high byte
	lda	#(>ypos_lookup)		; reset ypos lookup high byte
	sta	yp_smc+2

	;========================
yloop:
	lda	#>xpos_lookup	; reset xpos lookup high byte
	sta	xp_smc+2

	lda	#0
	sta	xpos_smc+1	; start with XPOS=0/XPOS6=0

	;========================
xloop:
	sta	xpos6_smc+1	; XPOS*6 is in A here, both paths
	ldx	#14		; start Depth at 14

	;========================
depth_loop:

	;========================
	; XP=(X*6)-DEPTH
	;	curve X by depth
	;=========================

	txa			; DEPTH in A
	eor	#$FF
	sec			; two's complement (-DEPTH in A)
xpos6_smc:			; XPOS6
	adc	#0		; add to XPOS6

				; if carry set means not negative
				; and draw path
				; otherwise we draw the sky
	bcs	draw_path


	;========================
	; draw the sky
	;========================
draw_sky:

	; fake random number to draw stars

pixel_smc:
	ldy	$F500		; PRNG from ROM code

	;==============
	; see if star

	lda	#$FF		; set color to white
	cpy	#4		; if random value<4 then draw star

	bcc	plot_pixel_exact_color

	;==============
	; not star, sky

	; convert from -> 0..47 ->  0..11
	; would prefer -> 0..47 ->  4..15

	; carry set here.  could add 7 but space savings would cancel

	lda	ypos_smc+1	; Color offset=YPOS/8
				; plot pixel shifts one more time
	lsr
	lsr

	jmp	plot_pixel	; plot pixel does an LSR/TAY

	;====================
	; draw path
	;====================

draw_path:
	;=================================
	; calc (XPOS*6-DEPTH)*DEPTH and get high byte
	;	same as (XPOS*6*DEPTH)-(DEPTH*DEPTH)

	; carry always set here (we came here with BCS)

xp_smc:
	lda	xpos_lookup,X		; XPOS
	sbc	squares_lookup,X

	; A now (XPOS*6*DEPTH - DEPTH*DEPTH)>>8

	;===================================
	; calc Q= ((XP*DEPTH) | (YPH))>>8
	;	for texture pattern

yp_smc:
	ora	ypos_lookup,X		; YPH = YPOS*4*DEPTH

	; A now XPH|YPH

	sta	qsmc+1		; Q=(XP*DEPTH)/256 | YP/256

	;==============================
	; calc C = Q & (Depth + Frame)
	; 	mask geometry by time shifted depth

	clc
	txa			; depth in X
frame_smc:			; FRAME
	adc	#0		; add depth plus frame  D+F

qsmc:
	and	#0		; Color Offset = Q & (D+FRAME)

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
	lda	color_lookup,Y		; Lookup in color table

	;=====================
	; set color
plot_pixel_exact_color:
	sta	COLOR			; if color top/bottom don't need SETCOL

	;=====================
	; plot point

xpos_smc:
	ldy	#0			; XPOS
ypos_smc:
	lda	#0			; YPOS
	jsr	PLOT			; PLOT AT Y,A (Y preserved)

	;===================
	; increment xloop


	inc	xp_smc+2
	inc	pixel_smc+1		; pixel count for PRNG

	inc	xpos_smc+1		; XPOS+=1

	lda	xpos6_smc+1		; XPOS6+=6
	clc
	adc	#6
	cmp	#240
	bne	xloop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; approximate end of zero page

xloop_done:

	;===================
	; increment yloop

	inc	yp_smc+2	; increment page of yp lookup table

	inc	ypos_smc+1
	lda	ypos_smc+1
	cmp	#48
	bne	yloop

;	dec	ypos_smc+1
;	bpl	yloop

yloop_done:

	;===================
	; end of frame
end_of_frame:


	ldy	#(DESTL-SRCL)			; copy from graphics to frames


	; enter here when pre-calcing with Y=DEST-SRC offset
	; also enters here when replaying with Y=0
copy_next_frame:

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

	lda	frame_smc+1		; get frame val.  Assume always <32

	asl				; 0->$40, 1->$44, 2->$48
	asl
	adc	#>frame_location	; start location
	sta	SRCH,Y			; 0 or 2 for src or dest

	ldy	#0			; start at 0
c1k_loop:

	lda	(SRCL),Y		; load src
	sta	(DESTL),Y		; store to destination

;==================
; sound
;=================
	; 2, 1  = ok
	; $FF (none) not horrible and 2 bytes shorter
	; for 1, lsr/bcc same
	; tried and boring: 5

;	and	#$7
;	beq	nosound

.ifndef QUIET
	lsr
	bcs	nosound

	bit	$C030
.endif

nosound:

;==================
;

	iny				; increment pointer
	bne	c1k_loop		; continue until 256 bytes

	inc	SRCH			; increment src page
	inc	DESTH			; increment dest_page

	dex				; go for required number of pages
	bne	c1k_loop


	;================================
	; point to next frame

	inc	frame_smc+1		; increment frame

	lda	frame_smc+1		; wrap FRAME at 32
	and	#$1F
	sta	frame_smc+1

	beq	done_frame_precalc	; triggered when FRAME%32==0

force_done_smc:
	jmp	next_frame		; gets modified to BIT when done precalc


done_frame_precalc:
	; Y always 0 here

	lda	#$2C			; BIT
	sta	a:force_done_smc	; change JMP to BIT
	bne	copy_next_frame		; bra


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


; plot pixel is called with color C
;	we divide by 2 to limit lookup table size
;
;	for star, we manually set
;	for sky, color is from 0..15 but never higher than 12
;	for wall, colors if from 16...31

color_lookup:

;sky_colors:
; 2=blue 1=magenta 3=purple 9=orange d=yellow c=l.green
.byte $22,$33,$11,$99,$DD,$CC,		$FF, $FF	; last two unused?
;wall_colors:
; wall colors, offset 8 from start
.byte $00,$55,$AA,$55,$77,$EE,$FF,$FF
