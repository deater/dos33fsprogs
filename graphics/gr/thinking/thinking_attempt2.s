; Print-shop Style THINKING

; by Vince `deater` Weaver <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

; 183 bytes
; 161 bytes (no pageflip)
; 114 only print thinking

COL	= $F0
XSTART	= $F1
XSTOP	= $F2
YSTART	= $F3
YSTOP	= $F4
OFFSET	= $F5
CURRENT	= $F6
YY	= $F7
YS	= $F8

thinking:

	jsr	SETGR		; set lo-res 40x40 mode
				; A=$D0 afterward

big_loop:

	;==============================
	; write THINKING + rainbow box
	;==============================

thinking_loop:
	ldx	#0
	stx	YY


	;===================
	; new yline
thinking_yloop:
	lda	YY
	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

	;===================
	; start with x=0

	ldy	#0
inc_pointer:
	inx
	lda	thinking_data-1-35,X
	sta	CURRENT
thinking_xloop:

	; to draw or not
	; first see if >7 && < 14
	lda	YY
	cmp	#7
	bcc	draw_bg
	cmp	#14
	bcs	draw_bg

	ror	CURRENT
	bcs	no_draw

	; set color of background
draw_bg:
	sty	YS
	lda	COL
	lda	color_lookup,Y
	ldy	YS
	sta	(GBASL),Y
no_draw:

	iny
	cpy	#40
	beq	done_line

	tya
	and	#$7
	beq	inc_pointer
	bne	thinking_xloop

done_line:

	inc	COL

	inc	YY
	lda	YY
	cmp	#19
	bne	thinking_yloop

	;==========================
	; flip pages
	;==========================

flip_pages:


	;==========================
	; Wait
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
