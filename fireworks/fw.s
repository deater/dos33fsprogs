;=======================================================================
; Based on BASIC program posted by FozzTexx, originally written in 1987
;=======================================================================

; State:
;	0: Launch Rocket   -> goes to 1
;	1: Move Rocket -> repeats 1 until CS done, then 2
;	2: Start Explosion -> goes to 3
;	3: Continue Explosion -> repeats 3 until done.
;				then randomly might go to 2
;				before going to 0


STATE_LAUNCH_ROCKET		=	0
STATE_MOVE_ROCKET		=	1
STATE_START_EXPLOSION		=	2
STATE_CONTINUE_EXPLOSION	=	3

; Constants
NUMSTARS 	= 16
YSIZE		= 160
XSIZE		= 280
MARGIN		= 24

; Zero page addresses
STATE		= $EE
OFFSET		= $EF
COLOR_GROUP	= $F0
X_VELOCITY	= $F1
Y_VELOCITY_H	= $F2
Y_VELOCITY_L	= $F3
MAX_STEPS	= $F4
XPOS_H		= $F5
XPOS_L		= $F6
YPOS_H		= $F7
YPOS_L		= $F8
PEAK		= $F9
CURRENT_STEP	= $FA
Y_OLD		= $FB
Y_OLDER		= $FC
X_OLD		= $FD
X_OLDER		= $FE
TEMPY		= $FF



draw_fireworks:

	jsr	HOME		; clear screen

	jsr	hgr		; set high-res, clear screen, page0
	lda	#STATE_LAUNCH_ROCKET
	sta	STATE

	jsr	draw_stars	; draw the stars

fireworks_state_machine:

	; see if key pressed
	lda	KEYPRESS		; check if keypressed
	bmi	done_fireworks		; if so, exit

	lda	STATE
	cmp	#STATE_LAUNCH_ROCKET
	bne	s1
	jsr	launch_firework
	jmp	fireworks_state_machine
s1:
	cmp	#STATE_MOVE_ROCKET
	bne	s2
	jsr	move_rocket
	jmp	fireworks_state_machine
s2:
	cmp	#STATE_START_EXPLOSION
	bne	s3
	jsr	start_explosion
	jmp	fireworks_state_machine
s3:
	jsr	continue_explosion
	jmp	fireworks_state_machine


done_fireworks:
	rts


	;===========================
	; LAUNCH_FIREWORK
	;===========================
	; cycles= 54+60+67+60+56+56+15+8+21+11 = 408

launch_firework:

	jsr	random16						; 6+42
	lda	SEEDL							; 3
	and	#$4							; 2
	sta	COLOR_GROUP	; HGR color group (0 PG or 4 BO)	; 3
								;============
								;	54

	jsr	random16						; 6+42
	lda	SEEDL							; 3
	and	#$3							; 2
	clc								; 2
	adc	#$1							; 2
	sta	X_VELOCITY	; x velocity = 1..4			; 3
								;===========
								;	60


	jsr	random16						; 6+42
	lda	SEEDL							; 3
	and	#$3							; 2
	clc								; 2
	adc	#$2							; 2
	eor	#$ff							; 2
	sta	Y_VELOCITY_H	; y velocity = -3..-6			; 3
	lda	#0							; 2
	sta	Y_VELOCITY_L	; it's 8:8 fixed point			; 3
								;============
								;	67

	jsr	random16						; 6+42
	lda	SEEDL							; 3
	and	#$1f							; 2
	clc								; 2
	adc	#33							; 2
	sta	MAX_STEPS	; 33..64				; 3
								;============
								;	60

	; launch from the two hills
	jsr	random16						; 6+42
	lda	SEEDL							; 3
	and	#$3f							; 2
	sta	XPOS_L				; base of 0..63		; 3
								;============
								;	56

	jsr	random16						; 6+42
	lda	SEEDL							; 3
	and	#$1							; 2

	beq	right_hill						; 3
								;============
								;	56



