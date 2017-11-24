;===========
; CONSTANTS
;===========
CONST_SHIPX	EQU	15
CONST_TILE_W	EQU	64
CONST_TILE_H	EQU	64
CONST_MAP_MASK	EQU	(CONST_TILE_W - 1)
CONST_LOWRES_W	EQU	40
CONST_LOWRES_H	EQU	40



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
	sta	SPLASH_COUNT
	sta	OVER_WATER

	lda	#1
	sta	ANGLE

	lda	#4
	sta	SPACEZ_I
	lda	#$80
	sta	SPACEZ_F

flying_loop:

	lda	SPLASH_COUNT						; 3
	beq	flying_keyboard						; 2nt/3
	dec	SPLASH_COUNT	; decrement splash count		; 5

flying_keyboard:

	jsr	get_key		; get keypress				; 6

	lda	LASTKEY							; 3

;	cmp	#('Q')		; if quit, then return
;	bne	skipskip
;	rts

;skipskip:

	cmp	#('W')							; 2
	bne	check_down						; 3/2nt

	;===========
	; UP PRESSED
	;===========

	lda	SHIPY
	cmp	#17
	bcc	check_down	; bgt, if shipy>16
	dec	SHIPY
	dec	SHIPY		; move ship up
	inc	SPACEZ_I	; incement height
	lda	#0
	sta	SPLASH_COUNT

check_down:
	cmp	#('S')
	bne	check_left

	;=============
	; DOWN PRESSED
	;=============

	lda	SHIPY
	cmp	#28
	bcs	splashy		; ble, if shipy < 28
	inc	SHIPY
	inc	SHIPY		; move ship down
	dec	SPACEZ_I	; decrement height
	bcc	check_left

splashy:
	lda	#10
	sta	SPLASH_COUNT

check_left:
	cmp	#('A')
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
	cmp	#('D')
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

	; finds value in space_x.i,space_y.i
	; returns color in A
	lda	CX_I
	sta	SPACEX_I
	lda	CY_I
	sta	SPACEY_I

	jsr	lookup_map

	cmp	#COLOR_BOTH_LIGHTGREEN
	bne	must_land_on_grass

landing_loop:

	jsr	draw_background_mode7

	; Draw Shadow
	lda     #>shadow_forward
        sta     INH
        lda     #<shadow_forward
        sta     INL
	lda	#(CONST_SHIPX+3)
	sta	XPOS
	clc
	lda	SPACEZ_I
	adc	#31
	and	#$fe			; make sure it's even
	sta	YPOS
	jsr	put_sprite

	lda     #>ship_forward
        sta     INH
        lda     #<ship_forward
        sta     INL

	lda	#CONST_SHIPX
	sta	XPOS
	lda	SHIPY
	sta	YPOS
	jsr	put_sprite

	jsr	page_flip

	dec	SPACEZ_I
	bpl	landing_loop


	rts			; finish flying

must_land_on_grass:

	lda     #10
        sta     CH              ; HTAB 11

        lda     #21
        sta     CV              ; VTAB 22

        lda     #>(grass_string)
        sta     OUTH
        lda     #<(grass_string)
        sta     OUTL

        jsr     print_both_pages	; "NEED TO LAND ON GRASS!"

check_help:
	cmp	#('H')
	bne	check_done

	;=====
	; HELP
	;=====

	jsr	print_help

check_done:

	;================
	; Wrap the Angle
	;================
	; FIXME: only do this in right/left routine?
	lda	ANGLE							; 3
	and	#$f							; 2
	sta	ANGLE							; 3

	;================
	; Handle Movement
	;================

speed_move:
	ldx	SPEED							; 3
	beq	draw_background						; 2nt/3
								;=============
	lda	ANGLE	; dx.i=fixed_sin[(angle+4)&0xf].i; // cos()	; 3
	clc								; 2
	adc	#4							; 2
	and	#$f							; 2
	asl								; 2
	tay								; 2
	lda	fixed_sin_scale,Y					; 4
	sta	DX_I							; 3
	iny		; dx.f=fixed_sin[(angle+4)&0xf].f; // cos()	; 2
	lda	fixed_sin_scale,Y					; 4
	sta	DX_F							; 3

	lda	ANGLE	; dy.i=fixed_sin[angle&0xf].i; // sin()		; 3
	and	#$f							; 2
	asl								; 2
	tay								; 2
	lda	fixed_sin_scale,Y					; 4
	sta	DY_I							; 3
	iny		; dx.f=fixed_sin[angle&0xf].f; // sin()		; 2
	lda	fixed_sin_scale,Y					; 4
	sta	DY_F							; 3
								;============
								;	 54
