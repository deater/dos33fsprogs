;=======================================================================
; Based on BASIC program posted by FozzTexx, originally written in 1987
;=======================================================================

; State: Launch
;	 rocketing
;	 explosion


; Constants
NUMSTARS 	= 16
YSIZE		= 160
XSIZE		= 280
MARGIN		= 24

; Zero page addresses
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

	jsr	draw_stars	; draw the stars


launch_firework:

	jsr	random16						; 6+?
	lda	SEEDL							; 3
	and	#$4							; 2
	sta	COLOR_GROUP	; HGR color group (0 PG or 4 BO)	; 4

	jsr	random16						; 6+
	lda	SEEDL							; 3
	and	#$3							; 2
	clc								; 2
	adc	#$1							; 2
	sta	X_VELOCITY	; x velocity = 1..4			; 3

	jsr	random16						; 6+
	lda	SEEDL							; 3
	and	#$3							; 2
	clc								; 2
	adc	#$2							; 2
	eor	#$ff							; 2
	sta	Y_VELOCITY_H	; y velocity = -3..-6			; 3
	lda	#0							; 2
	sta	Y_VELOCITY_L	; it's 8:8 fixed point			; 3

	jsr	random16						; 6+
	lda	SEEDL							; 3
	and	#$1f							; 2
	clc								; 2
	adc	#33							; 2
	sta	MAX_STEPS	; 33..64				; 3

	; launch from the two hills
	jsr	random16						; 6+
	lda	SEEDL							; 3
	and	#$3f							; 2
	sta	XPOS_L							; 3

	jsr	random16						; 6+
	lda	SEEDL							; 3
	and	#$1							; 2
	beq	right_hill						; 2
left_hill:
	lda	XPOS_L							; 3
	clc								; 2
	adc	#24							; 2
	sta	XPOS_L				; 24-88 (64)		; 3

	jmp	done_hill						; 3
right_hill:
									; 1
	lda	XPOS_L							; 3
	clc								; 2
	adc	#191							; 2
	sta	XPOS_L				; 191-255 (64)		; 3

	lda	X_VELOCITY						; 3
	eor	#$ff							; 2
	sta	X_VELOCITY						; 3
	inc	X_VELOCITY			; aim toward middle	; 5

done_hill:

	lda	#YSIZE							; 2
	sta	YPOS_H							; 3
	lda	#0				; fixed point 8:8	; 2
	sta	YPOS_L				; start at ground	; 3

	lda	YPOS_H							; 3
	sta	PEAK				; peak starts at ground	; 3

	lda	#1							; 2
	sta	CURRENT_STEP						; 3



	;===============
	; Draw rocket
	;===============

draw_rocket_loop:

	lda	Y_OLD
	sta	Y_OLDER

	lda	YPOS_H
	sta	Y_OLD

	lda	X_OLD
	sta	X_OLDER

	lda	XPOS_L
	sta	X_OLD

	; Move rocket

	lda	XPOS_L
	clc
	adc	X_VELOCITY
	sta	XPOS_L			; adjust xpos

	; 16 bit add
	clc
	lda	YPOS_L
	adc	Y_VELOCITY_L
	sta	YPOS_L
	lda	YPOS_H
	adc	Y_VELOCITY_H
	sta	YPOS_H			; adjust ypos


	; adjust Y velocity, slow it down
	clc
	lda	Y_VELOCITY_L
	adc	#$20			; $20 = 0.125
	sta	Y_VELOCITY_L
	lda	Y_VELOCITY_H
	adc	#0
	sta	Y_VELOCITY_H

	; if we went higher, adjust peak
	lda	YPOS_H
	cmp	PEAK
	bmi	no_peak
	sta	PEAK
no_peak:

	;========================================
	; Check if out of bounds and stop moving
	;========================================

	lda	XPOS_L		; if (xpos_l<=margin) too far left
	cmp	#MARGIN
	bcc	done_moving

	; Due to 256 wraparound, the above will catch this case???
;	cmp	#XSIZE-MARGIN	; if (xpos_l>=(xsize-margin)) too far right
;	bcs	done_moving

	lda	YPOS_H		; if (ypos_h<=margin) too far up
	cmp	#MARGIN
	bcc	done_moving

	;======================
	; if falling downward
	;======================
	lda	Y_VELOCITY_H
	bmi	going_up	; if (y_velocity_h>0)

	; if too close to ground, explode
	lda	YPOS_H		; if (ypos_h>=ysize-margin)
	cmp	#(YSIZE-MARGIN)
	bcs	done_moving

	; if fallen a bit past peak, explode
	sec			; if (ypos_h>ysize-(ysize-peak)/2)
	lda	#YSIZE
	sbc	PEAK
	lsr
	eor	#$FF
	clc
	adc	#1
	clc
	adc	#YSIZE
	cmp	YPOS_H
	bcc	done_moving

going_up:

	jmp	done_bounds_checking

done_moving:
	lda	MAX_STEPS
	sta	CURRENT_STEP

done_bounds_checking:

	;==========================
	; if not done, draw rocket
	;==========================

	lda	CURRENT_STEP
	cmp	MAX_STEPS
	beq	erase_rocket

draw_rocket:
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

	; HPLOT to X,Y X=(x,a), y=Y
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

	; HPLOT to X,Y X=(x,a), y=Y
        lda     X_OLD
        ldx     #0
        ldy     Y_OLD
        jsr     hglin			; hplot_to(x_old,y_old);

done_with_loop:

	lda	CURRENT_STEP
	cmp	MAX_STEPS
	beq	draw_explosion


	lda	#$c0
	jsr	WAIT

	inc	CURRENT_STEP
	jmp	draw_rocket_loop



	;==================================
	; Draw explosion near x_old, y_old
	;==================================
