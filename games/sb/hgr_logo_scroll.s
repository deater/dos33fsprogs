	;================================
	; HGR logo vscroll
	;================================
	; image to scroll in is in $4000
	;

hgr_logo_vscroll:

	ldx	#191						; 2
	stx	SCROLL		; SCROLL = 0			; 3

vscroll_loop:

	;====================
	; draw bottom part

	lda	#0						; 2
	sta	SCROLL_OFFSET		; offset in logo	; 3
	ldx	SCROLL			; offset in screen	; 3
vscroll_bottom:

	cpx	#192						; 2
	bcc	regular_scroll					; 2/3

	lda	#$20
	sta	vscroll_in_smc+2
	sta	vscroll_out_smc+2
	lda	#$00
	sta	vscroll_in_smc+1
	sta	vscroll_out_smc+1
	beq	done_scroll_setup

regular_scroll:
	ldy	SCROLL_OFFSET					; 3
	lda	hposn_high,Y					; 4
	eor	#$60			; $20->$40		; 2
	sta	vscroll_in_smc+2	; INH			; 4
	lda	hposn_low,Y					; 4
	sta	vscroll_in_smc+1	; INL			; 4
								;====
								; 21



	lda	hposn_high,X					; 4
	sta	vscroll_out_smc+2	; OUTH			; 4
	lda	hposn_low,X					; 4
	sta	vscroll_out_smc+1	; OUTL			; 4
								;====
								; 21
done_scroll_setup:

	inc	SCROLL_OFFSET					; 5


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

	txa
	sec
	sbc	SCROLL
	cmp	#58
	bcc	vscroll_bottom
							;==========
							;5+96*(42+561+7)-1
							; 58564

done_scroll:

	;=====================
	; exit early if keypress

	lda	KEYPRESS
	bmi	vscroll_early_exit

	;=====================
	; scroll whole screen

	dec	SCROLL
	bne	vscroll_loop

vscroll_early_exit:
	bit	KEYRESET

	rts
