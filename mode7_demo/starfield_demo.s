;===========
; CONSTANTS
;===========

NUMSTARS	EQU	16


;		State			Number	Speed	BGColor CLS
;		===========		======	=====	=======	===
;		Ship at rest		0	32	black	1
;		Flash			1	8	blue	1
;		Moving stars		2	200	black	1
;		Crazy stars		3	128	black	0
;		Moving stars		4	32	black	1
;		Ship moves off	1	5	32	black	1
;		Ship moves off	2	6	32	black	1
;		Shrinking line		7	20	black	1
;		Back to stars		8	255	black	1
;		Done			9

	;=====================
	;=====================
	;=====================
	; Starfield Demo
	;=====================
	;=====================
	;=====================

starfield_demo:

	;================================
	; Clear screen and setup graphics
	;================================

	bit	PAGE0			; set page 0
	bit	LORES			; Lo-res graphics
	bit	FULLGR
        bit	SET_GR			; set graphics

	jsr	clear_screens_notext	; clear top/bottom of page 0/1

	;===============
	; Init Variables
	;===============
	lda	#0							; 2
	sta	DRAW_PAGE						; 3
	sta	RANDOM_POINTER						; 3
	sta	STATE
	; always multiply with low byte as zero
	sta	NUM2L							; 3

	lda	#32
	sta	SPEED

	ldy	#(NUMSTARS-1)						; 2
init_stars:
	jsr	random_star						; 6
	dey								; 2
	bpl	init_stars						; 2nt/3

	;===========================
	;===========================
	; Main Loop
	;===========================
	;===========================

starfield_loop:

	;===============
	; clear screen
	;===============
	; check clear screen state machine

	lda	STATE				; get state

	cmp	#3				; state 3 -- don't clear
	beq	no_clear

	cmp	#1				; state 1 -- blue background
	bne	black_back
	lda	#COLOR_BOTH_LIGHTBLUE
	bne	back_color
black_back:
	lda	#0				; otherwise, black background
back_color:
	sta	clear_all_color+1

	jsr	clear_all						; 6+
									; 6047
no_clear:

	;===============
	; draw the stars
	;===============

	jsr	draw_stars

	;================
	; draw the ship
	;================

	lda	STATE
	cmp	#8			; 8- 9+ 10+
	bpl	draw_ship_done

	cmp	#7
	bpl	draw_ship_line

	cmp	#6
	bpl	draw_ship_tiny

	cmp	#5			; 3- 4+ 5+
	bpl	draw_ship_small

draw_ship_big:
	lda	#>ship_forward
	sta	INH
	lda	#<ship_forward
	sta	INL

	lda	#15
	sta	XPOS
	lda	#30
	sta	YPOS
	bne	draw_ship_sprite

draw_ship_small:
	lda	#>ship_small
	sta	INH
	lda	#<ship_small
	sta	INL

	lda	#17
	sta	XPOS
	lda	#28
	sta	YPOS
	bne	draw_ship_sprite

draw_ship_tiny:
	lda	#>ship_tiny
	sta	INH
	lda	#<ship_tiny
	sta	INL

	lda	#18
	sta	XPOS
	lda	#26
	sta	YPOS

draw_ship_sprite:
	jsr	put_sprite
	jmp	draw_ship_done

draw_ship_line:
	lda	#COLOR_LIGHTBLUE
	sta	COLOR

	clc
	lda	#20
	adc	SPEED
	sta	V2

	sec
	lda	#20
	sbc	SPEED
	tay

	; 20 - 0 to 0 - 20, 20 - 40

	lda	#24
	jsr	hlin_double


draw_ship_done:

	;==================
	; flip pages
	;==================

	jsr	page_flip						; 6

	dec	SPEED
	lda	SPEED

	beq	done_stars

	;==================
	; loop
	;==================
near_loop:
	jmp	starfield_loop						; 3
done_stars:

	inc	STATE
	ldx	STATE
	lda	speed_table,X
	sta	SPEED

	cpx	#$9
	bne	near_loop

	rts

speed_table:
	.byte	32,8,200,128,32,32,32,20,255


	;=====================
	;=====================
	;=====================
	; Starfield Credits
	;=====================
	;=====================
	;=====================

starfield_credits:

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	clear_screens		; clear top/bottom of page 0/1
	jsr     set_gr_page0

	lda	#0							; 2
	sta	DRAW_PAGE
	jsr	credits_draw_text_background
	lda	#4							; 2
	sta	DRAW_PAGE
	jsr	credits_draw_text_background

	lda	#128
	sta	SPEED


	;===============
	; Init Variables
	;===============
	lda	#0							; 2
	sta	DRAW_PAGE						; 3
	sta	RANDOM_POINTER						; 3
	sta	SCREEN_Y
	; always multiply with low byte as zero
	sta	NUM2L							; 3
	sta	YY		; which credit
	sta	LOOP		; delay loop

	lda	#>credits	; load credits pointer
	sta	OUTH
	lda	#<credits
	sta	OUTL

	; Initialize stars

	ldy	#(NUMSTARS-1)						; 2
