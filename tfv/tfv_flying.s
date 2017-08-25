SHIPY		EQU	$E4

; FIXME, sort out available ZP page space
TURNING		EQU	$40
SCREEN_X	EQU	$41
SCREEN_Y	EQU	$42


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

	; Temporarily Draw Ocean Everywhere

	lda	#8
	sta	SCREEN_Y

screeny_loop:
	ldy	#0
	jsr	hlin_setup


	lda	#0
	sta	SCREEN_X
screenx_loop:

	jsr	lookup_map		; get color in A
	ldy	#0
	sta	(GBASL),Y
	inc	GBASL

	inc	SCREEN_X
	lda	SCREEN_X
	cmp	#40			; LOWRES width
	bne	screenx_loop


	lda	SCREEN_Y
	clc
	adc	#2
	sta	SCREEN_Y
	cmp	#40			; LOWRES height
	bne	screeny_loop

	rts


	;====================
	; lookup_map
	;====================
	; finds value in space_x.i,space_y.i
	; returns color in A
lookup_map:
	lda	#COLOR_BOTH_DARKBLUE	; the color of the sea

	

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


; http://www.llx.com/~nparker/a2/mult.html
; MULTIPLY NUM1H:NUM1L * NUM2H:NUM2L

NUM1:	.byte 0,0
NUM2:	.byte 0,0
RESULT:	.byte 0,0,0,0

multiply:
	lda	#0		; Initialize RESULT to 0
	sta 	RESULT+2
	ldx	#16		; There are 16 bits in NUM2
L1:
	lsr	NUM2+1		; Get low bit of NUM2
	ror	NUM2
	bcc	L2		; 0 or 1?
	tay			; If 1, add NUM1 (hi byte of RESULT is in A)
	clc
	lda	NUM1
	adc	RESULT+2
	sta	RESULT+2
	tya
	adc	NUM1+1
L2:
	ror	A		; "Stairstep" shift
	ror	RESULT+2
	ror	RESULT+1
	ror	RESULT
	dex
	bne	L1
	sta	RESULT+3
	rts

; 8.8 fixed point
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
