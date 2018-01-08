#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "demo_title.c"
#if 0
static int fade_map[2][16]={
//       0 1 2 3 4 5 6 7  8 9 a b c d e f
	{0,1,2,2,4,5,2,5, 8,8,5,3,4,8,4,7},
	{0,0,0,5,0,0,5,5, 0,0,0,5,8,5,5,5},

};
#endif

static int fade_map[2][16]={
//       0 1 2 3 4 5 6 7  8 9 a b c d e f
	{0,0,0,2,0,0,2,5, 5,8,5,3,4,8,4,7},
	{0,0,0,0,0,0,5,0, 0,0,0,0,8,0,0,5},

};


int main(int argc, char **argv) {

	int x,temph,templ,ch;

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

	gr_copy_to_current(0xc00);
	page_flip();
	gr_copy_to_current(0xc00);
	page_flip();

	while(1) {
		repeat_until_keypressed();

		/* Fade step 1 */
		for(x=0xc00;x<0x1000;x++) {
			temph=ram[x]&0xf0;
			templ=ram[x]&0x0f;

			templ=fade_map[0][templ];
			temph=fade_map[0][temph>>4];

			ram[x-0x800]=(temph<<4)|templ;
		}
		grsim_update();

		ch=repeat_until_keypressed();
		if (ch=='q') break;

		/* Fade step 2 */

		for(x=0xc00;x<0x1000;x++) {
			temph=ram[x]&0xf0;
			templ=ram[x]&0x0f;

			templ=fade_map[1][templ];
			temph=fade_map[1][temph>>4];

			ram[x-0x800]=(temph<<4)|templ;
		}
		grsim_update();

		ch=repeat_until_keypressed();
		if (ch=='q') break;

		/* Fade to black */

		for(x=0x400;x<0x800;x++) {
			ram[x]=0x00;
		}
		grsim_update();

		ch=repeat_until_keypressed();
		if (ch=='q') break;


		/* Unfade step 2 */
		for(x=0xc00;x<0x1000;x++) {
			temph=ram[x]&0xf0;
			templ=ram[x]&0x0f;

			templ=fade_map[1][templ];
			temph=fade_map[1][temph>>4];

			ram[x-0x800]=(temph<<4)|templ;
		}
		grsim_update();

		ch=repeat_until_keypressed();
		if (ch=='q') break;

		/* Unfade step 1 */
		for(x=0xc00;x<0x1000;x++) {
			temph=ram[x]&0xf0;
			templ=ram[x]&0x0f;

			templ=fade_map[0][templ];
			temph=fade_map[0][temph>>4];

			ram[x-0x800]=(temph<<4)|templ;
		}
		grsim_update();

		ch=repeat_until_keypressed();
		if (ch=='q') break;

		/* Total unfade */
		for(x=0xc00;x<0x1000;x++) {
			temph=ram[x]&0xf0;
			templ=ram[x]&0x0f;

			ram[x-0x800]=(temph)|templ;
		}
		grsim_update();

		ch=repeat_until_keypressed();
		if (ch=='q') break;

	}

	return 0;
}

