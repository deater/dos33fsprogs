; Peasant's Quest

; Haystack (location 1,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

peasantry_haystack:

DIALOG_LOCATION=haystack_text_zx02
VERB_TABLE=hay_bale_verb_table
PRIORITY_LOCATION=haystack_priority_zx02
BG_LOCATION=haystack_zx02

.include "../location_common/init_common.s"


	;======================
	; check if in hay

	jsr	check_haystack_exit

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


skip_level_specific:

	;====================
	; always draw peasant

	jsr	draw_peasant

	;====================
	; increment frame

	inc	FRAME

	;====================
	; check keyboard

	lda	#13
	sta	WAIT_LOOP
wait_loop:
	jsr	check_keyboard


	lda	#50	; approx 7ms
	jsr	wait

	dec	WAIT_LOOP
	bne	wait_loop


	;=====================
	; delay

;	lda	#200	; approx 100ms
;	jsr	wait

	jmp	game_loop

oops_new_location:
	jmp	new_location


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


.include "../move_peasant_new.s"
.include "../draw_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"
.include "../hgr_routines/hgr_partial_restore.s"
.include "../hgr_routines/hgr_sprite.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

.include "../gr_copy.s"
.include "../hgr_routines/hgr_copy.s"

;.include "../wait.s"
.include "../wait_a_bit.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"

robe_sprite_data:
        .incbin "../sprites_peasant/robe_sprites.zx02"

.include "graphics_haystack/haystack_graphics.inc"
.include "graphics_haystack/haystack_priority.inc"

haystack_text_zx02:
.incbin "../text/DIALOG_HAYSTACK.ZX02"

.include "haystack_actions.s"
