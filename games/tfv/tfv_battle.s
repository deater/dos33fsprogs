	;================================
	; do battle
	;================================

do_battle:

	lda	#34
	sta	HERO_X

	lda	#0
	sta	HERO_STATE
	sta	MENU_STATE
	sta	MENU_POSITION

	lda	#3
	sta	HERO_LIMIT

	jsr	rotate_intro

	lda	#20
	sta	BATTLE_COUNT


	;=============================
	; Init Enemy
	;=============================

	jsr	init_enemy

	;==========================
	; Draw background

	;==========================
	;  Draw sky

	ldx	#0	; blue from 0 .. 10
battle_sky_loop:
	lda	gr_offsets,X
	sta	GBASL
	lda	gr_offsets+1,X
	clc
	adc	#$8		; store to $C00
	sta	GBASH

	lda	#$66		; COLOR_MEDIUMBLUE
	ldy	#0
battle_sky_inner:
	sta	(GBASL),Y
	iny
	cpy	#40
	bne	battle_sky_inner

	inx
	inx
	cpx	#10
	bne	battle_sky_loop


				; green from 10 .. 40
battle_ground_loop:
	lda	gr_offsets,X
	sta	GBASL
	lda	gr_offsets+1,X
	clc
	adc	#$8		; store to $C00
	sta	GBASH

	lda	#$CC		; COLOR_LIGHTGREEN
				; FIXME: should be GROUNDCOLOR
	ldy	#0
battle_ground_inner:
	sta	(GBASL),Y
	iny
	cpy	#40
	bne	battle_ground_inner

	inx
	inx
	cpx	#40
	bne	battle_ground_loop

	; Draw some background images for variety?

	; update bottom of screen
	jsr	draw_battle_bottom

main_battle_loop:

	jsr	gr_copy_to_current

	;========================================
	; draw our hero
	;========================================

	lda	HERO_HP
	beq	battle_draw_hero_down

	lda	HERO_STATE
	and	#HERO_STATE_RUNNING
	bne	battle_draw_hero_running

	jmp	battle_draw_normal_hero

battle_draw_hero_down:
	; grsim_put_sprite(tfv_defeat,ax-2,24);

	lda	HERO_X
	sec
	sbc	#2
	sta	XPOS
	lda	#24
	sta	YPOS

	lda	#<tfv_defeat_sprite
	sta	INL
	lda	#>tfv_defeat_sprite
	sta	INH
	jsr	put_sprite_crop
	jmp	battle_done_draw_hero

battle_draw_hero_running:

	; grsim_put_sprite(tfv_stand_right,ax,20);
	; grsim_put_sprite(tfv_walk_right,ax,20);

	lda	HERO_X
	sta	XPOS
	lda	#20
	sta	YPOS

	lda	BATTLE_COUNT
	and	#$8
	beq	battle_draw_running_walk

battle_draw_running_stand:
	lda	#<tfv_stand_right_sprite
	sta	INL
	lda	#>tfv_stand_right_sprite
	sta	INH
	jsr	put_sprite_crop
	jmp	battle_done_draw_hero

battle_draw_running_walk:
	lda	#<tfv_walk_right_sprite
	sta	INL
	lda	#>tfv_walk_right_sprite
	sta	INH
	jsr	put_sprite_crop
	jmp	battle_done_draw_hero

battle_draw_normal_hero:
	; grsim_put_sprite(tfv_stand_left,ax,20);

	lda	#20
	sta	HERO_Y

	jsr	draw_hero_and_sword

battle_done_draw_hero:

	;===========================
	; draw enemy
	;===========================
battle_draw_enemy:

	; grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS

	jsr	draw_enemy

battle_done_draw_enemy:

	;=======================================
	; draw bottom status

	jsr	draw_battle_bottom

	;=======================================
	; page_flip

	jsr	page_flip

	; pause if dead

	; if (hp==0) {
	;	for(i=0;i<15;i++) usleep(100000);
	;	break;
	; }

	; delay for framerate
	; usleep(100000);

	;=======================
	; handle keypresses

	jsr	get_keypress
	sta	LAST_KEY
	cmp	#'Q'
	beq	done_battle

	;========================
	; handle enemy attacks

	lda	ENEMY_COUNT
	bne	battle_no_enemy_attack
battle_start_enemy_attack:

	; attack and decrement HP
	jsr	enemy_attack

	; update limit count
	; max out at 4
	lda	HERO_LIMIT
	cmp	#4
	beq	battle_no_inc_limit

	inc	HERO_LIMIT
battle_no_inc_limit:

	; reset enemy time. FIXME: variable?
	lda	#50
	sta	ENEMY_COUNT

battle_no_enemy_attack:
	dec	ENEMY_COUNT


	;===============================
	; handle battle counter
