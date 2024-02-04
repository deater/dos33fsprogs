; Don't Tell Valve

; by Vince `deater` Weaver / DsR


; 147 bytes = initial block code
; 144 bytes = optimize color pick
; 137 bytes = optimize table generation
; 135 bytes = more optimization

; zero page locations
GBASL		=	$26
GBASH		=	$27

HGR_X		=	$E0
HGR_Y		=	$E2
HGR_SCALE	=	$E7

TEMPY		=	$F0
HGR_ROTATION	=	$F9

INL		=	$FE
INH		= 	$FF

; ROM locations
HGR2		=	$F3D8
HGR		=	$F3E2
BKGND0          =       $F3F4
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
HPLOT0		=	$F457


hposn_low	=	$6000
hposn_high	=	$6100

dont:

	jsr	HGR		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	lda	#$1
	sta	HGR_SCALE
	lda	#$0
	sta	HGR_ROTATION

	lda	#$80		; clear so we get blue/orange when xdraw
	jsr	BKGND0


	;==========================
	; make table

;	ldy	#0
table_loop:
;	sty	TEMPY
;	lda	#0			; we are out of bounds, does it matter?
;	tax
	tya
	jsr	HPOSN
	ldy	HGR_Y			; HPOSN saves this
	lda	GBASL
	sta	hposn_low,Y
	lda	GBASH
	sta	hposn_high,Y
	iny
;	cpy	#192			; what happens if we run 192..255?
	bne	table_loop

	ldx	#8
draw_loop:
	jsr	draw_box
	dex
	bpl	draw_loop

	ldx	#37
	lda	#<companion_cube
	sta	INL
	lda	#>companion_cube
	sta	INH
	jsr	draw_sprite

	ldx	#34
	lda	#<turret
	sta	INL
	lda	#>turret
	sta	INH
	jsr	draw_sprite

	lda	#101
	sta	draw_sprite_y_smc+1

	ldx	#38
	lda	#<exit_sign
	sta	INL
	lda	#>exit_sign
	sta	INH
	jsr	draw_sprite

;	jsr	do_xdraw

ending:
	jmp	ending


box_color_odd:
	.byte	$2A,$55,$AA,$7F,$7F,$7F,$60,$03,$E0
box_color_even:
	.byte	$55,$2A,$D5,$7F,$7F,$7F,$60,$03,$E0
box_x1:
	.byte	 16, 33,  0,  0, 24, 16, 15, 24, 39
box_x2:
	.byte	 24, 40, 34, 16, 40, 24, 16, 25, 40
box_y1:
	.byte	130, 50, 42,120,120,159,121,121,101
box_y2:
	.byte	159, 57, 43,121,121,160,160,160,120


	;==========================
	; draw box
	;==========================
	; which to draw in X
	;	X preserved?

draw_box:
	lda	box_y1,X		; 3
draw_box_outer:
	sta	TEMPY			; 2
	tay				; 1
	lda	hposn_low,Y		; 3
	sta	GBASL			; 2
	lda	hposn_high,Y		; 3
	sta	GBASH			; 2
	ldy	box_x1,X		; 3
draw_box_inner:
	tya				; 1
	lsr				; 1
	lda	box_color_odd,X		; 3
	bcc	draw_color_odd		; 2	; we might have these flipped
draw_color_even:
	lda	box_color_even,X	; 3
draw_color_odd:
	sta	(GBASL),Y		; 2
	iny				; 1
	tya				; 1
	cmp	box_x2,X		; 3
	bne	draw_box_inner		; 2

	inc	TEMPY			; 2
	lda	TEMPY			; 2
	cmp	box_y2,X		; 3
	bne	draw_box_outer		; 2

	rts				; 1


companion_cube:
	.byte	$6F,$3D			; .@@@@.@@ @.@@@@..
	.byte	$07,$38			; .@@@.... ...@@@..
	.byte	$03,$38			; .@@..... ....@@..
	.byte	$30,$03			; .....@@. @@......
	.byte	$73,$33			; .@@..@@@ @@..@@..
	.byte	$73,$33			; .@@..@@@ @@..@@..
	.byte	$60,$01			; ......@@ @.......
	.byte	$43,$30			; .@@....@ ....@@..
	.byte	$07,$38			; .@@@.... ...@@@..
	.byte	$6F,$3D			; .@@@@.@@ @.@@@@..
	.byte	$00,$00

