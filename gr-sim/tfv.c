#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "tfv_sprites.h"
#include "tfv_backgrounds.h"

/* stats */
unsigned char level=0;
unsigned char hp=50,max_hp=100;
unsigned char limit=2;
unsigned char money=0,experience=0;
unsigned char time_hours=0,time_minutes=0;
unsigned char items1=0xff,items2=0xff;
unsigned char steps=0;

/* location */
unsigned char map_x=5;
char tfv_x=15,tfv_y=19;
unsigned char ground_color;

char nameo[9];


static int name_screen(void) {

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


/* In Town */


/* Puzzle Room */
/* Get through office */
/* Have to run away?  What happens if die?  No save game?  Code? */

/* Construct the LED circuit */
/* Zaps through cloud */
/* Susie joins your party */

/* Final Battle */
/* Play music, lightning effects? */
/* TFV only hit for one damage, susie for 100 */




/*
	Map

	0         1          2        3

0     BEACH     ARCTIC   ARCTIC        BELAIR
                TREE    MOUNATIN

1     BEACH     LANDING   GRASS      FOREST
      PINETREE            MOUNTAIN

2     BEACH     GRASS     GRASS       FOREST
      PALMTREE            MOUNTAIN

3     BEACH     DESERT    COLLEGE      BEACH
                CACTUS   PARK
*/

/* Walk through bushes, beach water */
/* Make landing a sprite?  Stand behind things? */

static int load_map_bg(void) {

	int i,temp;
	int start,end;

	ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4));

	if (map_x==3) {
		grsim_unrle(harfco_rle,0x800);
		return 0;
	}

	if (map_x==5) {
		grsim_unrle(landing_rle,0x800);
		return 0;
	}

	if (map_x==14) {
		grsim_unrle(collegep_rle,0x800);
		return 0;
	}


	/* Sky */
	color_equals(COLOR_MEDIUMBLUE);
	for(i=0;i<10;i+=2) {
		hlin_double(1,0,40,i);
	}

	if (map_x<4) ground_color=(COLOR_WHITE|(COLOR_WHITE<<4));
	else if (map_x==13) ground_color=(COLOR_ORANGE|(COLOR_ORANGE<<4));
	else ground_color=(COLOR_LIGHTGREEN|(COLOR_LIGHTGREEN<<4));

	/* grassland/sloped left beach */
	if ((map_x&3)==0) {
		for(i=10;i<40;i++) {
			temp=4+(40-i)/8;
			color_equals(COLOR_DARKBLUE);
			hlin(1,0,temp,i);
			color_equals(COLOR_LIGHTBLUE);
			hlin_continue(2);
			color_equals(COLOR_YELLOW);
			hlin_continue(2);
			color_equals(ground_color);
			hlin_continue(36-temp);
		}
	}

	/* Grassland */
	if ((map_x&3)==1) {
		for(i=10;i<40;i+=2) {
			color_equals(ground_color);
			hlin_double(1,0,40,i);
		}
	}

	/* Mountain */
	if ((map_x&3)==2) {
		for(i=10;i<40;i+=2) {
			color_equals(ground_color);
			hlin_double(1,0,40,i);
		}
	}

	/* Forest/Right Beach */
	if ((map_x&3)==3) {
		for(i=10;i<40;i++) {
			temp=24+(i/4);
			/* 32 ... 40 */
			color_equals(ground_color);
			hlin(1,0,temp,i);
			color_equals(COLOR_YELLOW);
			hlin_continue(2);
			color_equals(COLOR_LIGHTBLUE);
			hlin_continue(2);
			color_equals(COLOR_DARKBLUE);
			hlin_continue(36-temp);
		}

	}

	/* Draw north shore */
	if (map_x<4) {
		color_equals(COLOR_DARKBLUE);
		hlin_double(1,0,40,10);
	}

	/* Draw south shore */
	if (map_x>=12) {
		start=0; end=40;
		color_equals(COLOR_DARKBLUE);
		hlin_double(1,0,40,38);
		color_equals(COLOR_LIGHTBLUE);
		if (map_x==12) start=6;
		if (map_x==15) end=35;
		hlin_double(1,start,end,36);
		if (map_x==12) start=8;
		if (map_x==15) end=32;
		color_equals(COLOR_YELLOW);
		hlin_double(1,start,end,34);
	}

	if ((map_x&3)==2) {
		for(i=0;i<4;i++) {
			grsim_put_sprite(1,mountain,10+(i%2)*5,(i*8)+2);
		}
	}



//		grsim_put_sprite(0,tfv_stand_left,tfv_x,20);

	return 0;
}

