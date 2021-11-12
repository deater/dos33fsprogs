; spinning dsr logo

dsr_spin:
	ldy	#$0
	sty	FRAME		; 2
	sty	OUR_ROT		; 2

	iny			; 1	; set shape table scale to 1
	sty	HGR_SCALE	; 2

	;=========================================
	; MAIN LOOP
	;=========================================

main_loop:
	; increment FRAME

	inc	FRAME		; 2

	;=======================
	; xdraw
	;=======================
xdraw:
	; setup X and Y co-ords

	ldy	#0		; XPOSH always 0 for us
	ldx	#140
	lda	#96
	jsr	HPOSN		; X= (y,x) Y=(a)

	jsr	fast_hclr

	ldx	#<shape_dsr	; point to our shape
	ldy	#>shape_dsr	; code fits in one page so this doesn't change
	lda	OUR_ROT		; set rotation

	jsr	XDRAW0		; XDRAW 1 AT X,Y

	jsr	flip_page

	lda	FRAME
	lsr
	bcc	skip_bigger

	inc	HGR_SCALE	; 2	; increment scale
skip_bigger:
	inc	OUR_ROT		; 2
	inc	OUR_ROT		; 2

	lda	FRAME
	cmp	#33		; 2
	bcc	main_loop	; 2

	ldx	#10
long_wait:
	lda	#200
	jsr	WAIT
	dex
	bne	long_wait

;	rts

;shape_dsr:
;.byte	$2d,$36,$ff,$3f
;.byte	$24,$ad,$22,$24,$94,$21,$2c,$4d
;.byte	$91,$3f,$36,$00
