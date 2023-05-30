	;================================
	; HGR vscroll
	;================================
	; image to scroll in is in $A000
	;
	; At SCROLL=96 timing = 44,543 + 66,629 = 111,172 cycles
	;		= approx 9 frames/second so 21s to scroll screen

hgr_vscroll:

	ldx	#191						; 2
	stx	SCROLL		; SCROLL = 0			; 3

vscroll_loop:

	; for x=0 to SCROLL
	; write 40 bytes of 00

	ldx	#0						; 2
vscroll_inner:
	lda	hposn_high,X					; 4
	sta	OUTH						; 3
	lda	hposn_low,X					; 4
	sta	OUTL						; 3
								;====
								; 14

	ldy	#39						; 2
	lda	#0						; 2
								;===
								; 4
vscroll_line:
	sta	(OUTL),Y					; 6
	dey							; 2
	bpl	vscroll_line					; 2/3
								;=====
								; 4+(40*11)-1
								; 443

	inx							; 2
	cpx	SCROLL						; 2
	bne	vscroll_inner					; 2/3

							;===============
							; assume SCROLL=96
							; 96*(14+443+7)-1
							;

	;====================
	; draw bottom part

	lda	#0						; 2
	sta	SCROLL_OFFSET					; 3
vscroll_bottom:
	stx	XSAVE						; 3

	ldx	SCROLL_OFFSET					; 3
	lda	hposn_high,X					; 4
	clc							; 2
	adc	#$80		; ora instead?			; 2
	sta	INH						; 3
	lda	hposn_low,X					; 4
	sta	INL						; 3
								;====
								; 24

	inc	SCROLL_OFFSET					; 5

	ldx	XSAVE						; 3

	lda	hposn_high,X					; 4
	sta	OUTH						; 3
	lda	hposn_low,X					; 4
	sta	OUTL						; 3
								;====
								; 22

	ldy	#39						; 2
vscroll_bottom_line:
	lda	(INL),Y						; 5
	sta	(OUTL),Y					; 6
	dey							; 2
	bpl	vscroll_bottom_line				; 2/3
								;=====
								; 2+40*(16)-1
								; 641

	inx							; 2
	cpx	#192						; 2
	bne	vscroll_bottom					; 2/3
							;==========
							;5+96*(46+641+7)-1
							; 66629

	;=====================
	; scroll whole screen

	dec	SCROLL
	bne	vscroll_loop

	rts
