; In Town

; Puzzle Room
; Get through office
; Have to run away?  What happens if die?  No save game?  Code?

; Construct the LED circuit
; Zaps through cloud
; Susie joins your party

; Final Battle
; Play music, lightning effects?
; TFV only hit for one damage, susie for 100


world_map:

	;===================
	; Clear screen/pages
	;===================

	jsr     clear_screens
	jsr     set_gr_page0

	;===============
	; Init Variables
	;===============

	lda	#$0
	sta	ODD
	sta	ON_BIRD

	lda	#$1
	sta	DIRECTION
	sta	REFRESH

	lda	#5
	sta	MAP_X

	lda	#15
	sta	TFV_X

	lda	#20
	sta	TFV_Y

	;==================
	; MAIN LOOP
	;==================

worldmap_loop:
	lda	#$0
	sta	MOVED
	lda	TFV_X
	sta	NEWX
	lda	TFV_Y
	sta	NEWY


worldmap_keyboard:

	jsr     get_key			; get keypress

	lda     LASTKEY

worldmap_handle_q:
	cmp     #('Q')			; if quit, then return
	bne     worldmap_handle_up
        rts

worldmap_handle_up:
	cmp	#('W')
	bne	worldmap_handle_down

	dec	NEWY
	dec	NEWY
	inc	MOVED

worldmap_handle_down:
	cmp	#('S')
	bne	worldmap_handle_left

	inc	NEWY
	inc	NEWY
	inc	MOVED

worldmap_handle_left:
	cmp	#('A')
	bne	worldmap_handle_right

	lda	DIRECTION		; 0=left, 1=right
	beq	go_left			; if (0) already left, keep going

left_turn:
	lda	#0			; change direction to left
	sta	DIRECTION
	sta	ODD			; stand (not walk) if changing
	beq	worldmap_handle_right	; skip ahead

go_left:
	dec	NEWX			; decrement x
	inc	MOVED			; we moved

worldmap_handle_right:
	cmp	#('D')
	bne	worldmap_handle_enter

	lda	DIRECTION		; 0=left, 1=right
	bne	go_right		; if (1) already right, keep going

right_turn:
	lda	#1			; change direction to right
	sta	DIRECTION
	lda	#0			; change to standing
	sta	ODD
	beq	worldmap_handle_enter	; skip ahead

go_right:
	inc	NEWX			; increment X
	inc	MOVED

worldmap_handle_enter:
	cmp	#13
	bne	worldmap_handle_help

	; jsr	city_map
	inc	REFRESH

worldmap_handle_help:
	cmp	#('H')
	bne	worldmap_handle_battle

	jsr	print_help

worldmap_handle_battle:
	cmp	#('B')
	bne	worldmap_handle_info

	; jsr	do_battle
	inc	REFRESH

worldmap_handle_info:
	cmp	#('I')
	bne	worldmap_handle_map

	; jsr	print_info
	inc	REFRESH

worldmap_handle_map:
	cmp	#('M')
	bne	worldmap_done_keyboard

	jsr show_map
	inc	REFRESH

worldmap_done_keyboard:

	;===========================
	; Handle Movement
	;===========================

	lda	MOVED
	beq	worldmap_refresh_screen

	inc	ODD
	inc	STEPS

	; Handle Collision Detection

	lda	NEWX
	sta	TFV_X

	lda	NEWY
	sta	TFV_Y

check_high_x:
	lda	TFV_X
	cmp	#36
	bmi	check_low_x

	; Off screen to right
	lda	#0
	sta	TFV_X
	inc	MAP_X
	inc	REFRESH
	bne	check_high_y

check_low_x:
	lda	TFV_X
	bpl	check_high_y

	dec	MAP_X
	lda	#35
	sta	TFV_X
	inc	REFRESH

check_high_y:
	lda	TFV_Y			; load Y value
	cmp	#28
	bmi	check_low_y		; if less than 28, check low Y

	clc
	lda	#$4
	sta	TFV_Y
	adc	MAP_X
	sta	MAP_X
	inc	REFRESH
	bne	done_map_check

check_low_y:
	lda	TFV_Y
	cmp	#4
	bpl	done_map_check

	lda	#28
	sta	TFV_Y
	dec	MAP_X
	dec	MAP_X
	dec	MAP_X
	dec	MAP_X
	inc	REFRESH

done_map_check:

	;============================
	; Refresh screen if needed
	;============================
worldmap_refresh_screen:

	lda	REFRESH
	beq	worldmap_copy_background
	jsr	load_map_bg
	dec	REFRESH

