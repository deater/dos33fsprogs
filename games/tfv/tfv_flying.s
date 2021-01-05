; Mode-7 Flying code

.include "zp.inc"
.include "hardware.inc"
.include "common_defines.inc"


;===========
; CONSTANTS
;===========
CONST_SHIPX	=	15
CONST_TILE_W	=	64
CONST_TILE_H	=	64
CONST_MAP_MASK_X	=	(CONST_TILE_W - 1)
CONST_MAP_MASK_Y	=	(CONST_TILE_H - 1)
CONST_LOWRES_W	=	40
CONST_LOWRES_H	=	40
CONST_BETA_I	=	$ff
CONST_BETA_F	=	$80
CONST_SCALE_I	=	$14
CONST_SCALE_F	=	$00
CONST_LOWRES_HALF_I	=	$ec	; -(LOWRES_W/2)
CONST_LOWRES_HALF_F	=	$00

flying:

	;===================
	; Clear screen/pages
	;===================

	jsr	clear_screens
	bit	PAGE0
	lda	#0
	sta	DISP_PAGE
	lda	#4
	sta	DRAW_PAGE

	; Initialize the 2kB of multiply lookup tables
	jsr	init_multiply_tables

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

	lda	#1		; slightly off North for better view of island
	sta	ANGLE

	jsr	draw_sky

	lda	#4		; starts out at 4.5 altitude
	sta	SPACEZ_I
	lda	#$80
	sta	SPACEZ_F

	jsr	update_z_factor

flying_loop:

	lda	SPLASH_COUNT						; 3
	beq	flying_keyboard						; 2nt/3
	dec	SPLASH_COUNT	; decrement splash count		; 5

flying_keyboard:

	jsr	get_keypress	; get keypress				; 6
	cmp	#0
	bne	key_was_pressed

	jmp	check_done

key_was_pressed:

;	lda	LASTKEY							; 3

;	cmp	#('Q')		; if quit, then return
;	bne	skipskip
;	rts

;skipskip:

	cmp	#'W'							; 2
	bne	flying_check_down					; 3/2nt

	;===========
	; UP PRESSED
	;===========

	lda	SHIPY
	cmp	#17
	bcc	flying_check_down	; bgt, if shipy>16
	dec	SHIPY
	dec	SHIPY		; move ship up
	inc	SPACEZ_I	; incement height
	jsr	update_z_factor
	lda	#0
	sta	SPLASH_COUNT
	jmp	check_done

flying_check_down:
	cmp	#'S'
	bne	flying_check_left

	;=============
	; DOWN PRESSED
	;=============

	lda	SHIPY
	cmp	#28
	bcs	splashy		; ble, if shipy < 28
	inc	SHIPY
	inc	SHIPY		; move ship down
	dec	SPACEZ_I	; decrement height
	jsr	update_z_factor
	bcc	done_flying_down

splashy:
	lda	#10
	sta	SPLASH_COUNT
done_flying_down:
	jmp	check_done

flying_check_left:
	cmp	#'A'
	bne	flying_check_right

	;=============
	; LEFT PRESSED
	;=============

	lda	TURNING
	bmi	turn_left
	beq	turn_left

	lda	#$0
	sta	TURNING
	jmp	check_done

turn_left:
	lda	#253	; -3
	sta	TURNING

	dec	ANGLE
	jmp	check_done

flying_check_right:
	cmp	#'D'
	bne	check_speedup

	;==============
	; RIGHT PRESSED
	;==============

	lda	TURNING		;; FIXME: optimize me
	bpl	turn_right
	lda	#0
	sta	TURNING
	jmp	check_done

turn_right:
	lda	#3
	sta	TURNING

	inc	ANGLE
	jmp	check_done

check_speedup:
	cmp	#'Z'
	bne	check_speeddown

	;=========
	; SPEED UP
	;=========
	lda	#$8
	cmp	SPEED
	beq	skip_speedup
	inc	SPEED
skip_speedup:
	jmp	check_done

check_speeddown:
	cmp	#'X'
	bne	check_brake

	;===========
	; SPEED DOWN
	;===========

	lda	SPEED
	beq	skip_speeddown
	dec	SPEED
skip_speeddown:
	jmp	check_done

check_brake:
	cmp	#' '
	bne	check_land

	;============
	; BRAKE
	;============
	lda	#$0
	sta	SPEED
	jmp	check_done

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
	jsr	update_z_factor
	lda	SPACEZ_I

	bpl	landing_loop

done_flying:
	lda	#LOAD_WORLD
	sta	WHICH_LOAD

	rts			; finish flying

must_land_on_grass:
	lda	#<(grass_string)
	sta	OUTL
	lda	#>(grass_string)
	sta	OUTH


	jsr	print_both_pages	; "NEED TO LAND ON GRASS!"

check_help:
	cmp	#('H')
	bne	check_done

	;=====
	; HELP
	;=====

	jsr	print_help

	jsr	draw_sky

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

check_over_water:
	;	See if we are over water
	lda	CX_I							; 3
	sta	SPACEX_I						; 3
	lda	CY_I							; 3
	sta	SPACEY_I						; 3

	jsr	lookup_map						; 6

	sec								; 2
	sbc	#COLOR_BOTH_DARKBLUE					; 2
	sta	OVER_LAND						; 3
								;===========
								;	31

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
	lda	OVER_LAND	; no splash if over land		; 3
	bne	no_splash						; 2nt/3

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
								;	 28
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
done_flying_loop:
	jmp	flying_loop						; 3


update_z_factor:

	; we only do the following if Z changes

	; fixed_mul(&space_z,&BETA,&factor);
;mul1
	lda	SPACEZ_I						; 3
	sta	NUM1H							; 3

	; interlude, update SPACEZ_SHIFTED
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
	sec								; 2
	sbc	#8							; 2
	sta	spacez_shifted+1					; 4


	lda	SPACEZ_F						; 3
	sta	NUM1L							; 3

	lda	#CONST_BETA_I	; BETA_I				; 2
	sta	NUM2H							; 3
	lda	#CONST_BETA_F	; BETA_F				; 2
	sta	NUM2L							; 3

	sec			; don't reuse old values		; 2
	jsr	multiply						; 6

	stx	FACTOR_I						; 3
	sta	FACTOR_F						; 3

	rts								; 6
								;===========
								;        60





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






grass_string:
	.byte 10,22,"NEED TO LAND ON GRASS!",0


;===============================================
; External modules
;===============================================

.include "gr_offsets.s"
;.include "gr_hlin.s"
.include "gr_pageflip.s"
.include "gr_putsprite.s"
.include "gr_fast_clear.s"

.include "keyboard.s"
.include "joystick.s"

.include "wait_keypressed.s"
.include "text_print.s"

.include "help_flying.s"

.include "flying_mode7.s"
.include "flying_sprites.inc"
.include "multiply_fast.s"
