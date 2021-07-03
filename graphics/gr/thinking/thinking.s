; Print-shop Style THINKING

; by Vince `deater` Weaver <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


; 0-------------------------
; 0 1111111111111111111111 0
; 0 1 22222222222222222221 0

; if XX < YY COL++
 ;if XX > 39-YY COL--

COL	= $F0
XSTART	= $F1
XSTOP	= $F2
YSTART	= $F3
YSTOP	= $F4
OFFSET	= $F5
CURRENT	= $F6
BITMAP_PTR	= $F7
BASE	= $F8
XSAVE	= $F9
SAVED_YY= $F9
YSAVE	= $FA
SAVED_XX= $FA
thinking:

	jsr	SETGR		; set lo-res 40x40 mode
				; A=$D0 afterward

big_loop:

	ldx	#0		; reset YY
	stx	BITMAP_PTR	; reset bitmap pointer to 0

yloop:
	txa
	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)


	;=======================

	ldy	#0
xloop:



	; this is only jumped to every 8th XX
inc_pointer:
	inc	BITMAP_PTR

	stx	XSAVE
	ldx	BITMAP_PTR
	lda	thinking_data-1-35,X
	sta	CURRENT
	ldx	XSAVE

thinking_xloop:
	; this is called every XX

	stx	XSAVE
	sty	YSAVE		; save Y (XX)

	; skip if out of range
	cpx	#7
	bcc	draw_color
	cpx	#14
	bcs	draw_color

	ror	CURRENT
	bcs	skip_color

draw_color:
	lda	COL		; set starting color
	and	#$7
	tay
	lda	color_lookup,Y	; lookup color
	ldy	YSAVE		; restore Y (XX)
	sta	(GBASL),Y
skip_color:
no_draw:

	;==================================
	; adjust colors to make boxes

	; 0000000000000000
	; 0111111111111110
	; 0122222222222210

	; XX is in Y (currently also in YSAVE)
	; YY is in X (currently also in XSAVE)

	; if XX is < 10, check for inc
	; if XX is > 30 check for dex
	; else, no adjust

	ldx	SAVED_YY	; YY

	ldy	SAVED_XX	; XX

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

	ldy	YSAVE

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



	;=======================

;	cpx	#9
;	beq	blarch
;	bcc	blurgh
;	inc	COL
;	jmp	blarch
;blurgh:
;	dec	COL
;blarch:


	;=======================
	; move to next line
	inc	COL

	inx
	cpx	#20
	bne	yloop


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

	;===================
	; WAIT

	lda	#255
	jsr	WAIT			; A = 0 at end

	beq	big_loop


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






	; for apple II bot entry at $3F5

	; at +8A, so 36B

	jmp	thinking
