#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <math.h>

#include "gr-sim.h"
#include "tfv_utils.h"
#include "tfv_zp.h"
#include "tfv_defines.h"
#include "tfv_definitions.h"

#include "tfv_sprites.h"
#include "tfv_backgrounds.h"


/* Do Battle */


/* Metrocat (summon?) */

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

		SUMMONS -> METROCAT VORTEXCN
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
		.hp_base=50,
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
		.sprite=plain_fish,
	},
	[2]= {
		.name="Evil Tree",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Leaves",
		.weakness=MAGIC_FIRE,
		.resist=MAGIC_ICE,
		.sprite=evil_tree,
	},
	[3]= {
		.name="Wood Elf",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Song",
		.weakness=MAGIC_MALAISE,
		.resist=MAGIC_BOLT|MAGIC_HEAL,
		.sprite=wood_elf,
	},
	[4]= {
		.name="Giant Bee",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Buzzsaw",
		.weakness=MAGIC_ICE,
		.resist=MAGIC_NONE,
		.sprite=giant_bee,
	},
	[5]= {
		.name="Procrastinon",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Putoff",
		.weakness=MAGIC_NONE,
		.resist=MAGIC_MALAISE,
		.sprite=procrastinon,
	},
	[6]= {
		.name="Ice Fish",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Auger",
		.weakness=MAGIC_FIRE,
		.resist=MAGIC_ICE,
		.sprite=ice_fish,
	},
	[7]= {
		.name="Evil Penguin",
		.hp_base=10,
		.hp_mask=0x1f,
		.attack_name="Waddle",
		.weakness=MAGIC_FIRE,
		.resist=MAGIC_ICE,
		.sprite=evil_penguin,
	},
};


// http://codebase64.org/doku.php?id=base:small_fast_8-bit_prng
static int random_8(void) {

	static int seed=0x1f;
	static int newseed;

	newseed=seed;					// lda seed
	if (newseed==0) goto doEor;			// beq doEor
	newseed<<=1;					// asl
	if (newseed==0) goto noEor;			//beq noEor
					// if the input was $80, skip the EOR
	if (!(newseed&0x100)) goto noEor;		// bcc noEor
doEor:
	newseed^=0x1d;					// eor #$1d
noEor:
	seed=(newseed&0xff);				// sta seed
	return seed;
}

static int gr_put_num(int xx,int yy,int number) {

	int xt=xx,digit,left,hundreds;

	digit=number/100;
	if ((digit) && (digit<10)) {
		grsim_put_sprite(numbers[digit],xt,yy);
		xt+=4;
	}
	hundreds=digit;
	left=number%100;

	digit=left/10;
	if ((digit) || (hundreds)) {
		grsim_put_sprite(numbers[digit],xt,yy);
		xt+=4;
	}
	left=number%10;

	digit=left;
	grsim_put_sprite(numbers[digit],xt,yy);

	return 0;
}

/*
                       ATTACK    SKIP
                       MAGIC     LIMIT
		       SUMMON    ESCAPE

		SUMMONS -> METROCAT VORTEXCN
		MAGIC   ->  HEAL    FIRE
                            ICE     MALAISE
			    BOLT
		LIMIT	->  SLICE   ZAP
                            DROP

	State Machine

		time
	BOTTOM -------> MAIN_MENU ----->ATTACK
				------->SKIP
				------->MAGIC_MENU
				------->LIMIT_MENU
				------->SUMMON_MENU
				------->ESCAPE

*/

#define MENU_NONE	0
#define MENU_MAIN	1
#define MENU_MAGIC	2
#define MENU_SUMMON	3
#define MENU_LIMIT	4

static int enemy_attacking=0;
static int menu_state=MENU_NONE;
static int menu_position=0;
static int battle_count=0;

