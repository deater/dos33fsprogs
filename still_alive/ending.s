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
PR		EQU	$11
SXH		EQU	$12
SXL		EQU	$13
SY		EQU	$14
UXL		EQU	$15
UXH		EQU	$16
UY		EQU	$17
TIME		EQU	$18

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

SOUND1		EQU	$302
SOUND2		EQU	$303

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
	sta	KO		; core out
	sta	TIME

	lda	#1
	sta	PR		; portals horizontal


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


	;======================
	; Draw Chell
	;======================

	lda	#1
	sta	HGR_SCALE
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

	lda	#0		; rotation

	jsr	XDRAW1

	;============
	; Draw blue core
	;============

	lda	#150
	sta	KXL
	lda	#0
	sta	KXH
	lda	#65
	sta	KY
	jsr	draw_core


	;============================
	; Start with blue portal out
	;============================

	lda	#0
	sta	BO
	sta	SXH
	lda	#45
	sta	SXL
	lda	#100
	sta	SY
	jsr	draw_blue_no_sound

	;============================
	; Start with orange portal out
	;============================

	lda	#0
	sta	GO
	sta	SXH
	lda	#119
	sta	SXL
	lda	#115
	sta	SY
	jsr	draw_orange_no_sound


game_loop:
	lda	KXL			; update core co-ords
	sta	UXL
	lda	KY
	sta	UY
	lda	KXH
	sta	UXH

	lda	TIME
	beq	no_time

	inc	TIME

	cmp	#15
	bne	time_30
time_15:
	lda	#1
	sta	SXH
	lda	#3
	sta	SXL
	lda	#50
	sta	SY
	jsr	draw_blue

	jmp	no_time
time_30:
	cmp	#30
	bne	no_time

	lda	#0
	sta	SXH
	lda	#149
	sta	SXL
	lda	#119
	sta	SY
	jsr	draw_orange


no_time:

	;===================
	; Physics Engine
	;===================

	; Draw/Move Fireball

	ldx	JO
	beq	jo_not_out
	dex
	beq	jo_out
	jmp	done_jo

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

done_jo:

	; Move Blue Core

	lda	KO
	beq	done_move
	; IF KO=1 THEN KY=KY-KV:KV=KV-4.5

	sec
	lda	KY
	sbc	KV
	sta	KY

	sec
	lda	KV
	sbc	#4
	sta	KV

done_move:
	;====================================
	; Portal Collision Detection
	;====================================

	; Portal/Core

	lda	KO
	beq	portal_fb		; IF KO=0 GOTO 206

	; IF KX>BX-12 AND KX<BX+12 AND KY<BY+6 AND KY>BY-6 THEN SCALE=1:KX=GX:KY=GY+6

	lda	GXL
	sec
	sbc	#12
	cmp	KXL
	bcs	no_g_core	; IF KX>GX-12 AND

	lda	GXL
	clc
	adc	#12
	cmp	KXL
	bcc	no_g_core	; KX<GX+12 AND

	lda	GY
	clc
	adc	#6
	cmp	KY
	bcc	no_g_core	; KY<GY+6 AND

	lda	GY
	sec
	sbc	#6
	cmp	KY
	bcs	no_g_core	; KY>GY-6 THEN SCALE=1:KX=BX:KY=BY+6

	lda	BXH
	sta	KXH

	lda	BXL
	sta	KXL
	lda	BY
	clc
	adc	#6
	sta	KY

no_g_core:

	; Portal/Fireball
portal_fb:
	lda	JO
	beq	done_portal_fireball	; IF L=1 OR JO=0 GOTO 210

	; Check blue

	lda	BXL
	sec
	sbc	#12
	cmp	JX
	bcs	no_b_fb		; IF JX>BX-12 AND

	lda	BXL
	clc
	adc	#12
	cmp	JX
	bcc	no_b_fb		; JX<BX+12 AND

	lda	BY
	clc
	adc	#6
	cmp	JY
	bcc	no_b_fb		; JY<BY+6 AND

	lda	BY
	sec
	sbc	#6
	cmp	JY
	bcs	no_b_fb		; JY>BY-6 THEN

	jsr	draw_j		; SCALE=2:XDRAW 6 AT JX,JY

	lda	GXL
	sta	JX		; JX=GX

	lda	GY
	sec
	sbc	#6
	sta	JY		; JY=GY-6

	lda	JA
	eor	#$FF
	clc
	adc	#$1
	sta	JA		; JA=-JA

	jsr	draw_j		; XDRAW 6 AT JX,JY

