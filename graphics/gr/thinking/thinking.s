; Print-shop Style THINKING

; by Vince `deater` Weaver <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

COL	= $F0
XSTART	= $F1
XSTOP	= $F2
YSTART	= $F3
YSTOP	= $F4

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

	lda	GBASH
draw_page_smc:
	adc	#0
	sta	GBASH

	lda	COL
	and	#$7
	tay
	lda	color_lookup,Y

	ldy	XSTART
xloop:
	sta	(GBASL),Y
	iny
	cpy	XSTOP
	bne	xloop

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

flip_pages:

	ldy	#1
	lda	draw_page_smc+1	; DRAW_PAGE
	bne	done_page
	dey
done_page:
	ldx	PAGE1,Y		; set display page to PAGE1 or PAGE2

	eor	#$4		; flip draw page between $400/$800
	sta	draw_page_smc+1	; DRAW_PAGE



	lda	#255
	jsr	WAIT

	;===================
	; increment color
	;	after loop we are +10
	;	so -1 actually means increment 1 (because we mod 8 it)
	dec	COL

	jmp	big_loop


;0         1         2         3        3
;0123456789012345678901234567890123456789
; ***** *  * * *   * *   * * *   *  ***
;   *   *  * * **  * *  *  * **  * *   *
;   *   *  * * **  * * *   * **  * *
;   *   **** * * * * **    * * * * *
;   *   *  * * *  ** * *   * *  ** *  **
;   *   *  * * *  ** *  *  * *  ** *   *
;   *   *  * * *   * *   * * *   *  ****
;
; 7*5 bytes = 35 bytes

thinking_loop:

end:
	jmp	end


color_lookup:
	; magenta, pink, orange, yellow, lgreen, aqua, mblue, lblue
.byte	$33,$BB,$99,$DD,$CC,$EE,$66,$77
