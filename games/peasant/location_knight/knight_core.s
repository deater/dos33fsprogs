; Peasant's Quest

; o/~ One Knight in Peasantry makes a hard man humble o/~

; Knight (location 5,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = mountain_pass_verb_table

knight_core:

.include "../location_common/common_core.s"


	;=================================
	; see if need to move knight

	jsr	move_knight


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
	; check keyboard

;	jsr	drain_keyboard_buffer

	jsr	check_keyboard


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

skip_level_specific:

	;=====================
	; update screen

	jsr	update_screen

	;====================
	; increment frame

	inc	FRAME

	;====================
	; increment flame

	jsr	increment_flame


	;====================
	; flip screen

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


	;===========================
	; update screen
	;===========================

update_screen:
	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster

	;===================
	; draw knight
	;===================
	; knight behavior, wait random number of frames (100+?)
	; do animation

	dec	knight_countdown
	lda	knight_countdown
	cmp	#$FF
	bne	good_knight
reset_knight:
	jsr	random8
	and	#$3f
	adc	#64
	sta	knight_countdown
good_knight:
	cmp	#18
	bcs	standing_knight

	tax
	lda	knight_animation,X
	tax

	jmp	draw_knight

	; otherwise we are standing
standing_knight:
	ldx	#0		; stand sprite

draw_knight:
	lda	#24		; 168/7=24
	sta	SPRITE_X

knight_y_smc:
	lda	#92
	sta	SPRITE_Y


	jsr	hgr_draw_sprite_mask



	;====================
	; draw peasant

	jsr	draw_peasant



	rts

knight_countdown:
	.byte 0


.include "../hgr_routines/hgr_sprite_mask.s"

.include "../location_common/include_bottom.s"

.include "knight_actions.s"

.include "sprites_knight/knight_sprites.inc"

knight_animation:
;	.byte	0,1,2,3,4,5,6,1,0

;	.byte	2,3,8,7,6,5,4,3,2
	.byte	3,3,4,4,9,9,8,8,7,7,6,6,5,5,4,4,3,3

sprites_xsize:
	.byte	3, 3, 3		; stand, walk, walk
	.byte	3, 3, 3, 3	; yawn0.3
	.byte	3, 3, 3, 3	; yawn4.7

sprites_ysize:
	.byte	33, 33, 33	; stand, walk, walk
	.byte	33, 33, 33, 33	; yawn0.3
	.byte	33, 33, 33, 33	; yawn4.7

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



	;================================
	; move the knight out of way
	;	only if knight moved
move_knight:

	lda	GAME_STATE_3
	and	#KNIGHT_MOVED
	beq	done_move_knight

	;=====================
	; move Y position

	lda	#100		; +8?
	sta	knight_y_smc+1

	;===================================
	; FIXME: need to update priority too

	;===============================================
	; patch collision detect so we can walk through

;	-91  3f 21
;	+91  20 20

	lda	#20
	sta	collision_location+$91
	sta	collision_location+$92

;	-b9  fc 9c
;	+b9  7c 7c

	lda	#$7c
	sta	collision_location+$b9
	sta	collision_location+$ba


done_move_knight:
	rts