static int draw_battle_bottom(int enemy_type) {

	int i;

	clear_bottom();

	vtab(22);
	htab(1);
	move_cursor();
	print(enemies[enemy_type].name);

	if (enemy_attacking) {
		vtab(24);
		htab(2);
		move_cursor();
		print_inverse(enemies[enemy_type].attack_name);
	}

	vtab(22);
	htab(15);
	move_cursor();
	// should print "NAMEO"
//	print("DEATER");
	print(nameo);

	if (menu_state==MENU_NONE) {

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
		htab(24);
		move_cursor();
		print_byte(hp);

		vtab(22);
		htab(27);
		move_cursor();
		print_byte(mp);

		/* Draw Time bargraph */
//		printf("Battle_bar=%d Limit=%d\n",battle_bar,limit);
		ram[COLOR]=0xa0;
		hlin_double(ram[DRAW_PAGE],30,34,42);
		ram[COLOR]=0x20;
		if (battle_bar) {
			hlin_double(ram[DRAW_PAGE],30,30+(battle_bar-1),42);
		}

		/* Draw Limit break bargraph */
		ram[COLOR]=0xa0;
		hlin_double(ram[DRAW_PAGE],35,39,42);

		ram[COLOR]=0x20;
		if (limit) hlin_double(ram[DRAW_PAGE],35,35+limit,42);
	}

	if (menu_state==MENU_MAIN) {

		if (limit>3) {
			if (menu_position>5) menu_position=5;
		}
		else {
			if (menu_position>4) menu_position=4;
		}

		vtab(21);
		htab(24);
		move_cursor();
		if (menu_position==0) print_inverse("ATTACK");
		else print("ATTACK");

		vtab(22);
		htab(24);
		move_cursor();
		if (menu_position==2) print_inverse("MAGIC");
		else print("MAGIC");

		vtab(23);
		htab(24);
		move_cursor();
		if (menu_position==4) print_inverse("SUMMON");
		else print("SUMMON");

		vtab(21);
		htab(32);
		move_cursor();
		if (menu_position==1) print_inverse("SKIP");
		else print("SKIP");

		vtab(22);
		htab(32);
		move_cursor();
		if (menu_position==3) print_inverse("ESCAPE");
		else print("ESCAPE");

		if (limit>3) {
			vtab(23);
			htab(32);
			move_cursor();
			if (menu_position==5) print_inverse("LIMIT");
			else print("LIMIT");
		}


	}
	if (menu_state==MENU_SUMMON) {

		if (menu_position>1) menu_position=1;

		vtab(21);
		htab(25);
		move_cursor();
		print("SUMMONS:");

		vtab(22);
		htab(25);
		move_cursor();
		if (menu_position==0) print_inverse("METROCAT");
		else print("METROCAT");

		vtab(23);
		htab(25);
		move_cursor();
		if (menu_position==1) print_inverse("VORTEXCN");
		else print("VORTEXCN");
	}
	if (menu_state==MENU_MAGIC) {

		if (menu_position>4) menu_position=4;

		vtab(21);
		htab(24);
		move_cursor();
		print("MAGIC:");

		vtab(22);
		htab(25);
		move_cursor();
		if (menu_position==0) print_inverse("HEAL");
		else print("HEAL");

		vtab(23);
		htab(25);
		move_cursor();
		if (menu_position==2) print_inverse("ICE");
		else print("ICE");

		vtab(24);
		htab(25);
		move_cursor();
		if (menu_position==4) print_inverse("BOLT");
		else print("BOLT");

		vtab(22);
		htab(32);
		move_cursor();
		if (menu_position==1) print_inverse("FIRE");
		else print("FIRE");

		vtab(23);
		htab(32);
		move_cursor();
		if (menu_position==3) print_inverse("MALAISE");
		else print("MALAISE");

	}

	if (menu_state==MENU_LIMIT) {

		if (menu_position>2) menu_position=2;

		vtab(21);
		htab(24);
		move_cursor();
		print("LIMIT BREAKS:");

		vtab(22);
		htab(25);
		move_cursor();
		if (menu_position==0) print_inverse("SLICE");
		else print("SLICE");

		vtab(23);
		htab(25);
		move_cursor();
		if (menu_position==2) print_inverse("DROP");
		else print("DROP");

		vtab(22);
		htab(32);
		move_cursor();
		if (menu_position==1) print_inverse("ZAP");
		else print("ZAP");
	}

	/* Draw inverse separator */
	ram[COLOR]=0x20;
	for(i=40;i<50;i+=2) {
		hlin_double(ram[DRAW_PAGE],12,12,i);
	}

//	ram[DRAW_PAGE]=saved_page;

	return 0;
}

