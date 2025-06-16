; Peasant's Quest

; Knight (location 5,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = mountain_pass_verb_table

knight_core:

.include "../location_common/common_core.s"


	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;================================
	;================================
	;================================
	; main loop
	;================================
	;================================
	;================================
game_loop:

	;====================
	; move peasant

	jsr	move_peasant

	;=====================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;=====================
	; level specific
	;=====================

skip_level_specific:

	;=====================
	; update screen
	;=====================

	jsr	update_screen

	;====================
	; increment frame

	inc	FRAME

	;====================
	; increment flame

	jsr	increment_flame


	;====================
	; check keyboard

	; original code also waited approximately 100ms?
	; this led to keypressed being lost

	lda	PEASANT_DIR
	sta	OLD_DIR

	jsr	check_keyboard

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop

oops_new_location:
;	jmp	new_location


	;========================
	; exit level
	;========================
level_over:
	cmp	#NEW_FROM_LOAD		; skip to end if loading save game
	beq	really_level_over

	; specical case if going outside inn
	; we don't want to end up behind inn

	lda	MAP_LOCATION
	cmp	#LOCATION_OUTSIDE_INN
	bne	not_behind_inn

	; be sure we're in range
	lda	PEASANT_X
	cmp	#6
	bcc	really_level_over	; fine if at far right

	cmp	#18
	bcc	to_left_of_inn
	cmp	#30
	bcc	to_right_of_inn

					; fine if at far left

not_behind_inn:
	lda	MAP_LOCATION
	cmp	#LOCATION_CLIFF_BASE
	bne	not_going_to_cliff

	lda	#18
	sta	PEASANT_X
	lda	#140
	sta	PEASANT_Y
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
	sta	PEASANT_DIR

not_going_to_cliff:
really_level_over:

	rts

to_right_of_inn:
	lda	#31
	sta	PEASANT_X
	rts

to_left_of_inn:
	lda	#5
	sta	PEASANT_X
	rts


	;===========================
	; update screen
	;===========================

update_screen:
	;===========================
	; copy bg to current screen

;	lda	#$60
	jsr	hgr_copy_faster


	;====================
	; always draw peasant

	jsr	draw_peasant

	;===================
	; draw knight

	lda	#24		; 168/7=24
	sta	SPRITE_X

	lda	#92
	sta	SPRITE_Y

	ldx	#0		; stand sprite
	jsr	hgr_draw_sprite_mask

	rts

.include "../hgr_routines/hgr_sprite_mask.s"
.include "../hgr_routines/hgr_copy_faster.s"

.include "../location_common/include_bottom.s"

.include "knight_actions.s"

.include "sprites_knight/knight_sprites.inc"

sprites_xsize:
	.byte	3, 3, 3		; stand, walk, walk
	.byte	3, 3, 3, 3	; yawn0.3
	.byte	3, 3, 3, 3	; yawn4.7

sprites_ysize:
	.byte	32, 32, 32	; stand, walk, walk
	.byte	32, 32, 32, 32	; yawn0.3
	.byte	32, 32, 32, 32	; yawn4.7

sprites_data_l:
	.byte <ks0_sprite,<kw0_sprite,<kw1_sprite
	.byte <yw0_sprite,<yw1_sprite,<yw2_sprite,<yw3_sprite
	.byte <yw4_sprite,<yw5_sprite,<yw6_sprite,<yw7_sprite

sprites_data_h:
	.byte >ks0_sprite,>kw0_sprite,>kw1_sprite
	.byte >yw0_sprite,>yw1_sprite,>yw2_sprite,>yw3_sprite
	.byte >yw4_sprite,>yw5_sprite,>yw6_sprite,>yw7_sprite

sprites_mask_l:
	.byte <ks0_mask,<kw0_mask,<kw1_mask
	.byte <yw0_mask,<yw1_mask,<yw2_mask,<yw3_mask
	.byte <yw4_mask,<yw5_mask,<yw6_mask,<yw7_mask

sprites_mask_h:
	.byte >ks0_mask,>kw0_mask,>kw1_mask
	.byte >yw0_mask,>yw1_mask,>yw2_mask,>yw3_mask
	.byte >yw4_mask,>yw5_mask,>yw6_mask,>yw7_mask
