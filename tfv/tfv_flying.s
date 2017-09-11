SHIPY		EQU	$E4

; FIXME, sort out available ZP page space
TURNING		EQU	$60
SCREEN_X	EQU	$61
SCREEN_Y	EQU	$62
ANGLE		EQU	$63

HORIZ_SCALE_I	EQU	$64
HORIZ_SCALE_F	EQU	$65
FACTOR_I	EQU	$66
FACTOR_F	EQU	$67
DX_I		EQU	$68
DX_F		EQU	$69
SPACEX_I	EQU	$6A
SPACEX_F	EQU	$6B
CX_I		EQU	$6C
CX_F		EQU	$6D
DY_I		EQU	$6E
DY_F		EQU	$6F
SPACEY_I	EQU	$70
SPACEY_F	EQU	$71
CY_I		EQU	$72
CY_F		EQU	$73
TEMP_I		EQU	$74
TEMP_F		EQU	$75
DISTANCE_I	EQU	$76
DISTANCE_F	EQU	$77
SPACEZ_I	EQU	$78
SPACEZ_F	EQU	$79
DRAW_SPLASH	EQU	$7A
SPEED		EQU	$7B

;===========
; CONSTANTS
;===========
SHIPX		EQU	15
TILE_W		EQU	64
TILE_H		EQU	64
MAP_MASK	EQU	(TILE_W - 1)
LOWRES_W	EQU	40
LOWRES_H	EQU	40



flying_start:

	;===================
	; Clear screen/pages
	;===================

	jsr	clear_screens
	jsr     set_gr_page0

	;===============
	; Init Variables
	;===============
	lda	#20
	sta	SHIPY
	lda	#0
	sta	TURNING
	sta	ANGLE
	sta	SPACEX_I
	sta	SPACEY_I
	sta	CX_I
	sta	CX_F
	sta	CY_I
	sta	CY_F
	sta	DRAW_SPLASH
	sta	SPEED

	lda	#4
	sta	SPACEZ_I
	lda	#$80
	sta	SPACEZ_F

flying_loop:

	lda	DRAW_SPLASH
	beq	flying_keyboard
	dec	DRAW_SPLASH	; decrement splash count

flying_keyboard:


	jsr	get_key		; get keypress

	lda	LASTKEY

	cmp	#('Q')		; if quit, then return
	bne	skipskip
	rts

skipskip:

	cmp	#('I')
	bne	check_down

	;===========
	; UP PRESSED
	;===========

	lda	SHIPY
	cmp	#17
	bcc	check_down	; bgt, if shipy>16
	dec	SHIPY
	dec	SHIPY		; move ship up
	inc	SPACEZ_I	; incement height

check_down:
	cmp	#('M')
	bne	check_left

	;=============
	; DOWN PRESSED
	;=============

	lda	SHIPY
	cmp	#28
	bcs	check_left	; ble, if shipy < 28
	inc	SHIPY
	inc	SHIPY		; move ship down
	dec	SPACEZ_I	; decrement height

check_left:
	cmp	#('J')
	bne	check_right

	;=============
	; LEFT PRESSED
	;=============

	lda	TURNING
	bmi	turn_left
	beq	turn_left

	lda	#$0
	sta	TURNING
	clv
	bvc	check_right

turn_left:
	lda	#253	; -3
	sta	TURNING

	dec	ANGLE

check_right:
	cmp	#('K')
	bne	check_speedup

	;==============
	; RIGHT PRESSED
	;==============

	lda	TURNING		;; FIXME: optimize me
	bpl	turn_right
	lda	#0
	sta	TURNING
	clv
	bvc	check_speedup

turn_right:
	lda	#3
	sta	TURNING

	inc	ANGLE

check_speedup:
	cmp	#('Z')
	bne	check_speeddown

	;=========
	; SPEED UP
	;=========
	lda	#$3
	cmp	SPEED
	beq	check_speeddown
	inc	SPEED

check_speeddown:
	cmp	#('X')
	bne	check_brake

	;===========
	; SPEED DOWN
	;===========

	lda	SPEED
	beq	check_brake
	dec	SPEED

check_brake:
	cmp	#(' '+128)
	bne	check_land

	;============
	; BRAKE
	;============
	lda	#$0
	sta	SPEED

check_land:
	cmp	#13
	bne	check_help

	;=====
	; LAND
	;=====


check_help:
	cmp	#('H')
	bne	check_done

	;=====
	; HELP
	;=====


