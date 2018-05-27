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


; zero page locations
HGR_SHAPE	=	$1A
HGR_SCALE	=	$E7
HGR_ROTATION	=	$F9
XPOS		=	$FD
XPOSH		=	$FE
YPOS		=	$FF

; ROM calls
HGR2		=	$F3D8
HPOSN		=	$F411
XDRAW0		=	$F65D

entropy:

loop:
	jsr	HGR2			; HGR2

eloop:	; FOR E=.08 TO .15 STEP .01:

	lda	#4
	sta	YPOS
yloop:					; FOR Y=4 to 189 STEP 6
	lda	#4
	sta	XPOS
	lda	#0
	sta	XPOSH
xloop:					; FOR X=4 to 278 STEP 6

	lda	#1
	sta	HGR_SCALE

	; SCALE=(RND(1)<E)*RND(1)*E*20+1
	; E=.08 80% of time less, so 0 + (0 to .08)*20 = 0 to 1.6
	; 80% of time 1 to 2.6, 20% of time 2 to 3.6
	; E=.15 65% 0+(0 to .15)*20 = 0 to 3
	; 65% 1 to 4, 45% 2 to 5
 


	ldy	XPOSH
	ldx	XPOS
	lda	YPOS

	jsr	HPOSN			; X= (y,x) Y=(a)


	ldx	#<shape_table
	ldy	#>shape_table
	lda	#0			; ROT=0


	jsr	XDRAW0			; XDRAW 1 AT X,Y

; NEXT X
	lda	XPOS
	clc
	adc	#6
	sta	XPOS
	lda	#0
	adc	XPOSH
	sta	XPOSH
	beq	xloop
	lda	XPOS
	cmp	#22
	bcc	xloop
nexty:

; NEXT Y
	lda	YPOS
	clc
	adc	#6
	sta	YPOS
	cmp	#189
	bcc	yloop
; NEXT E

	jmp	loop

shape_table:
;	.byte 1,0				; 1 shape
;	.byte 4,0				; offset at 4 bytes
	.byte 18,63,36,36,45,45,54,54,63,0	; data