left_hill:								;-1
	lda	X_VELOCITY	; nop					; 3
	lda	X_VELOCITY	; nop					; 3
	lda	X_VELOCITY	; nop					; 3
	nop								; 2
	lda	#24		; make it 24..87			; 2
	jmp	done_hill						; 3
								;===========
								;	 15

right_hill:
	lda	X_VELOCITY						; 3
	eor	#$ff							; 2
	sta	X_VELOCITY						; 3
	inc	X_VELOCITY	; aim toward middle			; 5

	lda	#191		; make it 191..254			; 2
								;===========
								;	 15

done_hill:
	clc								; 2
	adc	XPOS_L							; 3
	sta	XPOS_L							; 3

								;===========
								; 	  8

	lda	#YSIZE							; 2
	sta	YPOS_H							; 3
	lda	#0				; fixed point 8:8	; 2
	sta	YPOS_L				; start at ground	; 3

	lda	YPOS_H							; 3
	sta	PEAK				; peak starts at ground	; 3

	lda	#1							; 2
	sta	CURRENT_STEP						; 3
								;===========
								;	 21

	lda	#STATE_MOVE_ROCKET					; 2
	sta	STATE				; move to launch	; 3

	rts								; 6
								;============
								;	 11


	;===============
	; Move rocket
	;===============
	; cycles=24+11+20+18+14+53

move_rocket:

	; save old values
	lda	Y_OLD							; 3
	sta	Y_OLDER							; 3
	lda	YPOS_H							; 3
	sta	Y_OLD							; 3
	lda	X_OLD							; 3
	sta	X_OLDER							; 3
	lda	XPOS_L							; 3
	sta	X_OLD							; 3
								;===========
								;	 24

	; Move xpos
	lda	XPOS_L							; 3
	clc								; 2
	adc	X_VELOCITY						; 3
	sta	XPOS_L							; 3
								;============
								;	 11
	; Move ypos, 16-bit add
	clc								; 2
	lda	YPOS_L							; 3
	adc	Y_VELOCITY_L						; 3
	sta	YPOS_L							; 3
	lda	YPOS_H							; 3
	adc	Y_VELOCITY_H						; 3
	sta	YPOS_H							; 3
								;===========
								;	 20

	; adjust Y velocity, slow it down
	clc								; 2
	lda	Y_VELOCITY_L						; 3
	adc	#$20			; $20 = 0.125			; 2
	sta	Y_VELOCITY_L						; 3
	lda	Y_VELOCITY_H						; 3
	adc	#0							; 2
	sta	Y_VELOCITY_H						; 3
								;===========
								;	 18
	; if we went higher, adjust peak
	lda	YPOS_H							; 3
	cmp	PEAK							; 3
	bmi	no_peak_nop						; 3

									;-1
	sta	PEAK							; 3
	jmp	no_peak							; 3
no_peak_nop:
	nop								; 2
	jmp	no_peak							; 3
no_peak:
								;=============
								;	14

	;========================================
	; Check if out of bounds and stop moving
	;========================================

	lda	XPOS_L		; if (xpos_l<=margin) too far left	; 3
	cmp	#MARGIN							; 2
	bcc	done_moving_first					; 3

	; Due to 256 wraparound, the above will catch this case???
;	cmp	#XSIZE-MARGIN	; if (xpos_l>=(xsize-margin)) too far right
;	bcs	done_moving

									; -1
	lda	YPOS_H		; if (ypos_h<=margin) too far up	; 3
	cmp	#MARGIN							; 2
	bcc	done_moving_second					; 3

	;======================
	; if falling downward
	;======================
									; -1
	lda	Y_VELOCITY_H						; 3
	bmi	going_up	; if (y_velocity_h>0)			; 3

	; if too close to ground, explode				; -1
	lda	YPOS_H		; if (ypos_h>=ysize-margin)		; 3
	cmp	#(YSIZE-MARGIN)						; 2
	bcs	done_moving_third					; 3

	; if fallen a bit past peak, explode				; -1
	sec			; if (ypos_h>ysize-(ysize-peak)/2)	; 2
	lda	#YSIZE							; 2
	sbc	PEAK							; 3
	lsr								; 2
	eor	#$FF							; 2
	sec								; 2
	adc	#YSIZE							; 2
	cmp	YPOS_H							; 3
	bcc	done_moving						; 3
								;===========
								;	20


									;-1
