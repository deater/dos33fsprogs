.include "zp.inc"

JO		EQU	$00	; fireball out
JX		EQU	$01
JY		EQU	$02
JA		EQU	$03
KO		EQU	$04	; core out
KXL		EQU	$05
KXH		EQU	$06
KY		EQU	$07
KV		EQU	$08
BO		EQU	$09	; blue portal
BXL		EQU	$0A
BXH		EQU	$0B
BY		EQU	$0C
GO		EQU	$0D	; orange portal
GXL		EQU	$0E
GXH		EQU	$0F
GY		EQU	$10


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

SOUND1		EQU	$300
SOUND2		EQU	$301

HGR		EQU	$F3E2
HCLR		EQU	$F3F2
HPOSN		EQU	$F411
HPLOT0		EQU	$F457
HGLIN		EQU	$F53A
XDRAW1		EQU	$F661
COLORTBL	EQU	$F6F6


ending:

	;==========================
	; Init vars
	;==========================

	lda	#0
	sta	JO		; jam out


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


	lda	#150
	sta	KXL
	lda	#0
	sta	KXH
	lda	#65
	sta	KY
	jsr	draw_core


game_loop:
	;===================
	; Physics Engine
	;===================

	; Draw/Move Fireball

	lda	JO
	bne	jo_out

jo_not_out:
	lda	#1		; If JO=0 THEN JO=1
	sta	JO
	lda	#45
	sta	JX		; JX=45
	lda	#10
	sta	JY		; JY=10
	lda	#5
	sta	JA		; JA=5

	lda	#200		; POKE 768,200:POKE 769,10:CALL 770
	sta	SOUND1
	lda	#10
	sta	SOUND2
	jsr	sound

	jmp	jo_draw		; XDRAW 6 AT JX,JY

jo_out:
	jsr	draw_j		; erase old jo
	clc
	lda	JY
	adc	JA
	sta	JY
jo_draw:
	jsr	draw_j		; draw new jo


	; Move Blue Core

	; IF KO=1 THEN KY=KY-KV:KV=KV-4.5




	;====================================
	; Portal Collision Detection
	;====================================

	; 203 IF KO=0 GOTO 206
	; 204 IF KX>BX-12 AND KX<BX+12 AND KY<BY+6 AND KY>BY-6 THEN SCALE=1:KX=GX:KY=GY+6
	; 205 IF KX>GX-12 AND KX<GX+12 AND KY<GY+6 AND KY>GY-6 THEN SCALE=1:KX=BX:KY=BY+6
	; ' Portal/Blob
	; 206 IF L=1 OR JO=0 GOTO 210
	; 207 IF JX>BX-12 AND JX<BX+12 AND JY<BY+6 AND JY>BY-6 THEN SCALE=2:XDRAW 6 AT JX,JY:JX=GX:JY=GY-6:JA=-JA:XDRAW 6 AT JX,JY
	; 208 IF JX>GX-12 AND JX<GX+12 AND JY<GY+6 AND JY>GY-6 THEN SCALE=2:XDRAW 6 AT JX,JY:JX=BX:JY=BY-6:JA=-JA:XDRAW 6 AT JX,JY


	;=====================================
	; Wall Collision Detection
	;=====================================

	; Dropping Blob

	lda	JO
	beq	collide_object
	bmi	collide_object	; IF JO<=0 GOTO 229

	;225 IF JX>CX-5 AND JX<CX+5 AND JY>CY-7 AND JY<CY+7 THEN GOTO 800

	lda	JY
	cmp	#120
	bcc	jo_off

	jsr	draw_j	; IF JY>120 THEN SCALE=2:XDRAW 6 AT JX,JY:JO=0

	lda	#0
	sta	JO
jo_off:

	lda	JA
	bpl	jo_not_up
	lda	JY
	cmp	#5
	bcs	jo_not_up	; IF JA<0 AND JY<5 THEN SCALE=2:XDRAW 6 AT JX,JY:JO=0

	jsr	draw_j

	lda	#0
	sta	JO
jo_not_up:

	; check if hitting glados

	; IF JX>110 AND JX<130 AND JY>60 AND JY<85 THEN GOSUB 3000

	lda	JX
	cmp	#110
	bcc	jo_no_hit
	cmp	#130
	bcs	jo_no_hit
	lda	JY
	cmp	#60
	bcc	jo_no_hit
	cmp	#85
	bcs	jo_no_hit

	jmp	explosion

jo_no_hit:




collide_object:

;' Object
;229 IF KO=1 AND KY>115 THEN KY=115:KV=0
;' Object in Incinerator
;230 IF KO=1 AND KX>240 AND KY>100 THEN GOSUB 4000
;231 GOTO 240

	lda	#128
	jsr	WAIT

	jmp	game_loop



	;======================================
	; Draw J
	;======================================
draw_j:
	lda	#2
	sta	HGR_SCALE	; SCALE=2

	; XDRAW 6 AT JX,JY

	lda	#<fireball
	sta	HGR_SHAPE
	lda	#>fireball
	sta	HGR_SHAPE+1

	; HFNS	puts X-coord in Y,X, Y-coord in A
	; HPOSN sets up GBASL/GBASH

	ldy	#0
	lda	JY
	ldx	JX
	jsr	HPOSN

	lda	#0			; rotation

	jsr	XDRAW1			; (tail call?)

	rts


	;======================
	; Draw Blue Core
	;======================
draw_core:
	lda	#<blue_core
	sta	HGR_SHAPE
	lda	#>blue_core
	sta	HGR_SHAPE+1

	; HFNS	puts X-coord in Y,X, Y-coord in A
	; HPOSN sets up GBASL/GBASH

	; 2005 SCALE=1:KX=150:KY=65:XDRAW 7 AT KX,KY:KO=0

	ldy	KXH
	ldx	KXL
	lda	KY

	jsr	HPOSN

	lda	#0		; rotation

	jsr	XDRAW1

	rts

	;=====================================
	; Draw Explosion
	;=====================================
explosion:



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

	rts




; Script
; shape, x, y
; plasma drop
; plasma drop
; plasma drop
; hit!
; ball fall
; ball fall
; ball fall
; move portal blue
; move portal orange
; ball fall
; ball fall
; ball fall
; ending


	;=============================
	; sound
	;=============================
	; Violin sound, based on: https://gist.github.com/thelbane/9291cc81ed0d8e0266c8
sound:
				; 300
				; 301
	ldy	$0301		; 302
sound_l5:
	lda	$0300		; 305
	sta	$FA
sound_l4:
	ldx	$0300
sound_l2:
	cpx	$FA
	bne	sound_l1
	lda	$C030
sound_l1:
	dex
	bne	sound_l2
	lda	$C030
	dey
	beq	sound_l3
	dec	$FA
	bne	sound_l4
	jmp	sound_l5
sound_l3:
	rts


; 6 FOR L=770 TO 804:READ V:POKE L,V:NEXT L




; Shape Table
.include "objects_shape.inc"

.align $400

; Graphics Background
.incbin	"GLADOS.HGR",4
