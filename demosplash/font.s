; 12 bytes per char
; 0x20 - 0x5F = 32 - 96 = 64*12 = 768 bytes

; FIXME: if only 32 chars then we can make the code a lot simpler/smaller
;	+ only 2 pages of data (instead of 4)
;	+ calculations, no need for high bit in multiply


colors_hi:	.byte $C4,$CF
colors_lo:	.byte $FC,$4C

	;==================================
	; put_char
	;	ypos = Y (must be multiple of 2)
	;	xpos = X
	;	char = A

	;	waste 256 bytes to avoid crossing pages and muly by 6

	; 4+24+37+(43*3)+3+34+(43*3)+5 = 365

put_char:
		; point to font location
		sec						; 2
		sbc	#'A'					; 2
		; multiply by 8... 0..63 -> 0..511  1 1111
		; shift left by 4
;		pha						; 3
;		lsr						; 2
;		lsr						; 2
;		lsr						; 2
;		clc						; 2
;		adc	#>font_high				; 2
;		sta	fh1_smc+2				; 4
;		sta	fh2_smc+2				; 4
;		clc						; 2
;		adc	#1					; 2
;		sta	fl1_smc+2				; 4
;		sta	fl2_smc+2				; 4
							;============
							;	4

;		pla						; 4
		asl						; 2
		asl						; 2
		asl						; 2
		adc	#<font_high	; always zero		; 2
		sta	fh1_smc+1				; 4
		sta	fh2_smc+1				; 4
		sta	fl1_smc+1				; 4
		sta	fl2_smc+1				; 4
							;============
							;	24

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

		ldx	#0					; 2
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

		inx						; 2
		cpx	#3					; 2
		bne	put_char_inner_loop1			; 3
							;============
							;	43 * 3

								; -1
		iny						; 2
		iny						; 2
							;============
							;	  3
		; unrolled
		clc						; 2
		pla				; restore X pos	; 4
		adc	gr_offsets,y				; 4+
		sta	page0_put_char2+1			; 4
		sta	page1_put_char2+1			; 4
		lda	gr_offsets+1,y				; 4+
		sta	page1_put_char2+2			; 4
		clc						; 2
		adc	#$4					; 2
		sta	page0_put_char2+2			; 4

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

		inx						; 2
		cpx	#6					; 2
		bne	put_char_inner_loop2			; 3
							;============
							;	43*3

								; -1
		rts						; 6
							;==============
							;	  5


;H0H    **       ******        ** **    ** **      ** ** **    ** ** **
;L0H **    **    **    **   **          **    **   ** ** **    ** ** **
;H0L **    **    **    **   **          **    **   **          **
;L0L ** ** **    ** **      **          **    **   ** **       ** **
;H1H ** ** **    ** ** **   **          **    **   ** **       ** **
;L1H **    **    **    **   **          **    **   **          **
;H1L **    **    **    **   **          **    **   ** ** **    **
;L1L **    **    ** ** **      ** **    ** **      ** ** **    **

.align $100
font_high:
.byte	$f0,$0f,$f0,$ff,$0f,$ff,$00,$00		; A
.byte	$ff,$0f,$f0,$ff,$0f,$ff,$00,$00		; B
.byte	$f0,$0f,$0f,$ff,$00,$00,$00,$00		; C
.byte	$ff,$0f,$f0,$ff,$00,$ff,$00,$00		; D
.byte	$ff,$0f,$0f,$ff,$ff,$f0,$00,$00		; E
.byte	$ff,$0f,$0f,$0f,$ff,$0f,$00,$00		; F

;.align $100
;.byte 0

.align $100

font_low:	; 2 pages later
.byte	$ff,$f0,$ff,$ff,$00,$ff,$00,$00		; A
.byte	$ff,$f0,$0f,$ff,$f0,$ff,$00,$00		; B
.byte	$ff,$00,$00,$0f,$f0,$f0,$00,$00		; C
.byte	$ff,$00,$ff,$ff,$f0,$0f,$00,$00		; D
.byte	$ff,$ff,$0f,$ff,$f0,$f0,$00,$00		; E
.byte	$ff,$ff,$0f,$ff,$00,$00,$00,$00		; F