check_done:

	;================
	; Wrap the Angle
	;================

	lda	ANGLE
	and	#$f
	sta	ANGLE

	;================
	; Handle Movement
	;================

speed_move:
	ldx	SPEED
	beq	draw_background

	lda	ANGLE		; dx.i=fixed_sin[(angle+4)&0xf].i; // cos()
	clc
	adc	#4
	and	#$f
	asl
	tay
	lda	fixed_sin_scale,Y
	sta	DX_I
	iny			; dx.f=fixed_sin[(angle+4)&0xf].f; // cos()
	lda	fixed_sin_scale,Y
	sta	DX_F

	lda	ANGLE		; dy.i=fixed_sin[angle&0xf].i; // sin()
	and	#$f
	asl
	tay
	lda	fixed_sin_scale,Y
	sta	DY_I
	iny			; dx.f=fixed_sin[angle&0xf].f; // sin()
	lda	fixed_sin_scale,Y
	sta	DY_F

speed_loop:

	clc			; fixed_add(&cx,&dx,&cx);
	lda	CX_F
	adc	DX_F
	sta	CX_F
	lda	CX_I
	adc	DX_I
	sta	CX_I

	clc			; fixed_add(&cy,&dy,&cy);
	lda	CY_F
	adc	DY_F
	sta	CY_F
	lda	CY_I
	adc	DY_I
	sta	CY_I

	dex
	bne	speed_loop


	;====================
	; Draw the background
	;====================
draw_background:
	jsr	draw_background_mode7

	;==============
	; Draw the ship
	;==============

	clv
	lda	TURNING
	beq	draw_ship_forward
	bpl	draw_ship_right
	bmi	draw_ship_left		;; FIXME: optimize order

draw_ship_forward:
	; Draw Shadow
	lda     #>shadow_forward
        sta     INH
        lda     #<shadow_forward
        sta     INL
	lda	#(SHIPX+3)
	sta	XPOS
	clc
	lda	SPACEZ_I
	adc	#31
	sta	YPOS
	jsr	put_sprite

	lda     #>ship_forward
        sta     INH
        lda     #<ship_forward
        sta     INL
	bvc	draw_ship

draw_ship_right:

	dec	TURNING

	; Draw Shadow
	lda     #>shadow_right
        sta     INH
        lda     #<shadow_right
        sta     INL
	lda	#(SHIPX+3)
	sta	XPOS
	clc
	lda	SPACEZ_I
	adc	#31
	sta	YPOS
	jsr	put_sprite

	lda     #>ship_right
        sta     INH
        lda     #<ship_right
        sta     INL
	bvc	draw_ship

draw_ship_left:

	inc	TURNING

	; Draw Shadow
	lda     #>shadow_left
        sta     INH
        lda     #<shadow_left
        sta     INL
	lda	#(SHIPX+3)
	sta	XPOS
	clc
	lda	SPACEZ_I
	adc	#31
	sta	YPOS
	jsr	put_sprite

	lda     #>ship_left
        sta     INH
        lda     #<ship_left
        sta     INL

draw_ship:
	lda	#SHIPX
	sta	XPOS
	lda	SHIPY
	sta	YPOS
	jsr	put_sprite

	;==================
	; flip pages
	;==================

	jsr	page_flip

	;==================
	; loop forever
	;==================

	jmp	flying_loop


;===========================
; Draw the Mode7 Background
;===========================

draw_background_mode7:

	; Draw Sky

	lda	#COLOR_BOTH_MEDIUMBLUE	; MEDIUMBLUE color
	sta	COLOR

	lda	#0
sky_loop:				; draw line across screen
	ldy	#40			; from y=0 to y=6
	sty	V2
	ldy	#0
	pha
	jsr	hlin_double		; hlin y,V2 at A
	pla
	clc
	adc	#2
	cmp	#6
	bne	sky_loop

	; Draw Horizon

	lda	#COLOR_BOTH_GREY	; Horizon is Grey
	sta	COLOR
	lda	#6			; draw single line at 6/7
	ldy	#40
	sty	V2			; hlin	Y,V2 at A
	ldy	#0
	jsr	hlin_double		; hlin	0,40 at 6

	; fixed_mul(&space_z,&BETA,&factor);

	lda	SPACEZ_I
	sta	NUM1H
	lda	SPACEZ_F
	sta	NUM1L

	lda	#$ff	; BETA_I
	sta	NUM2H
	lda	#$80	; BETA_F
	sta	NUM2L

