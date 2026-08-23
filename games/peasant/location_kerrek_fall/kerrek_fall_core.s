; Peasant's Quest

; Downfall of the Kerrek

; separate file as can't really fit all 22k of sprites
; in the normal space

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

;VERB_TABLE = kerrek_verb_table

kerrek_fall:

        ;=======================
	; load proper sprites
	;=======================

	jsr	load_shooting_sprites

	jsr	load_kerrek_walking_sprites

	jsr	load_kerrek_hit_sprites

        ;=======================
	; draw header offscreen
	;=======================

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

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


	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE


	;================================
	; setup pointer to update_screen

	lda	#<update_screen
	sta	update_screen_smc+1
	lda	#>update_screen
	sta	update_screen_smc+2




	;========================================
	;========================================
	;========================================
	; main loop
	;========================================
	;========================================
	;========================================

game_loop:

	jsr	draw_peasant_bow

.if 0
	;======================
	; check if level over

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

	;==========================
	; update screen


	jsr	update_screen


	;===========================
	; "move"

	jsr	kerrek_move

	;=======================
	; increment frame

	inc	FRAME

	;=======================
	; increment flame

	jsr	increment_flame


	;=======================
	; flip page

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop
.endif

;	lda	#LOCATION_KERREK_FALL
;	jsr	update_map_location


	;========================
	; exit level
	;========================
oops_new_location:
level_over:

	;===============================
	; handle end of level
	;===============================

.include "../location_common/end_of_level_common.s"


really_level_over:
	rts



.include "../location_common/include_bottom.s"

.include "../wait_a_bit.s"
.include "../hgr_routines/hgr_sprite.s"
.include "../hgr_routines/hgr_sprite_mask.s"
.include "kerrek_fall_actions.s"

.include "../sound/mud_splat.s"
.include "../sound/thunder.s"
.include "../sound/raise_up.s"
.include "../sound/falling.s"

;.include "sprites_kerrek_fall/kerrek_walk_sprites_right.inc"
;.include "sprites_kerrek_fall/kerrek_walk_sprites_left.inc"

;.include "sprites_kerrek_fall/kerrek_hit_sprites.inc"
;.include "sprites_kerrek_fall/peasant_shoot_sprites_left.inc"
;.include "sprites_kerrek_fall/peasant_shoot_sprites_right.inc"

.include "load_shooting_sprites.s"

	;==========================
	; update screen
	;==========================
update_screen:


	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	; peasant is ~30 tall, kerrek ~48 tall
	sec
	lda	PEASANT_Y
	sbc	#18
	cmp	KERREK_Y
	bcs	kerrek1_draw_kerrek_first

kerrek1_draw_peasant_first:

	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_PEASANT
	bne	skip_draw_peasant_first

	jsr	draw_peasant
skip_draw_peasant_first:
	jsr	kerrek_draw		; draw kerrek

	rts

kerrek1_draw_kerrek_first:

	jsr	kerrek_draw		; draw kerrek

	lda	SUPPRESS_DRAWING
	and	#SUPPRESS_PEASANT
	bne	skip_draw_peasant_second
	jsr	draw_peasant
skip_draw_peasant_second:

	rts