speed_loop:

	clc			; fixed_add(&cx,&dx,&cx);		; 2
	lda	CX_F							; 3
	adc	DX_F							; 3
	sta	CX_F							; 3
	lda	CX_I							; 3
	adc	DX_I							; 3
	sta	CX_I							; 3

	clc			; fixed_add(&cy,&dy,&cy);		; 2
	lda	CY_F							; 3
	adc	DY_F							; 3
	sta	CY_F							; 3
	lda	CY_I							; 3
	adc	DY_I							; 3
	sta	CY_I							; 3

	dex								; 2
	bne	speed_loop						; 2nt/3
								;============
								;	45

	;====================
	; Draw the background
	;====================
draw_background:
	jsr	draw_background_mode7					; 6

	; Calculate whether to draw the splash

	lda	#0			; set splash drawing to 0	; 2
	sta	DRAW_SPLASH						; 3

	lda	SPEED			; if speed==0, no splash	; 3
	beq	no_splash						; 2nt/3

	lda	TURNING							; 3
	beq	no_turning_splash					; 2nt/3

	lda	SHIPY							; 3
	cmp	#27							; 2
	bcc	no_turning_splash	; blt if shipy<25 skip		; 2nt/3

	lda	#1							; 2
	sta	SPLASH_COUNT						; 3

no_turning_splash:
	lda	OVER_WATER	; no splash if over land		; 3
	beq	no_splash						; 2nt/3

	lda	SPLASH_COUNT	; no splash if splash_count expired	; 3
	beq	no_splash						; 2nt/3

	lda	#1							; 2
	sta	DRAW_SPLASH						; 3

no_splash:

	;==============
	; Draw the ship
	;==============

	clv								; 2
	lda	TURNING							; 3
	beq	draw_ship_forward					; 2nt/3
	bpl	draw_ship_right						; 2nt/3
	bmi	draw_ship_left		;; FIXME: optimize order	; 2nt/3

draw_ship_forward:
	lda	DRAW_SPLASH						; 2
	beq	no_forward_splash					; 2nt/3

	; Draw Splash
	lda     #>splash_forward					; 2
        sta     INH							; 3
        lda     #<splash_forward					; 2
        sta     INL							; 3
	lda	#(CONST_SHIPX+1)					; 2
	sta	XPOS							; 3
	clc								; 2
	lda	SHIPY							; 3
	adc	#9							; 2
	and	#$fe			; make sure it's even		; 2
	sta	YPOS							; 3
	jsr	put_sprite						; 6
								;==========
								;	33
no_forward_splash:
	; Draw Shadow
	lda     #>shadow_forward					; 2
        sta     INH							; 3
        lda     #<shadow_forward					; 2
        sta     INL							; 3
	lda	#(CONST_SHIPX+3)					; 2
	sta	XPOS							; 3
	clc								; 2
	lda	SPACEZ_I						; 3
	adc	#31							; 2
	and	#$fe			; make sure it's even		; 2
	sta	YPOS							; 3
	jsr	put_sprite						; 6

	lda     #>ship_forward						; 2
        sta     INH							; 3
        lda     #<ship_forward						; 2
        sta     INL							; 3
	bvc	draw_ship						; 3
								;===========
								;	46
draw_ship_right:
	lda	DRAW_SPLASH						; 3
	beq	no_right_splash						; 2nt/3

	; Draw Splash
	lda     #>splash_right						; 2
        sta     INH							; 3
        lda     #<splash_right						; 2
        sta     INL							; 3
	lda	#(CONST_SHIPX+1)					; 2
	sta	XPOS							; 3
	clc								; 2
	lda	#36							; 2
	sta	YPOS							; 3
	jsr	put_sprite						; 6
								;===========
								;	28
