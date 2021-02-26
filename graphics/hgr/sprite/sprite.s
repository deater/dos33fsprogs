GBASL	= $26
GBASH	= $27
HGRPAGE	= $E6

SPRITE_OFFSET = $F9
XDIR	= $FA
YDIR	= $FB
YC	= $FC
MY	= $FD
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
	sta	MY

	lda	#$FF
	sta	YDIR
	sta	XDIR

move_sprite:

	jsr	draw_sprite

	lda	#100
	jsr	WAIT

	jsr	draw_sprite


	lda	XX
	clc
	adc	XDIR
	sta	XX
	beq	switch_xdir
	cmp	#240
	bcc	noswitch_xdir

switch_xdir:
	lda	XDIR
	eor	#$FF
	sta	XDIR
	inc	XDIR		; two's complement
noswitch_xdir:



	lda	MY
	clc
	adc	YDIR
	sta	MY
	beq	switch_ydir
	cmp	#177
	bne	noswitch_ydir

switch_ydir:
	lda	YDIR
	eor	#$FF
	sta	YDIR
	inc	YDIR		; two's complement
noswitch_ydir:


	jmp	move_sprite



draw_sprite:

	lda	MY
	sta	YY

	lda	#14
	sta	YC

	lda	#0
	sta	SPRITE_OFFSET

sprite_loop:

	ldy	#0
	ldx	XX
	lda	YY

	jsr	HPOSN	;; (Y,X) = X, A = Y

	jsr	plot_line
	jsr	plot_line

	inc	YY

	dec	YC
	bne	sprite_loop

	rts

plot_line:
	ldx	SPRITE_OFFSET
	lda	(GBASL),Y
	eor	ball,X
	inc	SPRITE_OFFSET
	sta	(GBASL),Y
	iny
	rts



ball:
	.byte	$7f,$7a
	.byte	$7f,$7f
	.byte	$7f,$7f
	.byte	$7f,$7f
	.byte	$7f,$7f
	.byte	$7f,$7f
	.byte	$7f,$7f
	.byte	$7f,$7f
	.byte	$7f,$7f
	.byte	$7f,$7f
	.byte	$7f,$7f
	.byte	$7f,$7f
	.byte	$7f,$7f
	.byte	$7f,$7f

