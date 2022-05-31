; star

; by Vince `deater` Weaver

SPEAKER		= $C030
SET_GR		= $C050
SET_TEXT	= $C051
FULLGR		= $C052
PAGE1		= $C054
PAGE2		= $C055
LORES		= $C056		; Enable LORES graphics

HGR2		= $F3D8
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
GBASCALC	= $F847		; Y in A, put addr in GBASL/GBASH
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

GBASL		= $26
GBASH		= $27

OUTL		= $74
OUTH		= $75

FRAME		= $6D
PAGE		= $6E
LINE		= $6F

pattern1	= $d000		; location  in memory

;.zeropage
;.globalzp	pattern_smc


star:

	jsr	SETGR		; set LORES

	lda	#0
	sta	OUTL

	bit	FULLGR		; set FULL 48x40

main_loop:
	sta	PAGE		; start at page 1

	asl		; make OUTH $4 or $8 depending on value in PAGE
			; which we have in A above or at end of loop
	asl		; C is 0
	adc	#4

	sta	OUTH

	lda	#100
	jsr	WAIT

	inc	FRAME

	;============================
	; clear screen
	;============================
full_loop:
	ldx	#3

line_loop:
	ldy	#119

screen_loop:

	tya			; extrapolate X from Y

	lda	#$44

;inner_loop_smc:

	sta	(OUTL),Y

	dey
	bpl	screen_loop

	; move to next line by adding $80
	;  we save a byte by using EOR instead

	lda	OUTL
	eor	#$80			; add $80
	sta	OUTL

	bne	line_loop

	; we overflowed, so increment OUTH

	inc	OUTH

	dex
	bpl	line_loop

	;============================
	; end clear screen
	;============================


done_bg:


	;======================
	; draw 8x8 bitmap
	;======================

	ldx	#7
boxloop:
	txa
	jsr	GBASCALC		; calc address of X
					; note we center to middle of screen
					; by noting the middle 8 lines
					; are offset by $28 from first 8 lines

	; GBASL is in A at this point

	clc
	adc	#12+$28
	sta	GBASL		; center x-coord and y-coord at same time


	lda	PAGE		; want to add 0 or 4 (not 0 or 1)
	asl
	asl			; this sets C to 0
	adc	GBASH
	sta	GBASH


	ldy	#7
draw_line_loop:

	lda	bitmap,X	; get low bit of bitmap2 into carry
	lsr

	lda	#$00		; black is default color

	ror	bitmap,X	; 16-bit rotate (in memory)

	bcc	its_black

	lda	#$dd		; yellow
its_black:
	sta	(GBASL),Y		; partway down screen

	dey
	bpl	draw_line_loop

	dex
	bpl	boxloop

	;======================
	; switch page
	;======================

	lda	PAGE

	tax
	ldy	PAGE1,X			; flip page

	eor	#$1

	bpl	main_loop		; bra


; star bitmap

;012|456|
;   @     ;
;   @@    ;
;   @@@@@ ;
;@@@@@@@  ;
; @@@@@   ;
;  @@@@@  ;
; @@  @@  ;
;@@    @@ ;

bitmap:
	.byte $10
	.byte $18
	.byte $1f
	.byte $fe
	.byte $7c
	.byte $3e
	.byte $66
	.byte $C3

