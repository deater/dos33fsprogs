#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "demo_title.c"

#define PI 3.14159265358979323946264

int main(int argc, char **argv) {

	int xx,yy,ch,color,i;
	double dx,dy,u,v,_u,_v,au,av;
	double theta=0;
	int frame=0;
	double scale=1.0;

	grsim_init();
	gr();

//	clear_screens();

	ram[DRAW_PAGE]=PAGE0;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE1;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE2;
	clear_bottom();


//	clear_bottom(PAGE0);
//	clear_bottom(PAGE1);
//	clear_bottom(PAGE2);

//	grsim_unrle(demo_rle,0x400);
	grsim_unrle(demo_rle,0xc00);

//	gr_copy_to_current(0xc00);
//	page_flip();
//	gr_copy_to_current(0xc00);
//	page_flip();

	ram[DRAW_PAGE]=PAGE0;

	while(1) {
		grsim_update();

blah:
		ch=grsim_input();
		if (ch=='q') break;
		if (ch==0) goto blah;

// ; -----------------
// ; ROTOZOOM Théorie:
// ; theta: angle de rotation
// ; scale : coeff pour le zoom
// ; xx et yy : coordonnées point écran
// ; u et v : coordonnées du point texture
// ; déplacement :
// ; dx = cos(theta)*scale
// ; dx = sin(theta)*scale
// ; u = u + xx
// ; v = v + yy
// ; texture(u,v)->screen(x,y)
// ;
//; code:
///;
//;     ; déplacement
//;     dx = cos(theta)*scale;
//;     dy = sin(theta)*scale;
//;
//;   for(yy=0;yy<24;yy++)	{    		// pour les 24 lignes
//;        _u = u; 	; on sauve les coordonnées du premier pixel à afficher de la ligne
//;        _v = v;    ;
//;        for(xx=0;xx<40;xx++) { // affichage d'une ligne horizontale (40 points)
//;           u = u + dx	; déplacement
//;           v = v + dy	; x et y
//;           text(u,v) - > screen(xx,yy)
//;        	}
//;        u = _u - dy;    // on se place sur le premier pixel de la prochaine ligne a afficher 
//;        v = _v + dx;
//;		}
//;	theta++


		dx = cos(theta)*scale;
		dy = sin(theta)*scale;

		u=0;
		v=0;

		for(i=0;i<20;i++) {
			u=u-dx;
			v=v-dy;
		}
		v=40-v;


		for(yy=-20;yy<20;yy++) {
			/* save starting point */
			_u=u;
			_v=v;
			for(xx=-20;xx<20;xx++) {

				/* rotate in center of screen */
				au=u+20;
				av=v;//+20;

	//			if ((au<0) || (au>39)) color=0;
	//			else if ((av<0) || (av>39)) color=0;
	//			else {
					color=scrn_page(au,av,PAGE2);
	//			}

				if (
					((xx==-20) && (yy==-20)) ||
					((xx==0) && (yy==0)) ||
					((xx==19) && (yy==19))
				   ) {
				printf("%d,%d -> %0.2lf,%0.2lf\n",xx,yy,au,av);
				}

				color_equals(color);
				plot(xx+20,yy+20);

				u=u+dx;
				v=v+dy;

			}
			/* move on to next line */
			/* since we start in upper left, add dy */

			/* note: change sign for crazy effects */
			u=_u-dy;
			v=_v+dx;

		}
		theta+=(PI/4.0);

//		scale-=0.008;

		usleep(30000);

		frame++;
		/* reset */
//		if (frame==128) {
//			sleep(1);
//			theta=0;
//			scale=1.0;
//			frame=0;
//		}

	}

	return 0;
}

