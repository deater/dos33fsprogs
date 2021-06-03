;---------------------------------------
; based on 1bir - 1 block interactive raycaster for Commodore 64
;	coded by huseyin kilic (wisdom) copyright (c) 2009-2013 crescent
;
; converted to Apple II by Vince `deater` Weaver

.include "hardware.inc"

; zero page

V2		= $2D
COLOR		= $30

RAYPOSX		= $61
RAYPOSXH	= $62
RAYPOSY		= $63
RAYPOSYH	= $64

STEPX		= $66 ; leave 1 byte between x and y
STEPY		= $68

PLAYERX		= $69
PLAYERXH	= $6a
PLAYERY		= $6b
PLAYERYH	= $6c

DISTANCE	= $70

WALL_HEIGHT	= $72
FLOOR_SKY_HEIGHT= $73
HEADING		= $74
COLORS		= $75

vline_params	= $76
;	.byte	0,0,0,39
;	; 0, FLOOR_SKY_HEIGHT, FLOOR_SKY_HEIGHT+WALL_HEIGHT, 39

sin_t		= $80

; constants
;sin_t       = $1000
blocksize   = $28

cosine_table	= $F5BA

;---------------------------------------
; main
;---------------------------------------

main:
	jsr	SETGR
;	bit	FULLGR

;	lda	#$20
	sta	HEADING

;---------------------------------------
; sin/cos table generator
;---------------------------------------

	; first generate sine for 0..63 (0..90 degrees)

;	lda	#3
;	sta	SINADD

;	lda	#$00
;	tay
;gensin_loop:
;	sta	sin_t,Y
;	iny
;	clc
;	adc	SINADD
;	ldx	SINADD
;	dec	sincount_t,X
;	bne	gensin_loop
;	dec	SINADD
;	bpl	gensin_loop

	; x = $00
	; y = $40

	; next generate



	ldx	#$00
	stx	vline_params

	ldy	#$0f

	txa

gensin_loop2:
	lsr

	sta	sin_t+$10+1,Y	; store 90-180 degrees
	sta	sin_t,X		; store 0-90 degrees
	sta	sin_t+$40,X	; copy at $40 so cosine is easier

	eor	#$ff		; invert
	sta	sin_t+$30+1,Y	; store for 270-360 degrees
	sta	sin_t+$20,X	; store for 180-270 degrees
	inx
	lda	cosine_table,Y
	dey
	bpl	gensin_loop2


;---------------------------------------
; raycaster
;---------------------------------------
loop_main:
	; cast 40 rays for each screen column
	; starting with rightmost one
	; Y is used as global column index
	; throughout the rest of the program
	ldy	#39
	sty	vline_params+3
loop_ray:
	; determine current ray's direction
	; by taking player's current direction
	; and fov into account
	; fov is 40 b-rads out of 256 b-rads

	tya
	clc
	adc	HEADING
	;sec
	sbc	#19+1		; half of the fov (+1 because of sec)
	tax

	; get sin/cos values accordingly
	; and copy player position to current ray position
	; distance is reset on return from this call
	jsr	getsincos_copyplr2ray

	; reset line row before each column gets drawn
	; (needed in vertical line section)
	; X is 0 here?
	stx	DISTANCE

loop_dist:

	; step along current ray's path and find distance
	inc	DISTANCE

	; limit distance when it is needed in larger maps
	; or open (wrapped) maps

	; max distance = $29
	; lda DISTANCE
	; cmp #$29
	; bcs skip_dist

	; max distance = $40 (make sure ar is always 0 here)
	; bit DISTANCE
	; bvs skip_dist

	; max DISTANCE = $80
	bmi	skip_dist

	jsr	addsteptopos

	; on return from last call, A is cell (block) value
	; A == 0 means empty cell, so continue tracing
	beq	loop_dist

skip_dist:
	; now A contains the value in reached map position
	; (or last cell value fetched if max distance is reached)

	; use A or X to colorize the block
	; and #$07
	; ora #$03

	sta	colors+1

	; find out visible block height
	; according to distance
	ldx	#$ff

	; calculate visible block height through simple division
	lda	#<blocksize
loop_div:
	inx
	; sec
	sbc	DISTANCE
	bcs	loop_div

	; X = half of visible block height
	txa

