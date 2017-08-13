#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "tfv_sprites.h"

int flying(void) {

	int i;
	unsigned char ch;
	int xx,yy;
	int direction;

	/************************************************/
	/* Flying					*/
	/************************************************/

	gr();
	xx=17;	yy=30;
	color_equals(COLOR_BLACK);

	direction=0;

	color_equals(COLOR_MEDIUMBLUE);

	for(i=0;i<20;i++) {
		hlin(1, 0, 40, i);
	}

	color_equals(COLOR_DARKBLUE);
	for(i=20;i<48;i++) {
		hlin(1, 0, 40, i);
	}

	while(1) {
		ch=grsim_input();

		if ((ch=='q') || (ch==27))  break;
		if ((ch=='i') || (ch==APPLE_UP)) if (yy>20) yy-=2;
		if ((ch=='m') || (ch==APPLE_DOWN)) if (yy<39) yy+=2;
		if ((ch=='j') || (ch==APPLE_LEFT)) {
			direction--;
			if (direction<-1) direction=-1;
		}
		if ((ch=='k') || (ch==APPLE_RIGHT)) {
			direction++;
			if (direction>1) direction=1;
		}

		gr_copy(0x800,0x400);

		if (direction==0) grsim_put_sprite(0,ship_forward,xx,yy);
		if (direction==-1) grsim_put_sprite(0,ship_left,xx,yy);
		if (direction==1) grsim_put_sprite(0,ship_right,xx,yy);

		grsim_update();

		usleep(10000);
	}
	return 0;
}