;; TEST
;;	lda	#$0
;;	sta	NUM1H
;;	lda	#$2
;;	sta	NUM1L

;;	lda	#$0
;;	sta	NUM2H
;;	lda	#$3
;;	sta	NUM2L



	jsr	multiply

	lda	RESULT+2
	sta	FACTOR_I
	lda	RESULT+1
	sta	FACTOR_F

	;; SPACEZ=78  * ff80 = FACTOR=66

	;; C
	;; GOOD 4 80 * ffffffff 80 = fffffffd c0
	;; BAD  4 80 * ffffffff 80 = 42 40

	lda	#8
	sta	SCREEN_Y

screeny_loop:
	ldy	#0
	jsr	hlin_setup		; y-coord in a, x-coord in y
					; sets up GBASL/GBASH

	lda	#0			; horizontal_scale.i = 0
	sta	HORIZ_SCALE_I

	;horizontal_scale.f=
	;	horizontal_lookup[space_z.i&0xf][(screen_y-8)/2];

	lda	SPACEZ_I
	and	#$f
	asl
	asl
	asl
	asl
	sta	TEMP_I

	sec
	lda	SCREEN_Y
	sbc	#8
	lsr
	clc
	adc	TEMP_I
	tay
	lda	horizontal_lookup,Y
	sta	HORIZ_SCALE_F

	;; brk ASM, horiz_scale = 00:73

	; calculate the distance of the line we are drawing
	; fixed_mul(&horizontal_scale,&scale,&distance);
	lda	HORIZ_SCALE_I
	sta	NUM1H
	lda	HORIZ_SCALE_F
	sta	NUM1L
	lda	#$14	; SCALE_I
	sta	NUM2H
	lda	#$00	; SCALE_F
	sta	NUM2L
	jsr	multiply
	lda	RESULT+2
	sta	DISTANCE_I
	lda	RESULT+1
	sta	DISTANCE_F

	;; brk ASM, distance = 08:fc

	; calculate the dx and dy of points in space when we step
	; through all points on this line

	lda	ANGLE	; dx.i=fixed_sin[(angle+8)&0xf].i; // -sin()
	clc
	adc	#8
	and	#$f
	asl
	tay
	lda	fixed_sin,Y
	sta	DX_I
	iny		; dx.f=fixed_sin[(angle+8)&0xf].f; // -sin()
	lda	fixed_sin,Y
	sta	DX_F

	; fixed_mul(&dx,&horizontal_scale,&dx);
	lda	HORIZ_SCALE_I
	sta	NUM1H
	lda	HORIZ_SCALE_F
	sta	NUM1L
	lda	DX_I
	sta	NUM2H
	lda	DX_F
	sta	NUM2L
	jsr	multiply
	lda	RESULT+2
	sta	DX_I
	lda	RESULT+1
	sta	DX_F

	;; ANGLE
	;; brk ASM, dx = 00:00

	lda	ANGLE		; dy.i=fixed_sin[(angle+4)&0xf].i; // cos()
	clc
	adc	#4
	and	#$f
	asl
	tay
	lda	fixed_sin,Y
	sta	DY_I
	iny			; dy.f=fixed_sin[(angle+4)&0xf].f; // cos()
	lda	fixed_sin,Y
	sta	DY_F

	; fixed_mul(&dy,&horizontal_scale,&dy);
	lda	HORIZ_SCALE_I
	sta	NUM1H
	lda	HORIZ_SCALE_F
	sta	NUM1L
	lda	DY_I
	sta	NUM2H
	lda	DY_F
	sta	NUM2L
	jsr	multiply
	lda	RESULT+2
	sta	DY_I
	lda	RESULT+1
	sta	DY_F

	;; brk ASM, dy = 00:73

	; calculate the starting position

				; fixed_add(&distance,&factor,&space_x);
	clc			; fixed_add(&distance,&factor,&space_y);
	lda	DISTANCE_F
	adc	FACTOR_F
	sta	SPACEY_F
	sta	SPACEX_F
	lda	DISTANCE_I
	adc	FACTOR_I
	sta	SPACEY_I
	sta	SPACEX_I

	;; brk	space_x = 06:bc

	lda	ANGLE	; fixed_temp.i=fixed_sin[(angle+4)&0xf].i; // cos
	clc
	adc	#4
	and	#$f
	asl
	tay
	lda	fixed_sin,Y
	sta	TEMP_I
	iny		; fixed_temp.f=fixed_sin[(angle+4)&0xf].f; // cos
	lda	fixed_sin,Y
	sta	TEMP_F

	; fixed_mul(&space_x,&fixed_temp,&space_x);
	lda	SPACEX_I
	sta	NUM1H
	lda	SPACEX_F
	sta	NUM1L
	lda	TEMP_I
	sta	NUM2H
	lda	TEMP_F
	sta	NUM2L
	jsr	multiply
	lda	RESULT+2
	sta	SPACEX_I
	lda	RESULT+1
	sta	SPACEX_F


	clc			; fixed_add(&space_x,&cx,&space_x);
	lda	SPACEX_F
	adc	CX_F
	sta	SPACEX_F
	lda	SPACEX_I
	adc	CX_I
	sta	SPACEX_I

	lda	#$ec		; fixed_temp.i=0xec;      // -20 (LOWRES_W/2)
	sta	TEMP_I
	lda	#0		; fixed_temp.f=0;
	sta	TEMP_F

	; fixed_mul(&fixed_temp,&dx,&fixed_temp);
	lda	TEMP_I
	sta	NUM1H
	lda	TEMP_F
	sta	NUM1L
	lda	DX_I
	sta	NUM2H
	lda	DX_F
	sta	NUM2L
	jsr	multiply
	lda	RESULT+2
	sta	TEMP_I
	lda	RESULT+1
	sta	TEMP_F


	clc			; fixed_add(&space_x,&fixed_temp,&space_x);
	lda	SPACEX_F
	adc	TEMP_F
	sta	SPACEX_F
	lda	SPACEX_I
	adc	TEMP_I
	sta	SPACEX_I

	;; brk	space_x = 06:bc

	lda	ANGLE	; fixed_temp.i=fixed_sin[angle&0xf].i;
	and	#$f
	asl
	tay
	lda	fixed_sin,Y
	sta	TEMP_I
	iny		; fixed_temp.f=fixed_sin[angle&0xf].f;
	lda	fixed_sin,Y
	sta	TEMP_F


	; fixed_mul(&space_y,&fixed_temp,&space_y);
	lda	SPACEY_I
	sta	NUM1H
	lda	SPACEY_F
	sta	NUM1L
	lda	TEMP_I
	sta	NUM2H
	lda	TEMP_F
	sta	NUM2L
	jsr	multiply
	lda	RESULT+2
	sta	SPACEY_I
	lda	RESULT+1
	sta	SPACEY_F


	clc			; fixed_add(&space_y,&cy,&space_y);
	lda	SPACEY_F
	adc	CY_F
	sta	SPACEY_F
	lda	SPACEY_I
	adc	CY_I
	sta	SPACEY_I

	lda	#$ec		; fixed_temp.i=0xec;      // -20 (LOWRES_W/2)
	sta	TEMP_I
	lda	#0		; fixed_temp.f=0;
	sta	TEMP_F

	; fixed_mul(&fixed_temp,&dy,&fixed_temp);
	lda	TEMP_I
	sta	NUM1H
	lda	TEMP_F
	sta	NUM1L
	lda	DX_I
	sta	NUM2H
	lda	DY_F
	sta	NUM2L
	jsr	multiply
	lda	RESULT+2
	sta	TEMP_I
	lda	RESULT+1
	sta	TEMP_F


	clc			; fixed_add(&space_y,&fixed_temp,&space_y);
	lda	SPACEY_F
	adc	TEMP_F
	sta	SPACEY_F
	lda	SPACEY_I
	adc	TEMP_I
	sta	SPACEY_I

	;; brk	space_y = f7:04

	lda	#0
	sta	SCREEN_X
