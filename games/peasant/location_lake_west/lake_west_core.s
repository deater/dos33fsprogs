; Peasant's Quest

; Pebble Lake West (Location 4,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = lake_west_verb_table

lake_west_core:

.include "../location_common/common_core.s"


        ;====================================================
        ; check if pebbles gone, and if so erase them

	jsr	remove_pebbles


	;===================================
	; mark location visited

	lda	VISITED_2
	ora	#MAP_LAKE_WEST
	sta	VISITED_2


	;=============================
	; if it's night, end it

.include "../location_common/end_night.s"


        ;====================================================
        ; clear the keyboard in case we were holding it down

        bit     KEYRESET

	;=================================
	;=================================
	;=================================
	; main loop
	;=================================
	;=================================
	;=================================

game_loop:
	;====================
	; check keyboard

	jsr	check_keyboard

	;==============
	; move peasant

	jsr	move_peasant

	;=====================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;==================
	; update screen

	jsr	update_screen

	;==================
	; increment frame

	inc	FRAME

	;==================
	; increment flame

	jsr	increment_flame


	;===================
	; page flip


;	jsr	wait_vblank

	jsr	hgr_page_flip

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
.include "../hgr_routines/hgr_sprite.s"
.include "lake_west_actions.s"
.include "sprites_lake_west/bubble_sprites_w.inc"
.include "sprites_lake_west/pebbles_sprites.inc"
.include "animate_bubbles.s"
.include "sprites_lake_west/throw_sprites.inc"

	;========================
	; update screen
	;========================
update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;=========================
	; draw bubbles

	jsr	animate_bubbles_w

	;=====================
	; always draw peasant

	jsr	draw_peasant


	rts


	;==========================
	; remove pebbles
	;==========================
	; if pebbles picked up, erase them
	; from background graphics
remove_pebbles:

	; erase if we're holding them
	lda	INVENTORY_1
	and	#INV1_PEBBLES
	bne	undraw_pebbles

	; erase if we had them but they're gone
	lda	INVENTORY_1_GONE
	and	#INV1_PEBBLES
	beq	pebbles_are_fine

undraw_pebbles:
	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

	lda	#<no_pebbles
	sta	INL
	inx
	lda	#>no_pebbles
	sta	INH

	lda	#12		; 84/7 = 12
	sta	CURSOR_X
	lda	#100
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

pebbles_are_fine:
	rts


