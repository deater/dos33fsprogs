; That's not a moon....

; by Vince `deater` Weaver, dSr, Lovebyte 2021

; based on the following BASIC program

; 1HOME:POKE49167,0
; 2FORX=0TO64:POKE1024+RND(1)*999,174:NEXT
; 3FORI=0TO1:COLOR=6-I:FORJ=0TO1
; 4HLIN8,10AT6+J*10+I:HLIN7,11AT8+J*6+I:HLIN6,12AT10+J*2+I:NEXTJ,I
; 6VTAB6:HTAB11:?"()"
; 7FORX=13TO37:POKE1063+X,90:POKE1064+X,91:POKE1065+X,95
; 8FORI=1TO200:NEXT:VTAB9:HTABX:?"   ":NEXT
; 9GOTO7

; 167 -- initial implementation
; 170 -- smooth grey support
; 152 -- make death star data byte array
; 148 -- make death star VTAB not hardcoded
; 144 -- move to zero page
; 136 -- index into ROM for "random" numbers
; 133 -- optimize star placement
; 131 -- note when X already 0
; 130 -- optimize tie erase
; 126 -- more optimize death star drawing
; 124 -- use the DEC CV the instruction before VTAB

; need 124 for lovebyte

; zero page
CV	=	$25
BASL	=	$28
BASH	=	$29
SEEDL	=	$4E
INL	=	$66
INH	=	$67

; soft-switches
MOUSETEXT	= $C00F		; (write) to enable mouse text

; rom routines
HOME		= $FC58		; Clear the text screen
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us
VTAB		= $FC22		; calc screen position in CV, put in (BASL)
VTABZ		= $FC24		; calc screen position in A, put in (BASL)

.zeropage
.globalzp grey_smc,ds_data,star_store_smc,tie_data

	;=======================
	; Clear screen and setup
	;=======================
sw:

	jsr	HOME		; clear the screen
	sta	MOUSETEXT	; enable mouse text

	;=======================
	; Display Stars
	;=======================

	ldx	#64
star_loop:
	lda	$F100,X
	eor	$F300,X		; fake random
	tay

	lda	$F800,X
	eor	$F900,X		; more fake random
	and	#$3
	ora	#$4
	sta	star_store_smc+2

	lda	#'.'|$80
star_store_smc:
	sta	$400,Y
	dex
	bne	star_loop

	;=======================
	; Display Death Star
	;=======================

;	ldx	#0		; X already 0
	lda	#9		; count backwards
	sta	CV
ds_loop:
	;============================
	; draw grey line
	;============================
grey_line:
	jsr	$FC20		; this is a DEC CV line before VTAB
;	jsr	VTAB		; position VTAB based on CV
	sec
	lda	#19
	sbc	ds_data,X
	sta	grey_smc+1
	ldy	ds_data,X

;	inx
;	lda	ds_data,X
;	sta	grey_smc+1
	inx
grey_loop:
	clc
	tya
	and	#$1
	adc	#$56		; make it an even grey
	sta	(BASL),Y
	iny
grey_smc:
	cpy	#0
	bne	grey_loop
;	inc	CV
	cpx	#6
	bne	ds_loop

	; draw reflector
	lda	#'('+$80	; 5,10?
	sta	$68A
	lda	#')'+$80	; 5,11?
	sta	$68B


	;=======================
	; Draw Tie Fighter
	;=======================

tie_loop:
	ldy	#12

tie_move:

	; draw tie

	ldx	#2
xloop1:
	lda	tie_data,X
	sta	$428,Y		; line 8 (vtab 9)
	iny
	dex
	bpl	xloop1

	; delay a bit
	lda	#200
	jsr	WAIT

	; erase

	lda	#$A0			; space (the final frontier)
xloop2:
	dey
	sta	$428,Y			; line 8 (vtab 9)
	inx
	cpx	#2
	bne	xloop2

	iny
	cpy	#38
	bne	tie_move

	beq	tie_loop

tie_data:
.byte 95,91,90


ds_data:
.byte	8;,11
.byte	7;,12
.byte	6;,13
.byte	6;,13
.byte	7;,12
.byte	8;,11
