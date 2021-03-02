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


; 211 bytes -- initial
; 208 bytes -- use HGR2 to clear
; 204 bytes -- optimize buffer switch
; 197 bytes -- inline random8
; 169 bytes -- rip out page flipping
; 163 bytes -- use EOR for BUFH setting
; 159 bytes -- put YY in X
; 153 bytes -- fake random by reading ROM
; 151 bytes -- no seed at all, use frame
; 149 bytes -- FRAME saved in Y
; 148 bytes -- beq instead of jmp
; 147 bytes -- reuse color in drop
; 145 bytes -- leave out carry setting
; 142 bytes -- reduce to 4 colors (from 8)
; 141 bytes -- don't dex at beginning ($FF close enough)
; 138 bytes -- no need for jmp at end (not bot)



; zero page

GBASH	=	$27
MASK	=	$2E
COLOR	=	$30
SEEDL	=	$4E

FRAME	=	$F8
XX	=	$F9
DROPL	=	$FA
DROPH	=	$FB
BUF1L	=	$FC
BUF1H	=	$FD
BUF2L	=	$FE
BUF2H	=	$FF

; soft switches
FULLGR	=	$C052
LORES	=	$C056	; Enable LORES graphics


; ROM routines
HGR	= $F3E2
HGR2	= $F3D8
PLOT	= $F800		;; PLOT AT Y,A
PLOT1	= $F80E		;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)



	;================================
	; Clear screen and setup graphics
	;================================
drops:
	jsr	HGR		; clear $2000-$4000 to zero
				; A is $00 after this
				; Y is $00

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

	bmi	drops_outer	; small enough now!

colors:
.byte $22,$66,$77,$ff

;colors:
;.byte $00,$22,$66,$EE,$77,$ff,$ff,$ff

; 0       2    6    e    7    f    f    f
; 0000 0010 0110 1110 0111 1111 1111 1111
;    0    1    2    3    4    5    6    7