turret:
	.byte	$E0,$83			; .....@@ @@.....
	.byte	$B0,$86			; ....@@. .@@....
	.byte	$B0,$87			; ....@@= =@@....
	.byte	$B0,$86			; ....@@. .@@....
	.byte	$B0,$87			; ....@@= =@@....
	.byte	$B0,$86			; ....@@. .@@....
	.byte	$B0,$86			; ....@@. .@@....
	.byte	$F0,$87			; ....@@@ @@@....
	.byte	$8C,$98			; ..@@... ...@@..
	.byte	$86,$B0			; .@@.... ....@@.
	.byte	$86,$B0			; .@@.... ....@@.


exit_sign:
	.byte	$7F,$7F			; @@@@@@@ @@@@@@@
	.byte	$1F,$7F			; @@@@@.. @@@@@@@
	.byte	$3F,$7E			; @@@@@@. .@@@@@@
	.byte	$7F,$7C			; @@@@@@@ ..@@@@@
	.byte	$7F,$79			; @@@@@@@ @..@@@@
	.byte	$03,$70			; @@..... ....@@@
	.byte	$7F,$79			; @@@@@@@ @..@@@@
	.byte	$7F,$7C			; @@@@@@@ ..@@@@@
	.byte	$3F,$7E			; @@@@@@. .@@@@@@
	.byte	$1F,$7F			; @@@@@.. @@@@@@@
	.byte	$7F,$7F			; @@@@@@@@@@@@@@@

; note: these can't cross a page boundary or you'll get corruption

	;==========================
	; draw sprite
	;==========================
	; INL/INH is sprite
	; X is X location

draw_sprite:
	stx	draw_sprite_xpos+1
draw_sprite_y_smc:
	lda	#50			; 2	; Y position
	sta	draw_sprite_y_end_smc+1
	sec
	sbc	#11
draw_sprite_outer:
	sta	TEMPY			; 2
	tay				; 1
	lda	hposn_low,Y		; 3
	clc
draw_sprite_xpos:
	adc	#37			; Xpos=37
	sta	GBASL			; 2
	lda	hposn_high,Y		; 3
	sta	GBASH			; 2

	ldy	#0			; 2

	lda	(INL),Y
	sta	(GBASL),Y
	iny
	lda	(INL),Y
	sta	(GBASL),Y

	inc	INL
	inc	INL

	inc	TEMPY			; 2
	lda	TEMPY			; 2
draw_sprite_y_end_smc:
	cmp	#50			; 3
	bne	draw_sprite_outer	; 2

	rts				; 1



	;====================================

do_xdraw:

	; A and Y are 0 here.
	; X is left behind by the boot process?

	; set GBASL/GBASH
	; we really have to call this, otherwise it won't run
	; on some real hardware depending on setup of zero page at boot


	ldy	#0
	ldx	#139
	lda	#96
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??

	ldx	#<our_shape		; load $E2 into A, X, and Y
	ldy	#>our_shape		; 	our shape table is in ROM at $E2E2
	lda	#0

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	rts




;.byte	$07,$00
;.byte	$10,$00, $1b,$00, $2e,$00
;.byte	$42,$00, $61,$00, $80,$00
;.byte	$8a,$00

; crosshair

.byte	$1b,$6d,$39,$97,$12,$24,$24,$24
.byte	$24,$04,$00

; portal

.byte	$1b,$24,$0c,$24,$0c
.byte	$15,$36,$0e,$36,$36,$1e,$36,$1e
.byte	$1c,$24,$1c,$24,$04,$00

; sideways portal

.byte	$52,$0d
.byte	$0d,$0d,$6c,$24,$1f,$fc,$1f,$1f
.byte	$1f,$1f,$1f,$fe,$36,$0d,$6e,$0d
.byte	$05,$00

; chell right
our_shape:
.byte	$1b,$36,$36,$36,$0d,$df
.byte	$1b,$24,$0c,$24,$24,$1c,$24,$64
.byte	$69,$1e,$37,$2d,$1e,$77,$6e,$25
.byte	$2d,$2d,$f5,$ff,$13,$2d,$2d,$2d
.byte	$00

; chell left

.byte	$09,$36,$36,$36,$1f,$4d,$09
.byte	$24,$1c,$24,$24,$0c,$24,$e4,$fb
.byte	$0e,$35,$3f,$0e,$f5,$fe,$27,$3f
.byte	$3f,$77,$6d,$11,$3f,$3f,$3f,$00

; fireball

.byte	$12,$0c,$0c,$1c,$1c,$1e,$1e,$0e
.byte	$0e,$00

; blue core
.byte	$fa,$24,$0d,$0d,$36,$9f
.byte	$3a,$3f,$3c,$3c,$2c,$3c,$0c,$25
.byte	$2d,$2d,$2d,$2e,$2e,$3e,$2e,$1e
.byte	$37,$3f,$07,$00
