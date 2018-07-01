#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"

#include "tfv_sprites.h"
#include "tfv_backgrounds.h"


/* Do Battle */


/* Metrocat Easter Egg (summon?) */

/* Environment: grass, beach, forest, ice */

/* Enemies:          HP		ATTACK          WEAKNESS	RESIST */
/*   Killer Crab    RND-32	PINCH		MALAISE		FIRE
     Plain Fish                 BUBBLE          FIRE            ICE

     Evil Tree      RND-16	LEAVE		FIRE		ICE
     Wood Elf                   SING            MALAISE         BOLT

     Giant Bee	    RND-64	BUZZSAW		ICE		NONE
     Procrastinon   RND-32	PUTOFF		NONE		MALAISE

     Ice Fish       RND-32	AUGER		FIRE		ICE
     EvilPenguin                WADDLE          FIRE            ICE

*/

/* Battle.
Forest? Grassland? Artic? Ocean?
                       ATTACK    REST
                       MAGIC     LIMIT
		       SUMMON    RUN

		SUMMONS -> METROCAT
		MAGIC   ->  HEAL    FIRE
                            ICE     MALAISE
			    BOLT
		LIMIT	->  SLICE   ZAP
                            DROP    

          1         2         3
0123456789012345678901234567890123456789|
----------------------------------------|
            |            HP      LIMIT  |  -> FIGHT/LIMIT       21
KILLER CRAB | DEATER   128/255    128   |     ZAP               22
            |                           |     REST              23
            |                           |     RUN AWAY          24

Sound effects?

List hits

******    **    ****    ****    **  **  ******    ****  ******  ******  ******
**  **  ****        **      **  **  **  **      **          **  **  **  **  **
**  **    **      ****  ****    ******  ****    ******    **    ******  ******
**  **    **    **          **      **      **  **  **    **    **  **      **
******  ******  ******  ****        **  ****    ******    **    ******      **

*/

static int battle_bar=0;


/* Background depend on map location? */
/* Room for guinea pig in party? */

/* Attacks -> HIT, ZAP, HEAL, RUNAWAY */
#define MAGIC_NONE	0
#define MAGIC_FIRE	1
#define	MAGIC_ICE	2
#define MAGIC_MALAISE	4
#define MAGIC_BOLT	8
#define MAGIC_HEAL	16

struct enemy_type {
	char *name;
	int hp_base,hp_mask;
	char *attack_name;
	int weakness,resist;
	unsigned char *sprite;
};

static struct enemy_type enemies[8]={
	[0]= {
		.name="Killer Crab",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Pinch",
		.weakness=MAGIC_MALAISE,
		.resist=MAGIC_FIRE,
		.sprite=killer_crab,
	},
	[1]= {
		.name="Plain Fish",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Bubble",
		.weakness=MAGIC_FIRE,
		.resist=MAGIC_ICE,
		.sprite=killer_crab,
	},
	[2]= {
		.name="Evil Tree",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Leaves",
		.weakness=MAGIC_FIRE,
		.resist=MAGIC_ICE,
		.sprite=killer_crab,
	},
	[3]= {
		.name="Wood Elf",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Song",
		.weakness=MAGIC_MALAISE,
		.resist=MAGIC_BOLT|MAGIC_HEAL,
		.sprite=killer_crab,
	},
	[4]= {
		.name="Giant Bee",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Buzzsaw",
		.weakness=MAGIC_ICE,
		.resist=MAGIC_NONE,
		.sprite=killer_crab,
	},
	[5]= {
		.name="Procrastinon",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Putoff",
		.weakness=MAGIC_NONE,
		.resist=MAGIC_MALAISE,
		.sprite=killer_crab,
	},
	[6]= {
		.name="Ice Fish",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Auger",
		.weakness=MAGIC_FIRE,
		.resist=MAGIC_ICE,
		.sprite=killer_crab,
	},
	[7]= {
		.name="Evil Penguin",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Waddle",
		.weakness=MAGIC_FIRE,
		.resist=MAGIC_ICE,
		.sprite=killer_crab,
	},
};