static int enemy_hp=0,enemy_type=0,enemy_x=0;

static int damage_enemy(int value) {

	if (enemy_hp>value) enemy_hp-=value;
	else enemy_hp=0;

	return 0;

}

static int heal_self(int value) {

	hp+=value;
	if (hp>max_hp) hp=max_hp;

	return 0;

}


static int damage_tfv(int value) {

	if (hp>value) hp-=value;
	else hp=0;

	return 0;

}

static int attack(void) {

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

		draw_battle_bottom(enemy_type);

		page_flip();

		ax-=1;

		usleep(20000);
	}

	damage_enemy(damage);
	gr_put_num(2,10,damage);
	page_flip();
	usleep(250000);

	return 0;
}



static int enemy_attack(int tfv_x) {

	int ax=enemy_x;
	int damage=10;

	enemy_attacking=1;

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

		draw_battle_bottom(enemy_type);

		page_flip();

		ax+=1;

		usleep(20000);
	}
	enemy_attacking=0;

	damage_tfv(damage);
	gr_put_num(25,10,damage);
	draw_battle_bottom(enemy_type);

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

#define MENU_MAGIC_HEAL		0
#define MENU_MAGIC_ICE		1
#define MENU_MAGIC_FIRE		2
#define MENU_MAGIC_MALAISE	3
#define MENU_MAGIC_BOLT		4


static void magic_attack(int which) {

	int ax=34,ay=20;
	int mx,my;
	int damage=20;
	int i;

	unsigned char *sprite;

	if (which==MENU_MAGIC_HEAL) {
		sprite=magic_health;
		mx=33;
		my=20;
	}
	if (which==MENU_MAGIC_FIRE) {
		sprite=magic_fire;
		mx=2;
		my=20;
	}
	if (which==MENU_MAGIC_ICE) {
		sprite=magic_ice;
		mx=2;
		my=20;
	}
	if (which==MENU_MAGIC_BOLT) {
		sprite=magic_bolt;
		mx=2;
		my=20;
	}
	if (which==MENU_MAGIC_MALAISE) {
		sprite=magic_malaise;
		mx=2;
		my=20;
	}


	// FIXME: damage based on weakness of enemy
	// FIXME: disallow if not enough MP

	/* cast the magic */
	i=0;
	while(i<10) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_victory,34,20);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		draw_battle_bottom(enemy_type);

		page_flip();

		i++;

		usleep(20000);
	}

	ax=34;
	ay=20;
	i=0;

	/* Actually put the magic */

	while(i<=20) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		grsim_put_sprite(tfv_stand_left,ax,ay);
		grsim_put_sprite(tfv_led_sword,ax-5,ay);

		grsim_put_sprite(sprite,mx+(i&1),my);

		draw_battle_bottom(enemy_type);

		page_flip();

		i++;

		usleep(100000);
	}

	mp-=5;

	gr_copy_to_current(0xc00);

	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

	grsim_put_sprite(tfv_stand_left,ax,ay);
	grsim_put_sprite(tfv_led_sword,ax-5,ay);

	draw_battle_bottom(enemy_type);

	if (which!=MENU_MAGIC_HEAL) {
		damage_enemy(damage);
		gr_put_num(2,10,damage);
	}
	else {
		heal_self(damage);
	}
	draw_battle_bottom(enemy_type);
	page_flip();

	for(i=0;i<20;i++) {
		usleep(100000);
	}
}


/* Limit Break "Drop" */
/* Jump into sky, drop down and slice enemy in half */

static void limit_break_drop(void) {

	int ax=34,ay=20;
	int damage=100;
	int i;

	while(ay>0) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_stand_left,ax,ay);
		grsim_put_sprite(tfv_led_sword,ax-5,ay);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		draw_battle_bottom(enemy_type);

		page_flip();

		ay-=1;

		usleep(20000);
	}

	ax=10;
	ay=0;

	/* Falling */

	while(ay<=20) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		grsim_put_sprite(tfv_stand_left,ax,ay);
		grsim_put_sprite(tfv_led_sword,ax-5,ay);

		draw_battle_bottom(enemy_type);

		color_equals(13);
		vlin(0,ay,ax-5);

		page_flip();

		ay+=1;

		usleep(100000);
	}

	i=0;
	while(i<13) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		grsim_put_sprite(tfv_stand_left,ax,ay);
		grsim_put_sprite(tfv_led_sword,ax-5,ay);

		draw_battle_bottom(enemy_type);

		color_equals(COLOR_LIGHTGREEN);
		vlin(ay,ay+i,ax-5);

		page_flip();
		i++;

		usleep(100000);
	}

	ax=34;
	ay=20;

	gr_copy_to_current(0xc00);

	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

	grsim_put_sprite(tfv_stand_left,ax,ay);
	grsim_put_sprite(tfv_led_sword,ax-5,ay);

	draw_battle_bottom(enemy_type);

	color_equals(COLOR_LIGHTGREEN);
	vlin(20,33,5);

	damage_enemy(damage);
	gr_put_num(2,10,damage);
	page_flip();

	for(i=0;i<20;i++) {
		usleep(100000);
	}
}


/* Limit Break "Slice" */
/* Run up and slap a bunch with sword */
/* TODO: cause damage value to bounce around more? */

static void limit_break_slice(void) {

	int tx=34,ty=20;
	int damage=5;
	int i;

	while(tx>10) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_stand_left,tx,ty);
		grsim_put_sprite(tfv_led_sword,tx-5,ty);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		draw_battle_bottom(enemy_type);

		page_flip();

		tx-=1;

		usleep(20000);
	}

	/* Slicing */
	for(i=0;i<20;i++) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		if (i&1) {
			grsim_put_sprite(tfv_stand_left,tx,20);
			grsim_put_sprite(tfv_led_sword,tx-5,20);
		}
		else {
			grsim_put_sprite(tfv_victory,tx,20);
			grsim_put_sprite(tfv_led_sword,tx-2,14);
		}

		damage_enemy(damage);
		gr_put_num(2+(i%2),10+((i%2)*2),damage);

		draw_battle_bottom(enemy_type);

		page_flip();

		usleep(100000);
	}

	tx=34;
	ty=20;

	gr_copy_to_current(0xc00);

	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

	grsim_put_sprite(tfv_stand_left,tx,ty);
	grsim_put_sprite(tfv_led_sword,tx-5,ty);

	draw_battle_bottom(enemy_type);

	page_flip();

	for(i=0;i<20;i++) {
		usleep(100000);
	}
}

/* Limit Break "Zap" */
/* Zap with a laser out of the LED sword */

static void limit_break_zap(void) {

	int tx=34,ty=20;
	int damage=100;
	int i;


	gr_copy_to_current(0xc00);

	/* Draw background */
	color_equals(COLOR_AQUA);
	vlin(12,24,34);
	hlin_double(ram[DRAW_PAGE],28,38,18);

	/* Sword in air */
	grsim_put_sprite(tfv_victory,tx,20);
	grsim_put_sprite(tfv_led_sword,tx-2,14);

	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

	draw_battle_bottom(enemy_type);

	page_flip();

	usleep(500000);

	for(i=0;i<32;i++) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		color_equals(i%16);
		hlin_double(ram[DRAW_PAGE],5,30,22);

		grsim_put_sprite(tfv_stand_left,tx,ty);
		grsim_put_sprite(tfv_led_sword,tx-5,ty);

		draw_battle_bottom(enemy_type);

		page_flip();

		usleep(100000);
	}

	gr_copy_to_current(0xc00);

	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

	grsim_put_sprite(tfv_stand_left,tx,ty);
	grsim_put_sprite(tfv_led_sword,tx-5,ty);

	draw_battle_bottom(enemy_type);

	damage_enemy(damage);
	gr_put_num(2,10,damage);
	page_flip();

	for(i=0;i<20;i++) {
		usleep(100000);
	}

}


#define MENU_LIMIT_SLICE	0
#define MENU_LIMIT_ZAP		1
#define MENU_LIMIT_DROP		2


static void limit_break(int which) {

	if (which==MENU_LIMIT_DROP) limit_break_drop();
	else if (which==MENU_LIMIT_SLICE) limit_break_slice();
	else if (which==MENU_LIMIT_ZAP) limit_break_zap();

	/* reset limit counter */
	limit=0;

}

static void summon_metrocat(void) {

	int tx=34,ty=20;
	int damage=100;
	int i;
	int ax=28,ay=2;

	i=0;
	while(i<30) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_stand_left,tx,ty);
		grsim_put_sprite(tfv_led_sword,tx-5,ty);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		grsim_put_sprite(metrocat,ax,ay);

		draw_battle_bottom(enemy_type);

		page_flip();

		i++;

		usleep(20000);
	}

	while(ax>15) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_stand_left,tx,ty);
		grsim_put_sprite(tfv_led_sword,tx-5,ty);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		grsim_put_sprite(metrocat,ax,ay);

		draw_battle_bottom(enemy_type);

		page_flip();

		ax-=1;

		usleep(20000);
	}

	while(ax>5) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_stand_left,tx,ty);
		grsim_put_sprite(tfv_led_sword,tx-5,ty);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		grsim_put_sprite(metrocat,ax,ay);

		draw_battle_bottom(enemy_type);

		page_flip();

		ay+=1;
		ax-=1;

		usleep(20000);
	}

	i=0;
	while(i<30) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_stand_left,tx,ty);
		grsim_put_sprite(tfv_led_sword,tx-5,ty);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		grsim_put_sprite(metrocat,ax,ay);

		draw_battle_bottom(enemy_type);

		page_flip();

		i++;

		usleep(20000);
	}

	gr_copy_to_current(0xc00);

	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

	grsim_put_sprite(tfv_stand_left,tx,ty);
	grsim_put_sprite(tfv_led_sword,tx-5,ty);
	draw_battle_bottom(enemy_type);

	damage_enemy(damage);
	gr_put_num(2,10,damage);
	page_flip();

	for(i=0;i<20;i++) {
		usleep(100000);
	}
}

static void summon_vortex_cannon(void) {

	int tx=34,ty=20;
	int damage=5;
	int i;
	int ax=20,ay=20;

	/* draw the cannon */

	i=0;
	while(i<30) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_stand_left,tx,ty);
		grsim_put_sprite(tfv_led_sword,tx-5,ty);

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		grsim_put_sprite(vortex_cannon,ax,ay);

		draw_battle_bottom(enemy_type);

		page_flip();

		i++;

		usleep(20000);
	}

	/* Fire vortices */

	ax=20;
	for(i=0;i<5;i++) {
		while(ax>5) {

			gr_copy_to_current(0xc00);

			grsim_put_sprite(tfv_stand_left,tx,ty);
			grsim_put_sprite(tfv_led_sword,tx-5,ty);

			grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

			grsim_put_sprite(vortex_cannon,20,20);

			grsim_put_sprite(vortex,ax,24);

			draw_battle_bottom(enemy_type);

			if (ax<10) {
				gr_put_num(2,10,damage);
			}

			page_flip();

			ax-=1;

			usleep(50000);
		}
		damage_enemy(damage);
		ax=20;
	}


	gr_copy_to_current(0xc00);

	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

	grsim_put_sprite(tfv_stand_left,tx,ty);
	grsim_put_sprite(tfv_led_sword,tx-5,ty);
	draw_battle_bottom(enemy_type);

	page_flip();

	for(i=0;i<20;i++) {
		usleep(100000);
	}

}

static void summon(int which) {

	if (which==0) summon_metrocat();
	else summon_vortex_cannon();
}



static void done_attack(void) {
	// reset battle time
	battle_count=0;
	menu_state=MENU_NONE;
}

#define MENU_MAIN_ATTACK	0
#define MENU_MAIN_SKIP		1
#define MENU_MAIN_MAGIC		2
#define MENU_MAIN_ESCAPE	3
#define MENU_MAIN_SUMMON	4
#define MENU_MAIN_LIMIT		5


static int running=0;

void menu_keypress(int ch) {

	if ((ch==' ') || (ch==13)) {

		if (menu_state==MENU_MAIN) {

			switch(menu_position) {
				case MENU_MAIN_ATTACK:
					// attack and decrement HP
					attack();
					done_attack();
					break;
				case MENU_MAIN_SKIP:
					done_attack();
					break;
				case MENU_MAIN_MAGIC:
					menu_state=MENU_MAGIC;
					menu_position=0;
					break;
				case MENU_MAIN_LIMIT:
					menu_state=MENU_LIMIT;
					menu_position=0;
					break;
				case MENU_MAIN_SUMMON:
					menu_state=MENU_SUMMON;
					menu_position=0;
					break;
				case MENU_MAIN_ESCAPE:
					running=1;
					done_attack();
					break;
			}
		}
		else if (menu_state==MENU_MAGIC) {
			magic_attack(menu_position);
			done_attack();
		}
		else if (menu_state==MENU_LIMIT) {
			limit_break(menu_position);
			done_attack();
		}
		else if (menu_state==MENU_SUMMON) {
			summon(menu_position);
			done_attack();
		}
	}

	if (ch==27) {
		menu_state=MENU_MAIN;
		menu_position=0;
	}

	if (ch==APPLE_UP) {
		if (menu_position>=2) menu_position-=2;
	}
	if (ch==APPLE_DOWN) {
		menu_position+=2;
	}
	if (ch==APPLE_RIGHT) {
		menu_position++;
	}
	if (ch==APPLE_LEFT) {
		if (menu_position>0) menu_position--;
	}
}


int do_battle(int ground_color) {

	int i,ch;

	int saved_drawpage;

	int ax=34;
	int enemy_count=30;
	int old;

	rotate_intro();

	battle_count=20;

	/* Setup Enemy */
	// enemy_type=X
	// random, with weight toward proper terrain
	// 50% completely random, 50% terrain based?
	enemy_type=random_8()%0x7;
	enemy_hp=enemies[enemy_type].hp_base+
			(rand()&enemies[enemy_type].hp_mask);


	saved_drawpage=ram[DRAW_PAGE];

	ram[DRAW_PAGE]=PAGE2;



	/*******************/
	/* Draw background */

	/* Draw sky */
	color_equals(COLOR_MEDIUMBLUE);
	for(i=0;i<10;i++) {
		hlin_double(ram[DRAW_PAGE],0,39,i);
	}

	/* Draw ground */
	color_equals(ground_color);
	for(i=10;i<40;i++) {
		hlin_double(ram[DRAW_PAGE],0,39,i);
	}

	/* Draw some background images for variety? */

	ram[DRAW_PAGE]=saved_drawpage;

	draw_battle_bottom(enemy_type);

	while(1) {

		gr_copy_to_current(0xc00);

		if (hp==0) {
			grsim_put_sprite(tfv_defeat,ax-2,24);
		}
		else if (running) {
			if (battle_count%2) {
				grsim_put_sprite(tfv_stand_right,ax,20);
			}
			else {
				grsim_put_sprite(tfv_walk_right,ax,20);
			}
		}
		else {
			grsim_put_sprite(tfv_stand_left,ax,20);
			grsim_put_sprite(tfv_led_sword,ax-5,20);
		}

		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		draw_battle_bottom(enemy_type);

		page_flip();

		if (hp==0) {
			for(i=0;i<15;i++) usleep(100000);
			break;
		}

		usleep(100000);

		ch=grsim_input();
		if (ch=='q') return 0;

		if (enemy_count==0) {
			// attack and decrement HP
			enemy_attack(ax);
			// update limit count
			if (limit<4) limit++;

			// reset enemy time. FIXME: variable?
			enemy_count=50;
		}
		else {
			enemy_count--;
		}

		if (battle_count>=64) {

			/* TODO: randomly fail at running? */
			if (running) {
				break;
			}

			if (menu_state==MENU_NONE) menu_state=MENU_MAIN;
			menu_keypress(ch);

		} else {
			battle_count++;
		}

		old=battle_bar;
		battle_bar=(battle_count/16);
		if (battle_bar!=old) draw_battle_bottom(enemy_type);


		if (enemy_hp==0) {
			victory_dance();
			break;
		}


	}

	ram[DRAW_PAGE]=PAGE0;
	clear_bottom();
	ram[DRAW_PAGE]=PAGE1;
	clear_bottom();

	running=0;

	return 0;
}
