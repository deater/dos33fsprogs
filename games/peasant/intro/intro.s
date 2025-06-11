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
	sta	INPUT_X
	sta     input_buffer	; reset buffer (NUL at start)
	sta	GAME_STATE_2

	jsr	hgr_make_tables

	jsr	hgr2

	lda	#$20		; draw to page2
	sta	DRAW_PAGE


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

;.include "../hgr_routines/hgr_1x5_sprite.s"

.include "../hgr_routines/hgr_sprite.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"
.include "../hgr_routines/hgr_partial_restore.s"
;.include "../hgr_routines/hgr_partial_save.s"

.include "../gr_copy.s"
.include "../hgr_routines/hgr_copy_fast.s"

;.include "../wait.s"
.include "../wait_a_bit.s"




cottage_zx02:	.incbin "../location_cottage/graphics_cottage/cottage.zx02"
lake_w_zx02:	.incbin "../location_lake_west/graphics_lake_west/lake_w.zx02"
lake_e_zx02:	.incbin "../location_lake_east/graphics_lake_east/lake_e.zx02"
river_zx02:	.incbin "../location_river/graphics_river/river.zx02"
knight_zx02:	.incbin "../location_knight/graphics_knight/knight.zx02"

cottage_priority_zx02:	.incbin "../location_cottage/graphics_cottage/cottage_priority.zx02"
lake_w_priority_zx02:	.incbin "../location_lake_west/graphics_lake_west/lake_w_priority.zx02"
lake_e_priority_zx02:	.incbin "../location_lake_east/graphics_lake_east/lake_e_priority.zx02"
river_priority_zx02:	.incbin "../location_river/graphics_river/river_priority.zx02"
knight_priority_zx02:	.incbin "../location_knight/graphics_knight/knight_priority.zx02"

.include "../text/intro.inc"

.include "../location_lake_east/sprites_lake_east/bubble_sprites_e.inc"
.include "../location_lake_west/sprites_lake_west/bubble_sprites_w.inc"


.include "animate_bubbles.s"

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


	;================================
	; really_move_peasant

really_move_peasant:

        ; increment step count, wrapping at 6

        inc     PEASANT_STEPS
        lda     PEASANT_STEPS
        cmp     #6
        bne     no_peasant_wrap
        lda     #0
        sta     PEASANT_STEPS

no_peasant_wrap:
        jsr     erase_peasant	; tail?
	rts


walking_sprite_data:
	.incbin "../sprites_peasant/walking_sprites.zx02"

.include "../peasant_sprite.inc"