no_right_splash:

	; Draw Shadow
	lda     #>shadow_right						; 2
        sta     INH							; 3
        lda     #<shadow_right						; 2
        sta     INL							; 3
	lda	#(CONST_SHIPX+3)					; 2
	sta	XPOS							; 3
	clc								; 2
	lda	SPACEZ_I						; 3
	adc	#31							; 2
	and	#$fe			; make sure it's even		; 2
	sta	YPOS							; 3
	jsr	put_sprite						; 6

	lda     #>ship_right						; 2
        sta     INH							; 3
        lda     #<ship_right						; 2
        sta     INL							; 3

	dec	TURNING							; 5

	bvc	draw_ship						; 3
								;==========
								;	51
draw_ship_left:
	lda	DRAW_SPLASH						; 3
	beq	no_left_splash						; 2nt/3

	; Draw Splash
	lda     #>splash_left						; 2
        sta     INH							; 3
        lda     #<splash_left						; 2
        sta     INL							; 3
	lda	#(CONST_SHIPX+1)					; 2
	sta	XPOS							; 3
	clc								; 2
	lda	#36							; 2
	sta	YPOS							; 3
	jsr	put_sprite						; 6
								;===========
								;	28 
no_left_splash:

	; Draw Shadow
	lda     #>shadow_left						; 2
        sta     INH							; 3
        lda     #<shadow_left						; 2
        sta     INL							; 3
	lda	#(CONST_SHIPX+3)					; 2
	sta	XPOS							; 3
	clc								; 2
	lda	SPACEZ_I						; 3
	adc	#31							; 2
	and	#$fe			; make sure it's even		; 2
	sta	YPOS							; 3
	jsr	put_sprite						; 6

	lda     #>ship_left						; 2
        sta     INH							; 3
        lda     #<ship_left						; 2
        sta     INL							; 3

	inc	TURNING							; 5
								;==========
								;	 48

draw_ship:
	lda	#CONST_SHIPX						; 2
	sta	XPOS							; 3
	lda	SHIPY							; 3
	sta	YPOS							; 3
	jsr	put_sprite						; 6
								;===========
								;	17

	;==================
	; flip pages
	;==================

	jsr	page_flip						; 6

	;==================
	; loop forever
	;==================

	jmp	flying_loop						; 3


;===========================
; Draw the Mode7 Background
;===========================

draw_background_mode7:

	; Draw Sky
	; FIXME: the sky never changes?

	lda	#COLOR_BOTH_MEDIUMBLUE	; MEDIUMBLUE color		; 2
	sta	COLOR							; 3

	lda	#0							; 2
	sta	OVER_WATER						; 3
								;===========
								;	 10

sky_loop:				; draw line across screen
	ldy	#40			; from y=0 to y=6		; 2
	sty	V2							; 3
	ldy	#0							; 2
	pha								; 3
	jsr	hlin_double		; hlin y,V2 at A	; 63+(X*16)
	pla								; 4
	clc								; 2
	adc	#2							; 2
	cmp	#6							; 2
	bne	sky_loop						; 3/2nt
								;=============
								; (23+63+(X*16))*5
	; Draw Horizon

	lda	#COLOR_BOTH_GREY	; Horizon is Grey		; 2
	sta	COLOR							; 3
	lda	#6			; draw single line at 6/7	; 2
	ldy	#40							; 2
	sty	V2			; hlin	Y,V2 at A		; 3
	ldy	#0							; 2
	jsr	hlin_double		; hlin	0,40 at 6	; 63+(X*16)
								;===========
								; 63+(X*16)+14
	; fixed_mul(&space_z,&BETA,&factor);

	lda	SPACEZ_I						; 3
	sta	NUM1H							; 3
	lda	SPACEZ_F						; 3
	sta	NUM1L							; 3

	lda	#$ff	; BETA_I					; 2
	sta	NUM2H							; 3
	lda	#$80	; BETA_F					; 2
	sta	NUM2L							; 3

	jsr	multiply						; 6
								;===========
								;        28

	lda	RESULT+2						; 4
	sta	FACTOR_I						; 4
	lda	RESULT+1						; 4
	sta	FACTOR_F						; 4

	;; SPACEZ=78  * ff80 = FACTOR=66

	;; C
	;; GOOD 4 80 * ffffffff 80 = fffffffd c0
	;; BAD  4 80 * ffffffff 80 = 42 40

	lda	#8							; 2
	sta	SCREEN_Y						; 4
								;=============
								;	 22
