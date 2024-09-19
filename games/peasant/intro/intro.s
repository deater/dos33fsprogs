; Peasant's Quest Intro Sequence

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "../hardware.inc"
.include "../zp.inc"

.include "../qload.inc"
.include "../music/music.inc"

peasant_quest_intro:

	lda	#0
	sta	ESC_PRESSED
	sta	LEVEL_OVER
	sta	PEASANT_STEPS
	sta	GAME_STATE_2

	jsr	hgr_make_tables

	jsr	hgr2

	;==============================
	; load sprite data
	;==============================

	lda	#<walking_sprite_data
	sta	zx_src_l+1
	lda	#>walking_sprite_data
	sta	zx_src_h+1

	lda	#$A0                    ; load to $A000

	jsr	zx02_full_decomp


	;===============================
	; restart music, only drum loop
	;===============================

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	mockingboard_notfound

	; hack! modify the PT3 file to ignore the latter half

	lda	#$ff			; end after 4 patterns
	sta	PT3_LOC+$C9+$4

	lda	#$0			; set LOOP to 0
	sta	PT3_LOC+$66

	jsr	pt3_init_song

	cli
mockingboard_notfound:

	;========================
	; Cottage
	;========================

	jsr	intro_cottage

	lda	ESC_PRESSED
	bne	escape_handler

	;========================
	; Lake West
	;========================

	jsr	intro_lake_west

	lda	ESC_PRESSED
	bne	escape_handler

	;========================
	; Lake East
	;========================

	jsr	intro_lake_east

	lda	ESC_PRESSED
	bne	escape_handler

	;========================
	; River
	;========================

	jsr	intro_river

	lda	ESC_PRESSED
	bne	escape_handler

	;========================
	; Knight
	;========================

	jsr	intro_knight

	;========================
	; Start actual game
	;========================

	jsr	draw_peasant

	; wait a bit

	lda	#10
	jsr	wait_a_bit

escape_handler:

	;==========================
	; disable music

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	mockingboard_notfound2

	sei				; turn off music
	jsr	clear_ay_both		; clear AY state

	jsr	mockingboard_disable_interrupt
mockingboard_notfound2:



	;=============================
	; start new game
	;=============================

	; just fall on through...

;	jmp	start_new_game


.include "new_game.s"

.include "intro_cottage.s"
.include "intro_lake_w.s"
.include "intro_lake_e.s"
.include "intro_river.s"
.include "intro_knight.s"

.include "../draw_peasant_new.s"

.include "../hgr_1x5_sprite.s"

.include "../hgr_sprite.s"

.include "../hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"
.include "../hgr_partial_restore.s"

.include "../gr_copy.s"
.include "../hgr_copy.s"

.include "../wait.s"
.include "../wait_a_bit.s"




cottage_zx02:	.incbin "../graphics_peasantry/cottage.zx02"
lake_w_zx02:	.incbin "../graphics_peasantry/lake_w.zx02"
lake_e_zx02:	.incbin "../graphics_peasantry/lake_e.zx02"
river_zx02:	.incbin "../graphics_peasantry/river.zx02"
knight_zx02:	.incbin "../graphics_peasantry/knight.zx02"

cottage_priority_zx02:	.incbin "../graphics_peasantry/cottage_priority.zx02"
lake_w_priority_zx02:	.incbin "../graphics_peasantry/lake_w_priority.zx02"
lake_e_priority_zx02:	.incbin "../graphics_peasantry/lake_e_priority.zx02"
river_priority_zx02:	.incbin "../graphics_peasantry/river_priority.zx02"
knight_priority_zx02:	.incbin "../graphics_peasantry/knight_priority.zx02"

.include "../text/intro.inc"

.include "../animate_bubbles.s"

skip_text:
        .byte 0,2,"ESC Skips",0

	;===================
        ; print title
intro_print_title:
	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	lda	#<skip_text
	sta	OUTL
	lda	#>skip_text
	sta	OUTH

	jmp	hgr_put_string		; tail call


	; background restore parameters
	; currently 5, should check this and error if we overflow

save_xstart:
	.byte   0, 0, 0, 0, 0, 0
save_xend:
	.byte   0, 0, 0, 0, 0, 0
save_ystart:
	.byte   0, 0, 0, 0, 0, 0
save_yend:
	.byte   0, 0, 0, 0, 0, 0

walking_sprite_data:
	.incbin "../sprites_peasant/walking_sprites.zx02"

peasant_sprite_offset = $a000

peasant_sprites_xsize = peasant_sprite_offset+0
peasant_sprites_ysize = peasant_sprite_offset+36
peasant_sprites_data_l = peasant_sprite_offset+72
peasant_sprites_data_h = peasant_sprite_offset+108
peasant_mask_data_l = peasant_sprite_offset+144
peasant_mask_data_h = peasant_sprite_offset+180
