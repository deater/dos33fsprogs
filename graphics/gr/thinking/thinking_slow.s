; Print-shop Style THINKING

; by Vince `deater` Weaver <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

; 161 -- original with page flip removed
; 159 -- remove extraneous store to YY
; 158 -- cond jump for jmp

; 0-------------------------
; 0 1111111111111111111111 0
; 0 1 22222222222222222221 0

; if XX < YY COL++


COL	= $F0
XSTART	= $F1
XSTOP	= $F2
YSTART	= $F3
YSTOP	= $F4
OFFSET	= $F5
CURRENT	= $F6
YY	= $F7
BASE	= $F8

X0	= $F9
Y1	= $FA
Y0	= $FB
X1	= $FC


thinking:

	jsr	SETGR		; set lo-res 40x40 mode
				; A=$D0 afterward

big_loop:

	lda	#0
;	sta	COLOR
	sta	X0	; X0
	tax

	lda	#39
	sta	H2	; X1
	sta	Y1

draw_box_loop:

	stx	Y0

	lda	COL
	and	#$7
	tay
	lda	color_lookup,Y

	sta	COLOR

inner_loop:
	;; HLINE Y,H2 at A
	;; X left alone, carry set on exit
	;; H2 left alone
	;; Y and A trashed

	ldy	X0
	txa
	jsr	HLINE	; y, H2 at A

	cpx	Y1
	inx
	bcc	inner_loop

	inc	COL

	ldx	Y0
	inx		; Y0
	inx
	dec	Y1
	dec	Y1

	inc	X0
	dec	H2

	cpx	#20
	bne	draw_box_loop



	;==========================
	; done drawing rainbow box
	;==========================

	;==========================
	; write THINKING
	;==========================

thinking_loop:
	lda	#7		; YY
	ldx	#0

thinking_yloop:
	sta	YY		; YY in A here

;	lda	YY
	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

	ldy	#0
inc_pointer:
	inx
	lda	thinking_data-1,X
	sta	CURRENT
thinking_xloop:
	ror	CURRENT
	bcc	no_draw

	lda	#$00
	sta	(GBASL),Y
no_draw:
	iny
	tya
	and	#$7
	beq	inc_pointer

	cpy	#39
	bne	thinking_xloop

	inc	YY
	lda	YY
	cmp	#14
	bne	thinking_yloop

	;==========================
	; flip pages
	;==========================


	;===================
	; increment color
	;	after loop we are +10
	;	so -1 actually means increment 1 (because we mod 8 it)
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
