; Print-shop Style THINKING

; by Vince `deater` Weaver <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

COL	= $F0
XSTART	= $F1
XSTOP	= $F2
YSTART	= $F3
YSTOP	= $F4
OFFSET	= $F5
CURRENT	= $F6
YY	= $F7
XS	= $F8

thinking:

	jsr	SETGR		; set lo-res 40x40 mode
				; A=$D0 afterward

big_loop:

	; COL value doesn't matter?

	lda	#0
	sta	YSTART
	sta	XSTART

	lda	#20
	sta	YSTOP
	asl
	sta	XSTOP

box_loop:

	ldx	YSTART
yloop:
	txa
	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)


	lda	COL
	and	#$7
	tay
	lda	color_lookup,Y
	sta	COLOR

	;======================
	;======================
	; inner loop begin
	;	Y=xx
	;	X=yy


	ldy	XSTART
xloop:
	stx	XS
	tya
	lsr
	lsr
	lsr
	tax
	lda	thinking_data,X
	sta	CURRENT

	tya
	and	#$7
	tax
bloop:
	ror	CURRENT
	dex
	bne	bloop
	ldx	XS

	bcs	dont_draw

	lda	COLOR
	sta	(GBASL),Y

dont_draw:
	iny
	cpy	XSTOP
	bne	xloop

	; inner loop end
	;======================
	;======================


	inx
	cpx	YSTOP
	bne	yloop

	inc	COL

	inc	XSTART
	dec	XSTOP

	inc	YSTART
	dec	YSTOP
	lda	YSTOP
	cmp	#10
	bne	box_loop

	;==========================
	; done drawing rainbow box
	;==========================

	;==========================
	; wait a bit
	;==========================

	lda	#255
	jsr	WAIT

	;===================
	; increment color
	;	after loop we are +10
	;	so -1 actually means increment 1 (because we mod 8 it)
	dec	COL

	jmp	big_loop


;0          1          2          3         3
;01234567|89012345|67890123|45678901|23456789
; ***** *|  * * * |  * *   |* * *   |*  ***
;   *   *|  * * **|  * *  *|  * **  |* *   *
;   *   *|  * * **|  * * * |  * **  |* *
;   *   *|*** * * |* * **  |  * * * |* *
;   *   *|  * * * | ** * * |  * *  *|* *  **
;   *   *|  * * * | ** *  *|  * *  *|* *   *
;   *   *|  * * * |  * *   |* * *   |*  ****
;
; 7*5 bytes = 35 bytes

thinking_data:
.byte	$BE,$54,$14,$15,$39
.byte	$88,$D4,$94,$34,$45
.byte	$88,$D4,$54,$34,$05
.byte	$88,$57,$35,$54,$05
.byte	$88,$54,$56,$94,$65
.byte	$88,$54,$96,$94,$45
.byte	$88,$54,$14,$15,$79



color_lookup:
	; magenta, pink, orange, yellow, lgreen, aqua, mblue, lblue
.byte	$33,$BB,$99,$DD,$CC,$EE,$66,$77


	; for apple II bot entry at $3F5

	jmp	thinking
