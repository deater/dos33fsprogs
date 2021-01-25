
.include "zp.inc"

dgr_view:
	sta	EIGHTYCOL	; 80col    C00d
	lda	SET_GR		; graphics C050
	lda	LORES		; lores    C056
	lda	FULLGR		; mixset   C053
	sta	SET80STORE	; 80store  C001
	lda	AN3		; AN3      C05E

	;==================
	; myst
	;==================

	lda	#<myst_aux
	sta	aux_smc1+1
	lda	#>myst_aux
	sta	aux_smc1+2

	lda	#<myst_bin
	sta	bin_smc1+1
	lda	#>myst_bin
	sta	bin_smc1+2

	; copy to AUX
	bit	PAGE1
	jsr	copy_to_aux

	; copy to MAIN
	bit	PAGE0
	jsr	copy_to_main

myst_wait:
	lda	KEYPRESS
	bpl	myst_wait
	bit	KEYRESET


	;==================
	; channelwood
	;==================

	lda	#<channelwood_aux
	sta	aux_smc1+1
	lda	#>channelwood_aux
	sta	aux_smc1+2

	lda	#<channelwood_bin
	sta	bin_smc1+1
	lda	#>channelwood_bin
	sta	bin_smc1+2

	; copy to AUX
	bit	PAGE1
	jsr	copy_to_aux

	; copy to MAIN
	bit	PAGE0
	jsr	copy_to_main

cw_wait:
	lda	KEYPRESS
	bpl	cw_wait
	bit	KEYRESET

	;==================
	; selenetic
	;==================

	lda	#<selenetic_aux
	sta	aux_smc1+1
	lda	#>selenetic_aux
	sta	aux_smc1+2

	lda	#<selenetic_bin
	sta	bin_smc1+1
	lda	#>selenetic_bin
	sta	bin_smc1+2

	; copy to AUX
	bit	PAGE1
	jsr	copy_to_aux

	; copy to MAIN
	bit	PAGE0
	jsr	copy_to_main



forever:
	jmp	forever


	;===============================
	; copy to AUX
	;===============================
copy_to_aux:

	lda	#<$400
	sta	smc2+1
	lda	#>$400
	sta	smc2+2

	ldy	#0
ctp1_outer_loop:
	ldx	#0
ctp1_loop:

aux_smc1:
	lda	$9999,X
smc2:
	sta	$400,X
	inx
	cpx	#120
	bne	ctp1_loop

	lda	aux_smc1+1
	clc
	adc	#$80
	sta	aux_smc1+1
	lda	aux_smc1+2
	adc	#0
	sta	aux_smc1+2

	lda	smc2+1
	clc
	adc	#$80
	sta	smc2+1
	lda	smc2+2
	adc	#0
	sta	smc2+2


	iny
	cpy	#8
	bne	ctp1_outer_loop
	rts

	;=========================
	; copy to main
	;=========================
copy_to_main:

	lda	#<$400
	sta	smc4+1
	lda	#>$400
	sta	smc4+2

	ldy	#0
ctp2_outer_loop:
	ldx	#0
ctp2_loop:

bin_smc1:
	lda	$9999,X
smc4:
	sta	$400,X
	inx
	cpx	#120
	bne	ctp2_loop

	lda	bin_smc1+1
	clc
	adc	#$80
	sta	bin_smc1+1
	lda	bin_smc1+2
	adc	#0
	sta	bin_smc1+2

	lda	smc4+1
	clc
	adc	#$80
	sta	smc4+1
	lda	smc4+2
	adc	#0
	sta	smc4+2


	iny
	cpy	#8
	bne	ctp2_outer_loop
	rts


channelwood_aux:
.incbin "CHANNELWOOD.DGRA"
channelwood_bin:
.incbin "CHANNELWOOD.DGRB"

myst_aux:
.incbin "MYST.DGRA"
myst_bin:
.incbin "MYST.DGRB"

selenetic_aux:
.incbin "SELENETIC.DGRA"
selenetic_bin:
.incbin "SELENETIC.DGRB"


.if 0
lookup:
	;       0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
	.byte $00,$08,$01,$09,$02,$0A,$03,$0B,$04,$0C,$05,$0D,$06,$0E,$07,$0F
	.byte $80,$88,$81,$89,$82,$8A,$83,$8B,$84,$8C,$85,$8D,$86,$8E,$87,$8F
	.byte $10,$18,$11,$19,$12,$1A,$13,$1B,$14,$1C,$15,$1D,$16,$1E,$17,$1F
	.byte $90,$98,$91,$99,$92,$9A,$93,$9B,$94,$9C,$95,$9D,$96,$9E,$97,$9F
	.byte $20,$28,$21,$29,$22,$2A,$23,$2B,$24,$2C,$25,$2D,$26,$2E,$27,$2F
	.byte $A0,$A8,$A1,$A9,$A2,$AA,$A3,$AB,$A4,$AC,$A5,$AD,$A6,$AE,$A7,$AF
	.byte $30,$38,$31,$39,$32,$3A,$33,$3B,$34,$3C,$35,$3D,$36,$3E,$37,$3F
	.byte $B0,$B8,$B1,$B9,$B2,$BA,$B3,$BB,$B4,$BC,$B5,$BD,$B6,$BE,$B7,$BF
	.byte $40,$48,$41,$49,$42,$4A,$43,$4B,$44,$4C,$45,$4D,$46,$4E,$47,$4F
	.byte $C0,$C8,$C1,$C9,$C2,$CA,$C3,$CB,$C4,$CC,$C5,$CD,$C6,$CE,$C7,$CF
	.byte $50,$58,$51,$59,$52,$5A,$53,$5B,$54,$5C,$55,$5D,$56,$5E,$57,$5F
	.byte $D0,$D8,$D1,$D9,$D2,$DA,$D3,$DB,$D4,$DC,$D5,$DD,$D6,$DE,$D7,$DF
	.byte $60,$68,$61,$69,$62,$6A,$63,$6B,$64,$6C,$65,$6D,$66,$6E,$67,$6F
	.byte $E0,$E8,$E1,$E9,$E2,$EA,$E3,$EB,$E4,$EC,$E5,$ED,$E6,$EE,$E7,$EF
	.byte $70,$78,$71,$79,$72,$7A,$73,$7B,$74,$7C,$75,$7D,$76,$7E,$77,$7F
	.byte $F0,$F8,$F1,$F9,$F2,$FA,$F3,$FB,$F4,$FC,$F5,$FD,$F6,$FE,$F7,$FF

.endif