static int gr_put_num(int xx,int yy,int number) {

	int xt=xx,digit,left,hundreds;

	digit=number/100;
	if ((digit) && (digit<10)) {
		grsim_put_sprite(numbers[digit],xt,yy);
	}
	hundreds=digit;
	left=number%100;
	xt+=4;

	digit=left/10;
	if ((digit) || (hundreds)) {
		grsim_put_sprite(numbers[digit],xt,yy);
	}
	left=number%10;

	xt+=4;

	digit=left;
	grsim_put_sprite(numbers[digit],xt,yy);

	return 0;
}


static int attack(int enemy_x,int enemy_type) {

	int ax=34;
	int damage=10;

	while(ax>10) {

		gr_copy_to_current(0xc00);

		if (ax&1) {
			grsim_put_sprite(tfv_stand_left,ax,20);
		}
		else {
			grsim_put_sprite(tfv_walk_left,ax,20);
		}
		grsim_put_sprite(tfv_led_sword,ax-5,20);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		page_flip();

		ax-=1;

		usleep(20000);
	}

	gr_put_num(2,10,damage);
	page_flip();
	usleep(250000);

	return damage;
}



static int enemy_attack(int enemy_x,int enemy_type,int tfv_x) {

	int ax=enemy_x;
	int damage=10;

	while(ax<30) {

		// put attack name on
		// occasionally attack with that enemy's power?
		// occasionally heal self?

		gr_copy_to_current(0xc00);

		// draw first so behind enemy
		grsim_put_sprite(tfv_stand_left,tfv_x,20);
		grsim_put_sprite(tfv_led_sword,tfv_x-5,20);

		if (ax&1) {
			grsim_put_sprite(enemies[enemy_type].sprite,ax,20);
		}
		else {
			grsim_put_sprite(enemies[enemy_type].sprite,ax,20);
		}

		page_flip();

		ax+=1;

		usleep(20000);
	}

	gr_put_num(25,10,damage);
	page_flip();
	usleep(250000);

	return damage;
}



static int victory_dance(void) {

	int ax=34;
	int i;
	int saved_drawpage;

	saved_drawpage=ram[DRAW_PAGE];

	ram[DRAW_PAGE]=PAGE2;	// 0xc00

	clear_bottom();

	vtab(21);
	htab(10);
	move_cursor();
	print("EXPERIENCE +2");
	experience+=2;

	vtab(22);
	htab(10);
	move_cursor();
	print("MONEY +1");
	money+=1;

	ram[DRAW_PAGE]=saved_drawpage;

	for(i=0;i<25;i++) {

		gr_copy_to_current(0xc00);

		if (i&1) {
			grsim_put_sprite(tfv_stand_left,ax,20);
			grsim_put_sprite(tfv_led_sword,ax-5,20);
		}
		else {
			grsim_put_sprite(tfv_victory,ax,20);
			grsim_put_sprite(tfv_led_sword,ax-2,14);
		}

		page_flip();

		usleep(200000);
	}

	return 0;
}

static int draw_battle_bottom(int enemy_type) {

	int i;
	int saved_page;

	saved_page=ram[DRAW_PAGE];

	ram[DRAW_PAGE]=PAGE2;	// 0xc00

	clear_bottom();

	vtab(22);
	htab(1);
	move_cursor();
	print(enemies[enemy_type].name);

	vtab(21);
	htab(25);
	move_cursor();
	print("HP");

	vtab(21);
	htab(28);
	move_cursor();
	print("MP");

	vtab(21);
	htab(31);
	move_cursor();
	print("TIME");

	vtab(21);
	htab(36);
	move_cursor();
	if (limit<4) {
		print("LIMIT");
	}
	else {
		/* Make if flash? set bit 0x40 */
		print_flash("LIMIT");
	}

	vtab(22);
	htab(15);
	move_cursor();
	// should print "NAMEO"
	print("DEATER--");

	vtab(22);
	htab(24);
	move_cursor();
	print_byte(hp);

	vtab(22);
	htab(27);
	move_cursor();
	print_byte(mp);

	/* Draw Time bargraph */
	printf("Battle_bar=%d Limit=%d\n",battle_bar,limit);
	ram[COLOR]=0xa0;
	hlin_double(ram[DRAW_PAGE],30,34,42);
	ram[COLOR]=0x20;
	if (battle_bar) hlin_double(ram[DRAW_PAGE],30,30+(battle_bar-1),42);


	/* Draw Limit break bargraph */
	ram[COLOR]=0xa0;
	hlin_double(ram[DRAW_PAGE],35,39,42);

	ram[COLOR]=0x20;
	if (limit) hlin_double(ram[DRAW_PAGE],35,35+limit,42);

	/* Draw inverse separator */
	ram[COLOR]=0x20;
	for(i=40;i<50;i+=2) {
		hlin_double(ram[DRAW_PAGE],12,12,i);
	}

	ram[DRAW_PAGE]=saved_page;

	return 0;
}


