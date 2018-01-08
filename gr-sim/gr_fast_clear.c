#include "gr-sim.h"
#include "tfv_zp.h"

void clear_screens(void) {
	ram[DRAW_PAGE]=0;
	clear_top();
	clear_bottom();

	ram[DRAW_PAGE]=4;
	clear_top();
	clear_bottom();
}

void clear_top_a(int color) {

	int i,j,max,offset;

	ram[COLOR]=color;


	offset=0x400+(ram[DRAW_PAGE]<<8);

	for(i=0;i<8;i++) {

		if (i<4) max=120; else max=80;

		for(j=0;j<max;j++) {
			ram[offset+i*0x80+j]=ram[COLOR];
		}
	}
}

void clear_top(void) {
	clear_top_a(0);
}

void clear_bottom(void) {

	int i,j,max,offset;

	offset=0x400+(ram[DRAW_PAGE]<<8);

	for(i=4;i<8;i++) {

		max=120;

		for(j=80;j<max;j++) {
			ram[offset+i*0x80+j]=0xa0;	// plain space
		}
	}

}

void clear_screens_notext(void) {

}

void clear_all(void) {

}
