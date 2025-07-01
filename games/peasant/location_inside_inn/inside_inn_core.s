; Peasant's Quest

; Inside Inn

;	a lot happens at the Inn

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = inside_inn_verb_table

inside_inn_core:

.include "../location_common/common_core.s"

	;====================================================
        ; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;===========================
	;===========================
	;===========================
	; main loop
	;===========================
	;===========================
	;===========================

game_loop:

	;====================
	; check keyboard

	jsr	check_keyboard


	;========================
	; move the peasant

	jsr	move_peasant

	;======================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;=======================
	; update screen

	jsr	update_screen

	;========================
	; increment the frame

	inc	FRAME

	;========================
	; increment flame

	jsr	increment_flame



	;=====================
	; level specific
	;=====================

exit_inside_inn:
	; check if leaving

	lda	PEASANT_Y
	cmp	#149			; $95
	bcc	skip_level_specific

	; leaving inn

	lda	#LOCATION_OUTSIDE_INN
	jsr	update_map_location


skip_level_specific:




	;=====================
	; flip page

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

.include "inside_inn_actions.s"
.include "../hgr_routines/hgr_sprite.s"
.include "sprites_inside_inn/keeper_sprites.inc"


	;==========================
	; update screen
	;==========================
update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	;========================
	; draw the innkeeper

	jsr	draw_inkeeper

	;========================
	; always draw the peasant

	jsr	draw_peasant

	rts



	;=============================
	; draw inkeeper
	;=============================
draw_inkeeper:

	; TODO: is he always drawn?

	lda	FRAME
	and	#$7
	tax

	lda	keeper_sprites_l,X
	sta	INL
	lda	keeper_sprites_h,X
	sta	INH

        lda     #10		; 70/7
        sta     CURSOR_X
        lda     #60
        sta     CURSOR_Y

        jsr     hgr_draw_sprite

done_innkeeper:
	rts



keeper_sprites_l:
	.byte <keeper0,<keeper1,<keeper2,<keeper3
	.byte <keeper3,<keeper2,<keeper1,<keeper0

keeper_sprites_h:
	.byte >keeper0,>keeper1,>keeper2,>keeper3
	.byte >keeper3,>keeper2,>keeper1,>keeper0
