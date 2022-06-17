; horizontal star wipe

; initial code = 164 bytes

GBASL	= $26
GBASH	= $27
BASL	= $28
BASH	= $29

OFFSET_POINTER	= $FE
LINE	= $FF


SET_GR		=	$C050
SET_TEXT	=	$C051
FULLGR		=	$C052
TEXTGR		=	$C053
PAGE0		=	$C054
PAGE1		=	$C055
LORES		=	$C056	; Enable LORES graphics
HIRES		=	$C057	; Enable HIRES graphics

PLOT	= $F800			;; PLOT AT Y,A
PLOT1	= $F80E			;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
HLINE	= $F819			;; HLINE Y,$2C at A
VLINE	= $F828			;; VLINE A,$2D at Y
CLRSCR	= $F832			;; Clear low-res screen
CLRTOP	= $F836			;; clear only top of low-res screen
GBASCALC= $F847			;; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)
SETCOL	= $F864			;; COLOR=A

SETTXT	= $FB36
SETGR	= $FB40

BASCALC	= $FBC1			; Y-Coord in A, address in BASL/H,  X,Y preserved
WAIT	= $FCA8			;; delay 1/2(26+27A+5A^2) us


	;================================
	; Clear screen and setup graphics
	;================================
horiz:

	jsr	SETGR		; set lo-res 40x40 mode
	bit	SET_GR
	bit	FULLGR		; make it 40x48

	lda	#3
	sta	LINE
	lda	#0
	sta	OFFSET_POINTER

forever_loop:

	lda	#$0
	sta	OFFSET_POINTER

	ldx	#0
big_loop:

	txa
	pha
	jsr	BASCALC

	ldy	#39
	ldx	OFFSET_POINTER
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
	sbc	endoffsets,X
	bvs	gurg2
	eor	#$80
gurg2:
	bmi	skip_pixel		; neg if A<=endoffset

color_smc:
	lda	#$3b
	jmp	blah	; TODO: USE BIT TRICK
skip_pixel:
	lda	#$0			;
blah:
	sta	(BASL),Y
	dey
	bpl	hlin

	lda	#$bb
	sta	color_smc+1


	;==========================================
	; draw star at beginning of line

	lda	offsets,X
	bmi	skip_star

	clc
	lda	BASL
	adc	offsets,X
	sta	BASL

	ldx	LINE

	ldy	#7              ; 8-bits wide
	lda	star_bitmap-1,X	; get low bit of bitmap into carry
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

	; see if new line

	ldx	OFFSET_POINTER

	dec	LINE
	bne	not3

	lda	#$b3
	sta	color_smc+1

	dec	offsets,X
	dec	endoffsets,X

	inc	OFFSET_POINTER
	lda	#3
	sta	LINE

not3:

	;==========================

	pla
	tax

	inx
	cpx	#24
	bne	big_loop


	; set/flip pages
	; we want to flip pages and then draw to the offscreen one

;flip_pages:
;	ldx	#0		; x already 0
;	lda	draw_page_smc+1	; DRAW_PAGE
;;	beq	done_page
;	inx
;done_page:
;	ldy	PAGE0,X		; set display page to PAGE1 or PAGE2
;	eor	#$4		; flip draw page between $400/$800
;	sta	draw_page_smc+1 ; DRAW_PAGE


	lda	#80
	jsr	WAIT

	jmp	forever_loop


offsets:
	.byte	5,4,3,2,1,2,3,4,5

endoffsets:
	.byte	30,20,10,20,30,40,50,12

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