update_battle_counter:
	lda	BATTLE_COUNT
	cmp	#64
	bcc	inc_battle_count	; blt

	; battle timer expired, take action

	; If running, escape
	; TODO: randomly fail at running? */
	lda	HERO_STATE
	and	#HERO_STATE_RUNNING
	beq	battle_no_escape

	; we bravely ran away
	jmp	done_battle

battle_no_escape:

	; activate menu

	lda	MENU_STATE
	cmp	#MENU_NONE
	bne	menu_activated

	; move to main menu
	lda	#MENU_MAIN
	sta	MENU_STATE

menu_activated:

	jsr	battle_menu_keypress

	jmp	done_battle_count

inc_battle_count:
	inc	BATTLE_COUNT

done_battle_count:

	;========================
	; check enemy defeated

	lda	ENEMY_HP
	bne	end_battle_loop

	jsr	victory_dance
	jmp	done_battle


end_battle_loop:

	jmp	main_battle_loop

done_battle:

	jsr	clear_bottoms

	; running=0; ?

	rts

; Metrocat (summon?)

; Environment: grass, beach, forest, ice

; Enemies:          HP		ATTACK          WEAKNESS	RESIST
;   Killer Crab    RND-32	PINCH		MALAISE		FIRE
;   Plain Fish                  BUBBLE          FIRE            ICE

;   Evil Tree      RND-16	LEAVE		FIRE		ICE
;   Wood Elf                   SING            MALAISE         BOLT

;   Giant Bee	    RND-64	BUZZSAW		ICE		NONE
;   Procrastinon   RND-32	PUTOFF		NONE		MALAISE

;   Ice Fish       RND-32	AUGER		FIRE		ICE
;   EvilPenguin                WADDLE          FIRE            ICE

; Battle.
; Forest? Grassland? Artic? Ocean?
;                       ATTACK    REST
;                      MAGIC     LIMIT
;		       SUMMON    RUN
;
;		SUMMONS -> METROCAT VORTEXCN
;		MAGIC   ->  HEAL    FIRE
;                            ICE     MALAISE
;			    BOLT
;		LIMIT	->  SLICE   ZAP
;                           DROP
;
;          1         2         3
;0123456789012345678901234567890123456789|
;----------------------------------------|
;            |            HP      LIMIT  |  -> FIGHT/LIMIT       21
;KILLER CRAB | DEATER   128/255    128   |     ZAP               22
;            |                           |     REST              23
;            |                           |     RUN AWAY          24
;
;Sound effects?
;
;List hits
;
;******    **    ****    ****    **  **  ******    ****  ******  ******  ******
;**  **  ****        **      **  **  **  **      **          **  **  **  **  **
;**  **    **      ****  ****    ******  ****    ******    **    ******  ******
;**  **    **    **          **      **      **  **  **    **    **  **      **
;******  ******  ******  ****        **  ****    ******    **    ******      **

; Background depend on map location?
; Room for guinea pig in party?

; Attacks -> HIT, ZAP, HEAL, RUNAWAY
;#define MAGIC_NONE	0
;#define MAGIC_FIRE	1
;#define MAGIC_ICE	2
;#define MAGIC_MALAISE	4
;#define MAGIC_BOLT	8
;#define MAGIC_HEAL	16

; struct enemy_type {
;	char *name;
;	int hp_base,hp_mask;
;	char *attack_name;
;	int weakness,resist;
;	unsigned char *sprite;
;};


	;=============================
	; Init Enemy
	;=============================
init_enemy:

	; select type

	; random, with weight toward proper terrain
	; 50% completely random, 50% terrain based?

	; enemy_type=random_8()%0x7;
;	enemy_hp=enemies[enemy_type].hp_base+
;			(rand()&enemies[enemy_type].hp_mask);

	lda	#0		 ; hardcode crab for now
	sta	ENEMY_TYPE
	sta	ENEMY_X

	lda	#$30		; BCD
	sta	ENEMY_HP

	lda	#30
	sta	ENEMY_COUNT

	lda	#<killer_crab_sprite
	sta	draw_enemy_smc1+1
	lda	#>killer_crab_sprite
	sta	draw_enemy_smc2+1

	rts