done_moving_ft:
	nop								; 2
	nop								; 2
	jmp	done_bounds_checking					; 3

going_up:
	; 30 cycles
	lda	MAX_STEPS						; 3
	lda	MAX_STEPS						; 3
	lda	MAX_STEPS						; 3
	lda	MAX_STEPS						; 3
	lda	MAX_STEPS						; 3
	lda	MAX_STEPS						; 3
	nop								; 2
	jmp	done_moving_ft						; 3+7

done_moving_first:
	; 7 cycles
	lda	MAX_STEPS						; 3
	nop								; 2
	nop								; 2
done_moving_second:
	; 12 cycles
	lda	MAX_STEPS						; 3
	nop								; 2
	lda	MAX_STEPS						; 3
	nop								; 2
	nop								; 2
done_moving_third:
	; 20 cycles
	lda	MAX_STEPS						; 3
	lda	MAX_STEPS						; 3
	lda	MAX_STEPS						; 3
	lda	MAX_STEPS						; 3
	lda	MAX_STEPS						; 3
	lda	MAX_STEPS						; 3
	nop								; 2
done_moving:
	lda	MAX_STEPS						; 3
	sta	CURRENT_STEP						; 3

done_bounds_checking:







	;==========================
	; if not done, draw rocket
	;==========================
draw_rocket:

	lda	CURRENT_STEP
	cmp	MAX_STEPS
	beq	erase_rocket

	; set hcolor to proper white (3 or 7)
	clc
	lda	COLOR_GROUP
	adc	#3
	tax
	lda	colortbl,X		; get color from table
	sta	HGR_COLOR

	; HPLOT X,Y: X= (y,x), Y=a

	ldx	X_OLD
	lda	Y_OLD
	ldy	#0
	jsr	hplot0			; hplot(x_old,y_old);

	; HPLOT TO X,Y X=(x,a), y=Y
        lda     XPOS_L
        ldx     #0
        ldy     YPOS_H
        jsr     hglin			; hplot_to(xpos_l,ypos_h);


erase_rocket:
	; erase with proper color black (0 or 4)

	ldx	COLOR_GROUP
	lda	colortbl,X		; get color from table
	sta	HGR_COLOR

	; HPLOT X,Y: X= (y,x), Y=a

	ldx	X_OLDER
	lda	Y_OLDER
	ldy	#0
	jsr	hplot0			; hplot(x_old,y_old);

	; HPLOT TO X,Y X=(x,a), y=Y
        lda     X_OLD
        ldx     #0
        ldy     Y_OLD
        jsr     hglin			; hplot_to(x_old,y_old);

done_with_loop:

	lda	CURRENT_STEP
	cmp	MAX_STEPS
	bne	not_done_with_launch

	lda	#STATE_START_EXPLOSION
	sta	STATE


not_done_with_launch:

;	lda	#$c0
;	jsr	WAIT

	inc	CURRENT_STEP

	rts



	;==================================
	; Start explosion near x_old, y_old
	;==================================
	; cycles =

start_explosion:

	lda	#0
	sta	XPOS_H

	; Set X position

	jsr	random16						; 6+42
	lda	SEEDL							; 3
	and	#$f			; 0..15				; 2
	sec								; 2
	sbc	#8			; -8..7				; 2
	clc
vmw:
	bmi	blahblah

	adc	X_OLD							; 3
	sta	XPOS_L	;	xpos=x_old+(random()%16)-8; x +/- 8	; 3

	lda	#0
	adc	XPOS_H
	sta	XPOS_H

	jmp	blahblah2

blahblah:

	adc	X_OLD							; 3
	sta	XPOS_L	;	xpos=x_old+(random()%16)-8; x +/- 8	; 3

	lda	#$ff
	adc	XPOS_H
	sta	XPOS_H

