; 12 bytes per char
; 0x20 - 0x5F = 32 - 96 = 64*12 = 768 bytes


colors_hi:	.byte $C4,$CF
colors_lo:	.byte $FC,$4C

	;==================================
	; put_char
	;	ypos = Y (must be multiple of 2)
	;	xpos = X
	;	char = A

	;	waste 256 bytes to avoid crossing pages and muly by 6

	; 39+30+37+(41*3)+3+34+(43*3)+5 = 400

put_char:
		; point to font location
		sec						; 2
		sbc	#'A'					; 2
		; multiply by 8... 0..63 -> 0..511  1 1111
		; shift left by 4
		pha						; 3
		lsr						; 2
		lsr						; 2
		lsr						; 2
		lsr						; 2
		clc						; 2
		adc	#>font_high				; 2
		sta	fh1_smc+2				; 4
		sta	fh2_smc+2				; 4
		clc						; 2
		adc	#2					; 2
		sta	fl1_smc+2				; 4
		sta	fl2_smc+2				; 4
							;============
							;	39

		pla						; 4
		asl						; 2
		asl						; 2
		asl						; 2
		asl						; 2
		adc	#<font_high	; always zero		; 2
		sta	fh1_smc+1				; 4
		sta	fh2_smc+1				; 4
		sta	fl1_smc+1				; 4
		sta	fl2_smc+1				; 4
							;============
							;	30

		; calculate output
		txa						; 2
		pha						; 3
		clc						; 2
		adc	gr_offsets,y				; 4+
		sta	page0_put_char1+1			; 4
		sta	page1_put_char1+1			; 4
		lda	gr_offsets+1,y				; 4+
		sta	page1_put_char1+2			; 4
		clc						; 2
		adc	#$4					; 2
		sta	page0_put_char1+2			; 4

		ldx	#2					; 2
							;============
							;	 37
put_char_inner_loop1:
fh1_smc:
		lda	font_high,X				; 4+
		and	colors_hi				; 4
page0_put_char1:
		sta	$400					; 4

fl1_smc:
		lda	font_low,X				; 4+
		and	colors_lo				; 4
page1_put_char1:
		sta	$800					; 4

		inc	page0_put_char1+1			; 6
		inc	page1_put_char1+1			; 6

		dex						; 2
		bpl	put_char_inner_loop1			; 3
							;============
							;	41 * 3

								; -1
		iny						; 2
		iny						; 2
							;============
							;	  3
		; unrolled
		pla				; restore X pos	; 4
		adc	gr_offsets,y				; 4+
		sta	page0_put_char2+1			; 4
		sta	page1_put_char2+1			; 4
		lda	gr_offsets+1,y				; 4+
		sta	page1_put_char2+2			; 4
		clc						; 2
		adc	#$4					; 2
		sta	page0_put_char2+2			; 4

		ldx	#5					; 2
							;==============
							;	34
put_char_inner_loop2:
fh2_smc:
		lda	font_high,X				; 4
		and	colors_hi+1				; 4+
page0_put_char2:
		sta	$400					; 4
fl2_smc:
		lda	font_low,X				; 4+
		and	colors_lo+1				; 4+
page1_put_char2:
		sta	$800					; 4

		inc	page0_put_char2+1			; 6
		inc	page1_put_char2+1			; 6

		dex						; 2
		cpx	#2					; 2
		bne	put_char_inner_loop2			; 3
							;============
							;	43*3

								; -1
		rts						; 6
							;==============
							;	  5


		;H0H    **
		;L0H **    **
		;H0L **    **
		;L0L ** ** **
		;H1H **    **
		;L1H **    **
		;H1L **    **
		;L1L **    **
.align $100
font_high:
.byte	$f0,$0f,$f0
.byte	$ff,$00,$ff
.byte	$00,$00
.align $100
.byte 0

.align $100


font_low:	; 2 pages later
.byte	$ff,$f0,$ff
.byte	$ff,$00,$ff
.byte	$00,$00


