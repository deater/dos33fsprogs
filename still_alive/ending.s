.include "zp.inc"


HGR_SHAPE	EQU	$1A
HGR_SHAPEH	EQU	$1B
HGR_BITS	EQU	$1C
HGR_COUNT	EQU	$1D
HGR_DX		EQU	$D0
HGR_DY		EQU	$D2
HGR_QUADRANT	EQU	$D3
HGR_E		EQU	$D4
HGR_EH		EQU	$D5
HGR_X		EQU	$E0
HGR_Y		EQU	$E2
HGR_COLOR	EQU	$E4
HGR_HORIZ	EQU	$E5
HGR_PAGE	EQU	$E6
HGR_SCALE	EQU	$E7
HGR_COLLISIONS	EQU	$EA
HGR_ROTATION	EQU	$F9

X1		EQU	$FD
X2		EQU	$FE
Y1		EQU	$FF

HGR		EQU	$F3E2
HCLR		EQU	$F3F2
HPOSN		EQU	$F411
HPLOT0		EQU	$F457
HGLIN		EQU	$F53A
XDRAW1		EQU	$F661
COLORTBL	EQU	$F6F6


ending:

	;==========================
	; Setup Graphics
	;==========================

;	We can't use HGR as it clears the screen
;	jsr	HGR

	jsr	HOME

	bit	PAGE0			; first graphics page
	lda	#$20
	sta	HGR_PAGE
	bit	TEXTGR			; mixed text/graphics
	bit	HIRES			; hires mode
	bit	SET_GR			; graphics mode



	lda	#0
	sta	HGR_ROTATION
	lda	#1
	sta	HGR_SCALE


	;======================
	; Draw Chell
	;======================

	lda	#<chell_right
	sta	HGR_SHAPE
	lda	#>chell_right
	sta	HGR_SHAPE+1

	; HFNS	puts X-coord in Y,X, Y-coord in A
	; HPOSN sets up GBASL/GBASH

	ldy	#0
	lda	#112
	ldx	#69
	jsr	HPOSN

	lda	HGR_ROTATION		; rotation

	jsr	XDRAW1


	;======================
	; Draw Blue Core
	;======================

	lda	#<blue_core
	sta	HGR_SHAPE
	lda	#>blue_core
	sta	HGR_SHAPE+1

	; HFNS	puts X-coord in Y,X, Y-coord in A
	; HPOSN sets up GBASL/GBASH

	; 2005 SCALE=1:KX=150:KY=65:XDRAW 7 AT KX,KY:KO=0

	ldy	#0
	lda	#65
	ldx	#150
	jsr	HPOSN

	lda	HGR_ROTATION		; rotation

	jsr	XDRAW1

	;=====================================
	; Draw Explosion
	;=====================================




	; HCOLOR=5
	ldx	#5
	lda	COLORTBL,X		; get color pattern from table
	sta	HGR_COLOR







;4010 FOR X=0 TO 278 STEP 5:HPLOT X,0 TO 120,85:V=PEEK(-16336):NEXT X
	lda	#0
	sta	X1
	sta	X2
loop1:

	bit	$C030

	; HPLOT X,0 to 120,85
	; X= (y,x), Y=a
	ldy	X2
	ldx	X1
	lda	#0

	jsr	HPLOT0

	; X=(x,a), y=Y
	lda	#120
	ldx	#0
	ldy	#85
	jsr	HGLIN

	clc
	lda	X1
	adc	#5
	sta	X1
	lda	X2
	adc	#0
	sta	X2

	cmp	#1
	bne	loop1
	lda	X1
	cmp	#22
	bcc	loop1

;4015 FOR Y=0 TO 159 STEP 5:HPLOT 278,Y TO 120,85:V=PEEK(-16336):NEXT Y

	lda	#0
	sta	Y1
loop2:

	bit	$C030

	; HPLOT 278,Y to 120,85
	; X= (y,x), Y=a
	ldy	#1
	ldx	#22
	lda	Y1

	jsr	HPLOT0

	; X=(x,a), y=Y
	lda	#120
	ldx	#0
	ldy	#85
	jsr	HGLIN

	clc
	lda	Y1
	adc	#5
	sta	Y1

	cmp	#159
	bcc	loop2

;4020 FOR X=278 TO 0 STEP -5:HPLOT X,159 TO 120,85:V=PEEK(-16336):NEXT X
	lda	#22
	sta	X1
	lda	#1
	sta	X2
loop3:

	bit	$C030

	; HPLOT X,159 to 120,85
	; X= (y,x), Y=a
	ldy	X2
	ldx	X1
	lda	#159

	jsr	HPLOT0

	; X=(x,a), y=Y
	lda	#120
	ldx	#0
	ldy	#85
	jsr	HGLIN

	sec
	lda	X1
	sbc	#5
	sta	X1
	lda	X2
	sbc	#0
	sta	X2

	cmp	#0
	bne	loop3
	lda	X1
	cmp	#5
	bcs	loop3

;4025 FOR Y=159 TO 0 STEP -5:HPLOT 0,Y TO 120,85:V=PEEK(-16336):NEXT Y

	lda	#159
	sta	Y1
loop4:

	bit	$C030

	; HPLOT 0,Y to 120,85
	; X= (y,x), Y=a
	ldy	#0
	ldx	#0
	lda	Y1

	jsr	HPLOT0

	; X=(x,a), y=Y
	lda	#120
	ldx	#0
	ldy	#85
	jsr	HGLIN

	sec
	lda	Y1
	sbc	#5
	sta	Y1

	cmp	#$ff
	bne	loop4

infinite_loop:
	jmp	infinite_loop


;.include "../asm_routines/hgr_offsets.s"
;.include "../asm_routines/hgr_putsprite.s"
.include "../asm_routines/hgr_slowclear.s"


; Shape Table
.include "objects_shape.inc"

.align $400

; Graphics Background
.incbin	"GLADOS.HGR",4
