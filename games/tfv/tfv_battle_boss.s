
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
	rts
