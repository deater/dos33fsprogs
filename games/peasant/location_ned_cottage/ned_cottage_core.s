; Peasant's Quest

; Ned's Cottage (Empty Hut) Location 1,4

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = ned_cottage_verb_table

ned_cottage_core:

.include "../location_common/common_core.s"

	;========================
	; move rock if needed

	jsr	ned_move_rock

	;========================
	; open door if needed

	jsr	draw_door


	;===================================
	; mark location visited

	lda	VISITED_3
	ora	#MAP_OUTSIDE_NN
	sta	VISITED_3

	;======================================================
	; check if in hay, and if so, make us no longer in hay

	jsr	check_haystack_exit

	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;===============================
	;===============================
	;===============================
	; main loop
	;===============================
	;===============================
	;===============================

game_loop:

	;=======================
	; check keyboard

	jsr	check_keyboard

	;===================
	; move peasant

	jsr	move_peasant

	;=====================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;====================
	; update screen

	jsr	update_screen


	;====================
	; increment frame

	inc	FRAME

	;====================
	; increment flame

	jsr	increment_flame


	;=======================
	; flip page

;	jsr	wait_vblank

        jsr	hgr_page_flip



	;===============================
	; check if can enter ned cottage
	;===============================

	; OK are are at the cottage, is the door open?

	lda	INVENTORY_1_GONE
	and	#INV1_BABY
	beq	not_ned_cottage

	; at cottage, door open, check our co-ords
	lda	PEASANT_Y	; #$68
	cmp	#$64
	bcc	not_ned_cottage
	cmp	#$70
	bcs	not_ned_cottage

	lda	PEASANT_X	; 15 - 17
	cmp	#15
	bcc	not_ned_cottage
	cmp	#18
	bcs	not_ned_cottage

	;=========================================
	; we did it, we're entering Ned's cottage

	lda	#LOCATION_INSIDE_NN
	jsr	update_map_location

	lda	#11
	sta	PEASANT_X
	lda	#$90
	sta	PEASANT_NEWY
	lda	#PEASANT_DIR_UP
	sta	PEASANT_DIR
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD


not_ned_cottage:


	jmp	game_loop

	;========================
	; exit level
	;========================
oops_new_location:
level_over:

	;===============================
	; handle end of level
	;===============================

.include "../location_common/end_of_level_common.s"

	;======================================
	; special case leaving-level borders

.include "borders.s"

really_level_over:
	rts



.include "../location_common/include_bottom.s"

.include "ned_cottage_actions.s"

.include "../hgr_routines/hgr_sprite.s"

.include "sprites_ned_cottage/ned_sprites.inc"
.include "sprites_ned_cottage/baby_sprites.inc"
.include "sprites_ned_cottage/cottage_sprites.inc"

BLOWN_AWAY_OFFSET = 0
.include "../location_haystack/check_haystack.s"
.include "../location_haystack/sprites_haystack/blown_away_sprite.inc"
.include "haystack_data.s"
.include "../hgr_routines/hgr_sprite_custom_bg_mask.s"
.include "draw_door.s"
.include "deploy_baby.s"

;.include "graphics_ned_cottage/baby_hut_priority.inc"
;.include "graphics_ned_cottage/empty_hut_priority.inc"

	;=========================
	; update screen
	;=========================
update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=====================
	; draw peasant


	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_PEASANT
	bne	skip_draw_peasant

	jsr	draw_peasant
skip_draw_peasant:

	rts


	;==============================
	; draw moved rock if necessary
	;==============================
ned_move_rock:
	lda	GAME_STATE_2
	and	#COTTAGE_ROCK_MOVED
	beq	rock_not_moved

	; 161,117
	lda	#23
	sta	CURSOR_X
	lda	#117
	sta	CURSOR_Y

	lda	#<rock_moved_sprite
	sta	INL
	lda	#>rock_moved_sprite
	sta	INH

	;======================
	; draw to $6000

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE
	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

	jsr	hgr_draw_sprite

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

rock_not_moved:
	rts

