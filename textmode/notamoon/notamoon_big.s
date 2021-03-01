; death star?

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

; zero page
CV	=	$25
BASL	=	$28
BASH	=	$29
SEEDL	=	$4E
INL	=	$66
INH	=	$67
;LINE	=	$68
;MAXX	=	$69

; soft-switches
MOUSETEXT	= $C00F		; (write) to enable mouse text

; rom routines
HOME		= $FC58		; Clear the text screen
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us
VTAB		= $FC22		; calc screen position in CV, put in (BASL)
VTABZ		= $FC24		; calc screen position in A, put in (BASL)

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
	ldy	#0
star_loop:
	jsr	random8
	sta	BASL

	jsr	random8
	and	#$3
	clc
	adc	#$4
	sta	BASH
	lda	#'.'|$80
	sta	(BASL),Y
	dex
	bne	star_loop

	;=======================
	; Display Death Star
	;=======================

	ldx	#0
	lda	#3
	sta	CV
ds_loop:
	;============================
	; draw grey line
	;============================
grey_line:
	jsr	VTAB		; position VTAB based on CV
	ldy	ds_data,X
	inx
	lda	ds_data,X
	sta	grey_smc+1
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
	inc	CV
	cpx	#12
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
	ldx	#12
tie_move:
	; draw
	lda	#90
	sta	$428,X		; line 8 (vtab 9)
	lda	#91
	sta	$429,X
	lda	#95
	sta	$42A,X

	; delay a bit
	lda	#200
	jsr	WAIT

	; erase
	lda	#' '|$80
	sta	$428,X
	sta	$429,X
	sta	$42A,X

	inx
	cpx	#38
	bne	tie_move

	jmp	tie_loop


	;=============================
	; random8
	;=============================
	; 8-bit 6502 Random Number Generator
	; Linear feedback shift register PRNG by White Flame
	; http://codebase64.org/doku.php?id=base:small_fast_8-bit_prng

random8:
	lda	SEEDL							; 2
	beq	doEor							; 2
	asl								; 1
	beq	noEor	; if the input was $80, skip the EOR		; 2
	bcc	noEor							; 2
doEor:
	eor	#$1d							; 2
noEor:
	sta	SEEDL
	rts




ds_data:
.byte	8,11
.byte	7,12
.byte	6,13
.byte	6,13
.byte	7,12
.byte	8,11