init_stars2:
	jsr	random_star						; 6
	dey								; 2
	bpl	init_stars2						; 2nt/3

	; Initialize the credits

	jsr	init_credits

before_pause:
	jsr	clear_top						; 6+
	jsr	draw_stars
	jsr	credits_draw_bottom
	jsr	page_flip						; 6

	dec	SPEED
	lda	SPEED
	bne	before_pause
done_before_pause:

	;===========================
	;===========================
	;===========================
	; StarCredits Loop
	;===========================
	;===========================
	;===========================

starcredits_loop:

	;===============
	; clear screen
	;===============
	jsr	clear_top						; 6+


	;===============
	; draw the stars
	;===============
	jsr	draw_stars

	;====================
	; draw the rasterbars
	;====================
;	lda	SPEED
;	bne	done_rasters

	lda	YY
	cmp	#18
	beq	done_rasters

	jsr	draw_rasters
done_rasters:

	;====================
	; draw the credits
	;====================

	jsr	draw_credits
	jsr	credits_draw_bottom

	;==================
	; flip pages
	;==================

	jsr	page_flip						; 6

;	lda	SPEED
;	beq	no_speed
;	dec	SPEED
;no_speed:

	lda	YY
	cmp	#19				; NUMBER OF CREDITS
	beq	done_star_credits

	;==================
	; loop
	;==================

	jmp	starcredits_loop					; 3
done_star_credits:
	rts




	;======================================================
	;======================================================
	; draw stars
	;======================================================
	;======================================================
	; draws stars

draw_stars:
	; start at 15 and count down (rather than 0 and count up)
	ldx	#(NUMSTARS-1)						; 2

draw_stars_loop:
	stx	XX							; 3

	;================
	; calculate color
	;================

	lda	#$ff		; want if z<16, color = 5		; 2
	sta	COLOR		; 	if 16<z<32 color = 13		; 3
				;	if 32<z<64 color = 15

	lda	star_z,X						; 4
	tay			; put star_z[i] in X for later		; 2

	cmp	#32							; 2
	bpl	done_color						; 2nt/3

	cmp	#16		; 15 -1 16 0 17 1			; 2
	bpl	second_color						; 2nt/3

	lda	#$55							; 2
	sta	COLOR							; 3

	jmp	done_color						; 3
second_color:
	lda	#$dd							; 2
	sta	COLOR							; 3

done_color:


	; calculate x value, stars[i].x/stars[i].z

	; put 1/stars[i].z in NUM1H:NUM1L and multiply

	lda	z_table,Y						; 4
	sta	NUM1L		; F					; 3

	; adjust spacez for 58+
	; all this logic to avoid having a 128 byte table of mostly zero

	lda	#0		; I					; 2
	clc								; 2
	cpy	#60		; 59 -1 60 0 61 1			; 2
	bmi	no_adjust						; 2nt/3
	adc	#1		; 60, 61 = 1				; 2
	cpy	#62		; 61 -1 62 0 63 1			; 2
	bmi	no_adjust						; 2nt/3
	adc	#1		; 62 = 2				; 2
	cpy	#63		; 62 = -1 63 = 0 64 = not possible	; 2
	bne	no_adjust						; 2nt/3
	adc	#2		; 63 = 4				; 2
no_adjust:
	sta	NUM1H		; store int part of spacez		; 3

	; load stars[i].x into NUM2H:NUM2L
	; NUM2L is always zero
	ldy	XX							; 3

	lda	star_x,Y						; 4
	sta	NUM2H							; 3


	sec			; don't reuse old values		; 2
	jsr	multiply						; 6+?

	; integer result in X
	txa								; 2
	clc								; 2
	adc	#20		; center on screen			; 2

	sta	XPOS		; save for later			; 3

	; calculate y value, stars[i].y/stars[i].z

	; 1/stars[i].z is still in NUM1H:NUM1L

	ldy	XX		; reload index				; 3

	lda	star_y,Y	; load integer part of star_		; 4
	sta	NUM2H							; 3
	clc			; reuse old values			; 2
	jsr	multiply						; 6+

	; integer result in X
	txa								; 2
	clc								; 2
	adc	#20		; center the value			; 2

	tay			; Y is YPOS				; 2
	sty	YPOS		; put Y value in Y to plot		; 3


	;============================
	; Check Limits
	;============================

	bmi	new_star						; 2nt/3
