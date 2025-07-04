; Peasant's Quest

; Wavy Tree and Ned (location 2,4)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = ned_verb_table

lady_cottage_core:

.include "../location_common/common_core.s"


	;======================
	; init ned
	;	randomly waits 126-64 frames

	jsr	random8
	and	#$3f

;	lda	#64
	sta	NED_STATUS


	;===================================
	; mark location visited

	lda	VISITED_3
	ora	#MAP_WAVY_TREE
	sta	VISITED_3


	;====================================================
	; clear the keyboard in case we were holding it down

	bit     KEYRESET

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


	;===================
	; update screen

	jsr	update_screen


	;====================
	; increment frame

	inc	FRAME

	;====================
	; increment flame

	jsr	increment_flame


	;=====================
	; check keyboard

	jsr	check_keyboard



	;=====================
	; flip page


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

	;===============================
	; handle end of level
	;===============================

.include "../location_common/end_of_level_common.s"

	;======================================
	; special case leaving-level borders

.include "borders.s"

really_level_over:
	rts


	;======================
	; handle ned
	;======================
handle_ned:

	;====================
	; update ned status

	; if 0 or 128, do nothing

	lda	NED_STATUS
	beq	leave_ned_alone
	cmp	#128
	beq	leave_ned_alone

	inc	NED_STATUS

leave_ned_alone:

	lda	NED_STATUS		; check status
	beq	ned_erase_bg		; special case, erase if just hit 0

	cmp	#125
	bcc	no_draw_ned		;  blt, don't draw

	cmp	#128			; don't erase if fully out
	beq	no_draw_ned

	; erase by copying from background
ned_erase_bg:
;	lda	#81
;	sta	SAVED_Y1
;	lda	#114
;	sta	SAVED_Y2

;	lda	#25
;	ldx	#30
;	jsr	hgr_partial_restore

	; 125,255 draw ned1 sprite
	; 126,254 draw ned2 sprite
	; 127 draw ned3 sprite
	lda	NED_STATUS
	cmp	#127
	beq	draw_ned_out

	cmp	#125
	beq	draw_ned_hands
	cmp	#255
	beq	draw_ned_hands

	cmp	#126
	beq	draw_ned_half
	cmp	#254
	beq	draw_ned_half

	bne	no_draw_ned		; not out so don't draw

draw_ned_hands:
	lda	#28
	sta	CURSOR_X
	lda	#96
	sta	CURSOR_Y

	lda	#<ned1_sprite
	sta	INL
	lda	#>ned1_sprite
	jmp	draw_ned_common

draw_ned_half:
	lda	#28
	sta	CURSOR_X
	lda	#81
	sta	CURSOR_Y

	lda	#<ned2_sprite
	sta	INL
	lda	#>ned2_sprite
	jmp	draw_ned_common

draw_ned_out:
	lda	#25
	sta	CURSOR_X
	lda	#88
	sta	CURSOR_Y

	lda	#<ned3_sprite
	sta	INL
	lda	#>ned3_sprite
draw_ned_common:

	sta	INH

	jsr	hgr_draw_sprite

no_draw_ned:
	rts


.include "../location_common/include_bottom.s"

.include "wavy_tree_actions.s"

.include "../hgr_routines/hgr_sprite.s"

.include "sprites_wavy_tree/ned_sprites.inc"

	;=====================
	; update screen
	;=====================
update_screen:

	;===========================
	; copy bg to current screen

;	lda	#$60
	jsr	hgr_copy_faster

	;=====================
	; always draw peasant

	jsr	draw_peasant

	;==========================
	; draw ned if necessary
	;==========================

	jsr	handle_ned

	rts
