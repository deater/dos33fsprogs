; Fake Tiny HGr

; Fake 8-byte Apple II Hi-res intro

; by Vince `deater` Weaver, vince@deater.net	--- d e s i r e ---

; "fake" version of my tiny8 8-byte demo for running as part
; of a larger effect


.include "hardware.inc"

; ROM calls
;HGR2		= $F3D8
;BKGND0		= $F3F4	; A is color, after A=$40/$60, Y=0
			; $E6 needs to be $20/$40
			;   alternately can jump slightly further
			;   and have $1B be $20/$40

FRAME	= $D0

WAIT_TIME = 2

tiny_hgr:
	lda	#$0
	sta	FRAME

	jsr	hgr2

chrget:

tiny_loop:

	jsr	random8

	jsr	bkgnd0		; clear screen to value in A
				; $20 $F3 $F4, depends on f3/f4 being nops
				;	first time through the loop

;	lda	#WAIT_TIME
;	jsr	WAIT

	jsr	hgr2		; HGR2	-- init full-screen hi-res graphics
				; zero flag set

;	lda	#WAIT_TIME
;	jsr	WAIT

	inc	FRAME
	lda	FRAME

	cmp	#15
	beq	hgr8_done

	jmp	chrget
hgr8_done:


forever:
	jmp	forever


.include "random8.s"

HGR_PAGE = $E6
HGR_BITS = $E7
HGR_SHAPE = $E8
HGR_SHAPE2 = $E9

hgr2:
	bit	PAGE2
	bit	FULLGR
	lda	#$40
	bne	sethpg		; bra

sethpg:
	sta	HGR_PAGE
	lda	HIRES
	lda	SET_GR

	lda	#$00		; black background

bkgnd0:
	sta	HGR_BITS
bkgnd:
	lda     HGR_PAGE
	sta	HGR_SHAPE+1
	ldy	#$00
	sty	HGR_SHAPE
LF3FE:
	lda	#WAIT_TIME
	jsr	WAIT

	lda	HGR_BITS
	sta	(HGR_SHAPE),Y
	jsr	color_shift
	iny
	bne	LF3FE
	inc	HGR_SHAPE+1
	lda	HGR_SHAPE+1
	and	#$1f
	bne     LF3FE
	rts

color_shift:
	asl
	cmp	#$c0
	bpl	LF489
	lda	HGR_BITS
	eor	#$7f
	sta	HGR_BITS
LF489:
	rts