;static struct enemy_type enemies[9]={
;	[0]= {
;		.name="Killer Crab",
;		.hp_base=50,
;		.hp_mask=0x1f,
;		.attack_name="Pinch",
;		.weakness=MAGIC_MALAISE,
;		.resist=MAGIC_FIRE,
;		.sprite=killer_crab,
;	},
;	[1]= {
;		.name="Plain Fish",
;		.hp_base=10,
;		.hp_mask=0x1f,
;		.attack_name="Bubble",
;		.weakness=MAGIC_FIRE,
;		.resist=MAGIC_ICE,
;		.sprite=plain_fish,
;	},
;	[2]= {
;		.name="Evil Tree",
;		.hp_base=10,
;		.hp_mask=0x1f,
;		.attack_name="Leaves",
;		.weakness=MAGIC_FIRE,
;		.resist=MAGIC_ICE,
;		.sprite=evil_tree,
;	},
;	[3]= {
;		.name="Wood Elf",
;		.hp_base=10,
;		.hp_mask=0x1f,
;		.attack_name="Song",
;		.weakness=MAGIC_MALAISE,
;		.resist=MAGIC_BOLT|MAGIC_HEAL,
;		.sprite=wood_elf,
;	},
;	[4]= {
;		.name="Giant Bee",
;		.hp_base=10,
;		.hp_mask=0x1f,
;		.attack_name="Buzzsaw",
;		.weakness=MAGIC_ICE,
;		.resist=MAGIC_NONE,
;		.sprite=giant_bee,
;	},
;	[5]= {
;		.name="Procrastinon",
;		.hp_base=10,
;		.hp_mask=0x1f,
;		.attack_name="Putoff",
;		.weakness=MAGIC_NONE,
;		.resist=MAGIC_MALAISE,
;		.sprite=procrastinon,
;	},
;	[6]= {
;		.name="Ice Fish",
;		.hp_base=10,
;		.hp_mask=0x1f,
;		.attack_name="Auger",
;		.weakness=MAGIC_FIRE,
;		.resist=MAGIC_ICE,
;		.sprite=ice_fish,
;	},
;	[7]= {
;		.name="Evil Penguin",
;		.hp_base=10,
;		.hp_mask=0x1f,
;		.attack_name="Waddle",
;		.weakness=MAGIC_FIRE,
;		.resist=MAGIC_ICE,
;		.sprite=evil_penguin,
;	},
;	[8]= {
;		.name="Act.Principl",
;		.hp_base=10,
;		.hp_mask=0x1f,
;		.attack_name="BIRDIE",
;		.weakness=MAGIC_NONE,
;		.resist=MAGIC_ICE|MAGIC_FIRE,
;		.sprite=roboknee1,
;	},
;};


	;===========================
	; gr put num
	;===========================
	; damage in DAMAGE_VAL (BCD)
	; location in XPOS,YPOS

gr_put_num:


;	digit=number/100;
;	if ((digit) && (digit<10)) {
;		grsim_put_sprite(numbers[digit],xt,yy);
;		xt+=4;
;	}
;	hundreds=digit;
;	left=number%100;

gr_put_num_tens:
	; print tens digit
	lda	DAMAGE_VAL
	lsr
	lsr
	lsr
	lsr

	; leading zero suppression
	beq	gr_put_num_ones

	asl
	tay
	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	jsr	put_sprite_crop

	; point to next
	lda	XPOS
	clc
	adc	#4
	sta	XPOS

gr_put_num_ones:

	; print tens digit
	lda	DAMAGE_VAL
	and	#$f

	asl
	tay
	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	jsr	put_sprite_crop

	rts

;
;                       ATTACK    SKIP
;                      MAGIC     LIMIT
;		       SUMMON    ESCAPE
;
;		SUMMONS -> METROCAT VORTEXCN
;		MAGIC   ->  HEAL    FIRE
;                           ICE     MALAISE
;			    BOLT
;		LIMIT	->  SLICE   ZAP
;                           DROP
;
;	State Machine
;
;		time
;	BOTTOM -------> MAIN_MENU ----->ATTACK
;				------->SKIP
;				------->MAGIC_MENU
;				------->LIMIT_MENU
;				------->SUMMON_MENU
;				------->ESCAPE
;
;

; static int enemy_attacking=0;





	;=========================
	; damage enemy
	;=========================
	; amount to damage in DAMAGE_VAL
damage_enemy:
	lda	DAMAGE_VAL
	cmp	ENEMY_HP
	bcs	damage_enemy_too_much		; bge

	; enemy hp is BCD
	sed

	sec
	lda	ENEMY_HP
	sbc	DAMAGE_VAL

	cld

	jmp	damage_enemy_update

damage_enemy_too_much:
	lda	#0

damage_enemy_update:
	sta	ENEMY_HP

	rts

	;===================
	; heal self
	;===================
	; heal amount in DAMAGE_VAL (yes, I know)

heal_self:
	clc
	lda	HERO_HP
	adc	DAMAGE_VAL

	; check if HP went down, if so we wrapped

	cmp	HERO_HP
	bcc	heal_self_max	; blt
	bcs	heal_self_update

heal_self_max:
	lda	HERO_HP_MAX

heal_self_update:
	sta	HERO_HP

	rts

	;========================
	; damage TFV
	;========================
	; value in DAMAGE_VAL
damage_tfv:
	lda	DAMAGE_VAL
	cmp	HERO_HP
	bcs	damage_hero_too_much		; bge

	sec
	lda	HERO_HP
	sbc	DAMAGE_VAL
	jmp	damage_hero_update

damage_hero_too_much:
	lda	#0

damage_hero_update:
	sta	HERO_HP

	rts


	;=========================
	; attack
	;=========================
attack:
	lda	#34
	sta	HERO_X

	lda	#$10
	sta	DAMAGE_VAL

