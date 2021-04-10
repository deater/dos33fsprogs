; Sort of plotting (X^Y) % 9
; but in hires

; by Vince `deater` Weaver <vince@deater.net>

GBASL		= $26
GBASH		= $27
HGRPAGE		= $E6
HGR_BITS	= $1C
HGR_X		= $E0
HGR_Y		= $E2
HGR_COLOR	= $E4
HGR_HORIZ	= $E5

OUR_MASK	= $FB
YY		= $FC
SAVEX		= $FD
TEMP		= $FE
OLD		= $FF

PAGE0		= $C054
PAGE1		= $C055

COLORTBL	= $F6F6

HGR2		= $F3D8
HGR		= $F3E2
HCLR		= $F3F2
HPOSN		= $F411
HPLOT0  	= $F457		; plot at (Y,X), (A)
HPLOT1		= $F45A		; skip the HPOSN call
COLOR_SHIFT	= $F47E		; shift color for odd/even Y (0..7 or 7..13)
MOVE_RIGHT	= $F48A		; move next plot location one to the right

HCOLOR1		= $F6F0		; set HGR_COLOR to value in X
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us


mod9_lookup = $1000


	;==============================
	; mod9 start
	;==============================
mod9_start:
	jsr	make_mod9_lookup	; setup modulo 9 lookup table
					; could inline it here

	jsr	HGR2		; clear page1
				; A is 0 after

	sta	OUR_MASK

mod9_reset:
	ldy	#0
	sty	YY

mod9_yloop:

	ldy	#0
	ldx	#0		; XX = 0
	lda	YY		; Y co-ord
	jsr	HPOSN		; set cursor position to (Y,X), (A)

	ldx	#0

tiny_xloop:

	stx	SAVEX

;===============here

	txa
	eor	YY
	tax
	lda	mod9_lookup,X


;=================

	ldx	OUR_MASK
	bne	weird_pattern

	cmp	#0
	beq     store_color

        lda     #3
store_color:
	jmp	color_ready




weird_pattern:

	and	OUR_MASK

color_ready:
	tax

	tya
	lsr			; check even or odd
	php

	lda	COLORTBL,X
	sta	HGR_BITS

	plp
	bcc	no_shift

	jsr	COLOR_SHIFT	; if odd then color shift

no_shift:

	jsr	HPLOT1		; plot at current position

	jsr	MOVE_RIGHT	; move current position right (trashes A)

	ldx	SAVEX		; restore X

	;==================================

	inx
	bne	tiny_xloop	; repeat until X=256

	;==================================

	inc	YY		; repeat until Y=192
	ldy	YY
	cpy	#192
	bne	mod9_yloop

	;==================================

change_pattern:
	inc	OUR_MASK	; change pattern
	lda	OUR_MASK

check_4:
	cmp	#4
	bne	check_9
	lda	#8
	sta	OUR_MASK

check_9:
	cmp	#9
	bne	done_check
	lda	#0
	sta	OUR_MASK

done_check:
	jmp	mod9_reset



	;=============================
	; setup the mod9 lookup table
	;=============================
make_mod9_lookup:
	ldy	#0
m9_xreset:
	ldx	#0
m9_loop:
	txa
	sta	mod9_lookup,Y

	iny
	beq	m9_done

	inx
	cpx	#9
	beq	m9_xreset
	bne	m9_loop

m9_done:
	rts
