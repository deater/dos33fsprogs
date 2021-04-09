
; by Vince `deater` Weaver <vince@deater.net>


; calculating (X^Y) % 9


; zero page

GBASH	=	$27
MASK	=	$2E
COLOR	=	$30

XX	=	$F7
OFFSET	=	$F8
YY_OFFSET=	$F9
YY	=	$FA
OLD	=	$FE
TEMP	=	$FF

; Soft switches
FULLGR	= $C052
PAGE1	= $C054
PAGE2	= $C055
LORES	= $C056		; Enable LORES graphics

; ROM routines
HGR	= $F3E2
HGR2	= $F3D8
PLOT    = $F800		; PLOT AT Y,A
PLOT1	= $F80E		; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
GBASCALC= $F847		; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)
SETCOL  = $F864		; COLOR=A
SETGR   = $FB40


	;================================
	; Clear screen and setup graphics
	;================================
other:
	jsr	SETGR
	bit	FULLGR

	lda	#0
	sta	OFFSET

looper:
	lda	OFFSET
	sta	YY_OFFSET
	ldx	#47
	stx	YY
yloop:

	ldy	#39


	lda	YY
;	txa     ; YY		; plot call needs Y/2
	lsr
	php

	jsr	GBASCALC	; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)

	lda	GBASH
draw_page_smc:
	adc	#0
	sta	GBASH		; adjust for PAGE1/PAGE2 ($400/$800)

	plp
	jsr	$f806		; trick to calculate MASK by jumping
				; into middle of PLOT routine

xloop:
	tya
	clc
	adc	OFFSET
	eor	YY_OFFSET
	jsr	mod_9

	beq	its_zero

	lda	#0

	jmp	setcolor

its_zero:
	lda	#6

setcolor:

	jsr	SETCOL



	txa

	jsr	PLOT1		; plot at Y,A (A trashed, XY Saved)

	dey
	bpl	xloop


	inc	YY_OFFSET
	ldx	YY
	dex
	stx	YY
	bpl	yloop

end:

	ldx	#0
flip_pages:
	lda	draw_page_smc+1 ; DRAW_PAGE
	beq	done_page
	inx
done_page:
	ldy	$C054,X		; set display page to PAGE1 or PAGE2

	eor	#$4		; flip draw page between $400/$800
	sta	draw_page_smc+1	; DRAW_PAGE

	inc	OFFSET
	jmp	looper



	;===============================
	; modulo 9
	;===============================
	; value in A
mod_9:
	; Divide by 9
	; 17 bytes, 30 cycles
	; by Omegamatrix https://forums.nesdev.com/viewtopic.php?t=11336
	sta	OLD

	sta	TEMP
	lsr
	lsr
	lsr
	adc	TEMP
	ror
	adc	TEMP
	ror
	adc	TEMP
	ror
	lsr
	lsr
	lsr

	; A is ORIG/9, mod = OLD-(A*9)
	sta	TEMP

	asl
	asl
	asl
	clc
	adc	TEMP

	eor	#$ff
	sec
	adc	OLD

	rts

	; want this at $3F5, this is $80 in, so $375

	jmp	other
