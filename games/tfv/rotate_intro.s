	;===============================
	; rotate intro -- rotate screen
	;===============================

rotate_intro:

	; first copy current screen to background

	jsr	gr_copy_current_to_offscreen_40x40

;	int xx,yy,color,x2,y2;
;	double h,theta,dx,dy,theta2,thetadiff,nx,ny;
;	int i;

;	gr_copy(0x400,0xc00);

;	gr_copy_to_current(0xc00);
;	page_flip();
;	gr_copy_to_current(0xc00);
;	page_flip();

;	thetadiff=0;

;	for(i=0;i<8;i++) {

;		for(yy=0;yy<40;yy++) {
;			for(xx=0;xx<40;xx++) {
;				dx=(xx-20);
;				dy=(yy-20);
;				h=sqrt((dx*dx)+(dy*dy));
;				theta=atan2(dy,dx);
;
;				theta2=theta+thetadiff;
;				nx=h*cos(theta2);
;				ny=h*sin(theta2);
;
;				x2=nx+20;
;				y2=ny+20;
;				if ((x2<0) || (x2>39)) color=0;
;				else if ((y2<0) || (y2>39)) color=0;
;				else color=scrn_page(x2,y2,PAGE2);

;				color_equals(color);
;				plot(xx,yy);
;			}
;		}
;		thetadiff+=(6.28/16.0);
;		page_flip();

;		usleep(100000);
;	}

	rts





	;=========================================================
	; gr_copy_current_to_offscreen 40x40
	;=========================================================
	; Copy draw page to $c00
	; Take image in 0xc00
	; 	Copy to DRAW_PAGE
	;	Actually copy lines 0..39
	; Don't over-write bottom 4 lines of text
gr_copy_current_to_offscreen_40x40:

	ldx	#0
gco_40x40_loop:
	lda	gr_offsets,X
	sta	OUTL
	sta	INL
	lda	gr_offsets+1,X
	clc
	adc	DRAW_PAGE
	sta	OUTH

	lda	gr_offsets+1,X
	clc
	adc	#$8
	sta	INH

	ldy	#39
gco_40x40_inner:
	lda	(OUTL),Y
	sta	(INL),Y

	dey
	bpl	gco_40x40_inner

	inx
	inx

	cpx	#40
	bne	gco_40x40_loop

	rts								; 6