blahblah2:
	; FIXME: XPOS from 255-280.  A hard problem.  Makes everything
	;		more complicated, 16-bit math

	; set Y position

	jsr	random16						; 6+42
	lda	SEEDL							; 3
	and	#$f			; 0..15				; 2
	sec								; 2
	sbc	#8			; -8..7				; 2
	adc	Y_OLD							; 3
	sta	YPOS_H	;	ypos_h=y_old+(random()%16)-8; y +/- 8	; 3

	; draw white (with fringes)

	lda	COLOR_GROUP						; 3
	clc								; 2
	adc	#$3							; 2
	tax								; 2
	lda	colortbl,X		; get color from table		; 4+
	sta	HGR_COLOR						; 3

;	hplot(xpos,ypos_h);	// draw at center of explosion

	; HPLOT X,Y: X= (y,x), Y=a

	ldx	XPOS_L							; 3
	lda	YPOS_H							; 3
	ldy	#0		; never above 255?			; 3
	jsr	hplot0			; hplot(x_old,y_old);		; 6+244

	; Spread the explosion

	ldy	#1							; 2
	sty	TEMPY		; save Y				; 3

	; move to continue explosion
	lda	#STATE_CONTINUE_EXPLOSION				; 2

	sta	STATE							; 3

	rts								; 6

	;===============================
	; Continue Explosion
	;===============================
continue_explosion:
	ldy	TEMPY							; 3

	;================================
	; Draw spreading dots in white

	cpy	#9							; 2
	beq	explosion_erase						; ?

	; hcolor_equals(color_group+3);
	lda	COLOR_GROUP						; 3
	clc								; 2
	adc	#$3							; 2
	tax								; 2
	lda	colortbl,X		; get color from table		; 4+
	sta	HGR_COLOR						; 3

	ldx	TEMPY							; 3
	stx	OFFSET							; 3

	jsr	explosion						; 6+

explosion_erase:
	;======================
	; erase old

	; erase with proper color black (0 or 4)

	ldx	COLOR_GROUP						; 3
	lda	colortbl,X		; get color from table		; 4+
	sta	HGR_COLOR						; 3

	ldx	TEMPY							; 3
	dex								; 2
	stx	OFFSET							; 3

	jsr	explosion						; 6

done_with_explosion:

	lda	#$c0							;
	jsr	WAIT							;

	inc	TEMPY							; 5
	lda	TEMPY							; 3
	cmp	#10							; 2
	beq	explosion_done						; ?
	rts								; 6

explosion_done:
	;==================================
	; randomly draw more explosions
	;==================================
	jsr	random16						; 6+42
	lda	SEEDL							; 3
	and	#$2							; 2
	sta	STATE							; 3

	; if 0, then move to state 0 (start over)
	; if 2, then move to state 2 (new random explosion)

	rts								; 6



	;===============================
	; Draw explosion rays
	;===============================
	;
	; Note: the western pixels don't do the full 16-bit math
	;	as currently it's not possible for those to overflow 256
	;
	; cycles = 275+275+270+270+272+278+278+279+6=2203

