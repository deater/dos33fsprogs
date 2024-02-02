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
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
HPLOT0		=	$F457

hposn_low	=	$6000
hposn_high	=	$6100

dont:

	jsr	HGR		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

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
	lda	#<companion_cube
	sta	INL
	lda	#>companion_cube
	sta	INH
	jsr	draw_sprite

	lda	#101
	sta	draw_sprite_y_smc+1

	ldx	#38
	lda	#<companion_cube
	sta	INL
	lda	#>companion_cube
	sta	INH
	jsr	draw_sprite


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
