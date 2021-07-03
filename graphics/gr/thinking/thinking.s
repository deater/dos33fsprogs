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
YSAVE	= $FA

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

	; skip if out of range
	cpx	#7
	bcc	draw_color
	cpx	#14
	bcs	draw_color

	ldx	BITMAP_PTR
	lda	thinking_data-1-35,X
	sta	CURRENT
thinking_xloop:
	; this is called every XX

	; XX is in Y
	; YY is in X (currently saved in XSAVE)

;	cpx	XSAVE

	; if XX < YY then inc color
;	bcs	col_same

col_inc:
;	inc	COL
col_same:


	ror	CURRENT
	bcs	skip_color


draw_color:

	sty	YSAVE		; save Y
	lda	COL		; set starting color
	and	#$7
	tay
	lda	color_lookup,Y	; lookup color
	ldy	YSAVE		; restore Y
	sta	(GBASL),Y
skip_color:
no_draw:
	ldx	XSAVE

	iny

	cpy	#40
	beq	done_done

	tya
	and	#$7
	beq	inc_pointer
	bne	thinking_xloop
done_done:



	;=======================

	cpx	#9
	beq	blarch
	bcc	blurgh
	inc	COL
	jmp	blarch
blurgh:
	dec	COL
blarch:
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
