GBASL	= $26
GBASH	= $27
HGRPAGE	= $E6

XX	= $FE
YY	= $FF

PAGE0	= $C054
PAGE1	= $C055

HGR	= $F3E2
HGR2	= $F3D8
HCLR	= $F3F2
HPOSN	= $F411			;; (Y,X) = X, A = Y
				;; line addr in GBASL/GBASH
				;; 	with offset in HGR.HORIZ, Y
WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

sprite:
	jsr	HGR		; clear page0
	jsr	HGR2		; clear page1
				; HGR page now $40

	lda	#50
	sta	XX
	sta	YY

move_sprite:

draw_sprite:

	ldy	#0
	ldx	XX
	lda	YY

	jsr	HPOSN

;	ldy	#0
	lda	(GBASL),Y
	eor	#$7f
	sta	(GBASL),Y
	iny
	lda	(GBASL),Y
	eor	#$7f
	sta	(GBASL),Y

	inc	XX
	inc	YY
	lda	YY
	cmp	#190
	bcc	no_oflo
	lda	#0
	sta	YY
no_oflo:


	jmp	move_sprite