screenx_loop:

	jsr	lookup_map		; get color in A
	ldy	#0
	sta	(GBASL),Y		; plot double height
	inc	GBASL			; point to next pixel

	; advance to the next position in space

	clc			; fixed_add(&space_x,&dx,&space_x);
	lda	SPACEX_F
	adc	DX_F
	sta	SPACEX_F
	lda	SPACEX_I
	adc	DX_I
	sta	SPACEX_I

	clc			; fixed_add(&space_y,&dy,&space_y);
	lda	SPACEY_F
	adc	DY_F
	sta	SPACEY_F
	lda	SPACEY_I
	adc	DY_I
	sta	SPACEY_I



	inc	SCREEN_X
	lda	SCREEN_X
	cmp	#40			; LOWRES width
	bne	screenx_loop


	lda	SCREEN_Y
	clc
	adc	#2
	sta	SCREEN_Y
	cmp	#40			; LOWRES height
	beq	done_screeny
	jmp	screeny_loop
done_screeny:
	rts


	;====================
	; lookup_map
	;====================
	; finds value in space_x.i,space_y.i
	; returns color in A
lookup_map:
	lda	SPACEX_I
	and	#MAP_MASK
	sta	TEMPY

	lda	SPACEY_I
	and	#MAP_MASK		; wrap to 64x64 grid


	asl
	asl
	asl				; multiply by 8
	clc
	adc	TEMPY			; add in X value
					; (use OR instead?)

	ldy	SPACEX_I
	cpy	#$8
	beq	ocean_color		; bgt
	bcs	ocean_color
	ldy	SPACEY_I
	cpy	#$8
	beq	ocean_color		; bgt
	bcs	ocean_color

	tay
	lda	flying_map,Y		; load from array

	rts

