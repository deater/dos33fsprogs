
; 11+48 = 59 bytes

gr_setup_line:
	lda	gr_lookup_low,X				; 4
	sta	GBASL					; 3
	lda	gr_lookup_high,X			; 4
	sta	GBASH					; 3
	rts

gr_lookup_low:
	.byte $00,$80,$00,$80,$00,$80,$00,$80
	.byte $28,$A8,$28,$A8,$28,$A8,$28,$A8
	.byte $50,$D0,$50,$D0,$50,$D0,$50,$D0

gr_lookup_high:
	.byte $08,$08,$09,$09,$0A,$0A,$0B,$0B
	.byte $08,$08,$09,$09,$0A,$0A,$0B,$0B
	.byte $08,$08,$09,$09,$0A,$0A,$0B,$0B

	; 28+10 = 38

gr_setup_line2:
	txa
	pha
	and	#7
	lsr
	tax
	lda	gr_lookup_high2,X
	sta	GBASH

	pla
	pha
	lsr
	php
	lsr
	lsr
	plp
	rol
	tax
	lda	gr_lookup_low2,X
	sta	GBASL
	pla
	tax
	rts

; high= gr_lookup_high[(line&3)>>1]
; low = gr_lookup_low[abc defgh -> 0 1 0 1 0 1 2 3 2 3 2 3 2 3 4 5 4 5 4 5 4 5
;			deh

gr_lookup_low2:
	.byte $00,$80,$28,$A8,$50,$D0
gr_lookup_high2:
	.byte $08,$09,$0A,$0B


	; 24 bytes
	; based on GBASCALC from monitor firmware
gr_setup_line3:
	txa								; 2
	lsr								; 2
	and	#$03							; 2
	ora	#$08							; 2
	sta	GBASH							; 3

	txa
	and	#$18
	bcc	gbcalc
	adc	#$7f
gbcalc:
	sta	GBASL
	asl
	asl
	ora	GBASL
	sta	GBASL
	rts

gr_setup_line4:
	txa
	jmp	GBASCALC
