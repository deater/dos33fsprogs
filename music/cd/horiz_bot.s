; horizontal star wipe

; initial code = 164 bytes
; 163 bytes = jmp to bra
; 158 bytes = cleanup initialization
; 156 bytes = BIT trick
; 154 bytes = set offsets properly
; 151 bytes = redo init
; 145 bytes = leave OFFSET_POINTER in X
; 136 bytes = get rid of end offsets

GBASL		= $26
GBASH		= $27
BASL		= $28
BASH		= $29

OFFSET_POINTER	= $FE
LINE		= $FF

SET_GR		=	$C050
SET_TEXT	=	$C051
FULLGR		=	$C052
TEXTGR		=	$C053
PAGE1		=	$C054
PAGE2		=	$C055
LORES		=	$C056	; Enable LORES graphics
HIRES		=	$C057	; Enable HIRES graphics

HGR2	= $F3D8
SETTXT	= $FB36
SETGR	= $FB40

BASCALC	= $FBC1			; Y-Coord in A, address in BASL/H,  X,Y preserved
WAIT	= $FCA8			;; delay 1/2(26+27A+5A^2) us


	;================================
	; Clear screen and setup graphics
	;================================
horiz:

	jsr	SETGR		; set lo-res 40x40 mode, PAGE1
	bit	FULLGR		; show full screen

	lda	#3		; count down from 3 to 0 each subline
	sta	LINE

forever_loop:

	lda	#$0
	tax			; X = OFFSET_POINTER into length pointers
				; A = screen line, 0..24
big_loop:

	pha			; save screen line on stack

	jsr	BASCALC		; calculate address of line in BASL/BASH

	ldy	#39		; draw 40 pixels on screen
hlin:
	tya

	; if signed (y>offset) && (y<endoffset) draw
	; if signed (y<=offset) || (y>endoffset) don't draw

	clc
	sbc	offsets,X
	bvs	gurg
	eor	#$80
gurg:
	bpl	skip_pixel		; neg if A<=offset

	tya
	clc
	sbc	offsets,X
	sbc	#30
	bvs	gurg2
	eor	#$80
gurg2:
	bmi	skip_pixel	; neg if A<=endoffset

color_smc:
	lda	#$3b
	.byte	$2c		; bit trick, skips next two bytes
skip_pixel:
	lda	#$0		; color black otherwise
blah:
	sta	(BASL),Y	; write out pixel

	dey			; decrement Xcoord
	bpl	hlin		; loop until done all 40 pixels

	lda	#$bb		; force color to all-pink
	sta	color_smc+1


	;==========================================
	; draw star at beginning of line

	lda	offsets,X	; only draw if on-screen
	bmi	skip_star

	clc			; modify x-coord
	lda	BASL
	adc	offsets,X
	sta	BASL

	ldy	LINE		; which line of bitmap to use

	lda	star_bitmap-1,Y	; get low bit of bitmap into carry

	ldy	#7              ; 8-bits wide

draw_line_loop:
	lsr

	pha

	bcc	its_transparent

	lda	#$ff		; white
	sta	(BASL),Y	; draw on screen
its_transparent:

	pla

	dey
	bpl	draw_line_loop

skip_star:

	; see if new offset (meaning, we've gone three lines)

	dec	LINE
	bne	not3

	;======================
	; new line
	;======================


	lda	#$b3
	sta	color_smc+1		; add shadow to (top?) of line


	dec	offsets,X		; scroll the line length

;	lda	offsets,X
;	and	#$7f
;	sta	offsets,X


	inx				; point to next set of offsets

	lda	#3			; reset line vlue
	sta	LINE

not3:

	;==========================

	pla				; restore line count
	clc
	adc	#1			; increment

	cmp	#24			; see if reached bottom
	bne	big_loop


	; ideally we'd page flip, no room though


	lda	#80		; delay a bit
	jsr	WAIT

	beq	forever_loop




offsets:
	.byte	30,29,31,38,31,34,32,35

;endoffsets:
;	.byte	60,50,61,68,61,64,62,65


; 76543210
;   @
; @@@@@
;  @ @

star_bitmap:
        .byte $50
        .byte $f8
        .byte $20


; for bot

	jmp	horiz
