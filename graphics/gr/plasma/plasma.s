; do a (hopefully fast) plasma

; 151

.include "zp.inc"
.include "hardware.inc"

CTEMP	= $FC
SAVEOFF = $FD
SAVEX = $FE
SAVEY = $FF

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	SETGR

	lda	#0
	sta	DISP_PAGE
	lda	#4
	sta	DRAW_PAGE

;col = ( 8.0 + (sintable[xx&0xf])
 ;           + 8.0 + (sintable[yy&0xf])
  ;            ) / 2;


	ldy	#0
create_yloop:
	ldx	#0
create_xloop:
	clc
	lda	#15
	adc	sinetable,X
	adc	sinetable,Y
	lsr
lookup_smc:
	sta	lookup,X

	inx
	cpx	#16
	bne	create_xloop

	clc
	lda	lookup_smc+1
	adc	#16
	sta	lookup_smc+1
	lda	#0
	adc	lookup_smc+2
	sta	lookup_smc+2

	iny
	cpy	#16
	bne	create_yloop

forever_loop:

	; cycle colors

	ldx	#0
cycle_loop:
	inc	lookup,X
	inx
	bne	cycle_loop


	; plot

	ldx	#0		; YY=0
plot_yloop:
	ldy	#0		; XX = 0
plot_xloop:

	stx	SAVEX		; SAVE YY
	sty	SAVEY		; SAVE XX

	tya
	and	#$f
	sta	CTEMP

	txa
	and	#$f
	asl
	asl
	asl
	asl
	ora	CTEMP
	tax
	lda	lookup,X
	and	#$f
	tax
	lda	colorlookup,X

	jsr	SETCOL

	lda	SAVEX

	jsr	PLOT	; plot at Y,A

	ldy	SAVEY		; restore XX
	ldx	SAVEX		; restore YY

	iny
	cpy	#40
	bne	plot_xloop

	inx
	cpx	#40
	bne	plot_yloop
	beq	forever_loop


sinetable:
.byte $00,$03,$05,$07,$08,$07,$05,$03
.byte $00,$FD,$FB,$F9,$F8,$F9,$FB,$FD

colorlookup:
.byte $00,$00,$05,$05,$07,$07,$0f,$0f
.byte $07,$07,$06,$06,$02,$02,$05,$05

lookup:
