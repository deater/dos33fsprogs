; sierpinski-like demo
; based on the code from Hellmood's Memories demo

; 140 bytes -- enough for appleiibot plus {B11} directive
;			to allow for decompression time

; the simple sierpinski you more or less just plot
;		X AND Y

; Hellmood's you plot something more or less like
; 	COLOR = ( (Y-(X*T)) & (X+(Y*T) ) & 0xf0
; where T is an incrementing frame value

; to get speed on 6502/Apple II we change the multiplies to
; a series of 16-bit 8.8 fixed point adds

.include "hardware.inc"

GBASH	=	$27
MASK	=	$2E
COLOR	=	$30
;XX	=	$F7
XX_TH	=	$F8
XX_TL	=	$F9
;YY	=	$FA
YY_TH	=	$FB
YY_TL	=	$FC
T_L	=	$FD
T_H	=	$FE
SAVED	=	$FF


	;================================
	; Clear screen and setup graphics
	;================================
sier:

	jsr	SETGR		; set lo-res 40x40 mode
	bit	FULLGR		; make it 40x48

	lda	#0		; start with multiplier 0
	sta	T_L
	sta	T_H

sier_outer:

	ldx	#0		; YY starts at 0
	stx	YY_TL
	stx	YY_TH

sier_yloop:

	; calc YY_T (8.8 fixed point add)
	; save space by skipping clc as it's only a slight variation w/o
;	clc
	lda	YY_TL
	adc	T_L
	sta	YY_TL
	lda	YY_TH
	adc	T_H
	sta	YY_TH

	txa	; YY			; plot call needs Y/2
	lsr

	bcc	even_mask
	ldy	#$f0
	.byte	$C2	; bit hack
even_mask:
	ldy	#$0f
	sty	MASK

	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

	lda	GBASH

draw_page_smc:
	adc	#0
	sta	GBASH		 ; adjust for PAGE1/PAGE2 ($400/$800)


	; reset XX to 0

	ldy	#0		; XX
	sty	XX_TL
	sty	XX_TH


sier_xloop:

	; want (YY-(XX*T)) & (XX+(YY*T)


	; SAVED = XX+(Y*T)
;	clc
	tya		; XX
	adc	YY_TH
	sta	SAVED


	; calc XX*T
;	clc
	lda	XX_TL
	adc	T_L
	sta	XX_TL
	lda	XX_TH
	adc	T_H
	sta	XX_TH


	; calc (YY-X_T)
	txa	; lda YY
	sec
	sbc	XX_TH

	; want (YY-(XX*T)) & (XX+(YY*T)

	and	SAVED

	and	#$f0

	beq	green
black:
	lda	#00	; black
	.byte	$2C	; bit trick
green:
	lda	#$CC	; green
	sta	COLOR

	; XX value already in Y

	jsr	PLOT1		; PLOT AT (GBASL),Y

	iny		; XX
	cpy	#40
	bne	sier_xloop

	inx		; YY
	cpx	#48
	bne	sier_yloop

	; inc T
;	clc
	lda	T_L
blah_smc:
	adc	#1
	sta	T_L
	lda	T_H
	adc	#0
	sta	T_H

	; speed up the zoom as it goes
	inc	blah_smc+1

flip_pages:
	ldx	#0

	lda	draw_page_smc+1 ; DRAW_PAGE
	beq	done_page
	inx
done_page:
	ldy	PAGE0,X         ; set display page to PAGE1 or PAGE2

	eor	#$4             ; flip draw page between $400/$800
	sta	draw_page_smc+1 ; DRAW_PAGE

	jmp	sier_outer	; just slightly too far???

	; for maximum twitter size we enter this program
	; by using the "&" operator which jumps to $3F5

	; we can't load there though as the code would end up overlapping
	; $400 which is the graphics area

	; this is at 389
	; we want to be at 3F5, so load program at 36C?
	jmp	sier		; entry point from &
