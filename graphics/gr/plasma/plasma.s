; do a (hopefully fast) plasma

; 151 -- original
; 137 -- optimize generation

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
	sty	SAVEOFF
create_yloop:
	ldx	#0
create_xloop:
;	lda	SAVEOFF
;	and	#$f
;	tax

	clc
	lda	#15
	adc	sinetable,X
	adc	sinetable,Y
	lsr
lookup_smc:
	stx	SAVEX
	ldx	SAVEOFF
	sta	lookup,X
	ldx	SAVEX

	inc	SAVEOFF
	inx
	cpx	#16
	bne	create_xloop

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
	lsr
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
;.byte $00,$00,$05,$05,$07,$07,$0f,$0f
;.byte $07,$07,$06,$06,$02,$02,$05,$05
.byte $00,$05,$07,$0f,$07,$06,$02,$05

lookup:
