ODD		EQU	$7B
DIRECTION	EQU	$7C
REFRESH		EQU	$7D
ON_BIRD		EQU	$7E
MOVED		EQU	$7F
STEPS		EQU	$80
TFV_X		EQU	$81
TFV_Y		EQU	$82
NEWX		EQU	$83
NEWY		EQU	$84
MAP_X		EQU	$85

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

	; jsr	print_help

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

	; jsr show_map
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
	lda	#25
	sta	TFV_X
	inc	REFRESH



check_high_y:

check_low_y:

	;============================
	; Refresh screen if needed
	;============================
worldmap_refresh_screen:

	lda	REFRESH
	beq	worldmap_copy_background
	jsr	load_map_bg
	dec	REFRESH

worldmap_copy_background:


	; Copy background

	jsr	gr_copy_to_current

	; Handle ground scatter

	; Draw background trees

	; Draw TFV


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


	; Draw foreground scatter



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

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL		; load image off-screen 0xc00

	lda	MAP_X
map_harfco:
	cmp	#3
	bne	map_landing

	lda	#>(harfco_rle)
	sta	GBASH
        lda	#<(harfco_rle)
        sta	GBASL
        jsr	load_rle_gr
	rts

map_landing:
	cmp	#5
	bne	map_collegep

	lda	#>(landing_rle)
	sta	GBASH
        lda	#<(landing_rle)
        sta	GBASL
        jsr	load_rle_gr
	rts

map_collegep:
	cmp	#14
	bne	map_custom

	lda	#>(collegep_rle)
	sta	GBASH
        lda	#<(collegep_rle)
        sta	GBASL
        jsr	load_rle_gr
	rts

map_custom:

	; Draw the Sky

	lda	DRAW_PAGE
	pha

	lda	#$8
	sta	DRAW_PAGE

	lda	#COLOR_BOTH_MEDIUMBLUE	; MEDIUMBLUE color
	sta	COLOR

	lda	#0

map_sky:				; draw line across screen
	ldy     #40                     ; from y=0 to y=10
	sty     V2
	ldy     #0
	pha
	jsr	hlin_double		; hlin y,V2 at A
	pla
	clc
	adc     #2
	cmp     #10
	bne     map_sky

map_grassland:

	lda	#COLOR_BOTH_LIGHTGREEN	; LIGHTGREEN color
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

	pla				; restore the draw page
	sta	DRAW_PAGE

	rts
