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


.include "hardware.inc"

GBASH	=	$27
MASK	=	$2E
COLOR	=	$30
SEEDL	=	$4E

FRAME	=	$F9
XX	=	$FA
YY	=	$FB
BUF1L	=	$FC
BUF1H	=	$FD
BUF2L	=	$FE
BUF2H	=	$FF


	;================================
	; Clear screen and setup graphics
	;================================
drops:

	jsr	SETGR		; set lo-res 40x40 mode
	bit	FULLGR		; make it 40x48


drops_outer:

	inc	FRAME

	lda	FRAME
	and	#$f
	bne	no_drop

	jsr	random8

	; buffer is 40x48 = roughly 2k?
	; so random top bits = 0..7

	lda	SEEDL
	sta	BUF1L
	and	#$7
	clc
	adc	#$20
	sta	BUF1H

	lda	#$1f

	ldy	#41
	sta	(BUF1L),Y
	iny
	sta	(BUF1L),Y
	ldy	#81
	sta	(BUF1L),Y
	iny
	sta	(BUF1L),Y

no_drop:


	lda	FRAME
	and	#$1
	beq	even_frame

even_frame:
	lda	#$20
	sta	BUF1H
	lda	#$40
	sta	BUF2H
	jmp	done_frame
odd_frame:
	lda	#$40
	sta	BUF1H
	lda	#$20
	sta	BUF2H

done_frame:

	lda	#$00
	sta	BUF1L
	sta	BUF2L

	lda	#48
	sta	YY

drops_yloop:

	lda	YY		; plot call needs Y/2
	lsr

	bcc	even_mask
	ldy	#$f0
	.byte	$C2		; bit hack
even_mask:
	ldy	#$0f
	sty	MASK

	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

	lda	GBASH

draw_page_smc:
	adc	#0
	sta	GBASH		 ; adjust for PAGE1/PAGE2 ($400/$800)


	; reset XX to 0

	lda	#40		; XX
	sta	XX

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
	sec
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
	and	#$f
	tay
	lda	colors,Y
	sta	COLOR

	ldy	XX
	jsr	PLOT1		; PLOT AT (GBASL),Y

	dec	XX
	bpl	drops_xloop

	dec	YY
	bpl	drops_yloop



flip_pages:
	ldx	#0

	lda	draw_page_smc+1 ; DRAW_PAGE
	beq	done_page
	inx
done_page:
	ldy	PAGE0,X         ; set display page to PAGE1 or PAGE2

	eor	#$4             ; flip draw page between $400/$800
	sta	draw_page_smc+1 ; DRAW_PAGE

	jmp	drops_outer	; just slightly too far???



colors:
.byte $00,$22,$66,$EE,$77,$FF,$FF,$FF

	;=============================
	; random8
	;=============================
	; 8-bit 6502 Random Number Generator
	; Linear feedback shift register PRNG by White Flame
	; http://codebase64.org/doku.php?id=base:small_fast_8-bit_prng

random8:
	lda	SEEDL                                                   ; 2
	beq	doEor                                                   ; 2
	asl                                                             ; 1
	beq	noEor	; if the input was $80, skip the EOR            ; 2
	bcc	noEor                                                   ; 2
doEor:
	eor	#$1d                                                    ; 2
noEor:
	sta	SEEDL

	rts





	; for maximum twitter size we enter this program
	; by using the "&" operator which jumps to $3F5

	; we can't load there though as the code would end up overlapping
	; $400 which is the graphics area

	; this is at 389
	; we want to be at 3F5, so load program at 36C?

	jmp	drops		; entry point from &





