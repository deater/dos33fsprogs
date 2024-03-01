hgr_page1_clearscreen	=	$7000
hgr_page2_clearscreen	=	$7300


hgr_clear_codegen:
	;========================
	; set up output pointers

	lda	#<(hgr_page1_clearscreen)	; assume both start page boundary
	sta	OUTL
	sta	INL

	lda	#>(hgr_page1_clearscreen)
	sta	OUTH
	lda	#>(hgr_page2_clearscreen)
	sta	INH

	;=====================
	; set up prolog

	lda	#$A0				; ldy
	jsr	write_both

	lda	#8				; only part of screen
	jsr	write_both

	ldx	#0
hgr_clear_codegen_loop:
	lda	#$99		; STA
	jsr	write_both

	lda	hposn_low,X	; low is same both
	jsr	write_both

	lda	hposn_high,X
	ora	#$20
	pha
	jsr	write_p1
	pla
	eor	#$60
	jsr	write_p2

	inx
	cpx	#192
	bne	hgr_clear_codegen_loop

	;======================================
	; write epilog

	; TODO: replace with memcpy of some sort?

	lda	#$C8			; INY
	jsr	write_both

	lda	#$C0			; CPY
	jsr	write_both

	lda	#32			; end value
	jsr	write_both

	lda	#$F0			; beq
	jsr	write_both

	lda	#$03			; +3
	jsr	write_both

	lda	#$4C			; JMP
	jsr	write_both

	lda	#<(hgr_page1_clearscreen+2)
	jsr	write_both

	lda	#>(hgr_page1_clearscreen+2)
	jsr	write_p1
	lda	#>(hgr_page2_clearscreen+2)
	jsr	write_p2


	lda	#$60			; RTS
;	jsr	write_both

;	rts				; tail call

	; fallthrough


	;=============================
	;
write_both:

	pha
	jsr	write_p2
	pla

	; fallthrough

write_p1:
	ldy	#0
	sta	(OUTL),Y

	clc
	lda	OUTL
	adc	#1
	sta	OUTL
	lda	#0
	adc	OUTH
	sta	OUTH

	rts


write_p2:

	ldy	#0
	sta	(INL),Y

	clc
	lda	INL
	adc	#1
	sta	INL
	lda	#0
	adc	INH
	sta	INH

	rts

