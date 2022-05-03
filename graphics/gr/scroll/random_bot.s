; random scroll bot

; 126 bytes
; 124 bytes (optimize PAGE load)

; *****  *****
; *****  *****
;    **  **                 @@  @@@@@@
;    **  **                 @@  @@
;    **  **             @@@@@@  @@@@@@  @@@@@@
; *****  *****          @@  @@      @@  @@
; *****  *****          @@@@@@  @@@@@@  @@


; by Vince `deater` Weaver

FULLGR		= $C052
PAGE1		= $C054
PAGE2		= $C055
LORES		= $C056		; Enable LORES graphics

PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
GBASCALC	= $F847		; Y in A, put addr in GBASL/GBASH
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

GBASL		= $26
GBASH		= $27

B1		= $FC
B2		= $FD

PAGE		= $FE
LINE		= $FF

pattern1	= $f000		; location  in memory

random:

	jsr	SETGR		; set LORES
	bit	FULLGR		; display FULLSCREEN

	lda	#$0		; reset to beginning
	sta	PAGE

random_loop:

	lda	#8		; lines to count (*3=24)
	sta	LINE

	;============================
	; draw an interleaved line

line_loop:
	ldx	#119

screen_loop:

	txa			 ; extrapolate Y from X
	and	#$7
	tay

pattern_smc:
	lda	pattern1,Y

inner_loop_smc:
	sta	$400,X

	dex
	bpl	screen_loop

	;=================================
	; move to next pattern
	; assume we are in same 256 byte page (so high byte never change)

	jsr	scroll_pattern

	; move to next line

	clc
	lda	inner_loop_smc+1
	adc	#$80
	sta	inner_loop_smc+1	; FIXME just inc if carry set
	bcc	noflo
	inc	inner_loop_smc+2
noflo:

	dec	LINE
	bne	line_loop

	;=======================================
	; done drawing frame
	;=======================================


	;======================
	; draw bitmap

	ldx	#0
boxloop:
	txa
	clc
	adc	#8
	jsr	GBASCALC

	; GBASL is in A at this point

	clc
	adc	#12
	sta	GBASL

	lda	PAGE
	asl
	asl
;	clc
	adc	GBASH
	sta	GBASH

	lda	bitmap,X
	sta	B1
	lda	bitmap2,X
	sta	B2


	ldy	#15
draw_line_loop:

	lda	#$00
	ror	B1
	ror	B2
	bcc	its_black

	lda	#$ff
its_black:
	sta	(GBASL),Y		; partway down screen

	dey
	bpl	draw_line_loop

	inx
	cpx	#8
	bne	boxloop


	;=========================
	; scroll one line

	jsr	scroll_pattern

	; switch page
	lda	PAGE

	tax
	ldy	PAGE1,X		; flip page

	eor	#$1
	sta	PAGE		; is 4 or 8

	; reset page smc

	asl
	asl
;	clc
	adc	#4
	sta	inner_loop_smc+2

	lda	#200
	jsr	WAIT

	; A is 0 after

	beq	random_loop


scroll_pattern:
	clc
	lda	pattern_smc+1
	adc	#8
	and	#$1f
	sta	pattern_smc+1
	rts

;01234567|01234567
;
;   @@@@   @@@@
;     @@   @@
;     @@   @@
;     @@   @@
;   @@@@   @@@@
;
;@@@@@@@@@@@@@@@@
bitmap:
	.byte $FF ;,$FF
	.byte $E1 ;,$87
	.byte $F9 ;,$9F
	.byte $F9 ;,$9F
	.byte $F9 ;,$9F
	.byte $E1 ;,$87
	.byte $FF ;,$FF
	.byte $00 ;,$00

bitmap2:
	.byte $FF
	.byte $87
	.byte $9F
	.byte $9F
	.byte $9F
	.byte $87
	.byte $FF
	.byte $00



; want this at $3F5

	jmp	random






.if 0
	;======================
	; draw box

	ldx	#16
boxloop:
	txa
	jsr	GBASCALC

	lda	PAGE
	asl
	asl
;	clc
	adc	GBASH
	sta	GBASH

color_smc:
	lda	#$FF			; white bar
	ldy	#30
draw_line_loop:
	sta	(GBASL),Y		; partway down screen
	dey
	cpy	#10
	bne	draw_line_loop

	dex
	cpx	#6
	bne	boxloop
.endif
