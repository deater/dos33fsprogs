
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
	sta	ENEMY_DEAD

	; FIXME: lower

	lda	#$00		; BCD
	sta	ENEMY_HP_LO
	lda	#$03		; BCD
	sta	ENEMY_HP_HI

	lda	#$3		; max HP is 100
	sta	ENEMY_LEVEL

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


	;=========================
	; damage enemy
	;=========================
	; amount to damage in DAMAGE_VAL_LO/HI (BCD)
damage_enemy:

	; see if damage < enemy_hp, if so fine to subtract
	; if not, set enemy_hp to zero

	; 16 bit unsigned compare
	lda	DAMAGE_VAL_HI	; compare high bytes
	cmp	ENEMY_HP_HI
	bcc	damage_enemy_subtract	; if damage_hi<hp_hi then less
	bne	damage_enemy_too_much	; if damage_hi<>hp_hi then bigger
	lda	DAMAGE_VAL_LO		; compare low bytes
	cmp	ENEMY_HP_LO
	bcc	damage_enemy_subtract	; then damage_hi<hp_hi

damage_enemy_too_much:
	lda	#0
	sta	ENEMY_HP_HI
	sta	ENEMY_HP_LO
	jmp	damage_enemy_done

damage_enemy_subtract:

	sed
	sec
	lda	ENEMY_HP_LO
	sbc	DAMAGE_VAL_LO
	sta	ENEMY_HP_LO

	lda	ENEMY_HP_HI
	sbc	DAMAGE_VAL_HI
	sta	ENEMY_HP_HI
	cld

damage_enemy_done:

	rts




	;===============================
	; enemy attack
	;===============================
enemy_attack:

	lda	#$10
	sta	DAMAGE_VAL_LO
	lda	#$00
	sta	DAMAGE_VAL_HI

	lda	#1
	sta	ENEMY_ATTACKING


enemy_attack_loop:

	; put attack name onh
	; occasionally attack with that enemy's power?
	; occasionally heal self?

	;======================
	; copy over background

	jsr	gr_copy_to_current

	; draw hero first so behind enemy

	jsr	draw_hero_and_sword

	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; let you finish menu commands?

	lda     MENU_STATE
	cmp     #MENU_NONE
	beq     enemy_no_menu

	jsr	get_keypress
	sta	LAST_KEY
	jsr	battle_menu_keypress

enemy_no_menu:

	;============
	; draw bottom

	jsr	draw_battle_bottom



	;============
	; page flip

	jsr	page_flip

	;============
	; delay a bit

	lda	#50
	jsr	WAIT

	inc	ENEMY_X
	lda	ENEMY_X
	cmp	#30
	bcc	enemy_attack_loop

enemy_done_charging:

	; damage the hero

	jsr	damage_hero

	; update limit count
        ; max out at 5
	lda	HERO_LIMIT
	cmp	#5
	beq	battle_no_inc_limit

        inc	HERO_LIMIT

battle_no_inc_limit:


	;============================
	;============================
	;============================

	lda	#50
	sta	ANIMATE_LOOP
enemy_end_loop:


	;======================
	; copy over background

	jsr	gr_copy_to_current

	; draw hero first so behind enemy

	jsr	draw_hero_and_sword

	; if == 10 back to left
	lda	ANIMATE_LOOP
	cmp	#10
	bne	not_enemy_back

	lda	#0
	sta	ENEMY_X

	lda	#0
	sta	ENEMY_ATTACKING

not_enemy_back:


	; draw enemy
	lda	ENEMY_X
	sta	XPOS
	lda	#20
	sta	YPOS
	jsr	draw_enemy

	; let you finish menu commands?

	lda     MENU_STATE
	cmp     #MENU_NONE
	beq     enemy_no_menu2

	jsr	get_keypress
	sta	LAST_KEY
	jsr	battle_menu_keypress

enemy_no_menu2:

	;============
	; draw bottom

	jsr	draw_battle_bottom


	lda	ANIMATE_LOOP
	cmp	#10
	bcc	no_enemy_print_damage

	; print damage

	lda	#25
	sta	XPOS
	lda	#10
	sta	YPOS
	jsr	gr_put_num

no_enemy_print_damage:

	; flip page
	jsr	page_flip

	dec	ANIMATE_LOOP
	bne	enemy_end_loop


done_enemy_attack:

	; done attacking

	; reset enemy time. FIXME: variable?
	lda	#100
	sta	ENEMY_COUNT

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
	sta	INH

	lda	ENEMY_DEAD
	beq	draw_enemy_alive

	lda	#$99
	sta	COLOR
	jmp	put_sprite_mask

draw_enemy_alive:
	jmp	put_sprite_crop		; tail call







