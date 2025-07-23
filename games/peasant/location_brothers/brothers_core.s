; Peasant's Quest

; Archery / Brothers (Location 3,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE=archery_verb_table

peasantry_brothers_core:

.include "../location_common/common_core.s"

	;============================================
	; check if coming back from archery minigame
	;============================================

	lda	ARROW_SCORE
	bpl	not_from_archery

	jsr	handle_archery_return

not_from_archery:


	;==================================
	; add dongolev to priority map if needed
	;==================================

	jsr priority_add_dongolev

	;===================================
	; mark location visited

	lda	VISITED_1
	ora	#MAP_ARCHERY
	sta	VISITED_1


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
	;=======================
	; check keyboard

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
	;=====================



	;=====================
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


.include "../hgr_routines/hgr_sprite.s"
.include "../location_common/include_bottom.s"
.include "draw_brothers.s"
.include "brothers_actions.s"
.include "sprites_brothers/archery_sprites.inc"


	;========================
	; update screen
	;========================
update_screen:
	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	;=======================
	; archery animations
	;=======================

	jsr	animate_brothers

	;====================
	; always draw peasant

	jsr	draw_peasant

	rts



	;================================
	;================================
	; coming back from archery game
	;================================
	;================================

handle_archery_return:

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

	rts