worldmap_copy_background:

	;================
	; Copy background
	;================

	jsr	gr_copy_to_current

	;=================================
	; Handle background ground scatter
	;=================================

	; if (map_x==1) if (tfv_y>=22) grsim_put_sprite(snowy_tree,10,20);

	lda	MAP_X
	cmp	#1
	bne	back_not_snow

	lda	TFV_Y
	cmp	#22
	bmi	no_back_scatter

	; snowy tree

	lda	#>snowy_tree
	sta	INH
	lda	#<snowy_tree
	sta	INL

	lda	#10
	sta	XPOS
	lda	#20
	sta	YPOS

	bne	back_scatter_sprite

back_not_snow:

	; if (map_x==4) if (tfv_y>=16) grsim_put_sprite(pine_tree,25,16);

	cmp	#4
	bne	back_not_pine

	lda	TFV_Y
	cmp	#16
	bmi	no_back_scatter

	; pine tree

	lda	#>pine_tree
	sta	INH
	lda	#<pine_tree
	sta	INL

	lda	#25
	sta	XPOS
	lda	#16
	sta	YPOS

	bne	back_scatter_sprite


back_not_pine:
	; palm tree
	; if (map_x==8) if (tfv_y>=22) grsim_put_sprite(palm_tree,10,20);

	cmp	#8
	bne	back_not_palm

	lda	#10
	sta	XPOS

	bne	back_palm

back_not_palm:
	; palm tree 2
	; if (map_x==12) if (tfv_y>=22) grsim_put_sprite(palm_tree,20,20);

	cmp	#12
	bne	back_not_palm2

	lda	#20
	sta	XPOS

back_palm:

	lda	TFV_Y
	cmp	#22
	bmi	no_back_scatter

	lda	#>palm_tree
	sta	INH
	lda	#<palm_tree
	sta	INL

	lda	#20
	sta	YPOS

	bne	back_scatter_sprite

back_not_palm2:
	cmp	#13
	bne	no_back_scatter

	lda	TFV_Y
	cmp	#16
	bmi	no_back_scatter

	; cactus
	; if (map_x==13) if (tfv_y>=16) grsim_put_sprite(cactus,25,16);
	lda	#>cactus
	sta	INH
	lda	#<cactus
	sta	INL

	lda	#25
	sta	XPOS
	lda	#16
	sta	YPOS

back_scatter_sprite:

	jsr	put_sprite

no_back_scatter:
	;========================
	; Draw background forest
	;========================

	lda	MAP_X			; if ((map_x==7) || (map_x==11))
	cmp	#7
	beq	back_forest
	cmp	#11
	bne	back_no_forest

back_forest:
	lda	#COLOR_BOTH_DARKGREEN
	sta	COLOR

	lda	TFV_Y
	clc
	adc	#6
back_forest_loop:
	pha			; 10, ends at 23

	lsr			; limit=22+(i/4);
	lsr
	clc
	adc	#22
	sta     V2

	ldy     #0
	pla
	pha

	jsr	hlin_double		; hlin y,V2 at A

	;	for(i=10;i<tfv_y+8;i+=2)
	;		hlin_double(ram[DRAW_PAGE],0,limit,i);

	pla
	clc
	adc	#$fe		; -2
	cmp	#8
	bne	back_forest_loop

back_no_forest:


	;=============
	; Draw TFV
	;=============

	clc

	lda	#1
	bit	ODD
	bne	standing

walking:
	lda	DIRECTION		; 0=left, 1=right
	bne	walking_right		; if(!0) walk right

walking_left:
	lda	#>tfv_walk_left
	sta	INH
	lda	#<tfv_walk_left
	sta	INL
	bcc	done_walking

walking_right:
	lda	#>tfv_walk_right
	sta	INH
	lda	#<tfv_walk_right
	sta	INL
	bcc	done_walking

standing:
	lda	DIRECTION
	bne	standing_right
standing_left:
	lda	#>tfv_stand_left
	sta	INH
	lda	#<tfv_stand_left
	sta	INL
	bcc	done_walking

standing_right:
	lda	#>tfv_stand_right
	sta	INH
	lda	#<tfv_stand_right
	sta	INL

done_walking:


	lda	TFV_X
	sta	XPOS
	lda	TFV_Y
	sta	YPOS

	jsr	put_sprite


;	if (direction==-1) {
 ;                               if (odd) grsim_put_sprite(tfv_walk_left,tfv_x,tfv_y);
  ;                              else grsim_put_sprite(tfv_stand_left,tfv_x,tfv_y);
   ;                     }
    ;                    if (direction==1) {
     ;                           if (odd) grsim_put_sprite(tfv_walk_right,tfv_x,tfv_y);
      ;                          else grsim_put_sprite(tfv_stand_right,tfv_x,tfv_y);
       ;                 }


	;=================================
	; Handle foreground ground scatter
	;=================================

	;if (map_x==1) if (tfv_y<22) grsim_put_sprite(snowy_tree,10,22);

	lda	MAP_X
	cmp	#1
	bne	fore_not_snow

	lda	TFV_Y
	cmp	#22
	bpl	no_fore_scatter

	; snowy tree

	lda	#>snowy_tree
	sta	INH
	lda	#<snowy_tree
	sta	INL

	lda	#10
	sta	XPOS
	lda	#20
	sta	YPOS

	bne	fore_scatter_sprite

fore_not_snow:

	; if (map_x==4) if (tfv_y<15) grsim_put_sprite(pine_tree,25,15);

	cmp	#4
	bne	fore_not_pine

	lda	TFV_Y
	cmp	#16
	bpl	no_fore_scatter

	; pine tree

	lda	#>pine_tree
	sta	INH
	lda	#<pine_tree
	sta	INL

	lda	#25
	sta	XPOS
	lda	#16
	sta	YPOS

	bne	fore_scatter_sprite

fore_not_pine:
	; palm tree
	; if (map_x==8) if (tfv_y<22) grsim_put_sprite(palm_tree,10,20);

	cmp	#8
	bne	fore_not_palm

	lda	#10
	sta	XPOS

	bne	fore_palm

fore_not_palm:
	; palm tree 2
	; if (map_x==12) if (tfv_y<22) grsim_put_sprite(palm_tree,20,20);

	cmp	#12
	bne	fore_not_palm2

	lda	#20
	sta	XPOS

fore_palm:

	lda	TFV_Y
	cmp	#22
	bpl	no_fore_scatter

	lda	#>palm_tree
	sta	INH
	lda	#<palm_tree
	sta	INL

	lda	#20
	sta	YPOS

	bne	fore_scatter_sprite

fore_not_palm2:
	cmp	#13
	bne	no_fore_scatter

	lda	TFV_Y
	cmp	#16
	bpl	no_fore_scatter

	; cactus
	; if (map_x==13) if (tfv_y<15) grsim_put_sprite(cactus,25,15);

	lda	#>cactus
	sta	INH
	lda	#<cactus
	sta	INL

	lda	#25
	sta	XPOS
	lda	#16
	sta	YPOS

fore_scatter_sprite:

	jsr	put_sprite

no_fore_scatter:


	;========================
	; Draw foreground forest
	;========================

	lda	MAP_X			; if ((map_x==7) || (map_x==11))
	cmp	#7
	beq	fore_forest
	cmp	#11
	bne	fore_no_forest

fore_forest:
	lda	#COLOR_BOTH_DARKGREEN
	sta	COLOR

	lda	TFV_Y
	clc
	adc	#8
fore_forest_loop:
	cmp	#36
	beq	done_forest_loop

	pha

	lsr			; limit=22+(i/4);
	lsr
	clc
	adc	#22
	sta     V2

	ldy     #0
	pla
	pha

	jsr	hlin_double		; hlin y,V2 at A

	;	for(i=tfv_y+8;i<36;i+=2) {
	;		hlin_double(ram[DRAW_PAGE],0,limit,i);

	pla
	clc
	adc	#2
	bne	fore_forest_loop

done_forest_loop:

	;====================
	; Draw tree trunks
	;====================

	lda	#36

outer_treetrunk_loop:
	pha

	lda	#COLOR_BOTH_BROWN
	sta	COLOR

	lda	#0			; hlin_double(ram[DRAW_PAGE],0,0,36);
	sta     V2
	ldy     #0
	pla
	pha

	jsr	hlin_double		; hlin y,V2 at A

	lda	#0
treetrunk_loop:
	pha

	lda	#COLOR_BOTH_GREY
	sta	COLOR
	ldx	#1
	jsr	hlin_double_continue

	lda	#COLOR_BOTH_BROWN
	sta	COLOR
	ldx	#1
	jsr	hlin_double_continue

	pla
	clc
	adc	#1
	cmp	#13
	bne	treetrunk_loop

	pla
	clc
	adc	#2
	cmp	#40
	bne	outer_treetrunk_loop

	;	color_equals(COLOR_BROWN);
	;	hlin_double(ram[DRAW_PAGE],0,1,37);
	;	for(i=0;i<13;i++) {
	;		color_equals(COLOR_GREY);
	;		hlin_double_continue(1);
	;		color_equals(COLOR_BROWN);
	;		hlin_double_continue(1);
	;	}
	; }

