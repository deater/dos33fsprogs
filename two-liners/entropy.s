; Entropy
; by Dave McKellar of Toronto
; Two-line BASIC program
; Found on Beagle Brother's Apple Mechanic Disk
; Converted to 6502 Assembly by Vince Weaver

; 24001	ROT=0:FOR I=1 TO 15: READ A,B: POKE A,B: NEXT: DATA
;	232,252,233,29,7676,1,7678,4,7679,0,7680,18,7681,63,
;	7682,36,7683,36,7684,45,7685,45,7686,54,7687,54,7688,63,
;	7689,0
; 24002 FOR I=1 TO 99: HGR2: FOR E=.08 TO .15 STEP .01:
;	FOR Y=4 to 189 STEP 6: FOR X=4 to 278 STEP 6:
;	SCALE=(RND(1)<E)*RND(1)*E*20+1: XDRAW 1 AT X,Y:
;	NEXT: NEXT: NEXT

; Optimization
;	144 bytes:	first working version (including DOS33 4-byte size/addr)

;BLT=BCC, BGE=BCS

; zero page locations
HGR_SHAPE	=	$1A
TEMP1_EXP	=	$93
TEMP1_HO	=	$94
TEMP1_MOH	=	$95
TEMP1_MO	=	$96
TEMP1_LO	=	$97
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
SNGFLT		=	$E301
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
; ROM constants
TEN		=	$EA50

entropy:

	jsr	HGR2			; HGR2
					; Hires, no text at bottom

	lda	#8
	sta	EPOS			; Unlike BASIC, our loop is *10
					; 8 to 15 rather than .08 to .15

eloop:
	lda	#4			; FOR Y=4 to 189 STEP 6
	sta	YPOS
yloop:
	lda	#4			; FOR X=4 to 278 STEP 6
	sta	XPOS
	lda	#0			; can't fit 278 in one byte, need oflo
	sta	XPOSH
xloop:


	; SCALE=(RND(1)<E)*RND(1)*E*20+1
	;
	; Equivalent to IF RND(1)<E THEN SCALE=RND(1)*E*20+1
	;		ELSE SCALE=1

	; E=.08 80% of time less, so 0 + (0 to .08)*20 = 0 to 1.6
	; 80% of time 1 to 2.6, 20% of time 2 to 3.6
	; E=.15 65% 0+(0 to .15)*20 = 0 to 3
	; 65% 1 to 4, 45% 2 to 5

	; Note the Apple II generates a seed based on keypresses
	; but by default RND is never seeded from there.
	; Someone actually wrote an entire academic paper complaining about
	; this
	;
	; J.W. Aldridge.  "Cautions regarding random number generation
	;	on the Apple II", Behavior Research Methods, Instruments,
	;	& Computers, 1987, 19 (4), 397-399.

					; put random value in FAC
	ldx	#1			; RND(1), Force 1
	jsr	RND+6			; we skip passing the argument
					; in FAC as that would be a pain

 	; Compare to E

;	ldy	#>TEN
;	lda	#<TEN
	jsr	MUL10
	jsr	MUL10

	jsr	CONINT
debug:
	; X is now RND(1)*100

	cpx	EPOS
	bcc	less		; branch if less than EPOS
more:
	lda	#1		; the boring case
	jmp	done
less:
	; SCALE=RND(1)*E*20+1
	; EPOS is E*100, so RND(1)*(EPOS/10)*2+1
	; is EPOS/4 close enough?
					; put random value in FAC
	ldx	#1			; RND(1), Force 1
	jsr	RND+6			; we skip passing the argument
					; in FAC as that would be a pain

	lda	EPOS
	jsr	FLOAT			; convert value in A to float in FAC
;	jsr	MOVAF			; mov FAC into ARG
	jsr	DIV10			; FAC=FAC/10

	ldy	#>RND_EXP
	lda	#<RND_EXP

	jsr	FMULT			; multiply FAC by (Y,A)

	inc	FAC_EXP			; multiply by 2

	jsr	CONINT			; convert to int (in X)

	inx
	txa				; move to A
;	lsr
;	clc
;	adc	#1

done:
	sta	HGR_SCALE

	ldy	XPOSH
	ldx	XPOS
	lda	YPOS

	jsr	HPOSN			; X= (y,x) Y=(a)


	ldx	#<shape_table
	ldy	#>shape_table
	lda	#0			; ROT=0


	jsr	XDRAW0			; XDRAW 1 AT X,Y

nextx:				; NEXT X
	lda	XPOS							; 2
	clc								; 1
	adc	#6		; x+=6					; 2
	sta	XPOS							; 2

	lda	#0		; inc high bit if we wrap past 256	; 2
	adc	XPOSH							; 2
	sta	XPOSH							; 2

	beq	xloop		; if high byte zero, not at end		; 2
	lda	XPOS							; 2
	cmp	#22		; see if less than 278			; 2
	bcc	xloop		; if so, loop				; 2
								;============
								;	 21
nexty:				; NEXT Y
	lda	YPOS
	clc
	adc	#6
	sta	YPOS
	cmp	#189
	bcc	yloop
nexte:				; NEXT E
	inc	EPOS
	lda	EPOS
	cmp	#15
	bcc	eloop

	jmp	entropy

shape_table:
;	.byte 1,0				; 1 shape
;	.byte 4,0				; offset at 4 bytes
	.byte 18,63,36,36,45,45,54,54,63,0	; data