attack_loop:

	; copy over background

	jsr	gr_copy_to_current

	; draw hero

	lda	#20
	sta	YPOS

	lda	HERO_X
	sta	XPOS

	lsr
	bcc	attack_draw_walk

attack_draw_stand:
	lda	#<tfv_stand_left_sprite
	sta	INL
	lda	#>tfv_stand_left_sprite
	jmp	attack_actually_draw

attack_draw_walk:
	lda	#<tfv_walk_left_sprite
	sta	INL
	lda	#>tfv_walk_left_sprite

attack_actually_draw:
	sta	INH
	jsr	put_sprite_crop

	;=========================
	; draw sword

	lda	HERO_X
	sec
	sbc	#5
	sta	XPOS
	; ypos already 20?

	lda	#<tfv_led_sword_sprite
	sta	INL
	lda	#>tfv_led_sword_sprite
	sta	INH

	jsr	put_sprite_crop


	;=========================
	; draw enemy

	lda	ENEMY_X
	sta	XPOS
	; ypos already 20?

	jsr	draw_enemy

	;===========================
	; draw battle bottom

	jsr	draw_battle_bottom

	;===========================
	; page flip

	jsr	page_flip

	dec	HERO_X
	lda	HERO_X
	cmp	#10			; repeat until 10
	bne	attack_loop

	;======================
	; attack done

	;===================
	; damage the enemy

	jsr	damage_enemy

	; display damage

	lda	#2
	sta	XPOS
	lda	#10
	sta	YPOS
	jsr	gr_put_num

	;===================
	; page flip

	jsr	page_flip

	; delay
	lda	#255
	jsr	WAIT

	; restore X value
	lda	#34
	sta	HERO_X

	rts


	;===============================
	; enemy attack
	;===============================
enemy_attack:

;	int ax=enemy_x;
;	int damage=10;

;	enemy_attacking=1;

;	while(ax<30) {

		; put attack name on
		; occasionally attack with that enemy's power?
		; occasionally heal self?

;		gr_copy_to_current(0xc00);

		; draw first so behind enemy
;		grsim_put_sprite(tfv_stand_left,tfv_x,20);
;		grsim_put_sprite(tfv_led_sword,tfv_x-5,20);

;		if (ax&1) {
;			grsim_put_sprite(enemies[enemy_type].sprite,ax,20);
;		}
;		else {
;			grsim_put_sprite(enemies[enemy_type].sprite,ax,20);
;		}

;		draw_battle_bottom(enemy_type);

;		page_flip();

;		ax+=1;

;		usleep(20000);
;	}
;	enemy_attacking=0;

;	damage_tfv(damage);
;	gr_put_num(25,10,damage);
;	draw_battle_bottom(enemy_type);

;	page_flip();
;	usleep(250000);

;	return damage;
;}

	rts


victory_string:
	.byte 13,21,"EXPERIENCE +2",0
	.byte 16,22,"MONEY +1",0


	;====================================
	; victory dance
	;====================================

victory_dance:

	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y

	; update XP and money

	inc	HERO_XP
	inc	HERO_XP

	inc	HERO_MONEY


	ldx	#25
	stx	ANIMATE_LOOP
victory_dance_loop:

	jsr	gr_copy_to_current

	jsr	clear_bottom

	lda	#<victory_string
	sta	OUTL
	lda	#>victory_string
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print

	txa
	and	#1
	beq	victory_wave

victory_stand:

	jsr	draw_hero_and_sword
	jmp	victory_draw_done

victory_wave:

	jsr	draw_hero_victory

victory_draw_done:

	jsr	page_flip


	; delay
	lda	#255
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	victory_dance_loop

	rts

	;===========================
	; magic attack
	;===========================

magic_attack:

	lda	#34
	sta	HERO_X

	lda	#$15
	sta	DAMAGE_VAL

	lda	MENU_POSITION
	cmp	#MENU_MAGIC_HEAL
	beq	do_magic_heal
	cmp	#MENU_MAGIC_FIRE
	beq	do_magic_fire
	cmp	#MENU_MAGIC_ICE
	beq	do_magic_ice
	cmp	#MENU_MAGIC_BOLT
	beq	do_magic_bolt
	cmp	#MENU_MAGIC_MALAISE
	beq	do_magic_malaise

do_magic_heal:	; MENU_MAGIC_HEAL
	lda	#33
	sta	MAGIC_X
	lda	#20
	sta	MAGIC_Y

	jmp	done_magic_setup

do_magic_fire:		; MENU_MAGIC_FIRE
	lda	#2
	sta	MAGIC_X
	lda	#20
	sta	MAGIC_Y

	jmp	done_magic_setup

do_magic_ice:		; MENU_MAGIC_ICE
	lda	#2
	sta	MAGIC_X
	lda	#20
	sta	MAGIC_Y

	jmp	done_magic_setup