static int world_map(void) {

	int ch;
	int direction=1;
	int i,limit;
	int newx=0,newy=0,moved;

	/************************************************/
	/* Landed					*/
	/************************************************/

	// TODO:
	//  4x4 grid of island?
	//  proceduraly generated?
	//  can only walk if feet on green/yellow
	//  should features be sprites?

	// rotate when attacked

	gr();

	color_equals(COLOR_BLACK);

	direction=1;
	int odd=0;
	int refresh=1;

	while(1) {
		moved=0;
		newx=tfv_x;
		newy=tfv_y;

		ch=grsim_input();

		if ((ch=='q') || (ch==27))  break;

		if ((ch=='w') || (ch==APPLE_UP)) {
			newy=tfv_y-2;
			moved=1;
		}
		if ((ch=='s') || (ch==APPLE_DOWN)) {
			newy=tfv_y+2;
			moved=1;
		}
		if ((ch=='a') || (ch==APPLE_LEFT)) {
			if (direction>0) {
				direction=-1;
				odd=0;
			}
			else {
				newx=tfv_x-1;
				moved=1;
			}
		}
		if ((ch=='d') || (ch==APPLE_RIGHT)) {
			if (direction<0) {
				direction=1;
				odd=0;
			}
			else {
				newx=tfv_x+1;
				moved=1;
			}
		}

		if (ch=='h') print_help();
		if (ch=='b') do_battle();
		if (ch=='i') print_info();
		if (ch=='m') {
			show_map();
			refresh=1;
		}

		if (refresh) {
			load_map_bg();
			refresh=0;
		}

		gr_copy(0x800,0x400);

		/* Ground Scatter */

		if (map_x==1) if (tfv_y>=20) grsim_put_sprite(0,snowy_tree,10,20);
		if (map_x==4) if (tfv_y>=15) grsim_put_sprite(0,pine_tree,25,15);
		if (map_x==8) if (tfv_y>=22) grsim_put_sprite(0,palm_tree,10,20);
		if (map_x==12) if (tfv_y>=22) grsim_put_sprite(0,palm_tree,20,20);
		if (map_x==13) if (tfv_y>=15) grsim_put_sprite(0,cactus,25,15);


		if ((map_x==7) || (map_x==11)) {
			for(i=10;i<tfv_y+8;i+=2) {
				limit=22+(i/4);
				color_equals(COLOR_DARKGREEN);
				hlin_double(0,0,limit,i);
			}
		}


		/* Collision detection + Movement */
		if (moved) {
			odd=!odd;
			steps++;

			if (collision(newx,newy+10,ground_color)) {
			}
			else {
				tfv_x=newx;
				tfv_y=newy;
			}

			if (tfv_x>36) {
				map_x++;
				tfv_x=0;
				refresh=1;
			}
			if (tfv_x<=0) {
				map_x--;
				tfv_x=35;
				refresh=1;
			}

			if ((tfv_y<4) && (map_x>=4)) {
				map_x-=4;
				tfv_y=28;
				refresh=1;
			}

			if (tfv_y>=28) {
				map_x+=4;
				tfv_y=4;
				refresh=1;
			}
		}



		if (direction==-1) {
			if (odd) grsim_put_sprite(0,tfv_walk_left,tfv_x,tfv_y);
			else grsim_put_sprite(0,tfv_stand_left,tfv_x,tfv_y);
		}
		if (direction==1) {
			if (odd) grsim_put_sprite(0,tfv_walk_right,tfv_x,tfv_y);
			else grsim_put_sprite(0,tfv_stand_right,tfv_x,tfv_y);
		}

		if (map_x==1) if (tfv_y<20) grsim_put_sprite(0,snowy_tree,10,20);
		if (map_x==4) if (tfv_y<15) grsim_put_sprite(0,pine_tree,25,15);
		if (map_x==8) if (tfv_y<22) grsim_put_sprite(0,palm_tree,10,20);
		if (map_x==12) if (tfv_y<22) grsim_put_sprite(0,palm_tree,20,20);
		if (map_x==13) if (tfv_y<15) grsim_put_sprite(0,cactus,25,15);

		if ((map_x==7) || (map_x==11)) {
			for(i=tfv_y+8;i<36;i+=2) {
				limit=22+(i/4);
				color_equals(COLOR_DARKGREEN);
				hlin_double(0,0,limit,i);
			}

			color_equals(COLOR_BROWN);
			hlin_double(0,0,1,39);
			for(i=0;i<13;i++) {
				color_equals(COLOR_GREY);
				hlin_double_continue(1);
				color_equals(COLOR_BROWN);
				hlin_double_continue(1);
			}

			color_equals(COLOR_BROWN);
			hlin_double(0,0,1,37);
			for(i=0;i<13;i++) {
				color_equals(COLOR_GREY);
				hlin_double_continue(1);
				color_equals(COLOR_BROWN);
				hlin_double_continue(1);
			}
		}

		if (map_x==3) {
			if ((steps&0xf)==0) {
				grsim_put_sprite(0,lightning,25,4);
				/* Hurt hit points if in range? */
				if ((tfv_x>25) && (tfv_x<30) && (tfv_y<12)) {
					printf("HIT! %d %d\n\n",steps,hp);
					if (hp>11) {
						hp=10;
					}
				}
			}
		}

		grsim_update();

		if (steps>=60) {
			steps=0;
			time_minutes++;
			if (time_minutes>=60) {
				time_hours++;
				time_minutes=0;
			}
		}

		usleep(10000);
	}

	return 0;
}


int main(int argc, char **argv) {

	int result;

	grsim_init();

	home();
	gr();

	/* Clear bottom of zero page */
	apple_memset(&ram[0],0,16);

	/* clear top page0 */
	/* clear top page1 */
	clear_top(0);
	clear_top(1);

	/* clear bottom page0 */
	/* clear bottom page1 */
	clear_bottom(0);
	clear_bottom(1);

	/* Do Opening */
	opening();

	/* Title Screen */
title_loop:
	result=title();
	if (result!=0) goto title_loop;

	nameo[0]=0;

	/* Get Name */
	name_screen();
	if (nameo[0]==0) {
		strcpy(nameo,"DEATER");
	}

	/* Flying */
	home();
	flying();

	/* World Map */
	world_map();

	/* Game Over, Man */
	game_over();

	return 0;
}

