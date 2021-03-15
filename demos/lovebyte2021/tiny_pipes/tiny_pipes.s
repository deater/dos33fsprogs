; Tiny Pipes
;
; 64 Byte Apple II Demo for Lovebyte 2021
;
; by Vince `deater` Weaver <vince@deater.net> / dSr

; Roughly based on "Entropy" by Dave McKellar of Toronto
; A Two-line BASIC program Found on Beagle Brother's Apple Mechanic Disk
;
; It is XORing vector squares across the screen.  Randomly the size
;	is changed while doing this.


; 24001	ROT=0:FOR I=1 TO 15: READ A,B: POKE A,B: NEXT: DATA
;	232,252,233,29,7676,1,7678,4,7679,0,7680,18,7681,63,
;	7682,36,7683,36,7684,45,7685,45,7686,54,7687,54,7688,63,
;	7689,0
; 24002 FOR I=1 TO 99: HGR2: FOR E=.08 TO .15 STEP .01:
;	FOR Y=4 to 189 STEP 6: FOR X=4 to 278 STEP 6:
;	SCALE=(RND(1)<E)*RND(1)*E*20+1: XDRAW 1 AT X,Y:
;	NEXT: NEXT: NEXT: NEXT

; Optimization
;	88 bytes -- hack up the entropy code
;	83 bytes -- count down YPOS instead of up
;	73 bytes -- XPOS only up to 256
;	73 bytes -- move to zero page
;	65 bytes -- move XPOS/YPOS into X/Y, use RESTORE

; zero page locations
HGR_SHAPE	=	$1A
A5H		=	$45
XREG		=	$46
YREG		=	$47
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

.zeropage

pipes:

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this call

eloop:
	ldy	#180		; Y=180 down to 0 STEP 6
yloop:

	ldx	#4		; FOR X=4 to 278 STEP 6
xloop:

frame_smc:
	lda	$D000		; 3	; also FRAME
	and	#1		; 2
	sta	HGR_SCALE	; 2
	inc	HGR_SCALE	; 2

	stx	XREG		; save X
	sty	YREG		; save Y

	; setup X and Y co-ords
	tya			; YPOS into A
	ldy	#0		; Y always 0
				; XPOS already in X
	jsr	HPOSN		; X= (y,x) Y=(a)



	ldx	#<shape_table	; point to our shape
	lda	#0		; ROT=0
	tay			; ldy	#>shape_table


	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit

	jsr	RESTORE		; restore FLAGS/X/Y/A

nextx:				; NEXT X
	inc	frame_smc+1

	txa
	clc								; 1
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
	beq	eloop

shape_table:
	.byte 18,63,36,36,45,45,54,54,63,0	; shape data (a square)
