; water drops

; based roughly on
; https://github.com/seban-slt/Atari8BitBot/blob/master/ASM/water/water.m65

; for each pixel

;         C
;       A V B
;         D
;
; calculate color as NEW_V = (A+B+C+D)/2 - OLD_V
; then flip buffers



	;================================
	; Clear screen and setup graphics
	;================================
drops:
	jsr	HGR		; clear $2000-$4000 to zero
				; A is $00 after this
				; Y is $00

	sta	FRAME

	bit	FULLGR		; full page
	bit	LORES		; switch to LORES

drops_outer:

	; in all but first loop X is $FF on arrival

;	inx
	stx	BUF1L
	stx	BUF2L

	;=================================
	; handle new frame
	;=================================

	inc	FRAME
	lda	FRAME
	tay			; save frame in Y

	; alternate $20/$28 in BUF1H/BUF2H

	and	#$1
	asl
	asl
	asl			; A now 0 or 8

	ora	#$20
	sta	BUF1H
	eor	#$8
	sta	BUF2H

	; check if we add new raindrop

	tya			; reload FRAME
	and	#$3		; only drop every 4 frames
	bne	no_drop

	; fake random number generator by reading ROM

	lda	$E000,Y		; based on FRAME

	; buffer is 40x48 = roughly 2k?
	; so random top bits = 0..7

	sta	DROPL
	and	#$7
	ora	#$20
	sta	DROPH

	lda	#31	; $1f	value for drop

	tay		; cheat and draw drop at offset 31 to reuse value

	sta	(DROPL),Y	; draw at offset 31
	iny
	sta	(DROPL),Y	; draw at offset 32

	ldy	#71
	sta	(DROPL),Y	; draw at offset 71 (y+1)
	iny
	sta	(DROPL),Y	; draw at offset 72

no_drop:


	ldx	#47	 ; load 47 into YY


	;=================================
	; yloop
	;=================================

drops_yloop:

	; reset XX to 39

	lda	#39	; XX
	sta	XX

	tay
	txa		; YY into A

			; plot 39,YY
	jsr	PLOT	; PLOT Y,A, setting up MASK and putting addr in GBASL/H


	;=================================
	; xloop
	;=================================

drops_xloop:

	clc
	ldy	#1
	lda	(BUF1L),Y
	ldy	#81
	adc	(BUF1L),Y
	ldy	#40
	adc	(BUF1L),Y
	ldy	#42
	adc	(BUF1L),Y
	lsr
	dey

;	sec
	sbc	(BUF2L),Y
	bpl	done_calc
	eor	#$ff
done_calc:
	sta	(BUF2L),Y

	inc	BUF1L
	inc	BUF2L
	bne	no_oflo

	inc	BUF1H
	inc	BUF2H

no_oflo:

	; adjust color

	lsr
	lsr
	and	#$3
	tay
	lda	colors,Y
	sta	COLOR

	ldy	XX
	jsr	PLOT1		; PLOT AT (GBASL),Y

	dec	XX
	bpl	drops_xloop

	dex	; YY
	bpl	drops_yloop

weird_outer:

;	bmi	drops_outer	; small enough now!

	lda	FRAME
	cmp	#64
	beq	drops_done
	jmp	drops_outer
drops_done:
	rts


colors:
.byte $22,$66,$77,$ff

;colors:
;.byte $00,$22,$66,$EE,$77,$ff,$ff,$ff

; 0       2    6    e    7    f    f    f
; 0000 0010 0110 1110 0111 1111 1111 1111
;    0    1    2    3    4    5    6    7

