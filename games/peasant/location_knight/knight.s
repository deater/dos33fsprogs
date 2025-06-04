; Peasant's Quest

; Knight (location 4,2)

; by Vince `deater` Weaver	vince@deater.net

.include "../zp.inc"
.include "../hardware.inc"

.include "../peasant_sprite.inc"
.include "../qload.inc"
.include "../inventory/inventory.inc"
.include "../parse_input.inc"
.include "../common_defines.inc"

LOCATION_BASE   = LOCATION_MOUNTAIN_PASS	; index starts here (9)


peasantry_knight:

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME
	sta	FLAME_COUNT

	jsr	hgr_make_tables		; necessary?

	;===============================
	; decompress dialog to $D000

	lda	#<knight_text_zx02
        sta     zx_src_l+1
        lda     #>knight_text_zx02
        sta     zx_src_h+1

        lda     #$D0

        jsr     zx02_full_decomp

	;================================
	; update score

	jsr	update_score


	;=============================
	;=============================
	; new screen location
	;=============================
	;=============================

new_location:
	lda	#0
	sta	LEVEL_OVER

	;==========================
	; load updated verb table

        ; setup default verb table

        jsr     setup_default_verb_table

	lda	#<mountain_pass_verb_table	; 9	-- knight
	sta	INL
	lda	#>mountain_pass_verb_table	; 9	-- knight
	sta	INH

	jsr	load_custom_verb_table

	;============================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<knight_priority_zx02
	sta	zx_src_l+1
	lda	#>knight_priority_zx02
	sta	zx_src_h+1

	lda	#$20			; temporarily load to $2000

	jsr	zx02_full_decomp

	jsr	gr_copy_to_page1	; copy to $400

	; copy collision detection info

	ldx     #0
col_copy_loop:
	lda	$2400,X
	sta	collision_location,X
	inx
	bne	col_copy_loop


	;=====================
	; load bg

	lda	#<knight_zx02		; 9	-- knight
	sta	zx_src_l+1
	lda	#>knight_zx02		; 9	-- knight
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	; copy to $4000

	jsr	hgr_copy

	;=======================
	; put peasant text

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	;=======================
	; put score

	jsr	print_score

	;=======================
	; always activate text

	jsr	setup_prompt

	;========================
	; Load Peasant Sprites
	;========================

	lda	#<robe_sprite_data
	sta	zx_src_l+1
	lda	#>robe_sprite_data
	sta	zx_src_h+1

	lda	#$a0

	jsr	zx02_full_decomp


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
	; increment flame

	jsr	increment_flame


	;====================
	; check keyboard

	; original code also waited approximately 100ms?
	; this led to keypressed being lost

	lda	PEASANT_DIR
	sta	OLD_DIR

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

	jsr	wait_vblank

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

;.include "../peasant_common.s"
;.include "../move_peasant.s"
;.include "../draw_peasant.s"

.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"
.include "../hgr_routines/hgr_partial_restore.s"
.include "../hgr_routines/hgr_sprite.s"

.include "../wait.s"
.include "../wait_a_bit.s"


.include "../location_common/flame_common.s"

.include "../gr_copy.s"
.include "../hgr_routines/hgr_copy.s"

.include "../new_map_location.s"

.include "../keyboard.s"


.include "../vblank.s"

robe_sprite_data:
        .incbin "../sprites_peasant/robe_sprites.zx02"

.include "graphics_knight/knight_graphics.inc"
.include "graphics_knight/knight_priority.inc"

knight_text_zx02:
.incbin "../text/DIALOG_KNIGHT.ZX02"

.include "knight_actions.s"
