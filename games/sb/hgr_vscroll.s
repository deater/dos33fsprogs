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
.if 0
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
.endif
	; Original = 66629
	; optimize = 58564


	;====================
	; draw bottom part

	lda	#0						; 2
	sta	SCROLL_OFFSET					; 3
	ldx	SCROLL						; 3
vscroll_bottom:

	ldy	SCROLL_OFFSET					; 3
	lda	hposn_high,Y					; 4
	ora	#$80			; $20->$A0		; 2
	sta	vscroll_in_smc+2	; INH			; 4
	lda	hposn_low,Y					; 4
	sta	vscroll_in_smc+1	; INL			; 4
								;====
								; 21

	inc	SCROLL_OFFSET					; 5

	lda	hposn_high,X					; 4
	sta	vscroll_out_smc+2	; OUTH			; 4
	lda	hposn_low,X					; 4
	sta	vscroll_out_smc+1	; OUTL			; 4
								;====
								; 21

	ldy	#39						; 2
vscroll_bottom_line:

vscroll_in_smc:
	lda	$A000,Y						; 4
vscroll_out_smc:
	sta	$2000,Y						; 5
	dey							; 2
	bpl	vscroll_bottom_line				; 2/3
								;=====
								; 2+40*(14)-1
								; 561

	inx							; 2
	cpx	#192						; 2
	bne	vscroll_bottom					; 2/3
							;==========
							;5+96*(42+561+7)-1
							; 58564

	;=====================
	; scroll whole screen

	dec	SCROLL
	bne	vscroll_loop

	rts
