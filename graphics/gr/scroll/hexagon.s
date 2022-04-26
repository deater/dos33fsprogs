; hexagon scroll?

; by Vince `deater` Weaver

PARTICLES = 128
SCALE = 2

COLOR		= $30

QUOTIENT	= $FA
DIVISOR		= $FB
DIVIDEND	= $FC
XX		= $FD
YY		= $FE
FRAME		= $FF

FULLGR		= $C052
LORES		= $C056		; Enable LORES graphics

PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

hexagon:

	jsr	SETGR
	bit	FULLGR


hexagon_loop:


; 104 to beat

	lda	#$4
	sta	inner_loop_smc+2

line_loop:

	ldx	#120
	ldy	#0
screen_loop:


inner_loop:

pattern_smc:
	lda	pattern1,Y
inner_loop_smc:
	sta	$400,X

	iny
	tya
	and	#$7
	tay

	dex
	bpl	screen_loop

;=================================

	; move to next pattern

	clc
	lda	pattern_smc+1
	adc	#8
	sta	pattern_smc+1
	cmp	#(<pattern1+32)
	bne	pattern_ok
	lda	#<pattern1
	sta	pattern_smc+1

pattern_ok:

	; move to next line

	clc
	lda	inner_loop_smc+1
	adc	#$80
	sta	inner_loop_smc+1	; FIXME just inc if carry set
	lda	#$00
	adc	inner_loop_smc+2
	sta	inner_loop_smc+2

	cmp	#$8
	bne	line_loop

	; scroll!


	clc
	lda	pattern_smc+1
	adc	#8
	sta	pattern_smc+1
	cmp	#(<pattern1+32)
	bne	pattern_ok2
	lda	#<pattern1
	sta	pattern_smc+1

pattern_ok2:


	lda	#200
	jsr	WAIT

	jmp	hexagon_loop

pattern1:
	.byte $04,$40,$d4,$4d,$d4,$40,$04,$40
pattern2:
	.byte $d4,$4d,$04,$40,$04,$4d,$d4,$40
pattern3:
	.byte $d4,$40,$04,$40,$04,$40,$d4,$4d
pattern4:
	.byte $04,$4d,$d4,$40,$d4,$4d,$04,$40

	; for bot

	jmp	hexagon




;	lda	pattern1,Y
;	sta	$400,X
;	lda	pattern2,Y
;	sta	$480,X
;	lda	pattern3,Y
;	sta	$500,X
;	lda	pattern4,Y
;	sta	$580,X

;	lda	pattern1,Y
;	sta	$600,X
;	lda	pattern2,Y
;	sta	$680,X
;	lda	pattern3,Y
;	sta	$700,X
;	lda	pattern4,Y
;	sta	$780,X