ocean_color:
	and	#$1f
	tay
	lda	water_map,Y		; the color of the sea

	rts

flying_map:
	.byte $22,$ff,$ff,$ff, $ff,$ff,$ff,$22
	.byte $dd,$cc,$cc,$88, $44,$44,$00,$dd
	.byte $dd,$cc,$cc,$cc, $88,$44,$44,$dd
	.byte $dd,$cc,$cc,$88, $44,$44,$44,$dd
	.byte $dd,$cc,$99,$99, $88,$44,$44,$dd
	.byte $dd,$cc,$99,$88, $44,$44,$44,$dd
	.byte $dd,$cc,$99,$99, $11,$44,$44,$dd
	.byte $22,$dd,$dd,$dd, $dd,$dd,$dd,$22


water_map:
	.byte $22,$22,$22,$22,  $22,$22,$22,$22
	.byte $ee,$22,$22,$22,  $22,$22,$22,$22
	.byte $22,$22,$22,$22,  $22,$22,$22,$22
	.byte $22,$22,$22,$22,  $ee,$22,$22,$22

.include "tfv_multiply.s"


; 8.8 fixed point
; should we store as two arrays, one I one F?
fixed_sin:
	.byte $00,$00 ;  0.000000=00.00
	.byte $00,$61 ;  0.382683=00.61
	.byte $00,$b5 ;  0.707107=00.b5
	.byte $00,$ec ;  0.923880=00.ec
	.byte $01,$00 ;  1.000000=01.00
	.byte $00,$ec ;  0.923880=00.ec
	.byte $00,$b5 ;  0.707107=00.b5
	.byte $00,$61 ;  0.382683=00.61
	.byte $00,$00 ;  0.000000=00.00
	.byte $ff,$9f ; -0.382683=ff.9f
	.byte $ff,$4b ; -0.707107=ff.4b
	.byte $ff,$14 ; -0.923880=ff.14
	.byte $ff,$00 ; -1.000000=ff.00
	.byte $ff,$14 ; -0.923880=ff.14
	.byte $ff,$4b ; -0.707107=ff.4b
	.byte $ff,$9f ; -0.382683=ff.9f

fixed_sin_scale:
	.byte $00,$00
	.byte $00,$0c
	.byte $00,$16
	.byte $00,$1d
	.byte $00,$20
	.byte $00,$1d
	.byte $00,$16
	.byte $00,$0c
	.byte $00,$00
	.byte $ff,$f4
	.byte $ff,$ea
	.byte $ff,$e3
	.byte $ff,$e0
	.byte $ff,$e3
	.byte $ff,$ea
	.byte $ff,$f4

horizontal_lookup:
	.byte $0C,$0A,$09,$08,$07,$06,$05,$05,$04,$04,$04,$04,$03,$03,$03,$03
	.byte $26,$20,$1B,$18,$15,$13,$11,$10,$0E,$0D,$0C,$0C,$0B,$0A,$0A,$09
	.byte $40,$35,$2D,$28,$23,$20,$1D,$1A,$18,$16,$15,$14,$12,$11,$10,$10
	.byte $59,$4A,$40,$38,$31,$2C,$28,$25,$22,$20,$1D,$1C,$1A,$18,$17,$16
	.byte $73,$60,$52,$48,$40,$39,$34,$30,$2C,$29,$26,$24,$21,$20,$1E,$1C
	.byte $8C,$75,$64,$58,$4E,$46,$40,$3A,$36,$32,$2E,$2C,$29,$27,$25,$23
	.byte $A6,$8A,$76,$68,$5C,$53,$4B,$45,$40,$3B,$37,$34,$30,$2E,$2B,$29
