;=======================================================================
; Based on BASIC program posted by FozzTexx, originally written in 1987
;=======================================================================

NUMSTARS = 16

;const int ysize=160,xsize=280,margin=24;
;
;int xpos;
;
;signed char o,i;
;signed char color_group,x_velocity,cs,max_steps;
;unsigned char xpos_l;
;unsigned char ypos_h,ypos_l;
;signed char y_velocity_h;
;unsigned char y_velocity_l;
;unsigned char y_old=0,y_even_older;
;unsigned char x_old=0,x_even_older;
;unsigned char peak;


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

label_180:
;	random_6502();
;	color_group=ram[SEED]&1;		// HGR color group (PG or BO)
;	random_6502();
;	x_velocity=(ram[SEED]&0x3)+1;		// x velocity = 1..4
;	random_6502();
;	y_velocity_h=-((ram[SEED]&0x3)+3);	// y velocity = -3..-6
;	y_velocity_l=0;

;	random_6502();
;	max_steps=(ram[SEED]&0x1f)+33;		// 33..64

;	/* launch from the two hills */
;	random_6502();
;	xpos_l=ram[SEED]&0x3f;
;	random_6502();
;	if (ram[SEED]&1) {
;		xpos_l+=24;			// 24-88 (64)
;	}
;	else {
;		xpos_l+=191;			// 191-255 (64)
;	}


;	ypos_h=ysize;				// start at ground
;	ypos_l=0;

;	peak=ypos_h;				// peak starts at ground?

;	/* Aim towards center of screen */
;	/* TODO: merge this with hill location? */
;	if (xpos_l>xsize/2) {
;		x_velocity=-x_velocity;
;	}

;	/* Draw rocket */
;	for(cs=1;cs<=max_steps;cs++) {
;		y_even_older=y_old;
;		y_old=ypos_h;
;		x_even_older=x_old;
;		x_old=xpos_l;

;		/* Move rocket */
;		xpos_l=xpos_l+x_velocity;

;		/* 16 bit add */
;		add16(&ypos_h,&ypos_l,y_velocity_h,y_velocity_l);

;		/* adjust Y velocity, slow it down */
;//		c=0;
;//		a=y_velocity_l;
;//		adc(0x20);		// 0x20 = 0.125
;//		y_velocity_l=a;
;//		a=y_velocity_h;
;//		adc(0);
;//		y_velocity_h=a;
;		sadd16(&y_velocity_h,&y_velocity_l,0x00,0x20);

;		/* if we went higher, adjust peak */
;		if (ypos_h<peak) peak=ypos_h;

;		/* check if out of bounds and stop moving */
;		if (xpos_l<=margin) {
;			cs=max_steps;		// too far left
;		}

;		if (xpos_l>=(xsize-margin)) {
;			cs=max_steps;		// too far right
;		}

;		if (ypos_h<=margin) {
;			cs=max_steps;		// too far up
;		}


;		// if falling downward
;		if (y_velocity_h>0) {
;			// if too close to ground, explode
;			if (ypos_h>=ysize-margin) {
;				cs=max_steps;
;			}
;			// if fallen a bit past peak, explode
;			if (ypos_h>ysize-(ysize-peak)/2) {
;				cs=max_steps;
;			}
;		}

;		// if not done, draw rocket
;		if (cs<max_steps) {
;			hcolor_equals(color_group*4+3);
;			hplot(x_old,y_old);
;			hplot_to(xpos_l,ypos_h);
;
;		}
;		// erase with proper color black
;		hcolor_equals(color_group*4);
;		hplot(x_even_older,y_even_older);
;		hplot_to(x_old,y_old);
;
;		grsim_update();
;		ch=grsim_input();
;		if (ch=='q') exit(0);
;		usleep(50000);
;
;	}
;
;
;label_290:
;	/* Draw explosion near x_old, y_old */
;	xpos=x_old;
;	xpos+=(random()%20)-10;	// x +/- 10
;
;	ypos_h=y_old;
;	ypos_h+=(random()%20)-10;	// y +/- 10
;
;	hcolor_equals(color_group*4+3);	// draw white (with fringes)
;
;	hplot(xpos,ypos_h);	// draw at center of explosion
;
;	/* Spread the explosion */
;	for(i=1;i<=9;i++) {
;		/* Draw spreading dots in white */
;		if (i<9) {
;			o=i;
;			hcolor_equals(color_group*4+3);
;			routine_370();
;		}
;		/* erase old */
;		o=i-1;
;		hcolor_equals(color_group*4);
;		routine_370();
;
;		grsim_update();
;		ch=grsim_input();
;		if (ch=='q') break;
;		usleep(50000);
;	}
;
;	/* randomly draw more explosions */
;	random_6502();
;	if (ram[SEED]&1) goto label_290;
;

;
;	goto label_180;
;

	jsr	wait_until_keypressed

	rts


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

