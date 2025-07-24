; Peasant's Quest

; Inside Inn (Night)

;	a lot happens at the Inn (at night)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = inside_inn_night_verb_table

inside_inn_core:

.include "../location_common/common_core.s"

	;====================================================
        ; clear the keyboard in case we were holding it down

	bit	KEYRESET


	;======================================
	; special case coming in from sleeping

	lda	GAME_STATE_3
	and	#ASLEEP
	beq	not_asleep


	;====================================
	; do wipe in reverse

	; peasant is on bed facing up
	; roll around a bit

	jsr	roll_in_bed

	; UP->LEFT_>UP->RIGHT->up->left->up

	; gets out of bed and stands, facing left

	ldx	#32
	stx	PEASANT_X
	ldy	#98
	sty	PEASANT_Y
	lda	#PEASANT_DIR_LEFT
	sta	PEASANT_DIR

	; what an uncomfortable bed...
	ldx	#<inside_inn_get_room3_message
	ldy	#>inside_inn_get_room3_message
	jsr	finish_parse_message

	; wake up

	lda	GAME_STATE_3
	and	#<(~ASLEEP)
	sta	GAME_STATE_3

not_asleep:

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

.include "inside_inn_night_actions.s"
.include "wipe_center.s"

.include "../hgr_routines/hgr_sprite.s"
.include "sprites_inside_inn_night/sleep_sprites.inc"


	;==========================
	; update screen
	;==========================
update_screen:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	;========================
	; always draw the peasant

	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_PEASANT
	bne	done_suppress_peasant

	jsr	draw_peasant
done_suppress_peasant:

	rts


	;==============================
	;==============================
	; roll in bed
	;==============================
	;==============================
roll_in_bed:
	; UP->LEFT_>UP->RIGHT->up->left->up

	lda	#0
	sta	FRAME

	lda	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

	lda	#$20		; draw to page2
	sta	DRAW_PAGE
	bit	PAGE1		; page1 should be clear?

roll_in_bed_loop:

	;========================
	; update screen

	jsr	update_screen

	;=========================
	; draw peasant

	lda	FRAME
	lsr
	lsr
	lsr	; slow down a bit
	tay

	ldx	roll_in_bed_pattern,Y
	bmi	done_peasant_sleep

	lda	sleep_sprite_l,X
	sta	INL
	lda	sleep_sprite_h,X
	sta	INH

	lda	#32			; 224/7 = 32
	sta	CURSOR_X
	lda	#131
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	;===========================
	; special case if FRAME<16

	lda	FRAME
	cmp	#16
	bcs	skip_wipe

	;=====================
	; do reverse wipe

	jsr	wipe_center_to_scene

skip_wipe:

	jsr	hgr_page_flip

	inc	FRAME

	jmp	roll_in_bed_loop

done_peasant_sleep:

	lda	#0
	sta	SUPPRESS_DRAWING

	rts


roll_in_bed_pattern:
	.byte 0,1,0,2,0,1,0,2,0,$FF


sleep_sprite_l:
	.byte <sleep0,<sleep1,<sleep2

sleep_sprite_h:
	.byte >sleep0,>sleep1,>sleep2