no_b_fb:

	; 207 IF JX>BX-12 AND JX<BX+12 AND JY<BY+6 AND JY>BY-6 THEN SCALE=2:XDRAW 6 AT JX,JY:JX=GX:JY=GY-6:JA=-JA:XDRAW 6 AT JX,JY

no_o_fb:


	; 208 IF JX>GX-12 AND JX<GX+12 AND JY<GY+6 AND JY>GY-6 THEN SCALE=2:XDRAW 6 AT JX,JY:JX=BX:JY=BY-6:JA=-JA:XDRAW 6 AT JX,JY
done_portal_fireball:

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

	jsr	hit_glados

jo_no_hit:




collide_object:
	; Object and floor
	lda	KO
	beq	done_collide

	lda	KY
	cmp	#115
	bcc	check_incinerator
			; IF KY>115 THEN KY=115:KV=0
	lda	#115
	sta	KY
	lda	#0
	sta	KV

check_incinerator:
	; Object in Incinerator

	lda	KY
	cmp	#100
	bcc	done_collide

	lda	KXH
	bne	incinerated
	lda	KXL
	cmp	#240
	bcc	done_collide
incinerated:
	jmp	explosion	; IF KX>240 AND KY>100 THEN GOSUB 4000


done_collide:




	;===============================
	; Draw Objects
	;===============================

	; Core

	lda	UXH
	cmp	KXH
	bne	blah

	lda	UXL
	cmp	KXL
	bne	blah

	lda	UY
	cmp	KY
	beq	done_draw_objects	; IF UX=KX AND UY=KY GOTO 300

blah:
	jsr	erase_core	; SCALE=1:XDRAW 7 AT UX,UY:XDRAW 7 AT KX,KY

done_draw_objects:

	lda	#228
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
erase_core:
	lda	#<blue_core
	sta	HGR_SHAPE
	lda	#>blue_core
	sta	HGR_SHAPE+1

	; HFNS	puts X-coord in Y,X, Y-coord in A
	; HPOSN sets up GBASL/GBASH

	lda	#1
	sta	HGR_SCALE

	; 2005 SCALE=1:KX=150:KY=65:XDRAW 7 AT KX,KY:KO=0

	ldy	UXH
	ldx	UXL
	lda	UY

	jsr	HPOSN

	lda	#0		; rotation

	jsr	XDRAW1

draw_core:
	lda	#<blue_core
	sta	HGR_SHAPE
	lda	#>blue_core
	sta	HGR_SHAPE+1

	; HFNS	puts X-coord in Y,X, Y-coord in A
	; HPOSN sets up GBASL/GBASH

	lda	#1
	sta	HGR_SCALE

	; 2005 SCALE=1:KX=150:KY=65:XDRAW 7 AT KX,KY:KO=0

	ldy	KXH
	ldx	KXL
	lda	KY

	jsr	HPOSN

	lda	#0		; rotation

	jsr	XDRAW1


	rts

	;==============================
	; Draw Blue Portal
	;==============================
draw_blue:
	; 6002 POKE 768,143:POKE 769,40:CALL 770
	lda	#143
	sta	SOUND1
	lda	#40
	sta	SOUND2
	jsr	sound

draw_blue_no_sound:

	; Erase old
;	lda	PR		; 0 = vertical
;	bne	blue_horizontal

;	lda	#2
;	sta	HGR_SCALE

;	lda	#<portal_vert
;	sta	HGR_SHAPE
;	lda	#>portal_vert
;	sta	HGR_SHAPE+1

;	jmp	blue_portal_erase

blue_horizontal:
	lda	#1
	sta	HGR_SCALE

	lda	#<portal_horiz
	sta	HGR_SHAPE
	lda	#>portal_horiz
	sta	HGR_SHAPE+1

blue_portal_erase:

	lda	BO
	beq	blue_portal_draw

