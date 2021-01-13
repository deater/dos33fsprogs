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

	jmp	battle_actual_draw_hero

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
	jmp	battle_actual_draw_hero

battle_draw_running_walk:
	lda	#<tfv_walk_right_sprite
	sta	INL
	lda	#>tfv_walk_right_sprite
	jmp	battle_actual_draw_hero

battle_draw_normal_hero:
	; grsim_put_sprite(tfv_stand_left,ax,20);
	lda	HERO_X
	sta	XPOS
	lda	#20
	sta	YPOS

	lda	#<tfv_stand_left_sprite
	sta	INL
	lda	#>tfv_stand_left_sprite
	sta	INH

	jsr	put_sprite_crop

battle_draw_normal_sword:
	; grsim_put_sprite(tfv_led_sword,ax-5,20);
	lda	HERO_X
	sec
	sbc	#5
	sta	XPOS
	lda	#20
	sta	YPOS

	lda	#<tfv_led_sword_sprite
	sta	INL
	lda	#>tfv_led_sword_sprite

battle_actual_draw_hero:
	sta	INH
	jsr	put_sprite_crop



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

draw_enemy_smc1:
	lda	#$a5
	sta	INL
draw_enemy_smc2:
	lda	#$a5

battle_actual_draw_enemy:
	sta	INH
	jsr	put_sprite_crop

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

.if 0


; Do Battle */


; Metrocat (summon?) */

; Environment: grass, beach, forest, ice */

; Enemies:          HP		ATTACK          WEAKNESS	RESIST */
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

static int battle_bar=0;
static int susie_out=0;

; Background depend on map location? */
; Room for guinea pig in party? */

; Attacks -> HIT, ZAP, HEAL, RUNAWAY */
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
.endif

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

	lda	#200
	sta	ENEMY_HP

	lda	#30
	sta	ENEMY_COUNT

	lda	#<killer_crab_sprite
	sta	draw_enemy_smc1+1
	lda	#>killer_crab_sprite
	sta	draw_enemy_smc2+1

	rts

.if 0

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

#define MENU_NONE	0
#define MENU_MAIN	1
#define MENU_MAGIC	2
#define MENU_SUMMON	3
#define MENU_LIMIT	4

static int enemy_attacking=0;
static int menu_state=MENU_NONE;
static int menu_position=0;
static int battle_count=0;


.endif

battle_enemy_string:
.byte 0,21,"KILLER CRAB",0
battle_enemy_attack_string:
.byte 1,23,"PINCHING",0

battle_name_string:
.byte 14,21,"DEATER",0


battle_menu_none:
	.byte 24,20,"HP",0
	.byte 27,20,"MP",0
	.byte 30,20,"TIME",0
	.byte 35,20,"LIMIT",0
hp_string:
	.byte 23,21,"100",0
mp_string:
	.byte 26,21," 50",0


battle_menu_main:
	.byte 23,20,"ATTACK",0
	.byte 23,21,"MAGIC",0
	.byte 23,22,"SUMMON",0
	.byte 31,20,"SKIP",0
	.byte 31,21,"ESCAPE",0
	.byte 31,22,"LIMIT",0

battle_menu_summons:
	.byte 23,20,"SUMMONS:",0
	.byte 24,21,"METROCAT",0	; 0
	.byte 24,22,"VORTEXCN",0	; 1

battle_menu_magic:
	.byte 23,20,"MAGIC:",0
	.byte 24,21,"HEAL",0		; 0
	.byte 24,22,"ICE",0		; 2
	.byte 24,23,"BOLT",0		; 4
	.byte 31,21,"FIRE",0		; 1
	.byte 31,22,"MALAISE",0		; 3

battle_menu_limit:
	.byte 23,20,"LIMIT BREAKS:",0
	.byte 24,21,"SLICE",0		; 0
	.byte 24,22,"DROP",0		; 2
	.byte 31,21,"ZAP",0		; 1

	;========================
	; draw_battle_bottom
	;========================

