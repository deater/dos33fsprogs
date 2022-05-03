; random scroll

; 125 bytes


; *****  *****
;    **  **
;    **  **
;    **  **
;    **  **
;    **  **
; *****  *****


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
PAGE		= $FE
LINE		= $FF

diamond:

	jsr	SETGR
	bit	FULLGR

	lda	#$4		; reset to beginning
	sta	PAGE

diamond_loop:

	lda	PAGE		; reset page smc
	sta	inner_loop_smc+2

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
	; draw box

	ldx	#16
boxloop:
	txa
	jsr	GBASCALC
	lda	GBASH
	clc
	adc	PAGE
	sec
	sbc	#4
	sta	GBASH

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


	;=========================
	; scroll one line

	jsr	scroll_pattern

	; switch page
	lda	PAGE
	eor	#$c
	sta	PAGE		; is 4 or 8

	lsr
	lsr			; now 0 or 1 (C is 1 or 0)
	and	#$1
	tax
	lda	PAGE1,X

	lda	#200
	jsr	WAIT

	; A is 0 after

	beq	diamond_loop


scroll_pattern:
	clc
	lda	pattern_smc+1
	adc	#8
	and	#$1f
	sta	pattern_smc+1
	rts


pattern1:

	jmp	diamond
