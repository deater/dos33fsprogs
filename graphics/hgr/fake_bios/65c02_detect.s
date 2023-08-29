
	; relies on different behavior of decimal mode on 6502 vs 65c02
detect_65c02:
	sed			; set decimal mode
	clc			; clear carry for add
	lda	#$99		; 99 decimal
	adc	#$01		; +1 gives 00 and sets Z on 65C02
	cld			; exit decimal mode

	rts