do_magic_bolt:		; MENU_MAGIC_BOLT
	lda	#2
	sta	MAGIC_X
	lda	#20
	sta	MAGIC_Y

	jmp	done_magic_setup

do_magic_malaise:	; MENU_MAGIC_MALAISE
	lda	#2
	sta	MAGIC_X
	lda	#20
	sta	MAGIC_Y

	jmp	done_magic_setup

done_magic_setup:



	;=========================================
	; cast the magic
	; FIXME: damage based on weakness of enemy
	; FIXME: disallow if not enough MP

cast_the_magic:

	lda	MENU_POSITION
	sta	MAGIC_TYPE

	lda	#10
	sta	ANIMATE_LOOP

cast_magic_loop:
	jsr	gr_copy_to_current

	; sprite with hands up

	lda	HERO_X
	sta	XPOS
	lda	#20
	sta	YPOS

	lda	#<tfv_victory_sprite
	sta	INL
	lda	#>tfv_victory_sprite
	sta	INH

	jsr	put_sprite_crop

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy


	jsr	draw_battle_bottom

	jsr	page_flip

	; delay a bit
	lda	#50
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	cast_magic_loop


	;========================
	; Actually do the magic

	lda	#20
	sta	ANIMATE_LOOP
magic_happens_loop:

	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw hero
	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y
	jsr	draw_hero_and_sword

	lda	ANIMATE_LOOP
	and	#$1
	clc
	adc	MAGIC_X
	sta	XPOS

	lda	MAGIC_Y
	sta	YPOS

	lda	MAGIC_TYPE
	asl
	tay
	lda	magic_sprites,Y
	sta	INL
	lda	magic_sprites+1,Y
	sta	INH

	jsr	put_sprite_crop

	jsr	draw_battle_bottom

	jsr	page_flip

	; delay a bit
	lda	#50
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	magic_happens_loop


	;=============================


	; decrease magic points
	; mp-=5;

	jsr	gr_copy_to_current


	; draw hero
	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y
	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	lda	MAGIC_TYPE
	cmp	#MENU_MAGIC_HEAL
	beq	was_heal_magic

	jsr	damage_enemy
	lda	#2
	sta	XPOS
	lda	#10
	sta	YPOS
	jsr	gr_put_num
	jmp	done_magic_damage

was_heal_magic:
	jsr	heal_self
done_magic_damage:

	jsr	draw_battle_bottom

	jsr	page_flip

	; wait 2s
	ldx	#200
	jsr	long_wait

	rts


	;======================
	;======================
	; Limit Break "Drop"
	; Jump into sky, drop down and slice enemy in half
	;======================
	;======================

limit_break_drop:

	lda	#$99
	sta	DAMAGE_VAL

	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y

