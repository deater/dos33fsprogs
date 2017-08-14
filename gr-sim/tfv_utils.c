#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "tfv_utils.h"
#include "gr-sim.h"
#include "tfv_zp.h"

int repeat_until_keypressed(void) {

	int ch;

	while(1) {
		ch=grsim_input();
		if (ch!=0) break;

		usleep(10000);
	}

	return ch;
}

int select_menu(int x, int y, int num, char **items) {

	int result=0;
	int ch,i;

	while(1) {
		for(i=0;i<num;i++) {
			htab(x);
			vtab(y+i);
			move_cursor();

			if (i==result) {
				print_inverse("--> ");
			}
			else {
				print("    ");
			}

			print(items[i]);
		}
		page_flip();

		ch=repeat_until_keypressed();
		if (ch=='\r') break;
		if (ch==' ') break;
		if (ch==APPLE_RIGHT) result++;
		if (ch==APPLE_DOWN) result++;
		if (ch==APPLE_LEFT) result--;
		if (ch==APPLE_UP) result--;
		if (result>=num) result=num-1;
		if (result<0) result=0;
	}

	return result;
}

void apple_memset(unsigned char *ptr, int value, int length) {

	a=value;
	x=length;
	y=0;

	while(x>0) {
		ptr[y]=a;
		y++;
		x--;
	}
}

void print_u8(unsigned char value) {

	char temp[4];

	sprintf(temp,"%d",value);

	basic_print(temp);

}

void print_byte(unsigned char value) {
	char temp[4];
	sprintf(temp,"%3d",value);
	temp[3]=0;
	basic_print(temp);
}

void page_flip(void) {

	if (ram[DISP_PAGE]==0) {
		soft_switch(HISCR);
		ram[DISP_PAGE]=1;
		ram[DRAW_PAGE]=0;
	}
	else {
		soft_switch(LOWSCR);
		ram[DISP_PAGE]=0;
		ram[DRAW_PAGE]=1;
	}

	grsim_update();

}