; static int draw_battle_bottom(int enemy_type) {
draw_battle_bottom:

	jsr	clear_bottom

	jsr	normal_text

	; print(enemies[enemy_type].name);
	lda	#<battle_enemy_string
	sta	OUTL
	lda	#>battle_enemy_string
	sta	OUTH
	jsr	move_and_print


;	if (enemy_attacking) {
;		print_inverse(enemies[enemy_type].attack_name);
;	}

	; print name string
	lda	#<battle_name_string
	sta	OUTL
	lda	#>battle_name_string
	sta	OUTH
	jsr	move_and_print

;	if (susie_out) {
;		vtab(23);
;		htab(15);
;		move_cursor();
;		print("SUSIE");
;	}


	; jump to current menu

	; set up jump table fakery
handle_special:
	ldy	MENU_STATE
	lda	battle_menu_jump_table_h,Y
	pha
	lda	battle_menu_jump_table_l,Y
	pha
	rts

battle_menu_jump_table_l:
	.byte	<(draw_battle_menu_none-1)
	.byte	<(draw_battle_menu_main-1)
	.byte	<(draw_battle_menu_magic-1)
	.byte	<(draw_battle_menu_summon-1)
	.byte	<(draw_battle_menu_limit-1)

battle_menu_jump_table_h:
	.byte	>(draw_battle_menu_none-1)
	.byte	>(draw_battle_menu_main-1)
	.byte	>(draw_battle_menu_magic-1)
	.byte	>(draw_battle_menu_summon-1)
	.byte	>(draw_battle_menu_limit-1)


draw_battle_menu_none:
	;======================
	; TFV Stats

	lda	#<battle_menu_none
	sta	OUTL
	lda	#>battle_menu_none
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	; make limit label flash if at limit break

	lda	HERO_LIMIT
	cmp	#4
	bcc	plain_limit
	jsr	flash_text
plain_limit:
	jsr	move_and_print
	jsr	normal_text

	jsr	move_and_print	; HP
	jsr	move_and_print	; MP

	; Draw Time bargraph
	; start at 30,42 go to battle_bar
	; Y in X, X in A, max in CH

	; hlin_double(ram[DRAW_PAGE],30,30+(battle_bar-1),42);

	lda	BATTLE_COUNT
	lsr
	lsr
	lsr
	lsr
	sta	CH

	ldx	#42
	lda	#30

	jsr	draw_bargraph


	; Draw Limit bargraph
	; start at 30,42 go to battle_bar
	; Y in X, X in A, max in CH
	; if (limit) hlin_double(ram[DRAW_PAGE],35,35+limit,42);

	lda	HERO_LIMIT
	sta	CH

	ldx	#42
	lda	#35

	jsr	draw_bargraph

;	; Susie Stats
;	if (susie_out) {
;	vtab(23);
;	htab(24);
;	move_cursor();
;	print_byte(255);
;
;	vtab(23);
;	htab(27);
;	move_cursor();
;	print_byte(0);
;
;	; Draw Time bargraph
;	ram[COLOR]=0xa0;
;	hlin_double(ram[DRAW_PAGE],30,34,42);
;	ram[COLOR]=0x20;
;	if (battle_bar) {
;		hlin_double(ram[DRAW_PAGE],30,30+(battle_bar-1),42);
;	}
;
;	; Draw Limit break bargraph
;	ram[COLOR]=0xa0;
;	hlin_double(ram[DRAW_PAGE],35,39,42);
;
;	ram[COLOR]=0x20;
;	if (limit) hlin_double(ram[DRAW_PAGE],35,35+limit,42);

	jmp	done_draw_battle_menu

	;======================
	; draw main battle menu
draw_battle_menu_main:

	; wrap location
	lda	HERO_LIMIT
	cmp	#3
	bcs	limit3_wrap	; bge
limit4_wrap:
	lda	MENU_POSITION
	cmp	#4
	bcc	done_menu_wrap
	lda	#4
	sta	MENU_POSITION
	bne	done_menu_wrap	; bra

limit3_wrap:
	lda	MENU_POSITION
	cmp	#5
	bcc	done_menu_wrap
	lda	#5
	sta	MENU_POSITION
	bne	done_menu_wrap	; bra

done_menu_wrap:

	lda	#<battle_menu_main
	sta	OUTL
	lda	#>battle_menu_main
	sta	OUTH

	ldx	MENU_POSITION

	cpx	#MENU_MAIN_ATTACK
	bne	print_menu_attack	; print ATTACK
	jsr	inverse_text
print_menu_attack:
	jsr	move_and_print
	jsr	normal_text


	cpx	#MENU_MAIN_MAGIC
	bne	print_menu_magic	; print MAGIC
	jsr	inverse_text
print_menu_magic:
	jsr	move_and_print
	jsr	normal_text


	cpx	#MENU_MAIN_SUMMON
	bne	print_menu_summon	; print SUMMON
	jsr	inverse_text
print_menu_summon:
	jsr	move_and_print
	jsr	normal_text


	cpx	#MENU_MAIN_SKIP
	bne	print_menu_skip		; print SKIP
	jsr	inverse_text
print_menu_skip:
	jsr	move_and_print
	jsr	normal_text


	cpx	#MENU_MAIN_ESCAPE
	bne	print_menu_escape	; print ESCAPE
	jsr	inverse_text
print_menu_escape:
	jsr	move_and_print
	jsr	normal_text


	lda	HERO_LIMIT
	cmp	#4
	bcc	done_battle_draw_menu_main	 ; only draw if limit >=4

	cpx	#MENU_MAIN_LIMIT
	bne	print_menu_limit	; print LIMIT
	jsr	inverse_text
print_menu_limit:
	jsr	move_and_print
	jsr	normal_text


done_battle_draw_menu_main:
	jmp	done_draw_battle_menu

	;=========================
	; menu summon
draw_battle_menu_summon:

	lda	#<battle_menu_summons
	sta	OUTL
	lda	#>battle_menu_summons
	sta	OUTH

	; make sure it is 1 or 0
	ldx	MENU_POSITION
	cpx	#2
	bcc	wrap_menu_summon	; blt
	ldx	#1
	stx	MENU_POSITION
wrap_menu_summon:

	jsr	move_and_print		; print SUMMONS:

	cpx	#MENU_SUMMON_METROCAT
	bne	print_menu_metrocat	; print METROCAT
	jsr	inverse_text
print_menu_metrocat:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_SUMMON_VORTEX
	bne	print_menu_vortex	; print VORTEXCN
	jsr	inverse_text
print_menu_vortex:
	jsr	move_and_print
	jsr	normal_text

	jmp	done_draw_battle_menu

	;=======================
	; menu magic
draw_battle_menu_magic:

	lda	#<battle_menu_magic
	sta	OUTL
	lda	#>battle_menu_magic
	sta	OUTH


	; make sure it is less than 5
	ldx	MENU_POSITION
	cpx	#5
	bcc	wrap_menu_magic
	ldx	#4
	stx	MENU_POSITION
wrap_menu_magic:

	jsr	move_and_print		; print MAGIC:

	cpx	#MENU_MAGIC_HEAL
	bne	print_menu_heal		; print HEAL
	jsr	inverse_text
print_menu_heal:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_MAGIC_ICE
	bne	print_menu_ice		; print ICE
	jsr	inverse_text
print_menu_ice:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_MAGIC_BOLT
	bne	print_menu_bolt		; print BOLT
	jsr	inverse_text
print_menu_bolt:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_MAGIC_FIRE
	bne	print_menu_fire		; print FIRE
	jsr	inverse_text
print_menu_fire:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_MAGIC_MALAISE
	bne	print_menu_malaise	; print MALAISE
	jsr	inverse_text
print_menu_malaise:
	jsr	move_and_print
	jsr	normal_text

	jmp	done_draw_battle_menu

	;===============================
	; menu limit

draw_battle_menu_limit:

	lda	#<battle_menu_limit
	sta	OUTL
	lda	#>battle_menu_limit
	sta	OUTH


	; make sure it is less than 3
	ldx	MENU_POSITION
	cpx	#3
	bcc	wrap_limit_magic
	ldx	#2
	stx	MENU_POSITION
wrap_limit_magic:

	jsr	move_and_print		; print LIMIT BREAKS:

	cpx	#MENU_LIMIT_SLICE
	bne	print_menu_slice	; print SLICE
	jsr	inverse_text
print_menu_slice:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_LIMIT_DROP
	bne	print_menu_drop		; print DROP
	jsr	inverse_text
print_menu_drop:
	jsr	move_and_print
	jsr	normal_text

	cpx	#MENU_LIMIT_ZAP
	bne	print_menu_zap		; print ZAP
	jsr	inverse_text
print_menu_zap:
	jsr	move_and_print
	jsr	normal_text



done_draw_battle_menu:

	;========================
	; Draw inverse separator

	lda	DRAW_PAGE
	bne	draw_separator_page1
draw_separator_page0:
	lda	#$20
	sta	$650+12
	sta	$6d0+12
	sta	$750+12
	sta	$7d0+12
	bne	done_draw_separator	; bra

draw_separator_page1:

	lda	#$20
	sta	$a50+12
	sta	$ad0+12
	sta	$b50+12
	sta	$bd0+12

done_draw_separator:

	rts


        ;===========================
        ; draw bargraph
        ;===========================
	; draw text-mode bargraph
	;
	; limit is 0..4
	; battle_bar is battle_count/16 = 0..4
	; at 30, 35 both line 42

	; Y in X
	; X in A
	; max in CH
draw_bargraph:
	clc
	adc	gr_offsets,X
	sta	GBASL
	lda	gr_offsets+1,X
	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	#0
draw_bargraph_loop:
        cpy	CH
        bcc	bar_on
        lda	#' '|$80	; '_' ?
        bne	done_bar
bar_on:
        lda	#' '
done_bar:
        sta	(GBASL),Y

        iny
        cpy	#5
        bne	draw_bargraph_loop

        rts



.if 0


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
.endif

	;=========================
	; attack
	;=========================
attack:
;	int ax=34;
;	int damage=10;

;	while(ax>10) {

;		gr_copy_to_current(0xc00);

;		if (ax&1) {
;			grsim_put_sprite(tfv_stand_left,ax,20);
;		}
;		else {
;			grsim_put_sprite(tfv_walk_left,ax,20);
;		}
;		grsim_put_sprite(tfv_led_sword,ax-5,20);
;
;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);
;
;		draw_battle_bottom(enemy_type);
;
;		page_flip();
;
;		ax-=1;
;
;		usleep(20000);
;	}
;
;	damage_enemy(damage);
;	gr_put_num(2,10,damage);
;	page_flip();
;	usleep(250000);

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


	;====================================
	; victory dance
	;====================================

victory_dance:

.if 0

	int ax=34;
	int i;
	int saved_drawpage;

	saved_drawpage=ram[DRAW_PAGE];

	ram[DRAW_PAGE]=PAGE2;	; 0xc00

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

.endif
	rts

	;===========================
	; magic attack
	;===========================

magic_attack:

.if 0

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


	; FIXME: damage based on weakness of enemy
	; FIXME: disallow if not enough MP

	; cast the magic */
	i=0;
	while(i<10) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_victory,34,20);

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		draw_battle_bottom(enemy_type);

		page_flip();

		i++;

		usleep(20000);
	}

	ax=34;
	ay=20;
	i=0;

	; Actually put the magic */

	while(i<=20) {

		gr_copy_to_current(0xc00);

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

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

;	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

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
.endif
	rts


.if 0
; Limit Break "Drop" */
; Jump into sky, drop down and slice enemy in half */

static void limit_break_drop(void) {

	int ax=34,ay=20;
	int damage=100;
	int i;

	while(ay>0) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_stand_left,ax,ay);
		grsim_put_sprite(tfv_led_sword,ax-5,ay);

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		draw_battle_bottom(enemy_type);

		page_flip();

		ay-=1;

		usleep(20000);
	}

	ax=10;
	ay=0;

	; Falling */

	while(ay<=20) {

		gr_copy_to_current(0xc00);

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

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

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

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

;	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

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


; Limit Break "Slice" */
; Run up and slap a bunch with sword */
; TODO: cause damage value to bounce around more? */

static void limit_break_slice(void) {

	int tx=34,ty=20;
	int damage=5;
	int i;

	while(tx>10) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_stand_left,tx,ty);
		grsim_put_sprite(tfv_led_sword,tx-5,ty);

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		draw_battle_bottom(enemy_type);

		page_flip();

		tx-=1;

		usleep(20000);
	}

	; Slicing */
	for(i=0;i<20;i++) {

		gr_copy_to_current(0xc00);

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		if (i&1) {
			grsim_put_sprite(tfv_stand_left,tx,20);
			grsim_put_sprite(tfv_led_sword,tx-5,20);
		}
		else {
			grsim_put_sprite(tfv_victory,tx,20);
			grsim_put_sprite(tfv_led_sword,tx-2,14);
		}

		damage_enemy(damage);
;		gr_put_num(2+(i%2),10+((i%2)*2),damage);

		draw_battle_bottom(enemy_type);

		page_flip();

		usleep(100000);
	}

	tx=34;
	ty=20;

	gr_copy_to_current(0xc00);

