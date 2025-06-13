; Peasant's Quest

; Archery / Brothers (Location 3,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE=archery_verb_table

peasantry_brothers_core:

.include "../location_common/common_core.s"


	;=====================
	; special archery
	;=====================

	lda	ARROW_SCORE
	bpl	not_from_archery

	; coming back from archery game

	and	#$7f		; unset
	sta	ARROW_SCORE

	and	#$f			; see if score (bottom) is 0
	beq	arrow_game_zero

	sta	TEMP0

	lda	ARROW_SCORE
	lsr
	lsr
	lsr
	lsr
	cmp	TEMP0
	bne	arrow_game_lost

arrow_game_won:
	; get 3 points
	lda	#3
	jsr	score_points

	; get bow
	lda	INVENTORY_1
	ora	#INV1_BOW
	sta	INVENTORY_1

	; set won
	lda	GAME_STATE_0
	ora	#ARROW_BEATEN
	sta	GAME_STATE_0

	lda	TEMP0
	clc
	adc	#'0'
	sta	archery_won_message+14

	ldx	#<archery_won_message
	ldy	#>archery_won_message
	jsr	partial_message_step
	jmp	game_loop

arrow_game_zero:
	ldx	#<archery_zero_message
	ldy	#>archery_zero_message
	jsr	partial_message_step
	jmp	arrow_game_lose_common

arrow_game_lost:
	lda	TEMP0
	clc
	adc	#'0'
	sta	archery_some_message+24	; urgh affected by compression

	ldx	#<archery_some_message
	ldy	#>archery_some_message
	jsr	partial_message_step

arrow_game_lose_common:
	ldx	#<archery_lose_message
	ldy	#>archery_lose_message
	jsr	partial_message_step

not_from_archery:

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

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;=====================
	; level specific
	;=====================

	;=======================
	; archery animations
	;=======================
at_archery:
	jsr	animate_archery

skip_level_specific:

	;===========================
	; copy bg to current screen

	lda	#$60
	jsr	hgr_copy_fast

	;====================
	; always draw peasant

	jsr	draw_peasant

	;====================
	; increment frame

	inc	FRAME

	;=======================
	; check keyboard

	lda	PEASANT_DIR
	sta	OLD_DIR

	jsr	check_keyboard

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop

	;====================
	; end of level

oops_new_location:


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


	;========================
	; animate archery
	;=========================
animate_archery:

	lda     FRAME
	and     #4
	bne	mendelev_arm_moved

mendelev_normal:

;	lda	#107
;	sta	SAVED_Y1
;	lda	#110
;	sta	SAVED_Y2

;	lda	#29
;	ldx	#31
;	jmp	hgr_partial_restore
	rts

mendelev_arm_moved:

	lda	#<mendelev1_sprite
	sta	INL
	inx
	lda	#>mendelev1_sprite
	sta	INH

	lda	#29
	sta     CURSOR_X
	lda	#107
	sta	CURSOR_Y

	jmp	hgr_draw_sprite		;


.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"

;.include "../hgr_routines/hgr_partial_restore.s"
.include "../hgr_routines/hgr_sprite.s"

.include "../wait_a_bit.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"

.include "../gr_copy.s"
.include "../hgr_routines/hgr_copy_fast.s"

.include "sprites_brothers/archery_sprites.inc"

;brothers_text_zx02:
;.incbin "../text/DIALOG_BROTHERS.ZX02"

.include "brothers_actions.s"