screeny_loop:
	ldy	#0							; 2
	jsr	hlin_setup		; y-coord in a, x-coord in y	; 41
					; sets up GBASL/GBASH
								;=============
								;	 43

	lda	#0			; horizontal_scale.i = 0	; 2
	sta	HORIZ_SCALE_I						; 3

	;horizontal_scale.f=
	;	horizontal_lookup[space_z.i&0xf][(screen_y-8)/2];

	lda	SPACEZ_I						; 3
	and	#$f							; 2
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
	sta	TEMP_I							; 3

	sec								; 2
	lda	SCREEN_Y						; 3
	sbc	#8							; 2
	lsr								; 2
	clc								; 2
	adc	TEMP_I							; 3
	tay								; 2
	lda	horizontal_lookup,Y					; 4
	sta	HORIZ_SCALE_F						; 3
								;============
								;	 44
	;; brk ASM, horiz_scale = 00:73

	; calculate the distance of the line we are drawing
	; fixed_mul(&horizontal_scale,&scale,&distance);
	lda	HORIZ_SCALE_I						; 3
	sta	NUM1H							; 4
	lda	HORIZ_SCALE_F						; 3
	sta	NUM1L							; 4
	lda	#$14	; SCALE_I					; 2
	sta	NUM2H							; 4
	lda	#$00	; SCALE_F					; 2
	sta	NUM2L							; 4
	jsr	multiply						; 6
	lda	RESULT+2						; 4
	sta	DISTANCE_I						; 2
	lda	RESULT+1						; 4
	sta	DISTANCE_F						; 2
								;==========
								;	 44
	;; brk ASM, distance = 08:fc

	; calculate the dx and dy of points in space when we step
	; through all points on this line

	lda	ANGLE	; dx.i=fixed_sin[(angle+8)&0xf].i; // -sin()	; 3
	clc								; 2
	adc	#8							; 2
	and	#$f							; 2
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y						; 4
	sta	DX_I							; 3
	iny		; dx.f=fixed_sin[(angle+8)&0xf].f; // -sin()	; 2
	lda	fixed_sin,Y						; 4
	sta	DX_F							; 3
								;==========
								;	 29

	; fixed_mul(&dx,&horizontal_scale,&dx);
	lda	HORIZ_SCALE_I						; 3
	sta	NUM1H							; 4
	lda	HORIZ_SCALE_F						; 3
	sta	NUM1L							; 4
	lda	DX_I							; 3
	sta	NUM2H							; 4
	lda	DX_F							; 3
	sta	NUM2L							; 4
	jsr	multiply						; 6
	lda	RESULT+2						; 4
	sta	DX_I							; 3
	lda	RESULT+1						; 4
	sta	DX_F							; 3
								;==========
								;	 48
	;; ANGLE
	;; brk ASM, dx = 00:00

	lda	ANGLE	; dy.i=fixed_sin[(angle+4)&0xf].i; // cos()	; 3
	clc								; 2
	adc	#4							; 2
	and	#$f							; 2
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y						; 4
	sta	DY_I							; 3
	iny		; dy.f=fixed_sin[(angle+4)&0xf].f; // cos()	; 2
	lda	fixed_sin,Y						; 4
	sta	DY_F							; 3
								;==========
								;	 29
	; fixed_mul(&dy,&horizontal_scale,&dy);
	lda	HORIZ_SCALE_I						; 3
	sta	NUM1H							; 4
	lda	HORIZ_SCALE_F						; 3
	sta	NUM1L							; 4
	lda	DY_I							; 3
	sta	NUM2H							; 4
	lda	DY_F							; 3
	sta	NUM2L							; 4
	jsr	multiply						; 6
	lda	RESULT+2						; 4
	sta	DY_I							; 3
	lda	RESULT+1						; 4
	sta	DY_F							; 3
								;==========
								;	 48
	;; brk ASM, dy = 00:73

	; calculate the starting position

			; fixed_add(&distance,&factor,&space_x);
	clc		; fixed_add(&distance,&factor,&space_y);	; 2
	lda	DISTANCE_F						; 3
	adc	FACTOR_F						; 3
	sta	SPACEY_F						; 3
	sta	SPACEX_F						; 3
	lda	DISTANCE_I						; 3
	adc	FACTOR_I						; 3
	sta	SPACEY_I						; 3
	sta	SPACEX_I						; 3
								;==========
								;	 26
	;; brk	space_x = 06:bc

	lda	ANGLE	; temp.i=fixed_sin[(angle+4)&0xf].i; // cos	; 3
	clc								; 2
	adc	#4							; 2
	and	#$f							; 2
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y						; 4
	sta	TEMP_I							; 3
	iny		; temp.f=fixed_sin[(angle+4)&0xf].f; // cos	; 2
	lda	fixed_sin,Y						; 4
	sta	TEMP_F							; 3
								;==========
								;	 29

	; fixed_mul(&space_x,&temp,&space_x);
	lda	SPACEX_I						; 3
	sta	NUM1H							; 4
	lda	SPACEX_F						; 3
	sta	NUM1L							; 4
	lda	TEMP_I							; 3
	sta	NUM2H							; 4
	lda	TEMP_F							; 3
	sta	NUM2L							; 4
	jsr	multiply						; 6
	lda	RESULT+2						; 4
	sta	SPACEX_I						; 3
	lda	RESULT+1						; 4
	sta	SPACEX_F						; 3
								;==========
								;	 48

	clc			; fixed_add(&space_x,&cx,&space_x);	; 2
	lda	SPACEX_F						; 3
	adc	CX_F							; 3
	sta	SPACEX_F						; 3
	lda	SPACEX_I						; 3
	adc	CX_I							; 3
	sta	SPACEX_I						; 3

	lda	#$ec		; temp.i=0xec;	// -20 (LOWRES_W/2)	; 2
	sta	TEMP_I							; 3
	lda	#0		; temp.f=0;				; 2
	sta	TEMP_F							; 3
								;==========
								;	 30
	; fixed_mul(&temp,&dx,&temp);
	lda	TEMP_I							; 3
	sta	NUM1H							; 4
	lda	TEMP_F							; 3
	sta	NUM1L							; 4
	lda	DX_I							; 3
	sta	NUM2H							; 4
	lda	DX_F							; 3
	sta	NUM2L							; 4
	jsr	multiply						; 6
	lda	RESULT+2						; 4
	sta	TEMP_I							; 3
	lda	RESULT+1						; 4
	sta	TEMP_F							; 3
								;==========
								;	 48



	clc		; fixed_add(&space_x,&temp,&space_x);		; 2
	lda	SPACEX_F						; 3
	adc	TEMP_F							; 3
	sta	SPACEX_F						; 3
	lda	SPACEX_I						; 3
	adc	TEMP_I							; 3
	sta	SPACEX_I						; 3
								;==========
								;	 20
	; brk	; space_x = 06:bc

	lda	ANGLE	; temp.i=fixed_sin[angle&0xf].i;		; 3
	and	#$f							; 2
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y						; 4
	sta	TEMP_I							; 3
	iny		; fixed_temp.f=fixed_sin[angle&0xf].f;		; 2
	lda	fixed_sin,Y						; 4
	sta	TEMP_F							; 3
								;==========
								;	 25

	; fixed_mul(&space_y,&fixed_temp,&space_y);
	lda	SPACEY_I						; 3
	sta	NUM1H							; 4
	lda	SPACEY_F						; 3
	sta	NUM1L							; 4
	lda	TEMP_I							; 3
	sta	NUM2H							; 4
	lda	TEMP_F							; 3
	sta	NUM2L							; 4
	jsr	multiply						; 6
	lda	RESULT+2						; 4
	sta	SPACEY_I						; 3
	lda	RESULT+1						; 4
	sta	SPACEY_F						; 3
								;==========
								;	 48

	clc			; fixed_add(&space_y,&cy,&space_y);	; 2
	lda	SPACEY_F						; 3
	adc	CY_F							; 3
	sta	SPACEY_F						; 3
	lda	SPACEY_I						; 3
	adc	CY_I							; 3
	sta	SPACEY_I						; 3

	lda	#$ec		; temp.i=0xec;	// -20 (LOWRES_W/2)	; 2
	sta	TEMP_I							; 3
	lda	#0		; temp.f=0;				; 2
	sta	TEMP_F							; 3
								;==========
								;	 30
	; fixed_mul(&fixed_temp,&dy,&fixed_temp);
	lda	TEMP_I							; 3
	sta	NUM1H							; 4
	lda	TEMP_F							; 3
	sta	NUM1L							; 4
	lda	DY_I							; 3
	sta	NUM2H							; 4
	lda	DY_F							; 3
	sta	NUM2L							; 4
	jsr	multiply						; 6
	lda	RESULT+2						; 4
	sta	TEMP_I							; 3
	lda	RESULT+1						; 4
	sta	TEMP_F							; 3
								;==========
								;	 48

	clc		; fixed_add(&space_y,&fixed_temp,&space_y);	; 2
	lda	SPACEY_F						; 3
	adc	TEMP_F							; 3
	sta	SPACEY_F						; 3
	lda	SPACEY_I						; 3
	adc	TEMP_I							; 3
	sta	SPACEY_I						; 3

	; brk	; space_y = f7:04

	lda	#0							; 2
	sta	SCREEN_X						; 3
								;==========
								;	 25
screenx_loop:

	jsr	lookup_map		; get color in A		; 6

	ldy	#0							; 2
	sta	(GBASL),Y		; plot double height		; 6
	inc	GBASL			; point to next pixel		; 5

	; Check if over water
	cmp	#$22			; see if dark blue		; 2
	bne	not_watery						; 2nt/3

	lda	SCREEN_Y	; only check pixel in middle of screen	; 3
	cmp	#38							; 2
	bne	not_watery						; 2nt/3

	lda	SCREEN_X	; only check pixel in middle of screen	; 3
	cmp	#20							; 2
	bne	not_watery						; 2nt/3

	lda	#$1		; set over water			; 2
	sta	OVER_WATER						; 3
								;============
								;	 42
not_watery:
	; advance to the next position in space

	clc			; fixed_add(&space_x,&dx,&space_x);	; 2
	lda	SPACEX_F						; 3
	adc	DX_F							; 3
	sta	SPACEX_F						; 3
	lda	SPACEX_I						; 3
	adc	DX_I							; 3
	sta	SPACEX_I						; 3

	clc			; fixed_add(&space_y,&dy,&space_y);	; 2
	lda	SPACEY_F						; 3
	adc	DY_F							; 3
	sta	SPACEY_F						; 3
	lda	SPACEY_I						; 3
	adc	DY_I							; 3
	sta	SPACEY_I						; 3

	inc	SCREEN_X						; 5
	lda	SCREEN_X						; 3
	cmp	#40			; LOWRES width			; 2
	bne	screenx_loop						; 2nt/3
								;=============
								;	53

	lda	SCREEN_Y						; 3
	clc								; 2
	adc	#2							; 2
	sta	SCREEN_Y						; 3
	cmp	#40			; LOWRES height			; 2
	beq	done_screeny						; 2nt/3
	jmp	screeny_loop						; 3
								;=============
								;	 17
done_screeny:
	rts								; 6


	;====================
	; lookup_map
	;====================
	; finds value in space_x.i,space_y.i
	; returns color in A
lookup_map:
	lda	SPACEX_I						; 3
	and	#CONST_MAP_MASK						; 2
	sta	TEMPY							; 3

	lda	SPACEY_I						; 3
	and	#CONST_MAP_MASK		; wrap to 64x64 grid		; 2


	asl								; 2
	asl								; 2
	asl				; multiply by 8			; 2
	clc								; 2
	adc	TEMPY			; add in X value		; 2
					; (use OR instead?)

	ldy	SPACEX_I						; 3
	cpy	#$8							; 2
	beq	ocean_color		; bgt				; 2nt/3
	bcs	ocean_color						; 2nt/3
	ldy	SPACEY_I						; 3
	cpy	#$8							; 2
	beq	ocean_color		; bgt				; 2nt/3
	bcs	ocean_color						; 2nt/3

	tay								; 2
	lda	flying_map,Y		; load from array		; 4

	rts								; 6

ocean_color:
	and	#$1f							; 2
	tay								; 2
	lda	water_map,Y		; the color of the sea		; 4

	rts								; 6

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

grass_string:
	.asciiz "NEED TO LAND ON GRASS!"
