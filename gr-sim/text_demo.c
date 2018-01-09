#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <string.h>

#include "gr-sim.h"

#define STEPS	10

#define NUM_CREDITS	10

#if 0
0                   1                   2                   3
0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9
              **************************************************
              **              T H A N K S   T O :             **
              **************************************************
****************  A L L   M S T I E S   E V E R Y W H E R E   *****************
              **************************************************
#endif

char credits[NUM_CREDITS][22]={
	"FROGGYSUE",
	"PIANOMAN08",
	"UTOPIA BBS",
	"THE 7HORSEMEN",
	"WEAVE'S WORLD TALKER",
	"STEALTHSUSIE",
	"ECE GRAD BOWLING",
	"CORNELL GCF",
	"ALL MSTIES EVERYWHERE",
	"...",
};

int main(int argc, char **argv) {

	int ch,i,j,k;

	grsim_init();

	home();
	gr();

	color_equals(15);
	hlin_double(PAGE0,7,32,38);

	basic_inverse();
	for(i=0;i<8;i++) {
		basic_htab(i+1);
		basic_vtab(23);
		basic_print(" ");

		basic_htab(i+33);
		basic_vtab(23);
		basic_print(" ");
	}

	for(i=7;i<33;i++) {
		basic_htab(i+1);
		basic_vtab(22);
		basic_print(" ");

		basic_htab(i+1);
		basic_vtab(24);
		basic_print(" ");
	}

	basic_htab(8);
	basic_vtab(21);
	basic_print(" ");

	basic_htab(33);
	basic_vtab(21);
	basic_print(" ");

	basic_normal();

	basic_htab(12);
	basic_vtab(21);
	basic_print("SPECIAL THANKS TO:");



	while(1) {
		ch=grsim_input();
		if (ch!=0) break;
	}
	for(k=0;k<NUM_CREDITS;k++) {
		for(i=0;i<strlen(credits[k]);i++) {
			credits[k][i]-=STEPS;
			if (credits[k][i]<0x20) credits[k][i]+=0x40;
		}
	}

	for(k=0;k<NUM_CREDITS;k++) {

		basic_htab(9);
		basic_vtab(23);
		basic_print("                      ");

		for(j=0;j<STEPS;j++) {
			for(i=0;i<strlen(credits[k]);i++) {
				credits[k][i]++;
				if (credits[k][i]>0x5f) credits[k][i]=0x20;
			}

			basic_htab(  ((40-strlen(credits[k]))/2)+1 );
			basic_vtab(23);
			basic_print(credits[k]);

			grsim_update();

			ch=grsim_input();
			if (ch!=0) break;

			usleep(80000);

		}

		ch=grsim_input();
		if (ch!=0) break;

		sleep(1);
	}

	while(1) {
		grsim_update();
		ch=grsim_input();
		if (ch!=0) break;
		usleep(100000);
	}


	return 0;
}
