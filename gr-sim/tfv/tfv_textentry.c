#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"
#include "tfv_defines.h"

#include "tfv_sprites.h"
#include "tfv_backgrounds.h"

int name_screen(void) {

	int xx,yy,cursor_x,cursor_y,ch,name_x;
	char tempst[BUFSIZ];

	text();
	home();

	cursor_x=0; cursor_y=0; name_x=0;

	/* Enter your name */
//            1         2         3
//  0123456789012345678901234567890123456789
//00PLEASE ENTER A NAME:
// 1
// 2
// 3            _ _ _ _ _ _ _ _
// 4
// 5            @ A B C D E F G
// 6
// 7            H I J K L M N O
// 8
// 9            P Q R S T U V W
//10
//11            X Y Z [ \ ] ^ _
//12
//13              ! " # $ % & '
//14
//15            ( ) * + , - . /
//16
//17            0 1 2 3 4 5 6 7
//18
//19            8 9 : ' < = > ?
//20
//21               FINISHED
//22
//23
//24
	basic_print("PLEASE ENTER A NAME:");

	apple_memset((unsigned char *)nameo,0,9);

	grsim_update();

	while(1) {

		basic_normal();
		basic_htab(12);
		basic_vtab(3);

		for(yy=0;yy<8;yy++) {
			if (yy==name_x) {
				basic_inverse();
				basic_print("+");
				basic_normal();
				basic_print(" ");
			}
			else if (nameo[yy]==0) {
				basic_print("_ ");
			}
			else {
				sprintf(tempst,"%c ",nameo[yy]);
				basic_print(tempst);
			}
		}

		for(yy=0;yy<8;yy++) {
			basic_htab(12);
			basic_vtab(yy*2+6);
			for(xx=0;xx<8;xx++) {
				if (yy<4) sprintf(tempst,"%c ",(yy*8)+xx+64);
				else  sprintf(tempst,"%c ",(yy*8)+xx);

				if ((xx==cursor_x) && (yy==cursor_y)) basic_inverse();
				else basic_normal();

				basic_print(tempst);
			}
		}

		basic_htab(12);
		basic_vtab(22);
		basic_normal();

		if ((cursor_y==8) && (cursor_x<4)) basic_inverse();
		basic_print(" DONE ");
		basic_normal();
		basic_print("   ");
		if ((cursor_y==8) && (cursor_x>=4)) basic_inverse();
		basic_print(" BACK ");

		while(1) {
			ch=grsim_input();

			if (ch==APPLE_UP) { // up
				cursor_y--;
			}

			else if (ch==APPLE_DOWN) { // down
				cursor_y++;
			}

			else if (ch==APPLE_LEFT) { // left
				if (cursor_y==8) cursor_x-=4;
				else cursor_x--;
			}

			else if (ch==APPLE_RIGHT) { // right
				if (cursor_y==8) cursor_x+=4;
				cursor_x++;
			}

			else if (ch=='\r') {
				if (cursor_y==8) {
					if (cursor_x<4) {
						ch=27;
						break;
					}
					else {
						nameo[name_x]=0;
						name_x--;
						if (name_x<0) name_x=0;
						break;
					}
				}

				if (cursor_y<4) nameo[name_x]=(cursor_y*8)+
							cursor_x+64;
				else nameo[name_x]=(cursor_y*8)+cursor_x;
//				printf("Set to %d\n",nameo[name_x]);
				name_x++;
			}

			else if ((ch>32) && (ch<128)) {
				nameo[name_x]=ch;
				name_x++;

			}

			if (name_x>7) name_x=7;

			if (cursor_x<0) {
				cursor_x=7;
				cursor_y--;
			}
			if (cursor_x>7) {
				cursor_x=0;
				cursor_y++;
			}

			if (cursor_y<0) cursor_y=8;
			if (cursor_y>8) cursor_y=0;

			if ((cursor_y==8) && (cursor_x<4)) cursor_x=0;
			else if ((cursor_y==8) && (cursor_x>=4)) cursor_x=4;

			if (ch!=0) break;

			grsim_update();

			usleep(10000);
		}

		if (ch==27) break;
	}
	return 0;
}