explosion:

	; HPLOT X,Y: X= (y,x), Y=a

	; Southeast pixel
	clc								; 2
	lda	XPOS_L							; 3
	adc	OFFSET							; 3
	tax								; 2
	lda	XPOS_H							; 3
	adc	#0							; 2
	tay								; 2
	clc								; 2
	lda	YPOS_H							; 3
	adc	OFFSET							; 3
	jsr	hplot0		; hplot(xpos+o,ypos_h+o);		; 6+244
								;==============
								;	  275

	; Northeast Pixel
	clc								; 2
	lda	XPOS_L							; 3
	adc	OFFSET							; 3
	tax								; 2
	lda	XPOS_H							; 3
	adc	#0							; 2
	tay								; 2
	sec								; 2
	lda	YPOS_H							; 3
	sbc	OFFSET							; 3
	jsr	hplot0		; hplot(xpos+o,ypos_h-o);		; 6+244
								;==============
								;	  275

	; Northwest Pixel
	sec								; 2
	lda	XPOS_L							; 3
	sbc	OFFSET							; 3
	tax								; 2
	ldy	#0							; 2
	sec								; 2
	lda	YPOS_H							; 3
	sbc	OFFSET							; 3
	jsr	hplot0		; hplot(xpos-o,ypos_h-o); NW		; 6+244
								;==============
								;	270

	; Southwest Pixel
	sec								; 2
	lda	XPOS_L							; 3
	sbc	OFFSET							; 3
	tax								; 2
	ldy	#0							; 2
	clc								; 2
	lda	YPOS_H							; 3
	adc	OFFSET							; 3
	jsr	hplot0		; hplot(xpos-o,ypos_h+o);	SW	; 6+244
								;=============
								;	 270

	; HPLOT X,Y: X= (y,x), Y=a

	; South Pixel
	ldx	XPOS_L							; 3
	ldy	XPOS_H							; 3
	clc								; 2
	lda	OFFSET							; 3
	adc	OFFSET							; 3
	adc	OFFSET							; 3
	lsr								; 2
	adc	YPOS_H							; 3
	jsr	hplot0		; hplot(xpos,ypos_h+(o*1.5));	S	; 6+244
								;=============
								;	272

	; North Pixel
	ldx	XPOS_L							; 3
	ldy	XPOS_H							; 3
	clc			; O   O*1.5	NEG			; 2
	lda	OFFSET		; 0 = 0		 0			; 3
	adc	OFFSET		; 1 = 1		-1			; 3
	adc	OFFSET		; 2 = 3		-3			; 3
	lsr			; 3 = 4		-4			; 2
	eor	#$FF		; 4 = 6		-6			; 2
	clc								; 2
	adc	#1							; 2
	adc	YPOS_H							; 3
	jsr	hplot0		; hplot(xpos,ypos_h-(o*1.5)); N		; 6+244
								;==============
								;	278

	; HPLOT X,Y: X= (y,x), Y=a

	; East Pixel
	clc								; 2
	lda	OFFSET							; 3
	adc	OFFSET							; 3
	adc	OFFSET							; 3
	lsr								; 2
	adc	XPOS_L							; 3
	tax								; 2
	lda	#0							; 2
	adc	XPOS_H							; 3
	tay								; 2
	lda	YPOS_H							; 3
	jsr	hplot0		; hplot(xpos+(o*1.5),ypos_h);	E	; 6+244
								;==============
								;	278

	; West Pixel
	clc			; O   O*1.5	NEG			; 2
	lda	OFFSET		; 0 = 0		 0			; 3
	adc	OFFSET		; 1 = 1		-1			; 3
	adc	OFFSET		; 2 = 3		-3			; 3
	lsr			; 3 = 4		-4			; 2
	eor	#$FF		; 4 = 6		-6			; 2
	clc								; 2
	adc	#1							; 2
	adc	XPOS_L							; 3
	tax								; 2
	ldy	#0							; 2
	lda	YPOS_H							; 3
	jsr	hplot0		; hplot(xpos-(o*1.5),ypos_h); W		; 6+244
								;==============
								;	279

	rts								; 6



	;=============================
	; Draw the stars
	;=============================
	; 7+ 280X + 5
	; 16 stars = 4492
.align $100
draw_stars:
	; HCOLOR = 3, white (though they are drawn purple)
	lda	#$7f							; 2
	sta	HGR_COLOR						; 3
	ldy	#0							; 2
								;===========
								;	  7

star_loop:
	tya								; 2
	pha								; 3

	; HPLOT X,Y
	; X= (y,x), Y=a

	ldx	stars,Y							; 4+
	lda	stars+1,Y						; 4+
	ldy	#0							; 2

	jsr	hplot0							;6+244

	pla								; 4
	tay								; 2

	iny								; 2
	iny								; 2
	cpy	#NUMSTARS*2						; 2

	bne	star_loop						; 3
								;============
								;	279

									; -1
	rts								; 6

stars:	; even x so they are purple
	.byte  28,107, 108, 88, 126, 88, 136, 95
	.byte 150,108, 148,120, 172,124, 180,109
	.byte 216, 21, 164, 40, 124, 18,  60, 12
	.byte 240,124,  94,125,  12, 22, 216,116

