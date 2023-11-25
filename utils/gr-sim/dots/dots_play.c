#include <stdio.h>
#include <unistd.h>

#include "../gr-sim.h"
#include "../tfv_zp.h"

int main(int argc, char **argv) {

	int xx,yy,ch;
	int current_row=0;

	grsim_init();

	gr();

	while(1) {
		clear_screens();
		soft_switch(MIXCLR);

		ram[DRAW_PAGE]=0;

        	color_equals(5);
        	for(yy=24;yy<48;yy++) hlin(0,0,40,yy);

		color_equals(0);

		/* parse loop */
		while(1) {
			ch=getchar();
			if (ch==0xff) break;

			if (ch==0xfe) {
				color_equals(0);
				break;
			}
			if (ch==0xfd) {
				color_equals(6);
				continue;
			}

			if (ch&0x40) {
				current_row=ch&0x3f;
				ch=getchar();
			}
			xx=ch;
			plot(xx,current_row);
		}
		if (ch==0xff) break;

		usleep(14285);

		grsim_update();

//again:
		ch=grsim_input();
		if (ch==27) {
			break;
		}
//		else if (ch==0) goto again;

	}

	return 0;
}
