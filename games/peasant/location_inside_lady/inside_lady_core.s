; Peasant's Quest

; Inside Lady's Cottage

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = inside_cottage_verb_table

hidden_glen_core:

.include "../location_common/common_core.s"

	;==================================
	; update priority map if lady gone

	jsr	update_priority_chair

	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;============================
	;============================
	;============================
	; main loop
	;============================
	;============================
	;============================

game_loop:

	;=======================
	; check keyboard

	jsr	check_keyboard

	;=====================
	; move peasant

	jsr	move_peasant

	;=====================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;=====================
	; update screen

	jsr	update_screen


	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; increment flame

	jsr	increment_flame


	;=====================
	; level specific
	;=====================


inside_lady_cottage:
	; check if leaving

	lda	PEASANT_Y
	cmp	#$95
	bcc	skip_level_specific

	; we're exiting, print proper message

	lda	INVENTORY_2
	and	#INV2_TRINKET
	bne	after_trinket_message

	lda	INVENTORY_2_GONE
	and	#INV2_TRINKET
	bne	after_trinket_message


before_trinket_message:
	ldx	#<inside_cottage_leaving_message
	ldy	#>inside_cottage_leaving_message
	jsr	finish_parse_message
	jmp	done_trinket_message

after_trinket_message:
	ldx	#<inside_cottage_leaving_post_trinket_message
	ldy	#>inside_cottage_leaving_post_trinket_message
	jsr	finish_parse_message

done_trinket_message:

	; put outside door
;	lda	#$17
;	sta	PEASANT_X
;	lda	#$7D
;	sta	PEASANT_Y

	; stop walking
;	lda	#0
;	sta	PEASANT_XADD
;	sta	PEASANT_YADD


	; move back

	lda     #LOCATION_OUTSIDE_LADY
	jsr	update_map_location


skip_level_specific:




	;=======================
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

.include "draw_lady.s"
.include "inside_lady_actions.s"

.include "sprites_inside_lady/lady_cottage_sprites.inc"
.include "../hgr_routines/hgr_sprite.s"


	;===========================
	; update screen
	;===========================

update_screen:


	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	;====================
	; draw lady and/or chair

	jsr	draw_lady

	;=====================
	; always draw peasant

	jsr	draw_peasant


	rts