fore_no_forest:

	;=============================
	; Draw lightning
	;=============================

	lda	MAP_X
	cmp	#3
	bne	no_lightning

	lda	STEPS
	and	#$f
	bne	no_lightning

	lda	#>lightning
	sta	INH
	lda	#<lightning
	sta	INL

	lda	#25
	sta	XPOS
	lda	#4
	sta	YPOS

	jsr	put_sprite	; grsim_put_sprite(lightning,25,4);

	;=============================
	; Hurt hit points if in range?
	;=============================
	;		if ((tfv_x>25) && (tfv_x<30) && (tfv_y<12)) {
	;		printf("HIT! %d %d\n\n",steps,hp);
	;			if (hp>11) {
	;				hp=10;

no_lightning:

        jsr	page_flip

	;============
	; Update Time
	;============
	; if (steps>=60) {
	;	steps=0;
	;	time_minutes++;
	;	if (time_minutes>=60) {
	;		time_hours++;
	;		time_minutes=0;
	;	}
	; }

	jmp	worldmap_loop



;	Map
;
;	0	1	2	3
;
; 0	BEACH	ARCTIC	ARCTIC	BELAIR
;		TREE	MOUNATIN
;
; 1	BEACH	LANDING	GRASS	FOREST
;	PINETREE	MOUNTAIN
;
; 2	BEACH	GRASS	GRASS	FOREST
;	PALMTREE	MOUNTAIN
;
; 3	BEACH	DESERT	COLLEGE	BEACH
;		CACTUS	PARK


	;=============================================
	;=============================================
	; Load World Map background
	;=============================================
	;=============================================

load_map_bg:

	; Set target for the background drawing

	; Check for special cases

	lda	MAP_X
map_harfco:
	cmp	#3		; if map_x==3, harfco
	bne	map_landing


	lda	#<(harfco_lzsa)
	sta	getsrc_smc+1
        lda	#>(harfco_lzsa)
        sta	getsrc_smc+2

	lda	#$c

	jsr	decompress_lzsa2_fast
	rts

map_landing:
	cmp	#5		; if map_x==5, landing site
	bne	map_collegep


	lda	#<(landing_lzsa)
	sta	getsrc_smc+1
        lda	#>(landing_lzsa)
	sta	getsrc_smc+2

	lda	#$c

	jsr	decompress_lzsa2_fast
	rts

map_collegep:
	cmp	#14		; if map_x==14, collegep
	bne	map_custom

	lda	#<(collegep_lzsa)
	sta	getsrc_smc+1
        lda	#>(collegep_lzsa)
	sta	getsrc_smc+2

	lda	#$c

	jsr	decompress_lzsa2_fast
	rts

	;============================
	; draw parametric background
	;============================
map_custom:

	; Draw the Sky

	lda	DRAW_PAGE		; save the DRAW_PAGE value for later
	pha

	lda	#$8			; temporarily draw to 0xc00
	sta	DRAW_PAGE

	lda	#COLOR_BOTH_MEDIUMBLUE	; MEDIUMBLUE color
	sta	COLOR

	lda	#0
map_sky:				; draw line across screen
	ldy     #39			; from y=0 to y=10
	sty     V2
	ldy     #0
	pha
	jsr	hlin_double		; hlin y,V2 at A
	pla
	clc
	adc     #2
	cmp     #10
	bne     map_sky

	;=================
	; Set Ground Color
	;=================

	ldx	#COLOR_BOTH_LIGHTGREEN	; default is grass color

	lda	MAP_X
	cmp	#4
	bpl	not_artic
	ldx	#COLOR_BOTH_WHITE	; snow white
not_artic:
	cmp	#13
	bne	not_desert
	ldx	#COLOR_BOTH_ORANGE	; desert orange
not_desert:
	stx	GROUND_COLOR


	;===========================================
	; sloped left beach, of left side of island
	;===========================================

	lda	#3
	and	MAP_X
	bne	not_sloped_left

	lda	#10
sloped_left_loop:
	pha
	eor	#$ff	; temp=4+(39-i)/8;
	sec
	adc	#39
	lsr
	lsr
	lsr
	sec
	adc	#3
	sta	TEMP
	sta	V2
	pla
	pha

	ldx	#COLOR_BOTH_DARKBLUE
	stx	COLOR

	ldy	#0

	jsr	hlin_double

	ldx	#COLOR_BOTH_LIGHTBLUE
	stx	COLOR
	ldx	#2
	jsr	hlin_double_continue

	ldx	#COLOR_BOTH_YELLOW
	stx	COLOR
	ldx	#2
	jsr	hlin_double_continue

	ldx	GROUND_COLOR
	stx	COLOR

	lda	TEMP
	eor	#$ff
	sec
	adc	#35
	tax

	jsr	hlin_double_continue

	pla
	clc
	adc	#2
	cmp	#40
	bne	sloped_left_loop

	beq	done_base

not_sloped_left:

	;=============================================
	; sloped right beach, on right side of island
	;=============================================

	lda	#3
	and	MAP_X
	cmp	#3
	bne	not_sloped_right

	lda	#10
sloped_right_loop:
	pha
	lsr		; temp=24+(A/4)
	lsr		; A/4
	clc
	adc	#24
	sta	TEMP
	sta	V2

	pla
	pha

	ldx	GROUND_COLOR
	stx	COLOR

	ldy	#0

	jsr	hlin_double

	ldx	#COLOR_BOTH_YELLOW
	stx	COLOR
	ldx	#2
	jsr	hlin_double_continue

	ldx	#COLOR_BOTH_LIGHTBLUE
	stx	COLOR
	ldx	#2
	jsr	hlin_double_continue

	ldx	#COLOR_BOTH_DARKBLUE
	stx	COLOR

	lda	TEMP
	eor	#$ff
	sec
	adc	#35
	tax

	jsr	hlin_double_continue


   ;                     color_equals(ground_color);
    ;                    hlin(PAGE2,0,temp,i);
     ;                   color_equals(COLOR_YELLOW);
      ;                  hlin_continue(2);
       ;                 color_equals(COLOR_LIGHTBLUE);
        ;                hlin_continue(2);
         ;               color_equals(COLOR_DARKBLUE);
          ;              hlin_continue(36-temp);

	pla
	clc
	adc	#$2
	cmp	#40
	bne	sloped_right_loop
	beq	done_base

	;==============================
	; grassland
	;==============================

not_sloped_right:

	lda	GROUND_COLOR
	sta	COLOR

	lda	#10

grassland_loop:				; draw line across screen
	ldy     #40                     ; from y=0 to y=10
	sty     V2
	ldy     #0
	pha
	jsr	hlin_double		; hlin y,V2 at A
	pla
	clc
	adc     #2
	cmp     #40
	bne     grassland_loop

done_base:

	;==============================
	; Draw North Shore
	;==============================
draw_north_shore:
	lda	MAP_X
	cmp	#4
	bpl	draw_south_shore

	ldx	#COLOR_BOTH_DARKBLUE
	stx	COLOR

	lda	#39
	sta	V2
	ldy	#0
	lda	#10

	jsr	hlin_double


	;==============================
	; Draw South Shore
	;==============================
draw_south_shore:
	lda	MAP_X
	cmp	#12
	bmi	draw_mountains

	ldx	#COLOR_BOTH_DARKBLUE
	stx	COLOR

	lda	#39
	sta	V2
	ldy	#0
	lda	#38

	jsr	hlin_double	; hlin 0,39 at 38

	ldx	#COLOR_BOTH_LIGHTBLUE
	stx	COLOR

	lda	#39
	sta	V2

	lda	#15
	cmp	MAP_X
	bne	lblue_15
	lda	#35
	sta	V2
lblue_15:

	ldy	#0
	lda	#12
	cmp	MAP_X
	bne	lblue_12
	ldy	#6
lblue_12:


	lda	#36

	jsr	hlin_double	; hlin 0,39 at 36

	ldx	#COLOR_BOTH_YELLOW
	stx	COLOR

	lda	#39
	sta	V2

	lda	#15
	cmp	MAP_X
	bne	yellow_15
	lda	#32
	sta	V2
yellow_15:

	ldy	#0
	lda	#12
	cmp	MAP_X
	bne	yellow_12
	ldy	#8
yellow_12:

	lda	#34

	jsr	hlin_double	; hlin 0,39 at 34


	;===============================
	; Draw Mountains
	;===============================
draw_mountains:
	lda	MAP_X
	and	#3
	cmp	#2
	bne	done_drawing

	lda	#0
mountain_loop:
	pha

	lda	#>mountain
	sta	INH
	lda	#<mountain
	sta	INL

	pla
	pha

	and	#1
	sta	XPOS
	asl
	asl
	clc
	adc	#10
	adc	XPOS
	sta	XPOS

	pla
	pha
	asl
	asl
	asl
	clc
	adc	#2
	sta	YPOS

	jsr	put_sprite

	pla
	clc
	adc	#1
	cmp	#4
	bne	mountain_loop

done_drawing:
	pla				; restore the draw page
	sta	DRAW_PAGE

	rts
