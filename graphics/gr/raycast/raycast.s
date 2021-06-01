;---------------------------------------
; based on 1bir - 1 block interactive raycaster
;	coded by huseyin kilic (wisdom)
;	copyright (c) 2009-2013 crescent


.include "hardware.inc"

; zero page

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

DISTANCE	= $70 ; reset in $bc00 and $bc0f calls

ROWPTR		= $d1
ROWPTRH		= $d2
LINEH_T		= $d9


HEIGHTS		= $f8 ; 3 bytes consecutively

; external value dependencies
HEADING		= $81
SINADD		= $9a
COLORS		= $b1 ; 3 bytes consecutively

; temp
CURRENTROW  = $ff

; constants
sin_t       = $1000
blocksize   = $28

; basic/kernal calls
;copyray2plr = $bc0f
;setrowptr   = $e9f0
;invertstepx = $bfb8
;setheights  = $f2c1
;linel_t     = $ecf0

;---------------------------------------
; main
;---------------------------------------

main:
	jsr	SETGR
	bit	FULLGR

	lda	#3
	sta	SINADD

	lda	#$20
	sta	HEADING

;---------------------------------------
; sin/cos table generator
;---------------------------------------
	lda	#$00
	tay
gensin_loop:
	sta	sin_t,Y
	iny
	clc
	adc	SINADD
	ldx	SINADD
	dec	sincount_t,X
	bne	gensin_loop
	dec	SINADD
	bpl	gensin_loop

	; x = $00
	; y = $40

gensin_loop2:
	lda	sin_t,X
	sta	sin_t+$0100,X ; needed for cos extension
	sta	sin_t-1+$40,Y
	eor	#$ff
	sta	sin_t+$80,X
	sta	sin_t-1+$c0,Y
	inx
	dey
	bpl	gensin_loop2


;---------------------------------------
; raycaster
;---------------------------------------
loop_main:
	; cast 40 rays for each screen column
	; starting with rightmost one
	; yr is used as global column index
	; throughout the rest of the program
	ldy	#39

loop_ray:
	; determine current ray's direction
	; by taking player's current direction
	; and fov into account
	; fov is 40 brads out of 256 brads

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
	stx	CURRENTROW

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

	; on return from last call, ar is cell (block) value
	; ar = 0 means empty cell, so continue tracing
	beq	loop_dist

skip_dist:
	; now ar contains the value in reached map position
	; (or last cell value fetched if max distance is reached)

	; use ar or xr to colorize the block
	; and #$07
	; ora #$03
	stx	COLORS+1

	; find out visible block height
	; according to distance
	ldx	#$ff
	txa

	; fill the single char that appears on screen
	; (as in char $a0 in default charset)
	; dirty but needed because of size restriction
	; sta $2900,y

	; calculate visible block height through simple division
	lda	#<blocksize
loop_div:
	inx
	; sec
	sbc	DISTANCE
	bcs	loop_div

	; xr = half of visible block height
	txa

;---------------------------------------
; vertical line
;---------------------------------------
	; yr = x position (screen column)
	; ar = half height (zero height is ok)
	cmp	#13		; height > 12?
	bcc	vline_validheight
	lda	#12		; make sure max height = 12
vline_validheight:
	asl			; calculate full height
	sta	HEIGHTS+1	; store for looping below
	eor	#$ff		; subtract full height from screen height
	; sec			; (24 rows)
	adc	#24+1		; +1 because of sec
	lsr			; sky/floor heights are equal to each other
	sta	HEIGHTS
	sta	HEIGHTS+2
.if 0
;            jsr setheights   ; dirty again, but works
;F2C1   85 F8      STA $F8
;F2C3   85 FA      STA $FA
;F2C5   4C 7D F4   JMP $F47D
;F47D   38         SEC
;
;F47E   A9 F0      LDA #$F0
;F480   4C 2D FE   JMP $FE2D
;FE2D   8E 83 02   STX $0283
;
;FE30   8C 84 02   STY $0284
;FE33   60         RTS
.endif

	; loop through 3 sections of one screen column
	; i.e. sky - wall - floor
	ldx	#$02
