
clear_bottom:
	; draw rectangle

	lda     #$00            ; color is black1
	sta     VGI_RCOLOR

	lda     #0
	sta     VGI_RX1
cb_smc1:
	lda     #183
	sta     VGI_RY1
	lda	#140
	sta	VGI_RXRUN
	lda	#9
        sta     VGI_RYRUN

        jsr     vgi_simple_rectangle

	lda     #140
	sta     VGI_RX1
cb_smc2:
	lda     #183
	sta     VGI_RY1
	lda	#140
	sta	VGI_RXRUN
	lda	#9
        sta     VGI_RYRUN

        jsr     vgi_simple_rectangle

	rts
