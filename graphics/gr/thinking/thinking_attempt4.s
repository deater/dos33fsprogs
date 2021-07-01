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
XR	= $F8
XL	= $F9
YT	= $FA
YB	= $FB

thinking:

	jsr	SETGR		; set lo-res 40x40 mode
				; A=$D0 afterward

	lda	#1
	sta	COL

	lda	#0
	sta	XL
	sta	YT

	lda	#39
	sta	XR
	sta	YB

big_loop:
	lda	COL
	jsr	SETCOL

	; FOR Y=0 TO 20 STEP 2
	; X=Y/2
	; HLIN X,39-X AT Y
	; HLIN X,39-X AT 39-Y
	; VLIN Y,39-Y AT X
	; VLIN Y,39-Y AT 39-X


	; HLIN X,39-X AT Y
	; HLIN X,39-X AT 39-Y
	ldy	XL
	lda	XR
	sta	$2C
	lda	YT
	jsr	HLINE			; HLINE Y,$2C at A

	ldy	XL
	lda	YB
	jsr	HLINE			; HLINE Y,$2C at A




	; VLIN Y,39-Y AT X
	; VLIN Y,39-Y AT 39-X

	ldy	XR
	lda	YB
	sta	$2D
	lda	YT

	jsr	VLINE			; VLINE A,$2D at Y


	ldy	XL
	lda	YB
	sta	$2D
	lda	YT

	jsr	VLINE			; VLINE A,$2D at Y


	;==========================
	; done drawing rainbow box
	;==========================

	;==========================
	; write THINKING
	;==========================

thinking_loop:
	lda	#7
	sta	YY
	ldx	#0

thinking_yloop:
	lda	YY
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



	lda	#255
	jsr	WAIT

	;===================
	; increment color
	;	after loop we are +10
	;	so -1 actually means increment 1 (because we mod 8 it)
	dec	COL

done:
	jmp	done

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