y_limit_smc:
	cpy	#40							; 2
	bpl	new_star		; if < 0 or > 40 then done	; 2nt/3

	lda	XPOS							; 3
	bmi	new_star						; 2nt/3
	cmp	#40							; 2
	bpl	new_star		; if < 0 or > 40 then done	; 2nt/3

	; FIXME: sort out all of these jumps to be more efficient
	bmi	plot_star						; 2

new_star:
	ldy	XX							; 3
	jsr	random_star						; 6

	jmp	plot_star_continue					; 3

plot_star:
	jsr	plot							; 6

plot_star_continue:

	;==============================
	ldx	XX							; 3

	dex								; 2
	bmi	move_stars						; 2nt/3
	bpl	draw_stars_loop						; 2nt/3

	;=============================
	; Move stars
move_stars:
	lda	STATE
	beq	done_move_stars

	ldy	#(NUMSTARS-1)						; 2
move_stars_loop:
				; increment z
	clc			; if z >= 64 new star			; 2
	lda	star_z,Y						; 4
	adc	#1							; 2
	sta	star_z,Y						; 4
	and	#64							; 2
	beq	move_loop_skip						; 2nt/3

	jsr	random_star	; new random star			; 6

move_loop_skip:
	dey								; 2
	bpl	move_stars_loop						; 2nt/3

done_move_stars:

	rts


	;==================================================
	;==================================================
	; Random Star
	;==================================================
	;==================================================
	; star number in Y
	; FIXME: increment at end?
	; X trashed
random_star:
	; random x location
	ldx	RANDOM_POINTER						; 3

	lda	random_table,X						; 4
	sta	star_x,Y						; 5
	inx								; 2

	; random y location
	lda	random_table,X						; 4
	sta	star_y,Y						; 5
	inx								; 2

	; random z location
	lda	random_table,X						; 4
	and	#$3f							; 2
	sta	star_z,Y						; 5
	inx								; 2

	stx	RANDOM_POINTER						; 3

	rts								; 6

z_table:
	; 1/16.0 - 1/12.25
	.byte	$10,$10,$10,$10,$11,$11,$11,$11,$12,$12,$12,$13,$13,$14,$14,$14
	; 1/12.0 - 1/8.25
	.byte	$15,$15,$16,$16,$17,$17,$18,$18,$19,$1A,$1A,$1B,$1C,$1D,$1E,$1F
	; 1/8.0 - 1/4.25
	.byte	$20,$21,$22,$23,$24,$25,$27,$28,$2A,$2C,$2E,$30,$33,$35,$38,$3C
	; 1/4.0 - 1/0.25
	.byte	$40,$44,$49,$4E,$55,$5D,$66,$71,$80,$92,$AA,$CC,$00,$55,$00,$00

;======================
; some "random" numbers
;======================
random_table:
	.byte	103,198,105,115, 81,255, 74,236, 41,205,186,171,242,251,227, 70
	.byte	124,194, 84,248, 27,232,231,141,118, 90, 46 ,99, 51,159,201,154
	.byte	102, 50, 13,183, 49, 88,163, 90, 37, 93,  5, 23, 88,233, 94,212
	.byte	171,178,205,198,155,180, 84, 17, 14,130,116, 65, 33, 61,220,135
	.byte	112,233, 62,161, 65,225,252,103, 62,  1,126,151,234,220,107,150
	.byte	143, 56, 92, 42,236,176, 59,251, 50,175, 60, 84,236, 24,219, 92
	.byte     2, 26,254, 67,251,250,170, 58,251, 41,209,230,  5, 60,124,148
	.byte	117,216,190, 97,137,249, 92,187,168,153, 15,149,177,235,241,179
	.byte	  5,239,247,  0,233,161, 58,229,202, 11,203,208, 72, 71,100,189
	.byte	 31, 35, 30,168, 28,123,100,197, 20,115, 90,197, 94, 75,121, 99
	.byte	 59,112,100, 36, 17,158,  9,220,170,212,172,242, 27, 16,175, 59
	.byte	 51,205,227, 80, 72, 71, 21, 92,187,111, 34, 25,186,155,125,245
	.byte	 11,225, 26, 28,127, 35,248, 41,248,164, 27, 19,181,202, 78,232
	.byte	152, 50, 56,224,121, 77, 61, 52,188, 95, 78,119,250,203,108,  5
	.byte	172,134, 33, 43,170, 26, 85,162,190,112,181,115, 59,  4, 92,211
	.byte	 54,148
; Line 3 of VMW logo at $4800
.byte $A0,$55,$26,$55,$81
	.byte 179,175,226,240,228,158, 79
	.byte 50,21
;73,253,130, 78,169