;---------------------------------------
; vertical line
;---------------------------------------
	; Y = x position (screen column)
	; A = half height (zero height is ok)
	cmp	#20		; height > 24?
	bcc	vline_validheight
	lda	#19		; make sure max height = 24
vline_validheight:
	asl			; calculate full height
	sta	WALL_HEIGHT	; store for looping below
	eor	#$ff		; subtract full height from screen height
	; sec			; (48 rows)
	adc	#40+1		; +1 because of sec
	lsr			; sky/floor heights are equal to each other
	sta	vline_params+1
	clc
	adc	WALL_HEIGHT
	sta	vline_params+2

	; loop through 3 sections of one screen column
	; i.e. sky - wall - floor



	ldx	#2
vline_loop:
	lda	colors,X
	sta	COLOR

	lda	vline_params+1,X
	sta	V2
	lda	vline_params,X
	jsr	VLINE		; VLINE A,$2D at Y

	dex
	bpl	vline_loop



	;---------------------------------------
	; advance to next ray/column
	dey
	bpl	loop_ray

;---------------------------------------
; user input
;---------------------------------------
	; common preparation code to set up sin/cos and
	; to copy player position to ray position to trace movement
	; direction to determine if player hits a block
	; in case player actually tries to move forward or backwards

	ldx	HEADING
	jsr	getsincos_copyplr2ray

	; get joystick 2 status (lowest 4 bits)
	; and check each bit to determine action

	lda	KEYPRESS
	beq	done_user_input

	cmp	#'W'+$80
	bne	skip_j1

	; try to move forward
	pha
	jsr	stepandcopy
	pla

skip_j1:
	cmp	#'S'+$80
	bne	skip_j2

	; try to move backward
	pha
	jsr	invertstepandcopy
	pla

skip_j2:
	cmp	#'A'+$80
	bne	skip_j3

	; turn right
	dec	HEADING
	dec	HEADING

skip_j3:
	cmp	#'D'+$80
	bne	done_user_input

	; turn left
	inc	HEADING
	inc	HEADING

done_user_input:
	bit	KEYRESET	; clear keyboard buffer

	; absolute jump, as carry is always 0 here
	jmp	loop_main

;---------------------------------------
; ray tracing subroutines
;---------------------------------------
            ; heart of tracing, very slow, because of looping
            ; for x and y components and also because of
            ; brute force approach
addsteptopos:

	ldx	#$02
loop_stepadd:
	lda	STEPX,X		; & y
	ora	#$7f		; sign extend 8 bit step value to 16 bit
	bmi	was_neg		; was negative
	lda	#$00
was_neg:
	pha
	;clc
	lda	STEPX,X		; & y
	adc	RAYPOSX,X	; & y
	sta	RAYPOSX,X	; & y
	pla

	adc	RAYPOSXH,X	; & y
	sta	RAYPOSXH,X	; & y


	dex
	dex
	bpl	loop_stepadd

	; A = RAYPOSXH

	; calculate index to look up the map cell
	; just use sierpinski

	and	RAYPOSYH
	and	#$f0

step_exit:
	rts


;---------------------------------------
; getsincos_copyplr2ray
;---------------------------------------

getsincos_copyplr2ray:
	txa
	lsr
	lsr
	tax

	lda	sin_t,X		; sin(x)
	sta	STEPX
	lda	sin_t+$10,X	; cos(x)
	sta	STEPY

	; copy player position to ray position for a start
	; through the basic rom


	; copy 4 bytes, from 69,6A,6B,6C to 61,62,63,64
copyplr2ray:

	ldx	#$04
copyloop:
	lda	$68,X
	sta	$60,X
	dex
	bne	copyloop

	rts

;======================================
; invert step and copy
;======================================
invertstepandcopy:
	; invert step variables for backward motion

invertstepx:			; from BFB8 in C64 ROM
	lda	$66
	eor	#$ff
	sta	$66

invertstepy:
	lda	STEPY
	eor	#$ff
	sta	STEPY

;=======================================
; stepandcopy
;=======================================
stepandcopy:
	; see if player can move to the direction desired
	jsr	addsteptopos

	bne	step_exit	; no, return without doing anything

	; yes, move player by
	; copying ray position to player position

copyray2plr:

	; Copy 61,62,63,64 to 69,6A,6B,6C

	ldx	#$4
r2_loop:
	lda	$60,X
	sta	$68,X
	dex
	bne	r2_loop

	rts


colors:
	.byte	$77,$11,$88


