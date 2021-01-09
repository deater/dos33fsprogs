; do a (hopefully fast) plasma

; 151 -- original
; 137 -- optimize generation
; 136 -- align lookup table so we can index it easier
; 130 -- optimize indexing of lookup
; 126 -- run loops backaward
; 124 -- notice X already 0 before plot
; 131 -- use GBASCALC.  much faster, but 7 bytes larger

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

create_lookup:

	ldy	#15
create_yloop:
	ldx	#15
create_xloop:
	clc
	lda	#15
	adc	sinetable,X
	adc	sinetable,Y
	lsr
lookup_smc:
	sta	lookup		; always starts at $d00

	inc	lookup_smc+1

	dex
	bpl	create_xloop

	dey
	bpl	create_yloop


create_lookup_done:

forever_loop:

cycle_colors:
	; cycle colors

	ldx	#0
cycle_loop:
	inc	lookup,X
	inx
	bne	cycle_loop


plot_frame:

	; plot frame

;	ldx	#40		; YY=0

plot_yloop:
	ldy	#0		; XX = 0

	txa
	lsr

	php
	jsr	GBASCALC	; point GBASL/H to address in A
				; after, A trashed, C is clear
	plp

	lda	#$0f		; setup mask
	bcc	plot_mask
	adc	#$e0

plot_mask:
	sta	MASK

plot_xloop:

	stx	SAVEX		; SAVE YY

	tya			; get x&0xf
	and	#$f
	sta	CTEMP

	txa			; get y<<4
	asl
	asl
	asl
	asl

	ora	CTEMP		; get (y*15)+x
	tax

plot_lookup:

;	sta	plot_lookup_smc+1

plot_lookup_smc:
	lda	lookup,X	; load lookup, (y*16)+x
;	lda	lookup	; load lookup, (y*16)+x
	and	#$f
	lsr
	tax

	lda	colorlookup,X

	jsr	SETCOL

	jsr	PLOT1	; plot at GBASL,Y (x co-ord in Y)

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

.org	$d00
;.align	$100
lookup:
