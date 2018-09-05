;=======================================================================
; Based on BASIC program posted by FozzTexx, originally written in 1987
;=======================================================================
; Constants
NUMSTARS 	= 16
YSIZE		= 160
XSIZE		= 280
MARGIN		= 24

; Zero page addresses
COLOR_GROUP	= $F0
X_VELOCITY	= $F1
Y_VELOCITY_H	= $F2
Y_VELOCITY_L	= $F3
MAX_STEPS	= $F4
;XPOS_H		= $F5
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

;signed char o,i;

;void routine_370(void) {

;	hplot(xpos+o,ypos_h+o);		// NE
;	hplot(xpos-o,ypos_h-o);		// SW

;	hplot(xpos+o,ypos_h-o);		// SE
;	hplot(xpos-o,ypos_h+o);		// NW

;	hplot(xpos,ypos_h+(o*1.5));		// N
;	hplot(xpos+(o*1.5),ypos_h);		// E

;	hplot(xpos,ypos_h-(o*1.5));		// S
;	hplot(xpos-(o*1.5),ypos_h);		// W

;}


draw_fireworks:

	jsr	HOME		; clear screen

	jsr	HGR		; set high-res, clear screen, page0

	jsr	draw_stars	; draw the stars

launch_firework:

	jsr	random16
	lda	SEEDL
	and	#$4
	sta	COLOR_GROUP	; HGR color group (0 PG or 4 BO)

	jsr	random16
	lda	SEEDL
	and	#$3
	clc
	adc	#$1
	sta	X_VELOCITY	; x velocity = 1..4

	jsr	random16
	lda	SEEDL
	and	#$3
	clc
	adc	#$2
	eor	#$ff
	sta	Y_VELOCITY_H	; y velocity = -3..-6
	lda	#0
	sta	Y_VELOCITY_L	; it's 8:8 fixed point

	jsr	random16
	lda	SEEDL
	and	#$1f
	clc
	adc	#33
	sta	MAX_STEPS	; 33..64

	; launch from the two hills
	jsr	random16
	lda	SEEDL
	and	#$3f
	sta	XPOS_L

	jsr	random16
	lda	SEEDL
	and	#$1
	beq	right_hill
left_hill:
	lda	XPOS_L
	clc
	adc	#24
	sta	XPOS_L				; 24-88 (64)

	jmp	done_hill
right_hill:
	lda	XPOS_L
	clc
	adc	#191
	sta	XPOS_L				; 191-255 (64)

	lda	X_VELOCITY
	eor	#$ff
	sta	X_VELOCITY
	inc	X_VELOCITY			; aim toward middle

done_hill:

	lda	#YSIZE
	sta	YPOS_H
	lda	#0				; fixed point 8:8
	sta	YPOS_L				; start at ground

	lda	YPOS_H
	sta	PEAK				; peak starts at ground

	;===============
	; Draw rocket
	;===============

	lda	#1
	sta	CURRENT_STEP

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
	lda	COLORTBL,X		; get color from table
	sta	HGR_COLOR

	; HPLOT X,Y: X= (y,x), Y=a

	ldx	X_OLD
	lda	Y_OLD
	ldy	#0
	jsr	HPLOT0			; hplot(x_old,y_old);

	; HPLOT to X,Y X=(x,a), y=Y
        lda     XPOS_L
        ldx     #0
        ldy     YPOS_H
        jsr     HGLIN			; hplot_to(xpos_l,ypos_h);


erase_rocket:
	; erase with proper color black (0 or 4)

	ldx	COLOR_GROUP
	lda	COLORTBL,X		; get color from table
	sta	HGR_COLOR

	; HPLOT X,Y: X= (y,x), Y=a

	ldx	X_OLDER
	lda	Y_OLDER
	ldy	#0
	jsr	HPLOT0			; hplot(x_old,y_old);

	; HPLOT to X,Y X=(x,a), y=Y
        lda     X_OLD
        ldx     #0
        ldy     Y_OLD
        jsr     HGLIN			; hplot_to(x_old,y_old);

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


;	xpos=x_old;
;	xpos+=(random()%20)-10;	// x +/- 10
;
;	ypos_h=y_old;
;	ypos_h+=(random()%20)-10;	// y +/- 10
;
;	hcolor_equals(color_group+3);	// draw white (with fringes)
;
;	hplot(xpos,ypos_h);	// draw at center of explosion
;
;	/* Spread the explosion */
;	for(i=1;i<=9;i++) {
;		/* Draw spreading dots in white */
;		if (i<9) {
;			o=i;
;			hcolor_equals(color_group+3);
;			routine_370();
;		}
;		/* erase old */
;		o=i-1;
;		hcolor_equals(color_group);
;		routine_370();
;
;		grsim_update();
;		ch=grsim_input();
;		if (ch=='q') break;
;		usleep(50000);
;	}

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


	;=============================
	; Draw the stars
	;=============================

draw_stars:
	; HCOLOR = 3, white (though they are drawn purple)
	ldx	#3
	lda	COLORTBL,X			; get color from table
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

	jsr	HPLOT0

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