drop_jump_loop:

	; while(ay>0) {

	jsr	gr_copy_to_current

	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#75
	jsr	WAIT

	; must be even
	dec	HERO_Y
	dec	HERO_Y

	lda	HERO_Y
	cmp	#$f6
	bne	drop_jump_loop


	lda	#10
	sta	HERO_X

	;===============
	; Falling

drop_falling_loop:
;	while(ay<=20) {

	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	; draw line
	; only if HERO_Y>0
	lda	#$dd	; yellow
	sta	COLOR

	ldx	HERO_Y
	bmi	done_drop_vlin
	stx	V2
	ldx	#0

	lda	HERO_X
	sec
	sbc	#5
	tay

	jsr	vlin	; X,V2 at Y vlin(0,ay,ax-5);

done_drop_vlin:

	jsr	page_flip

	lda	#100
	jsr	WAIT

	inc	HERO_Y
	inc	HERO_Y
	lda	HERO_Y
	cmp	#20
	bne	drop_falling_loop


	lda	#0
	sta	ANIMATE_LOOP

more_drop_loop:

	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	; draw cut line
	lda	#$CC
	sta	COLOR

	lda	HERO_Y
	clc
	adc	ANIMATE_LOOP
	sta	V2

	ldx	HERO_Y

	lda	HERO_X
	sec
	sbc	#5
	tay

	jsr	vlin	; x,v2 at Y vlin(ay,ay+i,ax-5);

	jsr	page_flip

	lda	#75
	jsr	WAIT

	inc	ANIMATE_LOOP
	lda	ANIMATE_LOOP
	cmp	#13
	bne	more_drop_loop


	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw hero

	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	; slice
	; FIXME: should this be ground color?

	lda	#$cc	; lightgreen
	sta	COLOR

	ldx	#33
	stx	V2
	ldx	#20
	lda	#5
	tay

	jsr	vlin	; x,v2 at Y

	jsr	damage_enemy

	lda	#2
	sta	XPOS
	lda	#10
	sta	YPOS
	jsr	gr_put_num

	jsr	page_flip

	; wait 2s
	ldx	#200
	jsr	long_wait

	rts

	;=========================
	;=========================
	; Limit Break "Slice"
	; Run up and slap a bunch with sword
	; TODO: cause damage value to bounce around more?
	; TODO: run up to slice, not slide in
	;=========================
	;=========================

limit_break_slice:

	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y

	lda	#5
	sta	DAMAGE_VAL

slice_run_loop:

	jsr	gr_copy_to_current

	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#50
	jsr	WAIT

	dec	HERO_X
	lda	HERO_X
	cmp	#10
	bcs	slice_run_loop		; bge

	;==================
	; Slicing

	lda	#20
	sta	ANIMATE_LOOP
slicing_loop:

	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	lda	ANIMATE_LOOP
	and	#1
	bne	slice_raised

slice_down:
	jsr	draw_hero_and_sword

	jmp	done_slice_down

slice_raised:

	jsr	draw_hero_victory

done_slice_down:

	jsr	damage_enemy

	; gr_put_num(2+(i%2),10+((i%2)*2),damage);
	lda	ANIMATE_LOOP
	and	#$1
	clc
	adc	#2
	sta	XPOS

	lda	ANIMATE_LOOP
	and	#$1
	asl
	clc
	adc	#10
	sta	YPOS

	jsr	gr_put_num

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#150
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	slicing_loop



	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y

	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw hero

	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	jsr	page_flip

	; wait 2s
	ldx	#20
	jsr	long_wait

	rts

	;=========================
	;========================
	; Limit Break "Zap"
	; Zap with a laser out of the LED sword */
	;=========================
	;=========================

limit_break_zap:


	lda	#34
	sta	HERO_X
	lda	#20
	sta	HERO_Y

	lda	#$55
	sta	DAMAGE_VAL

	jsr	gr_copy_to_current

	; Draw crossed line

;	color_equals(COLOR_AQUA);
	lda	#$ee
	sta	COLOR

;	vlin(12,24,34);

	ldx	#12
	lda	#24
	sta	V2
	ldy	#34

	jsr	vlin	; X, V2 at Y

;	hlin_double(ram[DRAW_PAGE],28,38,18);

	lda	#38
	sta	V2
	lda	#18
	ldy	#28
	jsr	hlin_double	; Y, V2 AT A

	; Sword in air
	jsr	draw_hero_victory

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	jsr	draw_battle_bottom

	jsr	page_flip

	; pause 0.5s
	ldx	#50
	jsr	long_wait



	lda	#32
	sta	ANIMATE_LOOP

zap_loop:
	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; rotate color
;	color_equals(i%16);
;	hlin_double(ram[DRAW_PAGE],5,30,22);

	lda	ANIMATE_LOOP
	jsr	SETCOL		; set color masked * 17

	lda	#30
	sta	V2
	lda	#22
	ldy	#5
	jsr	hlin_double	; Y, V2 AT A

	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#75
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	zap_loop



	jsr	gr_copy_to_current

	; grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);
	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy


	; draw hero

	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	jsr	damage_enemy

	lda	#2
	sta	XPOS
	lda	#10
	sta	YPOS
	jsr	gr_put_num

	jsr	page_flip

	; wait 2s
	ldx	#200
	jsr	long_wait

	rts

	;==========================
	; limit break
	;==========================
limit_break:

	; reset limit counter
	lda	#0
	sta	HERO_LIMIT

	; TODO: replace with jump table?

	lda	MENU_POSITION
	cmp	#MENU_LIMIT_DROP
	beq	do_limit_drop
	cmp	#MENU_LIMIT_SLICE
	beq	do_limit_slice
	cmp	#MENU_LIMIT_ZAP
	beq	do_limit_zap

do_limit_drop:
	jmp	limit_break_drop
do_limit_slice:
	jmp	limit_break_slice
do_limit_zap:
	jmp	limit_break_zap




	;========================
	; summon metrocat
	;========================
summon_metrocat:

	lda	#$17
	sta	DAMAGE_VAL

	lda	#28
	sta	MAGIC_X
	lda	#2
	sta	MAGIC_Y

	;===========================
	; draw looming metrocat head

	lda	#30
	sta	ANIMATE_LOOP
looming_metrocat_loop:

	jsr	gr_copy_to_current

	; draw hero
	lda	#34
	sta	HERO_X
	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw metrocat's head

	lda	MAGIC_X
	sta	XPOS
	lda	MAGIC_Y
	sta	YPOS

	lda	#<metrocat_sprite
	sta	INL
	lda	#>metrocat_sprite
	sta	INH

	jsr	put_sprite_crop

	; draw battle bottom

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#75
	jsr	WAIT			; delay a bit

	dec	ANIMATE_LOOP
	bne	looming_metrocat_loop

move_metrocat_loop:

	jsr	gr_copy_to_current

	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw metrocat's head

	lda	MAGIC_X
	sta	XPOS
	lda	MAGIC_Y
	sta	YPOS

	lda	#<metrocat_sprite
	sta	INL
	lda	#>metrocat_sprite
	sta	INH

	jsr	put_sprite_crop

	; draw battle bottom

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#50	; delay
	jsr	WAIT

	dec	MAGIC_X
	lda	MAGIC_X

	cmp	#15
	bcs	metrocat_no_move_y

	; have to keep even

	and	#1
	bne	metrocat_no_move_y

	inc	MAGIC_Y
	inc	MAGIC_Y

metrocat_no_move_y:
	lda	MAGIC_X
	cmp	#5			; move until X=5
	bcs	move_metrocat_loop


	lda	#30
	sta	ANIMATE_LOOP

metrocat_damage_loop:
	jsr	gr_copy_to_current

	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw metrocat's head

	lda	MAGIC_X
	sta	XPOS
	lda	MAGIC_Y
	sta	YPOS

	lda	#<metrocat_sprite
	sta	INL
	lda	#>metrocat_sprite
	sta	INH

	jsr	put_sprite_crop

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#50
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	metrocat_damage_loop

	jsr	gr_copy_to_current

	; draw enemy

	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw hero

	jsr	draw_hero_and_sword

	; draw bottom

	jsr	draw_battle_bottom

	jsr	damage_enemy

	lda	#2
	sta	XPOS
	lda	#10
	sta	YPOS

	jsr	gr_put_num

	jsr	page_flip

	; long wait (2s?)
	ldx	#200
	jsr	long_wait

	rts



	;=========================
	; Vortex Cannon
	;=========================

summon_vortex_cannon:

	lda	#5
	sta	DAMAGE_VAL

	lda	#20
	sta	MAGIC_X
	sta	MAGIC_Y


	; draw the cannon

	lda	#30
	sta	ANIMATE_LOOP

vortex_setup_loop:
	jsr	gr_copy_to_current


	; draw hero
	lda	#34
	sta	HERO_X
	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; grsim_put_sprite(vortex_cannon,ax,ay);

	; draw vortex_cannon

	lda	#20
	sta	XPOS
	lda	#20
	sta	YPOS

	lda	#<vortex_cannon_sprite
	sta	INL
	lda	#>vortex_cannon_sprite
	sta	INH

	jsr	put_sprite_crop

	; draw bottom

	jsr	draw_battle_bottom

	jsr	page_flip

	lda	#50
	jsr	WAIT

	dec	ANIMATE_LOOP
	bne	vortex_setup_loop


	; Fire vortices


	lda	#5
	sta	ANIMATE_LOOP

vortex_cannon_fire_loop:

	lda	#20
	sta	MAGIC_X

vortex_cannon_move_loop:

	jsr	gr_copy_to_current

	; draw hero
	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw vortex_cannon

	lda	#20
	sta	XPOS
	lda	#20
	sta	YPOS

	lda	#<vortex_cannon_sprite
	sta	INL
	lda	#>vortex_cannon_sprite
	sta	INH

	jsr	put_sprite_crop

	; draw vortex

	lda	MAGIC_X
	sta	XPOS
	lda	#24
	sta	YPOS

	lda	#<vortex_sprite
	sta	INL
	lda	#>vortex_sprite
	sta	INH

	jsr	put_sprite_crop

	jsr	draw_battle_bottom


	; print damage if < 10
	lda	MAGIC_X
	cmp	#10
	bcs	vortex_no_print_damage

	lda	#2
	sta	XPOS
	lda	#10
	sta	YPOS

	jsr	gr_put_num

vortex_no_print_damage:

	jsr	page_flip

	lda	#100
	jsr	WAIT

	dec	MAGIC_X

	lda	MAGIC_X
	cmp	#5
	bcs	vortex_cannon_move_loop

	; damage enemy
	jsr	damage_enemy

	dec	ANIMATE_LOOP
	bne	vortex_cannon_fire_loop


	; end of summon


	jsr	gr_copy_to_current

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; draw hero
	jsr	draw_hero_and_sword

	jsr	draw_battle_bottom

	jsr	page_flip

	; wait 2s
	ldx	#200
	jsr	long_wait

	rts

	;=========================
	; summon
	;=========================
summon:
	lda	MENU_POSITION
	beq	do_summon_metrocat
	bne	do_summon_vortex_cannon

do_summon_metrocat:
	jmp	summon_metrocat
do_summon_vortex_cannon:
	jmp	summon_vortex_cannon

	rts


	;=============================
	; done attack
	;=============================

done_attack:
	lda	#0
	sta	BATTLE_COUNT

	lda	#MENU_NONE
	sta	MENU_STATE

	rts



	;================================
	; draw enemy
	; relies on self-modifying code
	; position in XPOS,YPOS

draw_enemy:

draw_enemy_smc1:
	lda	#$a5
	sta	INL
draw_enemy_smc2:
	lda	#$a5

battle_actual_draw_enemy:
	sta	INH
	jmp	put_sprite_crop		; tail call



	;============================
	; draw hero victory
	;============================
	; draws at HERO_X,HERO_Y

draw_hero_victory:
	lda	HERO_X
	sta	XPOS
	lda	HERO_Y
	sta	YPOS

	lda	#<tfv_victory_sprite
	sta	INL
	lda	#>tfv_victory_sprite
	sta	INH
	jsr	put_sprite_crop

	lda	HERO_X
	sec
	sbc	#2
	sta	XPOS
	lda	#14
	sta	YPOS

	lda	#<tfv_led_sword_sprite
	sta	INL
	lda	#>tfv_led_sword_sprite
	sta	INH
	jsr	put_sprite_crop

	rts


	;============================
	; draw hero and sword
	;============================
	; draws at HERO_X,HERO_Y

draw_hero_and_sword:

	lda	HERO_X
	sta	XPOS
	lda	HERO_Y
	sta	YPOS

	lda	#<tfv_stand_left_sprite
	sta	INL
	lda	#>tfv_stand_left_sprite
	sta	INH

	jsr	put_sprite_crop

	; grsim_put_sprite(tfv_led_sword,ax-5,20);
	lda	HERO_X
	sec
	sbc	#5
	sta	XPOS
	lda	HERO_Y
	sta	YPOS

	lda	#<tfv_led_sword_sprite
	sta	INL
	lda	#>tfv_led_sword_sprite
	sta	INH
	jsr	put_sprite_crop

	rts


	;=====================
	;=====================
	; long(er) wait
	; waits approximately 10ms * X
	;=====================
	;=====================
long_wait:
	lda	#64
	jsr	WAIT		; delay 1/2(26+27A+5A^2) us, 11,117
	dex
	bne	long_wait
	rts



	;====================
	;====================
	; Boss Battle
	;====================
	;====================

boss_battle:

;	int i,ch;

;	int saved_drawpage;

;	int ax=34;
;	int enemy_count=30;
;	int old;


;	susie_out=1;

;	rotate_intro();

;	battle_count=20;

;	enemy_type=8;

;	enemy_hp=255;

;	saved_drawpage=ram[DRAW_PAGE];

;	ram[DRAW_PAGE]=PAGE2;

	;=====================
	; Draw background

	; Draw sky */
;	color_equals(COLOR_BLACK);
;	for(i=0;i<20;i++) {
;		hlin_double(ram[DRAW_PAGE],0,39,i);
;	}

;	color_equals(COLOR_ORANGE);
;	for(i=20;i<39;i++) {
;		hlin_double(ram[DRAW_PAGE],0,39,i);
;	}

	; Draw horizon */
;	color_equals(COLOR_GREY);
;	hlin_double(ram[DRAW_PAGE],0,39,10);

;	ram[DRAW_PAGE]=saved_drawpage;

;	draw_battle_bottom(enemy_type);

;	while(1) {

;		gr_copy_to_current(0xc00);
;
;		if (hp==0) {
;			grsim_put_sprite(tfv_defeat,ax-2,24);
;		}
;		else if (running) {
;			if (battle_count%2) {
;				grsim_put_sprite(tfv_stand_right,ax,20);
;			}
;			else {
;				grsim_put_sprite(tfv_walk_right,ax,20);
;			}
;		}
;		else {
;			grsim_put_sprite(tfv_stand_left,ax,20);
;			grsim_put_sprite(tfv_led_sword,ax-5,20);
;		}
;
;		grsim_put_sprite(susie_left,28,30);
;
;		if ((enemy_count&0xf)<4) {
;			grsim_put_sprite(roboknee1,enemy_x,16);
;		}
;		else {
;			grsim_put_sprite(roboknee2,enemy_x,16);
;		}
;
;		draw_battle_bottom(enemy_type);
;
;		page_flip();
;
;		if (hp==0) {
;			for(i=0;i<15;i++) usleep(100000);
;			break;
;		}
;
;		usleep(100000);
;
;		ch=grsim_input();
;		if (ch=='q') return 0;
;
;		if (enemy_count==0) {
;			; attack and decrement HP
;			enemy_attack(ax);
;			; update limit count
;			if (limit<4) limit++;
;
;			; reset enemy time. FIXME: variable?
;			enemy_count=50;
;		}
;		else {
;			enemy_count--;
;		}
;
;		if (battle_count>=64) {
;
;			; TODO: randomly fail at running? */
;			if (running) {
;				break;
;			}
;
;			if (menu_state==MENU_NONE) menu_state=MENU_MAIN;
;			menu_keypress(ch);
;
;		} else {
;			battle_count++;
;		}
;
;		old=battle_bar;
;		battle_bar=(battle_count/16);
;		if (battle_bar!=old) draw_battle_bottom(enemy_type);
;
;
;		if (enemy_hp==0) {
;			; FIXME?
;			victory_dance();
;			break;
;		}
;
;
;	}
;
;	ram[DRAW_PAGE]=PAGE0;
;	clear_bottom();
;	ram[DRAW_PAGE]=PAGE1;
;	clear_bottom();
;
;	running=0;
;
;	return 0;
;}


