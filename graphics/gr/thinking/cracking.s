; SPDX-License-Identifier: MIT

; Print-shop Style CRACKING

; without pageflip

; by Vince `deater` Weaver <vince@deater.net>

; zero page addresses

GBASL		= $26
GBASH		= $27

COL		= $F0
CURRENT_BITMAP	= $F1
BITMAP_PTR	= $F2
XSAVE		= $F3
SAVED_YY	= $F3
YSAVE		= $F4
SAVED_XX	= $F4
ADJUSTED_YY	= $F5


; monitor routines
GBASCALC	= $F847		; take Y-coord/2 in A, put address in GBASL/H ( A trashed, C clear)
SETGR		= $FB40		; Init graphics, clear screen, A is $D0 after
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

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
	;=============================
	; print thinking frame
	;=============================
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
	lda	thinking_data-1-30,X
	sta	CURRENT_BITMAP
	ldx	XSAVE

thinking_xloop:
	; this is called every XX

	stx	XSAVE		; save X (YY)
	sty	YSAVE		; save Y (XX)

	; if YY <6 or YY > 13 then don't draw bitmap
	cpx	#6
	bcc	do_plot
	cpx	#13
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


	; if YY is < 10 do following, otherwise reverse

	txa				; put YY in A (saved bytes later)
	cmp	#10
	bcc	counting_up

counting_down:
	; now doing the reverse

	lda	#19
	sec
	sbc	SAVED_YY

	; YY (in A) now going from 10..0

counting_up:
	sta	ADJUSTED_YY

detect_adjust_dir:
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

	cpy	ADJUSTED_YY		; compare XX to YY
	bcs	col_same		; bge do nothing

col_inc:
	inc	COL
col_same:

	jmp	color_adjust_none

color_adjust_down:

	lda	#39
	sec
	sbc	ADJUSTED_YY
	sta	ADJUSTED_YY

	cpy	ADJUSTED_YY		; compare XX to YY

	; if XX > 39-YY then inc color
	bcc	col_down_same

col_dec:
	dec	COL
col_down_same:

	; fallthrough

color_adjust_none:

	;============================
	; inc XX for next pixel

	iny				; inc XX

	cpy	#40			; if we hit 40, done line
	beq	done_done

	tya				; if we are multiple of 8
	and	#$7			; then need to increment bitmap ptr
	beq	inc_pointer
	bne	thinking_xloop
done_done:

	;=============================================
	; adjust color for next line

	inc	COL

	;=======================
	; move to next line

	inx
	cpx	#20
	bne	yloop

	;============================================
	; done frame, increment color for next round
	;============================================

	inc	COL

	rts


;0          1          2          3         3
;01234567|89012345|67890123|45678901|23456789
;  ** ***|   ***  | ** *   |* * *   |*  ***
; *   *  |* *   * |*   *  *|  * **  |* *   *
; *   *  |* *   * |*   * * |  * **  |* *
; *   ***|  ***** |*   **  |  * * * |* *
; *   * *|  *   * |*   * * |  * *  *|* *  **
; *   *  |* *   * |*   *  *|  * *  *|* *   *
;  ** *  |* *   * | ** *   |* * *   |*  ****
; 7*5 bytes = 35 bytes


thinking_data:
.byte	$EC,$38,$16,$15,$39
.byte	$22,$45,$91,$34,$45
.byte	$22,$45,$51,$34,$05
.byte	$E2,$7C,$31,$54,$05
.byte	$A2,$44,$51,$94,$65
.byte	$22,$45,$91,$94,$45
.byte	$2C,$45,$16,$15,$79

color_lookup:
	; magenta, pink, orange, yellow, lgreen, aqua, mblue, lblue
.byte	$33,$BB,$99,$DD,$CC,$EE,$66,$77
