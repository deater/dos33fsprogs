; Print-shop Style THINKING

; this one uses page flipping for smoother animation

; by Vince `deater` Weaver <vince@deater.net>

.include "hardware.inc"

; zero page locations

GBASL   = $26
GBASH   = $27

COL	= $F0	; current start color of animated boxes
XSTART	= $F1	; co-ords of current block being drawn
XSTOP	= $F2
YSTART	= $F3
YSTOP	= $F4

CURRENT	= $F3	; current bitmap block
YY	= $F4	; bitmap Y value

thinking:

	jsr	SETGR		; set lo-res 40x40 mode
				; A=$D0 afterward

	;=========================================
	; clear Lo-res PAGE2 to " "
	; technically just need to do that for bottom 4 lines
	; but easier(?) to just do it for whole screen

	ldy	#0
	lda	#$A0		; space
clear_page2_inner_loop:
cp2_smc:
	sta	$800,Y
	iny
	bne	clear_page2_inner_loop

	inc	cp2_smc+2	; want $800..$C00
	ldx	cp2_smc+2
	cpx	#$c
	bne	clear_page2_inner_loop


	; COL value doesn't matter, can be skipped if you don't care about
	; starting place in color animation

	lda	#0
	sta	COL


thinking_loop:

	jsr	thinking_next_frame

	; pause a bit

	lda	#255
	jsr	WAIT	; A==0 at end

	beq	thinking_loop



	;===========================
	; thinking next frame
	;===========================
	; draws and displays next frame
thinking_next_frame:

	; draw the next frame of the animation
	; draw a box from 0,0 to 40,20*2
	; then next at 1,1*2 to 39,19*2
	; etc

	lda	#0		; starting points
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
				; would be faster with lookup table

	lda	GBASH		; adjust for PAGE1/PAGE2
draw_page_smc:
	adc	#0
	sta	GBASH

	lda	COL		; take start color, wrap, lookup in table
	and	#$7
	tay
	lda	color_lookup,Y

	ldy	XSTART		; draw horizontal line
xloop:
	sta	(GBASL),Y
	iny
	cpy	XSTOP
	bne	xloop

	inx			; move to next Y, repeat until done
	cpx	YSTOP
	bne	yloop

	inc	COL		; move to next color

	inc	XSTART		; adjust boundaries for next box
	dec	XSTOP

	inc	YSTART
	dec	YSTOP
	lda	YSTOP

	cmp	#10		; see if reached middle
	bne	box_loop

	;==========================
	; done drawing rainbow box
	;==========================

	;==========================
	; write THINKING
	;==========================

thinking_bitmap_loop:
	lda	#7		; text is from lines 7 to 14
	sta	YY
	ldx	#0		; X is offset into the bitmap

thinking_yloop:
	lda	YY
	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)


	lda	GBASH		; adjust for PAGE1/PAGE2
draw_bitmap_smc:
	adc	#$0
	sta	GBASH

	ldy	#0		; bump to next part of bitmap each 8 pixels
inc_pointer:
	inx
	lda	thinking_data-1,X
	sta	CURRENT
thinking_xloop:
	ror	CURRENT
	bcc	no_draw

	lda	#$00			; draw black if bit set, otherwise skip
	sta	(GBASL),Y
no_draw:
	iny

	cpy	#40			; if it's been 40 bits, next line
	beq	done_line

	tya
	and	#$7			; if it's been 8 bits, move on
	beq	inc_pointer
	bne	thinking_xloop		; otherwise, keep drawing

done_line:

	inc	YY
	lda	YY
	cmp	#14
	bne	thinking_yloop

	;==========================
	; flip pages
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
	sta	draw_bitmap_smc+1




	;===================
	; increment color
	;	after loop we are +10
	;	so -1 actually means increment 1 (because we mod 8 it)
	dec	COL

	rts


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

