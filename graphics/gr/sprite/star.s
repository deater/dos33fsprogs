; bouncing star

; by Vince `deater` Weaver

; 135 -- original
; 122 -- clear screen w/o consideration of screen holes
; 121 -- try to optimize the rotate in the sprite
; 119 -- draw transparent

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
YPOS		= $76

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

	; A should be 0 here
main_loop:
	sta	PAGE	; save PAGE value (PAGE in A here)

	asl		; make OUTH $4 or $8 depending on value in PAGE
			; which we have in A above or at end of loop
	asl		; C is 0
	adc	#4

	sta	OUTH

	lda	#100
	jsr	WAIT

	inc	FRAME

	;=================================
	; clear lo-res screen, page1/page2
	;=================================
	; proper with avoiding screen holes is ~25 instructions

	ldx	#4
full_loop:
	ldy	#$00
inner_loop:
	lda	#$55		; color
	sta	(OUTL),Y
	dey
	bne	inner_loop

	inc	OUTH
	dex
	bne	full_loop


	;======================
	; draw 8x8 bitmap
	;======================

	lda	FRAME
	and	#$7
	tax
	lda	bounce,X
	sta	YPOS

	ldx	#7
boxloop:
	txa
	clc
	adc	YPOS
	jsr	GBASCALC		; calc address of X
					; note we center to middle of screen
					; by noting the middle 8 lines
					; are offset by $28 from first 8 lines

	; GBASL is in A at this point

	clc
	adc	#16
	sta	GBASL		; center x-coord

	; adjust for proper page

	lda	PAGE		; want to add 0 or 4 (not 0 or 1)
	asl
	asl			; this sets C to 0
	adc	GBASH
	sta	GBASH

	ldy	#7
	lda	bitmap,X	; get low bit of bitmap into carry
draw_line_loop:
	lsr

	pha

	bcc	its_transparent

	lda	#$dd		; yellow
	sta	(GBASL),Y	; draw on screen
its_transparent:

	pla

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

bounce:
	.byte 10,11,12,13,13,12,11,10