;	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

	grsim_put_sprite(tfv_stand_left,tx,ty);
	grsim_put_sprite(tfv_led_sword,tx-5,ty);

	draw_battle_bottom(enemy_type);

	page_flip();

	for(i=0;i<20;i++) {
		usleep(100000);
	}
}

; Limit Break "Zap" */
; Zap with a laser out of the LED sword */

static void limit_break_zap(void) {

	int tx=34,ty=20;
	int damage=100;
	int i;


	gr_copy_to_current(0xc00);

	; Draw background */
	color_equals(COLOR_AQUA);
	vlin(12,24,34);
	hlin_double(ram[DRAW_PAGE],28,38,18);

	; Sword in air */
	grsim_put_sprite(tfv_victory,tx,20);
	grsim_put_sprite(tfv_led_sword,tx-2,14);

;	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

	draw_battle_bottom(enemy_type);

	page_flip();

	usleep(500000);

	for(i=0;i<32;i++) {

		gr_copy_to_current(0xc00);

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		color_equals(i%16);
		hlin_double(ram[DRAW_PAGE],5,30,22);

		grsim_put_sprite(tfv_stand_left,tx,ty);
		grsim_put_sprite(tfv_led_sword,tx-5,ty);

		draw_battle_bottom(enemy_type);

		page_flip();

		usleep(100000);
	}

	gr_copy_to_current(0xc00);

;	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

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

.endif

	;==========================
	; limit break
	;==========================
limit_break:

.if 0
	if (which==MENU_LIMIT_DROP) limit_break_drop();
	else if (which==MENU_LIMIT_SLICE) limit_break_slice();
	else if (which==MENU_LIMIT_ZAP) limit_break_zap();
.endif

	; reset limit counter
	lda	#0
	sta	HERO_LIMIT
	rts

.if 0
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

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

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

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

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

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

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

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		grsim_put_sprite(metrocat,ax,ay);

		draw_battle_bottom(enemy_type);

		page_flip();

		i++;

		usleep(20000);
	}

	gr_copy_to_current(0xc00);

