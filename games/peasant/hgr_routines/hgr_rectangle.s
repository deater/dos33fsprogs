; HGR Rectangle (new, from scratch)

; will draw a white rectangle to DRAWPAGE
; will only draw with x-cord in multiples of 7
;	which greatly speeds things up and also removes need for 512 bytes
;	of div7/mod7 lookup tables

; trashes GBASL/GBASH

; Y1 in VGI_RY1
; X1/7 in VGI_RX1
; Y2 in VGI_RY2
; X2/7 in VGI_RX2


OTHER_MASK	= TEMP1
XRUN		= TEMP2



hgr_rectangle:

	lda	#$7f				; white0
						; for purple/green background
	sta	HGR_COLOR

hgr_rectangle_yloop:


	ldx	VGI_RY1
	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	VGI_RX1		; Y is already the RX1/7

hgr_rectangle_xloop:
	lda	HGR_COLOR
	sta	(GBASL),Y

	iny
	cpy	VGI_RX2
	bne	hgr_rectangle_xloop

	inc	VGI_RY1
	lda	VGI_RY1
	cmp	VGI_RY2

	bne	hgr_rectangle_yloop

done_hgr_rectangle:
	rts



