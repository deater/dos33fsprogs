; Fake Tiny HGr

; Fake 8-byte Apple II Hi-res intro

; by Vince `deater` Weaver, vince@deater.net	--- d e s i r e ---

; "fake" version of my tiny8 8-byte demo for running as part
; of a larger effect


WAIT_TIME = 2

fake_hgr8:

	lda	#$0
	sta	FRAME

;	jsr	hgr2

chrget:

tiny_loop:

	jsr	random8

	jsr	bkgnd0		; clear screen to value in A
				; $20 $F3 $F4, depends on f3/f4 being nops
				;	first time through the loop

	jsr	hgr2		; HGR2	-- init full-screen hi-res graphics
				; zero flag set

	inc	FRAME
	lda	FRAME

	cmp	#HGR8_LENGTH
	beq	hgr8_done

	jmp	chrget
hgr8_done:


	rts



;.include "random8.s"


hgr2:
	bit	PAGE2
	bit	FULLGR
	lda	#$40
	bne	sethpg		; bra

sethpg:
	sta	FAKE_HGR_PAGE
	lda	HIRES
	lda	SET_GR

	lda	#$00		; black background

bkgnd0:
	sta	FAKE_HGR_BITS
bkgnd:
	lda     FAKE_HGR_PAGE
	sta	FAKE_HGR_SHAPE+1
	ldy	#$00
	sty	FAKE_HGR_SHAPE
LF3FE:
	lda	#WAIT_TIME
	jsr	wait

	lda	FAKE_HGR_BITS
	sta	(FAKE_HGR_SHAPE),Y
	jsr	color_shift
	iny
	bne	LF3FE
	inc	FAKE_HGR_SHAPE+1
	lda	FAKE_HGR_SHAPE+1
	and	#$1f
	bne     LF3FE
	rts

color_shift:
	asl
	cmp	#$c0
	bpl	LF489
	lda	FAKE_HGR_BITS
	eor	#$7f
	sta	FAKE_HGR_BITS
LF489:
	rts

