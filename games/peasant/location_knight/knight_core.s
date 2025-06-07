; Peasant's Quest

; Knight (location 4,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = mountain_pass_verb_table





        ;=======================
	; draw header offscreen
	;=======================

	lda	DRAW_PAGE
	pha

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

        ; put peasant text

        lda     #<peasant_text
        sta     OUTL
        lda     #>peasant_text
        sta     OUTH

        jsr     hgr_put_string

	; update / print score

	jsr	update_score

	jsr	print_score

	; show prompt

	jsr	setup_prompt


	pla
	sta	DRAW_PAGE



	;====================================
	; check if allowed to be in haystack

	jsr	check_haystack_exit


	;==========================
	; load updated verb table

	; setup default verb table

	jsr     setup_default_verb_table

	lda	#<VERB_TABLE
	sta	INL
	lda	#>VERB_TABLE
	sta	INH

	jsr	load_custom_verb_table


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

	;====================
	; increment flame

	jsr	increment_flame


	;====================
	; check keyboard

	; original code also waited approximately 100ms?
	; this led to keypressed being lost

	lda	PEASANT_DIR
	sta	OLD_DIR
;	lda	#13
;	lda	#1
;	sta	WAIT_LOOP
wait_loop:

	jsr	check_keyboard


;	lda	#50	; approx 7ms
;	jsr	wait
;	dec	WAIT_LOOP
;	bne	wait_loop

	jsr	hgr_page_flip

	;=====================
	; delay
;	jsr	wait_vblank

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


.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"

.include "knight_actions.s"

;.include "../hgr_routines/hgr_page_flip.s"
.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"
