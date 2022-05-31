; bouncing stars

; by Vince `deater` Weaver

; 119 bytes -- single star original
; 143 bytes -- three stars
; 141 bytes -- optimize init
; 140 bytes -- 0 is already in X
; 143 bytes -- stars move independently
; 140 bytes -- optimize XPOS in multiple calls to draw_stars

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
XPOS		= $77

FRAME		= $6D
PAGE		= $6E
LINE		= $6F

;.zeropage
;.globalzp	pattern_smc


stars:
	jsr	HGR2		; sets graphics/full-screen/hires/PAGE2
				; sets A and Y to 0

	bit	LORES		; switch to lo-res mode

	sta	OUTL		; store 0 to OUTL

	; A should be 0 here
main_loop:
	sta	PAGE	; save PAGE value (PAGE in A here)

	asl		; make OUTH $4 or $8 depending on value in PAGE
			; which we have in A above or at end of loop
	asl		; C is 0
	adc	#4

	sta	OUTH

	lda	#100	; pause a bit
	jsr	WAIT

	inc	FRAME	; increment frame #

	;=================================
	; clear lo-res screen, page1/page2
	;=================================
	; proper with avoiding screen holes is ~25 instructions

	ldx	#4		; lores is 1k, so 4 pages
full_loop:
	ldy	#$00		; clear whole page
	lda	#$55		; color
inner_loop:
	sta	(OUTL),Y
	dey
	bne	inner_loop

	inc	OUTH		; point to next page
	dex
	bne	full_loop


	;====================
	; draw the stars
	;====================

	txa			; X is zero here
;	lda	#0
;	sta	XPOS

	jsr	draw_star
	jsr	draw_star
	jsr	draw_star

	;======================
	; flip page
	;======================

	lda	PAGE

	tax
	ldy	PAGE1,X			; flip page

	eor	#$1			; invert (leaving in A)

	bpl	main_loop		; bra




	;======================
	; draw 8x8 bitmap star
	;======================
	; A is XPOS on entry
draw_star:

	; calculate YPOS
	sta	XPOS

;	lda	XPOS
	lsr			; make middle star offset+4 from others
	lsr

	adc	FRAME
	and	#$7
	tax
	lda	bounce,X
	sta	YPOS


	ldx	#7		; draw 7 lines
boxloop:
	txa
	clc
	adc	YPOS
	jsr	GBASCALC	; calc address of line in X (Y-coord)


	; GBASL is in A at this point

	clc
	adc	XPOS		; adjust to X-coord
	sta	GBASL

	; adjust for proper page

	lda	PAGE		; want to add 0 or 4 (not 0 or 1)
	asl
	asl			; this sets C to 0
	adc	GBASH
	sta	GBASH

	;=================
	; draw line


	ldy	#7		; 8-bits wide
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

	lda	XPOS
	clc
	adc	#16
;	sta	XPOS

	rts


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

	; for apple II bot

	jmp	stars