;	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

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

	; draw the cannon */

	i=0;
	while(i<30) {

		gr_copy_to_current(0xc00);

		grsim_put_sprite(tfv_stand_left,tx,ty);
		grsim_put_sprite(tfv_led_sword,tx-5,ty);

;		grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

		grsim_put_sprite(vortex_cannon,ax,ay);

		draw_battle_bottom(enemy_type);

		page_flip();

		i++;

		usleep(20000);
	}

	; Fire vortices */

	ax=20;
	for(i=0;i<5;i++) {
		while(ax>5) {

			gr_copy_to_current(0xc00);

			grsim_put_sprite(tfv_stand_left,tx,ty);
			grsim_put_sprite(tfv_led_sword,tx-5,ty);

;			grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

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

;	grsim_put_sprite(enemies[enemy_type].sprite,enemy_x,20);

	grsim_put_sprite(tfv_stand_left,tx,ty);
	grsim_put_sprite(tfv_led_sword,tx-5,ty);
	draw_battle_bottom(enemy_type);

	page_flip();

	for(i=0;i<20;i++) {
		usleep(100000);
	}

}
.endif

	;=========================
	; summon

summon:

;	if (which==0) summon_metrocat();
;	else summon_vortex_cannon();

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

	;=========================
	; battle menu keypress
	;=========================

battle_menu_keypress:

	lda	LAST_KEY
	cmp	#27
	beq	keypress_escape
	cmp	#'W'
	beq	keypress_up
	cmp	#'S'
	beq	keypress_down
	cmp	#'A'
	beq	keypress_left
	cmp	#'D'
	beq	keypress_right

	cmp	#' '
	beq	keypress_action
	cmp	#13
	beq	keypress_action

	rts

keypress_escape:
	lda	#MENU_MAIN
	sta	MENU_STATE
	lda	#0
	sta	MENU_POSITION
	rts

keypress_up:
	lda	MENU_STATE
	cmp	#MENU_SUMMON
	bne	up_the_rest
up_for_summons:
	lda	MENU_POSITION
	cmp	#1
	bcc	done_keypress_up	; blt
	bcs	up_dec_menu

up_the_rest:
	lda	MENU_POSITION
	cmp	#2
	bcc	done_keypress_up	; blt
	dec	MENU_POSITION
up_dec_menu:
	dec	MENU_POSITION
done_keypress_up:
	rts

keypress_down:
	inc	MENU_POSITION
	inc	MENU_POSITION
	rts

keypress_right:
	inc	MENU_POSITION
	rts

keypress_left:
	lda	MENU_POSITION
	beq	done_keypress_left
	dec	MENU_POSITION
done_keypress_left:
	rts

keypress_action:

	lda	MENU_STATE
	cmp	#MENU_MAIN
	beq	keypress_main_action
	cmp	#MENU_MAGIC
	beq	keypress_magic_action
	cmp	#MENU_LIMIT
	beq	keypress_limit_action
	cmp	#MENU_SUMMON
	beq	keypress_summon_action

keypress_main_action:
	lda	MENU_POSITION
	cmp	#MENU_MAIN_ATTACK
	beq	keypress_main_attack
	cmp	#MENU_MAIN_SKIP
	beq	keypress_main_skip
	cmp	#MENU_MAIN_MAGIC
	beq	keypress_main_magic
	cmp	#MENU_MAIN_LIMIT
	beq	keypress_main_limit
	cmp	#MENU_MAIN_SUMMON
	beq	keypress_main_summon
	cmp	#MENU_MAIN_ESCAPE
	beq	keypress_main_escape

keypress_main_attack:
	; attack and decrement HP
	jsr	attack
	jsr	done_attack
	rts

keypress_main_skip:
	jsr	done_attack
	rts

keypress_main_magic:
	lda	#MENU_MAGIC
	sta	MENU_STATE
	lda	#0
	sta	MENU_POSITION
	rts

keypress_main_limit:
	lda	#MENU_LIMIT
	sta	MENU_STATE
	lda	#0
	sta	MENU_POSITION
	rts

keypress_main_summon:
	lda	#MENU_SUMMON
	sta	MENU_STATE
	lda	#0
	sta	MENU_POSITION
	rts

keypress_main_escape:
	lda	#HERO_STATE_RUNNING
	ora	HERO_STATE
	sta	HERO_STATE

	jsr	done_attack
	rts

keypress_magic_action:
	jsr	magic_attack
	jsr	done_attack
	rts

keypress_limit_action:
	jsr	limit_break
	jsr	done_attack
	rts

keypress_summon_action:
	jsr	summon
	jsr	done_attack

	rts




.if 0
int boss_battle(void) {

	int i,ch;

	int saved_drawpage;

	int ax=34;
	int enemy_count=30;
	int old;


	susie_out=1;

	rotate_intro();

	battle_count=20;

	enemy_type=8;

	enemy_hp=255;

	saved_drawpage=ram[DRAW_PAGE];

	ram[DRAW_PAGE]=PAGE2;

	;******************/
	; Draw background */

	; Draw sky */
	color_equals(COLOR_BLACK);
	for(i=0;i<20;i++) {
		hlin_double(ram[DRAW_PAGE],0,39,i);
	}

	color_equals(COLOR_ORANGE);
	for(i=20;i<39;i++) {
		hlin_double(ram[DRAW_PAGE],0,39,i);
	}

	; Draw horizon */
;	color_equals(COLOR_GREY);
;	hlin_double(ram[DRAW_PAGE],0,39,10);

	ram[DRAW_PAGE]=saved_drawpage;

	draw_battle_bottom(enemy_type);

	while(1) {

		gr_copy_to_current(0xc00);

		if (hp==0) {
			grsim_put_sprite(tfv_defeat,ax-2,24);
		}
		else if (running) {
;			if (battle_count%2) {
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

		grsim_put_sprite(susie_left,28,30);

		if ((enemy_count&0xf)<4) {
			grsim_put_sprite(roboknee1,enemy_x,16);
		}
		else {
			grsim_put_sprite(roboknee2,enemy_x,16);
		}

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
			; attack and decrement HP
			enemy_attack(ax);
			; update limit count
			if (limit<4) limit++;

			; reset enemy time. FIXME: variable?
			enemy_count=50;
		}
		else {
			enemy_count--;
		}

		if (battle_count>=64) {

			; TODO: randomly fail at running? */
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
			; FIXME?
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

.endif
