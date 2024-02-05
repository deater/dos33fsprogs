; wires -- Apple II Hires


; D0+ used by HGR routines

HGR_COLOR	= $E4
HGR_PAGE	= $E6

GBASL		= $26
GBASH		= $27

HGR_END2	= $FC
HGR_END		= $FD
COUNT		= $FE
FRAME		= $FF

; soft-switches

PAGE1   = $C054
PAGE2   = $C055

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3FFF
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

wires:
	jsr	HGR
	jsr	HGR2		; clear screen PAGE2  A and Y 0 after

reset_x:
	ldx	#$0

switch_pages:
	lda	HGR_PAGE
	eor	#$60
	sta	HGR_PAGE
	cmp	#$40
	bne	switch_page2
	bit	PAGE1
	jmp	outer_loop
switch_page2:
	bit	PAGE2

outer_loop:

	;=====================================
	; pulse loop horizontal
	;=====================================
	; write out pattern to horizontal line
	; due to memory layout by going $4000-$43FF only draw every 8th line


	lda	#$00
	tay

	sta	GBASL

	lda	HGR_PAGE		; point GBASL to $4000
	sta	GBASH

	clc
	adc	#$4
	sta	HGR_END
	adc	#$1C
	sta	HGR_END2
horiz_loop:

	lda	even_lookup,X
	sta	(GBASL),Y
	iny

	lda	odd_lookup,X
	sta	(GBASL),Y
	iny

	bne	noflo2
	inc	GBASH
noflo2:

	lda	HGR_END
	cmp	GBASH
	bne	horiz_loop

	;========================================
	; vertical loop
	;========================================

	; A should already be $44 here
	; Y should be 0
	; X is position in pattern

	; to be honest I don't remember how this works

vert_loop:
	txa

	clc
	adc	#2		; $44 + 2?		= $46
	asl			;			= $8E
	asl			; shift left?		= $1C + carry
	adc	HGR_PAGE	; what?			= $5D
	sbc	GBASH		; huh	- $44		= $19

	cmp	#8		; WHAT IS GOING ON HERE?
	lda	#$81
	bcs	noeor
	ora	#$02
noeor:

	sta	(GBASL),Y	; store it out

	inc	GBASL		; skip two columns
	inc	GBASL
	bne	noflo
	inc	GBASH
noflo:
	lda	HGR_END2
	cmp	GBASH
	bne	vert_loop

	inx			; wrap at 7
	cpx	#7
	beq	reset_x

	bne	switch_pages	; bra

even_lookup:
.byte	$D7,$DD,$F5, $D5,$D5,$D5,$D5
odd_lookup:
.byte	$AA,$AA,$AA, $AB,$AE,$BA,$EA