static int rotate_intro(void) {

	int xx,yy,color,x2,y2;
	double h,theta,dx,dy,theta2,thetadiff,nx,ny;
	int i;

	gr_copy(0x400,0xc00);

//	gr_copy_to_current(0xc00);
//	page_flip();
//	gr_copy_to_current(0xc00);
//	page_flip();

	thetadiff=0;

	for(i=0;i<8;i++) {

		grsim_update();

		for(yy=0;yy<40;yy++) {
			for(xx=0;xx<40;xx++) {
				dx=(xx-20);
				dy=(yy-20);
				h=sqrt((dx*dx)+(dy*dy));
				theta=atan2(dy,dx);

				theta2=theta+thetadiff;
				nx=h*cos(theta2);
				ny=h*sin(theta2);

				x2=nx+20;
				y2=ny+20;
				if ((x2<0) || (x2>39)) color=0;
				else if ((y2<0) || (y2>39)) color=0;
				else color=scrn_page(x2,y2,PAGE2);

				color_equals(color);
				plot(xx,yy);
			}
		}
		thetadiff+=(6.28/16.0);
		page_flip();

		usleep(100000);
	}

	return 0;
}


int do_battle(void) {

	int i,ch;

	int enemy_x=2;
	int enemy_type=0;
	int saved_drawpage;
	int enemy_hp=0;

	int ax=34;
	int battle_count=20;
	int enemy_count=30;
	int old;

	/* Setup Enemy */
	// enemy_type=X
	// random, with weight toward proper terrain

	rotate_intro();

	/* Setup Enemy HP */
	enemy_hp=enemies[enemy_type].hp_base+
			(rand()&enemies[enemy_type].hp_mask);


	saved_drawpage=ram[DRAW_PAGE];

	ram[DRAW_PAGE]=PAGE2;

	draw_battle_bottom(enemy_type);

	/*******************/
	/* Draw background */

	/* Draw sky */
	color_equals(COLOR_MEDIUMBLUE);
	for(i=0;i<10;i++) {
		hlin_double(ram[DRAW_PAGE],0,39,i);
	}

	/* Draw ground */
	/* FIXME: base on map location */
	color_equals(COLOR_LIGHTGREEN);
	for(i=10;i<40;i++) {
		hlin_double(ram[DRAW_PAGE],0,39,i);
	}

	ram[DRAW_PAGE]=saved_drawpage;

	while(1) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_stand_left,ax,20);
		grsim_put_sprite(tfv_led_sword,ax-5,20);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		page_flip();

		usleep(100000);

		ch=grsim_input();
		if (ch=='q') return 0;

		if (enemy_count==0) {
			// attack and decrement HP
			hp-=enemy_attack(enemy_x,enemy_type,ax);
			// update limit count
			if (limit<4) limit++;
			// redraw bottom
			draw_battle_bottom(enemy_type);
			// reset enemy time. FIXME: variable?
			enemy_count=50;
		}
		else {
			enemy_count--;
		}

		if (battle_count>=64) {
			if (ch==' ') {
				// attack and decrement HP
				enemy_hp-=attack(enemy_x,enemy_type);
				// redraw bottom
				draw_battle_bottom(enemy_type);
				// reset battle time
				battle_count=0;
			}
		} else {
			battle_count++;
		}

		old=battle_bar;
		battle_bar=(battle_count/16);
		if (battle_bar!=old) draw_battle_bottom(enemy_type);


		if (enemy_hp<0) {
			victory_dance();
			break;
		}

//		if (hp<0) {
//			game_over();
//		}

	}

	ram[DRAW_PAGE]=PAGE0;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE1;
	clear_bottom();

	return 0;
}