;	6004 SCALE=2: IF PR=1 THEN SCALE=1
;	6005 IF BO=1 THEN XDRAW 2+PR AT BX,BY
;	6010 BX=SX:BY=SY
;	6020 BO=1:XDRAW 2+PR AT BX,BY

	ldy	BXH
	ldx	BXL
	lda	BY

	jsr	HPOSN

	lda	#0		; rotation

	jsr	XDRAW1

blue_portal_draw:

	lda	SXH
	sta	BXH
	lda	SXL
	sta	BXL
	lda	SY
	sta	BY

	lda	#<portal_horiz
	sta	HGR_SHAPE
	lda	#>portal_horiz
	sta	HGR_SHAPE+1

	lda	#1
	sta	BO

	ldy	BXH
	ldx	BXL
	lda	BY

	jsr	HPOSN

	lda	#0		; rotation

	jmp	XDRAW1

	; IF BO=1 AND GO=1 AND L=1 THEN GOTO 7000

;	rts

	;=============================
	; Draw Orange Portal
	;=============================
draw_orange:
	; POKE 768,72:POKE 769,40:CALL 770
	lda	#72
	sta	SOUND1
	lda	#40
	sta	SOUND2
	jsr	sound

draw_orange_no_sound:

	; Erase old
;	lda	PR		; 0 = vertical
;	bne	orange_horizontal

;	lda	#2
;	sta	HGR_SCALE

;	lda	#<portal_vert
;	sta	HGR_SHAPE
;	lda	#>portal_vert
;	sta	HGR_SHAPE+1

;	jmp	orange_portal_erase

orange_horizontal:
	lda	#1
	sta	HGR_SCALE

	lda	#<portal_horiz
	sta	HGR_SHAPE
	lda	#>portal_horiz
	sta	HGR_SHAPE+1

orange_portal_erase:

	lda	GO
	beq	orange_portal_draw

;6104 SCALE=2: IF PR=1 THEN SCALE=1
;6105 IF GO=1 THEN XDRAW 2+PR AT GX,GY
;6110 GX=SX+1:GY=SY
;6120 GO=1:XDRAW 2+PR AT GX,GY

	ldy	GXH
	ldx	GXL
	lda	GY

	jsr	HPOSN

	lda	#0		; rotation

	jsr	XDRAW1

orange_portal_draw:

	lda	SXH
	sta	GXH
	ldx	SXL
	inx
	stx	GXL		; FIXME: overflow
	lda	SY
	sta	GY

	lda	#<portal_horiz
	sta	HGR_SHAPE
	lda	#>portal_horiz
	sta	HGR_SHAPE+1

	lda	#1
	sta	GO

	ldy	GXH
	ldx	GXL
	lda	GY

	jsr	HPOSN

	lda	#0		; rotation

	jmp	XDRAW1


	; IF BO=1 AND GO=1 AND L=1 THEN GOTO 7000

;	rts

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

	;===============================
	; hit glados
	;===============================
hit_glados:
	; 3000 HTAB 3:VTAB 21:PRINT "    Nice job breaking it, hero.    "

	ldy	#10
boom_loop:
	sty	TEMPY

	lda	#110
	sta	JX
	lda	#60
	sta	JY
	jsr	draw_j		; XDRAW 7 AT 110,60
	bit	$C030		; V=PEEK(-16336)
	lda	#130
	sta	JX
	jsr	draw_j		; XDRAW 7 AT 130,60
	lda	#85
	sta	JY
	jsr	draw_j		; XDRAW 7 AT 130,85
	bit	$C030		; V=PEEK(-16336)
	lda	#110
	sta	JX
	jsr	draw_j		; XDRAW 7 AT 110,85
	lda	#120
	sta	JX
	jsr	draw_j		; XDRAW 7 AT 120,85
	bit	$C030		; V=PEEK(-16336)

	ldy	TEMPY
	dey
	bne	boom_loop

	lda	#$ff
	sta	JO		; JO=-1


	; Release the orb
	lda	#1
	sta	KO		; KO=1

	; start time counting
	lda	#1
	sta	TIME

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
	ldy	SOUND2		; 302
sound_l5:
	lda	SOUND1		; 305
	sta	$FA
sound_l4:
	ldx	SOUND1
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