vline_loop:

	; load color
;	lda	COLORS,X
;	jsr	SETCOL

	sty	$FE

	; VLINE A,$2D at Y

	; vline sky

	lda	#$77
	jsr	SETCOL

	lda	HEIGHTS
	sta	$2D
	lda	#0
	ldy	$FE

	jsr	VLINE

	; vline wall

	lda	#$FF
	jsr	SETCOL

	lda	HEIGHTS
	clc
	adc	HEIGHTS+1
	sta	$2D
	lda	HEIGHTS

	ldy	$FE
	jsr	VLINE		; VLINE A,$2D at Y

	; vline floor

	lda	#$66
	jsr	SETCOL

	lda	#47
	sta	$2D

	lda	HEIGHTS
	clc
	adc	HEIGHTS+1
	ldy	$FE
	jsr	VLINE		; VLINE A,$2D at Y

	ldy	$FE

.if 0
	dec	HEIGHTS,X
            bmi vline_sectioncomplete
            txs              ; dirty way of saving xr temporarily
            ldx CURRENTROW   ; this was reset before the distance loop
            ; there are two ways used in this program to set up
            ; current row address, either through kernal call ($e549)
            ; or by directly modifiying zp pointer
            ;jsr setrowptr ; call $e549 in main if you comment out this line
            lda linel_t,x
            sta ROWPTR
            lda LINEH_T,x
            sta ROWPTRH
            tsx
            lda COLORS,x ; each section can be assigned to a different color
            sta (ROWPTR),y
            ; advance to next screen row
            inc CURRENTROW
            bne vline_loop ; absolute jump, as CURRENTROW never reaches zero
vline_sectioncomplete:
            ; advance to next column section
            dex
            bpl vline_loop
.endif

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
	; dec	HEADING

skip_j3:
	cmp	#'D'+$80
	bne	done_user_input

	; turn left
	inc	HEADING
	;inc	HEADING

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
	bmi	*+4
	lda	#$00
	pha
	;clc
	lda	STEPX,x		; & y
	adc	RAYPOSX,x	; & y
	sta	RAYPOSX,x	; & y
	pla
	adc	RAYPOSXH,x	; & y
	sta	RAYPOSXH,x	; & y
	dex
	dex
	bpl	loop_stepadd

	; ar = RAYPOSXH

	; calculate index to look up the map cell
	; the map area is 8x8 bytes
	; instead of the usual y * 8 + x
	; x * 8 + y done here, to save some bytes
	; (just causing a flip of the map as a side effect)
	asl
	asl
	asl

	; by doing ora instead of adc, it is possible to have
	; a closed area map in $ecb9
	adc	RAYPOSYH
	tax
	lda	map_t,X
step_exit:
	rts


;---------------------------------------
; getsincos_copyplr2ray
;---------------------------------------

getsincos_copyplr2ray:
	lda	sin_t,X		; sin(x)
	sta	STEPX
	lda	sin_t+$40,x	; cos(x)
	sta	STEPY

	; copy player position to ray position for a start
	; through the basic rom

copyplr2ray:		; $bc00 in c64 kernel?

	ldx	#$05		; copy 5 bytes, from 69..6D to 61..65
copyloop:
	lda	$68,X
	sta	$60,X
	dex
	bne	copyloop
	stx	DISTANCE	; side effect, needed?

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
	; through the basic rom

copyray2plr:	; BC0f in c64 ROM

	ldx	#$6
r2_loop:
	lda	$60,X
	sta	$68,X
	dex
	bne	r2_loop
	stx	DISTANCE
	rts

;---------------------------------------
; data
;---------------------------------------

	; number of sin additions (backwards)
sincount_t:
	.byte 6,14,19,25
;---------------------------------------


map_t:
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
	.byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$00,$00,$22,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$33,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$11,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$ff
	.byte $ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff
