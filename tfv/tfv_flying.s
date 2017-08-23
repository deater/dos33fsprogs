SHIPY		EQU	$E4

; FIXME, sort out available ZP page space
TURNING		EQU	$40


SHIPX		EQU	15

flying_start:

	; Clear screen/pages

	jsr     set_gr_page0

	; Init Variables
	lda	#20
	sta	SHIPY
	lda	#0
	sta	TURNING

flying_loop:


	jsr	wait_until_keypressed

	lda	LASTKEY

	cmp	#('Q')
	bne	skipskip
	rts
skipskip:

	cmp	#('I')
	bne	check_down
	lda	SHIPY
	cmp	#16
	bcc	check_down	; bgt
	dec	SHIPY
	dec	SHIPY

check_down:
	cmp	#('M')
	bne	check_left
	lda	SHIPY
	cmp	#28
	bcs	check_left	; ble
	inc	SHIPY
	inc	SHIPY

check_left:
	cmp	#('J')
	bne	check_right
	inc	TURNING

check_right:
	cmp	#('K')
	bne	check_done
	dec	TURNING

check_done:

	;====================
	; Draw the background
	;====================

	jsr	draw_background_mode7

	;==============
	; Draw the ship
	;==============

	clv
	lda	TURNING
	bmi	draw_ship_right
	bne	draw_ship_left

draw_ship_forward:
	lda     #>ship_forward
        sta     INH
        lda     #<ship_forward
        sta     INL
	bvc	draw_ship

draw_ship_right:
	lda     #>ship_right
        sta     INH
        lda     #<ship_right
        sta     INL
	bvc	draw_ship

draw_ship_left:
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

	lda	#COLOR_BOTH_MEDIUMBLUE
	sta	COLOR

	lda	#0
sky_loop:
	ldy	#40
	sty	V2
	ldy	#0
	pha

	jsr	hlin_double

	pla
	clc
	adc	#2
	cmp	#6
	bne	sky_loop

	; Draw Horizon

	lda	#COLOR_BOTH_GREY
	sta	COLOR

	lda	#6
	ldy	#40
	sty	V2
	jsr	hlin_double

	; Temporarily Draw Ocean Everywhere

	lda	#COLOR_BOTH_DARKBLUE
	sta	COLOR

	lda	#6
sea_loop:
	ldy	#40
	sty	V2
	ldy	#0
	pha

	jsr	hlin_double

	pla
	clc
	adc	#2
	cmp	#40
	bne	sea_loop

	rts

flying_map:
	.byte  2,15,15,15, 15,15,15, 2
	.byte 13,12,12, 8,  4, 4, 0,13
	.byte 13,12,12,12,  8, 4, 4,13
	.byte 13,12,12, 8,  4, 4, 4,13
	.byte 13,12, 9, 9,  8, 4, 4,13
	.byte 13,12, 9, 8,  4, 4, 4,13
	.byte 13,12, 9, 9,  1, 4, 4,13
	.byte  2,13,13,13, 13,13,13, 2

