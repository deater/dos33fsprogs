;*******************************************************************************
;* Micro-Painter, by Bob Bishop                                                *
;* Copyright 1980 Datasoft, Inc. All Rights Reserved.                          *
;*                                                                             *
;* Disassembly of "PAINT" routines.                                            *
;*******************************************************************************
;* Disassembly by Andy McFadden, using 6502bench SourceGen v1.4.               *
;* Last updated 2019/10/25.                                                    *
;*******************************************************************************

color_black	= 0
color_purple	= 1
color_green	= 2
color_blue	= 3
color_orange	= 4
color_white	= 5

work_buffer	= $7000		; work data area,$ from $7000-7fff


pageflg		= $00
xc		= $01
yc		= $02
back		= $03
evenc		= $04
oddc		= $05
screen_bit	= $06
hptr		= $07
cflag		= $09
match_color	= $10
add_coord_lo	= $12
plot_coord_lo	= $13
add_coord_ptr	= $14	; new coords are added at this point
plot_coord_ptr	= $16	; coords are read from this pointer and plotted
tmp		= $18

HGR2           = $F3D8
HGR            = $F3E2

flood_test:
	jsr	HGR2
	lda	#100
	sta	xc
	sta	yc
	lda	#color_blue
	sta	evenc
	lda	#color_white
	sta	oddc
	jsr	FILL
done:
	jmp	done

.align $100

;*******************************************************************************
;* FILL - flood fill with dither pattern.                                      *
;*                                                                             *
;* Uses a circular buffer at $7000-7fff to hold X/Y coordinates.  The color of *
;* the pixel at the initial X/Y is used as the to-fill color.                  *
;*                                                                             *
;* Start by adding the initial X/Y to the work buffer.  We then loop, removing *
;* the first coordinate from the buffer and testing the color at that location.*
;* If it matches, we draw the pixel, and then add the four adjacent pixels to  *
;* the list.  Repeat until the list is empty.                                  *
;*                                                                             *
;* Warning: filling with the same color, e.g. filling a white area with white,*
;* will likely hang.                                                           *
;*                                                                             *
;* On entry:                                                                   *
;*   $01 - X-coord                                                             *
;*   $02 - Y-coord                                                             *
;*   $04 - even color (0-5)                                                    *
;*   $05 - odd color (0-5)                                                     *
;*                                                                             *
;* Preserves X/Y registers.                                                    *
;*******************************************************************************


FILL:
	txa
	pha
	tya
	pha
	lda	#$80
	sta	back
	jsr	PLT		; get current color at X,Y
	lda	back
	sta	match_color	; this is the color we're replacing
	lda	#<work_buffer
	sta	add_coord_ptr
	sta	plot_coord_ptr
	lda	#>work_buffer
	sta	add_coord_ptr+1
	sta	plot_coord_ptr+1
	lda	xc		; put first point into work buffer
	sta	work_buffer
	lda	yc
	sta	work_buffer+1
	ldy	#$02		; point next output past the X,Y we just added
	sty	add_coord_lo
	ldy	#$00
	sty	plot_coord_lo

	; Get the next candidate coordinate.

FillLoop:
	lda	(plot_coord_ptr),Y
	sta	xc
	iny
	lda	(plot_coord_ptr),Y
	sta	yc
	iny
	bne	L6845			; still on same page, branch
	inc	plot_coord_ptr+1	; move to next page
	lda	plot_coord_ptr+1
	cmp	#$80			;did we reach the end of the buffer?
	bne	L6845			; no, keep going
	lda	#>work_buffer		; yes, reset it
	sta	plot_coord_ptr+1
L6845:
	sty	plot_coord_lo
	lda	#$80
	sta	back
	jsr	PLT			; get screen pixel color
	lda	back
	cmp	match_color		; matching color?
	bne	L6873			; no, don't plot

; The current pixel matches the color we want to replace.  Plot a pixel and add
; the four adjacent pixels to the work list.

	jsr	DITHER		; plot pixel with dither colors
	inc	xc
	jsr	AddCoord	; X+1,Y
	dec	xc
	inc	yc
	jsr	AddCoord	; X,Y+1
	dec	xc
	dec	yc
	jsr	AddCoord	; X-1,Y
	inc	xc
	dec	yc
	jsr	AddCoord	; X-1,Y-1
	inc	yc
L6873:
	ldy	plot_coord_lo	; have we reached the end?
	cpy	add_coord_lo
	bne	FillLoop	; low part differs, continue
	lda	plot_coord_ptr+1
	cmp	add_coord_ptr+1
	bne	FillLoop	; high part differs, continue
	pla			; done!
	tay
	pla
	tax
	rts

AddCoord:
	lda	yc		; check Y-coord
	cmp	#255		; off top of screen?
	beq	L68CA		; yes, ignore
	cmp	#192		; off bottom of screen?
	beq	L68CA		; yes, ignore
	lda	xc		; check X-coord
	cmp	#$ff		; off left of screen?
	beq	L68CA		; yes, ignore
	cmp	#140		; off right of screen?
	beq	L68CA		; yes, ignore

; Looks good, add X,Y to list.
; Note add_coord_ptr is always $xx00; the low byte is in add_coord_lo.

	ldy	add_coord_lo
	sta	(add_coord_ptr),Y
	iny
	lda	yc
	sta	(add_coord_ptr),Y
	iny
	sty	add_coord_lo
	lda	add_coord_ptr+1
	sta	tmp
	cpy	#$00			; did we advance to next page?
	bne	L68B8			; no, continue
	inc	add_coord_ptr+1		; yes, advance
	lda	add_coord_ptr+1
	cmp	#(>work_buffer)+16	; did we reach end of work area?
	bne	L68B8			; no, still good
	lda	#>work_buffer		; yes, wrap around
	sta	add_coord_ptr+1
L68B8:
	cpy	plot_coord_lo		; did we run into the "write" ptr?
	bne	L68CA			; no
	lda	plot_coord_ptr+1	; check the high byte
	cmp	add_coord_ptr+1
	bne	L68CA ;still no
	dec	add_coord_lo		; whoops; back up, discarding what we just added
	dec	add_coord_lo
	lda	tmp			; restore previous high byte
	sta	add_coord_ptr+1
L68CA:
	rts

.align $100

DITHER:
	jmp	DITHER1

PLT:
	jmp	 PLT1		; external entry point


;*******************************************************************************
;* DITHER - plot a point with dithered colors.                                 *
;*                                                                             *
;* On entry:                                                                   *
;*                                                                             *
;*   $00 - hi-res page (zero for page 1, nonzero for page 2)                   *
;*   $01 - X coordinate [0,139]                                                *
;*   $02 - Y coordinate [0,191]                                                *
;*   $04 - even color value                                                    *
;*   $05 - odd color value                                                     *
;*                                                                             *
;* Preserves X/Y registers.                                                    *
;*******************************************************************************
;Clear variables



DITHER1:
	txa
	pha
	lda	yc		; start with the Y-coord
	ldx	evenc		; check the even color
	beq	L691A		; black, use checkerboard
	cpx	#color_white	; white
	beq	L691A		; yes, use checkerboard pattern
	ldx	oddc		; check the odd color
	beq	L691A		; black, use checkerboard
	cpx	#color_white	; white?
	bne	L691C		; yes, use checkerboard
L691A:
	eor	xc		; factor in the X coord to get checkerboard
L691C:
	and	#$01		; only low bit matters
	tax			; X=0 or 1
	lda	evenc,X		; load evenc or oddc
	sta	back		; set as color to draw
	jmp	Plt2

