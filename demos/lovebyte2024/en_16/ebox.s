; Tiny Entropy Boxes
; by Vince `Deater` Weaver / dSr

; based on:

; Entropy
; by Dave McKellar of Toronto
; Two-line BASIC program
; Found on Beagle Brother's Apple Mechanic Disk

; 24001 ROT=0:FOR I=1 TO 15: READ A,B: POKE A,B: NEXT: DATA
;       232,252,233,29,7676,1,7678,4,7679,0,7680,18,7681,63,
;       7682,36,7683,36,7684,45,7685,45,7686,54,7687,54,7688,63,
;       7689,0
; 24002 FOR I=1 TO 99: HGR2: FOR E=.08 TO .15 STEP .01:
;       FOR Y=4 to 189 STEP 6: FOR X=4 to 278 STEP 6:
;       SCALE=(RND(1)<E)*RND(1)*E*20+1: XDRAW 1 AT X,Y:
;       NEXT: NEXT: NEXT: NEXT



; zero page locations
HGR_SHAPE	=	$1A

A5H		=	$45	; AREG RESTORE
AREG		=	$45
XREG		=	$46	; XREG RESTORE
YREG		=	$47	; YREG RESTORE
STATUS		=	$48	; FLAGS RESTORE

HGR_SCALE	=	$E7
HGR_ROTATION	=	$F9
FRAME		=	$FC
XPOS		=	$FD
YPOS		=	$FF

; ROM calls
HGR2		=	$F3D8
HPOSN		=	$F411
XDRAW0		=	$F65D
RESTORE		=	$FF3F
SAVE		=	$FF4A	; saves AREG/XREG/YREG/STATUS/STACK (trashes A/X)

.zeropage

entropy:

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this call

eloop:
	; A,Y both 0 here?

	ldy	#180		; Y=180 down to 0 STEP 6
yloop:

	ldx	#4		; FOR X=4 to 278 STEP 6
xloop:

frame_smc:
	lda	$D000		; 3	; also FRAME
	eor	$E000,Y
	cmp	#$7		; 2
	lda	#$1
	adc	#$0
	asl			; want 2 or 4 for scale
	sta	HGR_SCALE

	stx	AREG		; save X to be restored later into A
	sty	YREG		; save Y

	; setup X and Y co-ords
	tya			; YPOS into A
	ldy	#0		; Y always 0
				; XPOS already in X
	jsr	HPOSN		; X= (y,x) Y=(a)
				; saves X,Y,A to zero page


	ldx	#<shape_table	; point to our shape
	lda	#0		; ROT=0
	tay			; ldy	#>shape_table (in zero page so 0)

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit

	jsr	RESTORE		; restore FLAGS/X/Y/A

nextx:				; NEXT X
	inc	frame_smc+1

	; X was restored into A

	; carry usually clear, close enough?
;	clc								; 1
	adc	#6		; x+=6					; 2
	tax
	bne	xloop		; if so, loop				; 2

nexty:
	; carry always set if we get here
;	sec
	tya
	sbc	#6		; y-=6
	tay
	bne	yloop		; if so, loop
	beq	eloop		; bra

shape_table:		;      C   B   A
;	.byte 18	; $12  00 010 010	NDN NDN nop
;	.byte 63	; $3F  00 111 111	LT  LT  nop
;	.byte 36	; $24  00 100 100	UP  UP  nop
;	.byte 36	; $24  00 100 100	UP  UP  nop
;	.byte 45	; $2D  00 101 101	RT  RT  nop
;	.byte 45	; $2D  00 101 101	RT  RT  nop
;	.byte 54	; $36  00 110 110	DN  DN	nop
;	.byte 54	; $36  00 110 110	DN  DN  nop
;	.byte 63	; $3F  00 111 111	LT  LT  nop
;	.byte 0
	.byte 58
	.byte 36
	.byte 45
	.byte 54
	.byte 7
	.byte 0
