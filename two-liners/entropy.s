; Entropy
; by Dave McKellar of Toronto
; Two-line BASIC program
; Found on Beagle Brother's Apple Mechanic Disk
; Converted to 6502 Assembly by Deater (Vince Weaver) vince@deater.net

; 24001	ROT=0:FOR I=1 TO 15: READ A,B: POKE A,B: NEXT: DATA
;	232,252,233,29,7676,1,7678,4,7679,0,7680,18,7681,63,
;	7682,36,7683,36,7684,45,7685,45,7686,54,7687,54,7688,63,
;	7689,0
; 24002 FOR I=1 TO 99: HGR2: FOR E=.08 TO .15 STEP .01:
;	FOR Y=4 to 189 STEP 6: FOR X=4 to 278 STEP 6:
;	SCALE=(RND(1)<E)*RND(1)*E*20+1: XDRAW 1 AT X,Y:
;	NEXT: NEXT: NEXT: NEXT


; Optimization
;	144 bytes:	first working version (including DOS33 4-byte size/addr)
;	141 bytes:	nextx: cache XPOS in X register
;	140 bytes:	nexty: we know state of carry flag
;	139 bytes:	change jmp to bcs
;	138 bytes:	jmp at end now fits into a bcs
;	136 bytes:	store YPOS on stack
;	135 bytes:	store X to HGR_SCALE rather than TXA+STA
;	131 bytes:	some fancy branch elimination by noticing X=1
;	126 bytes:	nextx: simplify by using knowledge of possible x/y vals
;	124 bytes:	qkumba noticed we can bump yloop up to include the
;			pha, letting us remove two now unneeded stack ops
;	123 bytes:	qkumba noticed XDRAW0 always exits with X==0 so
;			we can move some things to use X instead and
;			can get a "1" value simply by using INX
;	122 bytes:	Nick Westgate noticed that we could save a byte
;			in eloop by pushing the stx ELOOP to the beginning
;			rather than the end.

;BLT=BCC, BGE=BCS

; zero page locations
HGR_SHAPE	=	$1A
FAC_EXP		=	$9D
FAC_HO		=	$9E
FAC_MOH		=	$9F
FAC_MO		=	$A0
FAC_LO		=	$A1
FAC_SGN		=	$A2
RND_EXP		=	$C9
RND_HO		=	$CA
RND_MOH		=	$CB
RND_MO		=	$CC
RND_LO		=	$CD
RND_SGN		=	$CE
HGR_SCALE	=	$E7
HGR_ROTATION	=	$F9
EPOS		=	$FC
XPOS		=	$FD
XPOSH		=	$FE
YPOS		=	$FF

; ROM calls
CONINT		=	$E6FB
FMULT		=	$E97F
MUL10		=	$EA39
DIV10		=	$EA55
MOVAF		=	$EB63
FLOAT		=	$EB93
RND		=	$EFAE
HGR2		=	$F3D8
HPOSN		=	$F411
XDRAW0		=	$F65D


entropy:

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=$60 after this call

	ldx	#8		; Unlike the BASIC, our loop is *100
				; 8 to 15 rather than .08 to .15
eloop:
	stx	EPOS		; EPOS was temporarily in X


	lda	#4		; FOR Y=4 to 189 STEP 6
yloop:
	pha			; YPOS stored on stack
	lda	#4		; FOR X=4 to 278 STEP 6
	sta	XPOS
	ldx	#0		; can't fit 278 in one byte, need overflow byte
	stx	XPOSH
xloop:


	; SCALE=(RND(1)<E)*RND(1)*E*20+1
	;
	; Equivalent to IF RND(1)<E THEN SCALE=RND(1)*E*20+1
	;		ELSE SCALE=1

	; Note the Apple II generates a seed based on keypresses
	; but by default RND is never seeded from there.
	; Someone actually wrote an entire academic paper complaining about
	; this
	;
	; J.W. Aldridge.  "Cautions regarding random number generation
	;	on the Apple II", Behavior Research Methods, Instruments,
	;	& Computers, 1987, 19 (4), 397-399.

	; Many of these values are in Applesoft 5-byte floating point

				; get random value in FAC
				;    (floating point accumlator)

	inx			; X is always 0 coming in, increment to 1

				; RND(1), Force 1
				; returns "random" value between 0 and 1
	jsr	RND+6		; we skip passing the argument
				; as a floating point value
				; as that would be a pain

 	; Compare to E

	jsr	MUL10		; EPOS is E*100
	jsr	MUL10		; so multiply rand*100 before compare
	jsr	CONINT		; now convert to int, result in X
				; X is now RND(1)*100

	cpx	EPOS		; compare E*100 to RND*100

	ldx	#1		; load 1 into X (this is clever)

	bcs	done		; if EPOS>=RND then SCALE=1, skip ahead

	; SCALE=RND(1)*E*20+1
	; EPOS is E*100, so RND(1)*(EPOS/10)*2+1

	; What this does:
	;	if EPOS is 8,9 then value is either 1 or 2
	;	if EPOS is 10,11,12,13,14 then value is either 1, 2, or 3


				; put random value in FAC
;	ldx	#1		; RND(1), Force 1, this set from earlier
	jsr	RND+6		; skip arg parsing in RND

	lda	EPOS
	jsr	FLOAT		; convert value in A to float in FAC
	jsr	DIV10		; FAC=FAC/10

	ldy	#>RND_EXP	; point (Y,A) to RND value
	lda	#<RND_EXP
	jsr	FMULT		; multiply FAC by RND in (Y,A)

	inc	FAC_EXP		; multiply by 2

	jsr	CONINT		; convert to int (in X)

	inx			; add 1

done:
	stx	HGR_SCALE	; set scale value

	ldy	XPOSH		; setup X and Y co-ords
	ldx	XPOS
	pla			; YPOS is on stack
	pha
	jsr	HPOSN		; X= (y,x) Y=(a)


	ldx	#<shape_table	; point to our shape
	ldy	#>shape_table
	lda	#0		; ROT=0


	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit

nextx:				; NEXT X
	lda	XPOS							; 2
	clc								; 1
	adc	#6		; x+=6					; 2
	sta	XPOS							; 2

	; we know that the X=4 to 278 STEP 6 loop passes through exactly 256
	; so we can check for that by looking for overflow to zero

	bne	skip							; 2
	inc	XPOSH							; 2
skip:
	; the X=4 to 278 STEP 6 loop actually ends when X is at 280, which
	; is 256+24.  The lower part of the loop does not hit 24, so we
	; can check for the end by looking for the low byte at 24.

	cmp	#24		; see if less than 278			; 2
	bne	xloop		; if so, loop				; 2
								;============
								;	 15
nexty:				; NEXT Y
	pla			; YPOS on stack
	adc	#5		; y+=6
				; carry always set coming in, so only add 5
	cmp	#189		; see if less than 189
	bcc	yloop		; if so, loop

nexte:				; NEXT E
	ldx	EPOS
	inx			; EPOS saved at beginning og eloop
	cpx	#15
	bcc	eloop		; branch if <15

	bcs	entropy

shape_table:
;	.byte 1,0				; 1 shape
;	.byte 4,0				; offset at 4 bytes
	.byte 18,63,36,36,45,45,54,54,63,0	; data