;*******************************************************************************
;* PLT - plot a point and return the current color.                            *
;*                                                                             *
;* On entry:                                                                   *
;*                                                                             *
;*   $00 = hi-res page (zero for page 1, nonzero for page 2)                   *
;*   $01 = X-coord [0,139]                                                     *
;*   $02 = Y-coord [0,191]                                                     *
;*   $03 = $80=no plot, 0-5=color to draw                                      *
;*                                                                             *
;* On exit:                                                                    *
;*   $03 = screen color (0-5) (will be the new color if we're in draw mode)    *
;*                                                                             *
;* Preserves X/Y registers.                                                    *
;*******************************************************************************

PLT1:
	txa
	pha
Plt2:
	tya
	pha
	jsr	SetRowBase	; set $07-08 as hi-res pointer
	ldx	back		; get color
	bmi	L693B		; not drawing, branch
	lda	color_flag_0,X	; get color flags for the two bits
	sta	cflag
	lda	color_flag_1,X
	sta	cflag+1
L693B:
	ldx	xc
	ldy	div7_tab,X	; get byte offset
	lda	bit_tab,X	; get bit offset (low bit of pair)
	sta	screen_bit

; We want to read/write two hi-res bits, so we loop through here twice.

	ldx	#$00		; first bit
BitLoop:
	lda	screen_bit
	bit	back		; are we writing?
	bpl	PlotWrite	; yes, branch

; Just reading the screen.

	and	(hptr),Y	; test screen bit
	beq	BitLoopBottom	; not set
	txa			; 0 or 1
	sec			; will add +1 or +2
	adc	back		; so this sets bit 0 or bit 1
	sta	back
	lda	(hptr),Y	; check hi bit
	bpl	BitLoopBottom	; not set, branch
	lda	back		; set bit 2 if the hi-res pixel's high bit was set
	ora	#$04
	sta	back
	bne	BitLoopBottom


; Draw the pixel.

PlotWrite:
	eor	#$ff		; reverse screen bit to form mask
	and	(hptr),Y	; AND with screen data
	sta	(hptr),Y	; store, clearing previous value at that bit
	lda	cflag,X		; get color flag 0 or 1
	beq	BitLoopBottom	; zero, don't need to set pixel or high bit
	lda	screen_bit	; nonzero, set the appropriate bit in the pixel
	ora	(hptr),Y
	sta	(hptr),Y
	lda	cflag		; is it black or white?
	cmp	cflag+1		; (want black/white to match hi bit of adjacent color)
	beq	BitLoopBottom	; yes, leave high bit alone
	lda	(hptr),Y	; not black or white, so we need to set high bit
	and	#$7f		; clear whatever's there now
	sta	(hptr),Y
	lda	cflag,X		; get high bit from color flag
	and	#$80
	ora	(hptr),Y
	sta	(hptr),Y	; set that on the screen
BitLoopBottom:
	inx
	cpx	#$02		; have we done it twice?
	beq	BitLoopDone	; yes, bail
	asl	screen_bit	; no, shift screen bit to next position
	bpl	BitLoop		; didn't shift into high bit, loop
	iny			; shifted into high bit, move on to next byte
	lda	#$01		; and reset bit to low bit
	sta	screen_bit
	bne	BitLoop		; (always)

BitLoopDone:
	lda	back		; were we writing?
	bpl	L69A3		; yes, bail
	and	#$07		; no, do a color lookup
	tax
	lda	bits_to_color,X	; convert 00000HBA to 0-5
	sta	back
L69A3:
	pla
	tay
	pla
	tax
	rts

;
; Sets $07-08 as the hi-res base pointer for the row in "yc".
;

SetRowBase:
	ldy	yc
	lda	ytable_lo,Y
	sta	hptr
	lda	pageflg		; 0 for page 1, nonzero for page 2
	beq	L69D2
	lda	#$60		; configure for page 2
L69D2:
	eor	ytable_hi,Y
	sta	hptr+1
	rts

; These bytes have three possible values.  They're used by PLT to figure out
; which bits to set on the hi-res screen for a given color (0-5).
;
;  $00 = don't set this bit
;  $7f = set this bit, clear high bit of byte
;  $ff = set this bit, set high bit of byte
;
; Each hi-res color (in our 140x192 screen) requires two bits per pixel.  One
; bit comes from each table.

color_flag_0:
	.byte $00,$7f,$00,$ff,$00,$ff

color_flag_1:
	.byte $00,$00,$7f,$00,$ff,$ff

;
; Converts a bit pattern to a color, 0-5.
;
; Index is a 3-bit value 00000HBA, where A is set if the first bit of the hi-res
; pixel was set, B is set if the second bit of the hi-res pixel was set, and H
; is set if the high bit of at least one of the bytes with a pixel was set. 
; (Remember that we're treating the screen as being 140 pixels across, so it's
; two bits per pixel.)

bits_to_color:
	.byte color_black
	.byte color_purple
	.byte color_green
	.byte color_white
	.byte color_black
	.byte color_blue
	.byte color_orange
	.byte color_white

.align $100

; Hi-res row base address, low byte.
ytable_lo:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$80,$80,$80,$80,$80,$80,$80,$80
.byte $00,$00,$00,$00,$00,$00,$00,$00,$80,$80,$80,$80,$80,$80,$80,$80
.byte $00,$00,$00,$00,$00,$00,$00,$00,$80,$80,$80,$80,$80,$80,$80,$80
.byte $00,$00,$00,$00,$00,$00,$00,$00,$80,$80,$80,$80,$80,$80,$80,$80
.byte $28,$28,$28,$28,$28,$28,$28,$28,$a8,$a8,$a8,$a8,$a8,$a8,$a8,$a8
.byte $28,$28,$28,$28,$28,$28,$28,$28,$a8,$a8,$a8,$a8,$a8,$a8,$a8,$a8
.byte $28,$28,$28,$28,$28,$28,$28,$28,$a8,$a8,$a8,$a8,$a8,$a8,$a8,$a8
.byte $28,$28,$28,$28,$28,$28,$28,$28,$a8,$a8,$a8,$a8,$a8,$a8,$a8,$a8
.byte $50,$50,$50,$50,$50,$50,$50,$50,$d0,$d0,$d0,$d0,$d0,$d0,$d0,$d0
.byte $50,$50,$50,$50,$50,$50,$50,$50,$d0,$d0,$d0,$d0,$d0,$d0,$d0,$d0
.byte $50,$50,$50,$50,$50,$50,$50,$50,$d0,$d0,$d0,$d0,$d0,$d0,$d0,$d0
.byte $50,$50,$50,$50,$50,$50,$50,$50,$d0,$d0,$d0,$d0,$d0,$d0,$d0,$d0


.align $100

; Hi-res row base address, high byte.

ytable_hi:
.byte $20,$24,$28,$2c,$30,$34,$38,$3c,$20,$24,$28,$2c,$30,$34,$38,$3c
.byte $21,$25,$29,$2d,$31,$35,$39,$3d,$21,$25,$29,$2d,$31,$35,$39,$3d
.byte $22,$26,$2a,$2e,$32,$36,$3a,$3e,$22,$26,$2a,$2e,$32,$36,$3a,$3e
.byte $23,$27,$2b,$2f,$33,$37,$3b,$3f,$23,$27,$2b,$2f,$33,$37,$3b,$3f
.byte $20,$24,$28,$2c,$30,$34,$38,$3c,$20,$24,$28,$2c,$30,$34,$38,$3c
.byte $21,$25,$29,$2d,$31,$35,$39,$3d,$21,$25,$29,$2d,$31,$35,$39,$3d
.byte $22,$26,$2a,$2e,$32,$36,$3a,$3e,$22,$26,$2a,$2e,$32,$36,$3a,$3e
.byte $23,$27,$2b,$2f,$33,$37,$3b,$3f,$23,$27,$2b,$2f,$33,$37,$3b,$3f
.byte $20,$24,$28,$2c,$30,$34,$38,$3c,$20,$24,$28,$2c,$30,$34,$38,$3c
.byte $21,$25,$29,$2d,$31,$35,$39,$3d,$21,$25,$29,$2d,$31,$35,$39,$3d
.byte $22,$26,$2a,$2e,$32,$36,$3a,$3e,$22,$26,$2a,$2e,$32,$36,$3a,$3e
.byte $23,$27,$2b,$2f,$33,$37,$3b,$3f,$23,$27,$2b,$2f,$33,$37,$3b,$3f

.align $100

; Maps X coordinate [0,139] to bit.

bit_tab:
.byte $01,$04,$10,$40,$02,$08,$20,$01,$04,$10,$40,$02,$08,$20,$01,$04
.byte $10,$40,$02,$08,$20,$01,$04,$10,$40,$02,$08,$20,$01,$04,$10,$40
.byte $02,$08,$20,$01,$04,$10,$40,$02,$08,$20,$01,$04,$10,$40,$02,$08
.byte $20,$01,$04,$10,$40,$02,$08,$20,$01,$04,$10,$40,$02,$08,$20,$01
.byte $04,$10,$40,$02,$08,$20,$01,$04,$10,$40,$02,$08,$20,$01,$04,$10
.byte $40,$02,$08,$20,$01,$04,$10,$40,$02,$08,$20,$01,$04,$10,$40,$02
.byte $08,$20,$01,$04,$10,$40,$02,$08,$20,$01,$04,$10,$40,$02,$08,$20
.byte $01,$04,$10,$40,$02,$08,$20,$01,$04,$10,$40,$02,$08,$20,$01,$04
.byte $10,$40,$02,$08,$20,$01,$04,$10,$40,$02,$08,$20

.align $100

; Maps X coordinate [0,$139] to byte [0,$39].

div7_tab:
.byte $00,$00,$00,$00,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$04,$04
.byte $04,$04,$05,$05,$05,$06,$06,$06,$06,$07,$07,$07,$08,$08,$08,$08
.byte $09,$09,$09,$0a,$0a,$0a,$0a,$0b,$0b,$0b,$0c,$0c,$0c,$0c,$0d,$0d
.byte $0d,$0e,$0e,$0e,$0e,$0f,$0f,$0f,$10,$10,$10,$10,$11,$11,$11,$12
.byte $12,$12,$12,$13,$13,$13,$14,$14,$14,$14,$15,$15,$15,$16,$16,$16
.byte $16,$17,$17,$17,$18,$18,$18,$18,$19,$19,$19,$1a,$1a,$1a,$1a,$1b
.byte $1b,$1b,$1c,$1c,$1c,$1c,$1d,$1d,$1d,$1e,$1e,$1e,$1e,$1f,$1f,$1f
.byte $20,$20,$20,$20,$21,$21,$21,$22,$22,$22,$22,$23,$23,$23,$24,$24
.byte $24,$24,$25,$25,$25,$26,$26,$26,$26,$27,$27,$27

