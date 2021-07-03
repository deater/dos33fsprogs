; Print-shop Style THINKING

; without pageflip

; by Vince `deater` Weaver <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


COL	= $F0
XSTART	= $F1
XSTOP	= $F2
YSTART	= $F3
YSTOP	= $F4
OFFSET	= $F5
CURRENT_BITMAP	= $F6
BITMAP_PTR	= $F7
BASE	= $F8
XSAVE	= $F9
SAVED_YY= $F9
YSAVE	= $FA
SAVED_XX= $FA


thinking:

	jsr	SETGR		; set lo-res 40x40 mode
				; A=$D0 afterward

	lda	#0
	sta	COL		; consistent starting color
				; not technically needed

print_thinking_loop:

	jsr	print_thinking_frame

	;===================
	; WAIT

	lda	#255
	jsr	WAIT			; A = 0 at end

	beq	print_thinking_loop


	;=============================
	; print thinking
	;=============================

print_thinking_frame:

	ldx	#0		; reset YY to 0
	stx	BITMAP_PTR	; also reset bitmap pointer to 0

yloop:
	txa			; load YY
	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H

	;=======================

	ldy	#0		; reset XX to 0
xloop:

	; this is only jumped to every 8th XX
inc_pointer:
	inc	BITMAP_PTR

	; load current bitmap ptr into CURRENT_BITMAP
	; is a don't care if not between 7 and 14

	stx	XSAVE
	ldx	BITMAP_PTR
	lda	thinking_data-1-35,X
	sta	CURRENT_BITMAP
	ldx	XSAVE

thinking_xloop:
	; this is called every XX

	stx	XSAVE		; save X (YY)
	sty	YSAVE		; save Y (XX)

	; if YY <7 or YY > 14 then don't draw bitmap
	cpx	#7
	bcc	do_plot
	cpx	#14
	bcs	do_plot

handle_bitmap:
	ror	CURRENT_BITMAP	; rotate next bit from bitmap in
	bcs	skip_plot	; skip plotting (assume BG is black)

do_plot:

	lda	COL		; set starting color
	and	#$7
	tay
	lda	color_lookup,Y	; lookup color in table

	ldy	YSAVE		; restore Y (XX)
	sta	(GBASL),Y

skip_plot:


	;==================================
	; adjust colors to make boxes

	; 0000000000000000
	; 0111111111111110
	; 0122222222222210

	; XX is in Y (currently also in YSAVE)
	; YY is in X (currently also in XSAVE)


	ldx	SAVED_YY	; YY
	ldy	SAVED_XX	; XX

	cpx	#10
	bcc	counting_up

counting_down:

;	cpy	#30			; is XX < 10
;	bcc	color_adjust_up		; then potentially adjust UP
;	cpy	#10			; is XX > 30
;	bcs	color_adjust_down	; then potentially adjust down
;	bcc	color_adjust_none	; else, do nothing


counting_up:
	; if YY is < 10 do following, otherwise reverse

	; if XX is < 10, check for inc
	; if XX is > 30 check for dex
	; else, no adjust

	cpy	#10			; is XX < 10
	bcc	color_adjust_up		; then potentially adjust UP
	cpy	#30			; is XX > 30
	bcs	color_adjust_down	; then potentially adjust down
	bcc	color_adjust_none	; else, do nothing


color_adjust_up:

	; if XX < YY then inc color
	; if XX >= YY then do nothing

	cpy	SAVED_YY		; compare XX to YY
	bcs	col_same		; bge do nothing

col_inc:
	inc	COL
col_same:

	jmp	color_adjust_none

color_adjust_down:

	lda	#39
	sec
	sbc	XSAVE
	sta	XSAVE

	cpy	XSAVE		; compare XX to YY

	; if XX > 39-YY then inc color
	bcc	col_down_same

col_dec:
	dec	COL
col_down_same:

;	ldy	YSAVE

	; fallthrough

color_adjust_none:

	;============================
	; inc XX for next pixel

	iny

	cpy	#40
	beq	done_done

	tya
	and	#$7
	beq	inc_pointer
	bne	thinking_xloop
done_done:

	;=============================================
	; reverse the colors on bottom half of screen

	cpx	#9
	beq	blarch
	bcc	blurgh
	dec	COL
	jmp	blarch
blurgh:
	inc	COL
blarch:


	;=======================
	; move to next line

	inx
	cpx	#20
	beq	done_yloop

	jmp	yloop
done_yloop:

	;==========================
	; done drawing rainbow box
	;==========================

	;==========================
	; flip pages
	;==========================


	;===================
	; increment color
	;	after loop we are +10
	;	so -1 actually means increment 1 (because we mod 8 it)
;	inc	COL
;	inc	COL
	dec	COL
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

color_lookup:
	; magenta, pink, orange, yellow, lgreen, aqua, mblue, lblue
.byte	$33,$BB,$99,$DD,$CC,$EE,$66,$77

thinking_data:
.byte	$BE,$54,$14,$15,$39
.byte	$88,$D4,$94,$34,$45
.byte	$88,$D4,$54,$34,$05
.byte	$88,$57,$35,$54,$05
.byte	$88,$54,$56,$94,$65
.byte	$88,$54,$96,$94,$45
.byte	$88,$54,$14,$15,$79