draw_explosion:

	jsr	random16
	lda	SEEDL
	and	#$f
	sec
	sbc	#8
	adc	X_OLD
	sta	XPOS_L	;	xpos=x_old+(random()%16)-8;	x +/- 8
			;	FIXME: XPOS can overlow

	jsr	random16
	lda	SEEDL
	and	#$f
	sec
	sbc	#8
	adc	Y_OLD
	sta	YPOS_H	;	ypos_h=y_old+(random()%16)-8;	// y +/- 8

	; draw white (with fringes)

	lda	COLOR_GROUP
	clc
	adc	#$3
	tax
	lda	colortbl,X		; get color from table
	sta	HGR_COLOR

;	hplot(xpos,ypos_h);	// draw at center of explosion

	; HPLOT X,Y: X= (y,x), Y=a

	ldx	XPOS_L
	lda	YPOS_H
	ldy	#0
	jsr	hplot0			; hplot(x_old,y_old);



	; Spread the explosion

	ldy	#1
	sty	TEMPY		; save Y

explosion_loop:
	ldy	TEMPY

	;================================
	; Draw spreading dots in white

	cpy	#9
	beq	explosion_erase

	; hcolor_equals(color_group+3);
	lda	COLOR_GROUP
	clc
	adc	#$3
	tax
	lda	colortbl,X		; get color from table
	sta	HGR_COLOR

	ldx	TEMPY
	stx	OFFSET

	jsr	explosion

explosion_erase:
	;======================
	; erase old

	; erase with proper color black (0 or 4)

	ldx	COLOR_GROUP
	lda	colortbl,X		; get color from table
	sta	HGR_COLOR

	ldx	TEMPY
	dex
	stx	OFFSET

	jsr	explosion

done_with_explosion:

	lda	#$c0
	jsr	WAIT

	inc	TEMPY
	lda	TEMPY
	cmp	#10
	bne	explosion_loop

	;==================================
	; randomly draw more explosions
	;==================================
	jsr	random16
	lda	SEEDL
	and	#$1
	beq	draw_explosion

	; see if key pressed
	lda	KEYPRESS		; check if keypressed
	bmi	done_fireworks		; if so, exit
	jmp	launch_firework
done_fireworks:
	rts


explosion:

	; HPLOT X,Y: X= (y,x), Y=a

	clc
	lda	XPOS_L
	adc	OFFSET
	tax
	ldy	#0

	clc
	lda	YPOS_H
	adc	OFFSET

	jsr	hplot0		; hplot(xpos+o,ypos_h+o);	SE



	clc
	lda	XPOS_L
	adc	OFFSET
	tax
	ldy	#0

	sec
	lda	YPOS_H
	sbc	OFFSET

	jsr	hplot0		; hplot(xpos+o,ypos_h-o);	NE


	sec
	lda	XPOS_L
	sbc	OFFSET
	tax
	ldy	#0

	sec
	lda	YPOS_H
	sbc	OFFSET

	jsr	hplot0		; hplot(xpos-o,ypos_h-o);	NW


	sec
	lda	XPOS_L
	sbc	OFFSET
	tax
	ldy	#0

	clc
	lda	YPOS_H
	adc	OFFSET

	jsr	hplot0		; hplot(xpos-o,ypos_h+o);	SW


	; HPLOT X,Y: X= (y,x), Y=a

	ldx	XPOS_L
	ldy	#0

	clc
	lda	OFFSET
	adc	OFFSET
	adc	OFFSET
	lsr
	adc	YPOS_H

	jsr	hplot0		; hplot(xpos,ypos_h+(o*1.5));	S

	ldx	XPOS_L
	ldy	#0

	clc			; O   O*1.5  NEG
	lda	OFFSET		; 0 = 0		0
	adc	OFFSET		; 1 = 1		-1
	adc	OFFSET		; 2 = 3		-3
	lsr			; 3 = 4		-4
	eor	#$FF		; 4 = 6		-6
	clc
	adc	#1
	adc	YPOS_H

	jsr	hplot0		; hplot(xpos,ypos_h-(o*1.5));	N


	; HPLOT X,Y: X= (y,x), Y=a


	clc
	lda	OFFSET
	adc	OFFSET
	adc	OFFSET
	lsr
	adc	XPOS_L
	tax
	ldy	#0

	lda	YPOS_H

	jsr	hplot0		; hplot(xpos+(o*1.5),ypos_h);	E


	clc			; O   O*1.5  NEG
	lda	OFFSET		; 0 = 0		0
	adc	OFFSET		; 1 = 1		-1
	adc	OFFSET		; 2 = 3		-3
	lsr			; 3 = 4		-4
	eor	#$FF		; 4 = 6		-6
	clc
	adc	#1
	adc	XPOS_L
	tax

	ldy	#0

	lda	YPOS_H

	jsr	hplot0		; hplot(xpos-(o*1.5),ypos_h);		// W

	rts



	;=============================
	; Draw the stars
	;=============================

draw_stars:
	; HCOLOR = 3, white (though they are drawn purple)
	lda	#$7f
	sta	HGR_COLOR

	ldy	#0

star_loop:
	tya
	pha

	; HPLOT X,Y
	; X= (y,x), Y=a

	ldx	stars,Y
	lda	stars+1,Y
	ldy	#0

	jsr	hplot0

	pla
	tay

	iny
	iny
	cpy	#NUMSTARS*2
	bne	star_loop

	rts

stars:	; even x so they are purple
	.byte  28,107, 108, 88, 126, 88, 136, 95
	.byte 150,108, 148,120, 172,124, 180,109
	.byte 216, 21, 164, 40, 124, 18,  60, 12
	.byte 240,124,  94,125,  12, 22, 216,116

