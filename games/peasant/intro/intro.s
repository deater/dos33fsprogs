; Peasant's Quest Intro Sequence

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "../hardware.inc"
.include "../zp.inc"
.include "../common_defines.inc"

.include "../qload.inc"
.include "../music/music.inc"
.include "../peasant_sprite.inc"

DEFAULT_WAIT = 1	; was 3 before we changed background copy?

peasant_quest_intro:

	; we get here from "tips"
	; DRAW_PAGE = PAGE2
	; looking at PAGE1

	lda	#0
	sta	ESC_PRESSED
	sta	LEVEL_OVER
	sta	PEASANT_STEPS
	sta	INPUT_X
	sta     input_buffer	; reset buffer (NUL at start)
				; ????
	sta	GAME_STATE_2


	;==============================
	; load sprite data
	;==============================

	;==============================
        ; load initial peasant sprites

        ; loads temporarily in $6000

        lda     #0				; FIXME: default walking
        jsr     load_peasant_sprites


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

;	jsr	draw_peasant

	; wait a bit

;	lda	#10
;	jsr	wait_a_bit

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

.include "../hgr_routines/hgr_sprite.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"

.include "../wait_a_bit.s"

.include "../priority_copy.s"


cottage_zx02:	.incbin "../location_cottage/graphics_cottage/cottage.zx02"
lake_w_zx02:	.incbin "../location_lake_west/graphics_lake_west/lake_w.zx02"
lake_e_zx02:	.incbin "../location_lake_east/graphics_lake_east/lake_e.zx02"
river_zx02:	.incbin "../location_river/graphics_river/river.zx02"
;knight_zx02:	.incbin "../location_knight/graphics_knight/knight.zx02"
; now in MUSIC

cottage_priority_zx02:	.incbin "../location_cottage/graphics_cottage/cottage_priority.zx02"
lake_w_priority_zx02:	.incbin "../location_lake_west/graphics_lake_west/lake_w_priority.zx02"
lake_e_priority_zx02:	.incbin "../location_lake_east/graphics_lake_east/lake_e_priority.zx02"
river_priority_zx02:	.incbin "../location_river/graphics_river/river_priority.zx02"
knight_priority_zx02:	.incbin "../location_knight/graphics_knight/knight_priority.zx02"

.include "../text/intro.inc"

.include "../location_lake_east/sprites_lake_east/bubble_sprites_e.inc"
.include "../location_lake_west/sprites_lake_west/bubble_sprites_w.inc"


.include "animate_bubbles.s"
.include "../location_river/animate_river.s"

skip_text:
        .byte 0,2,"ESC Skips",0

	;===================
        ; print title
	;===================
	; print to $6000 area
intro_print_title:

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	lda	#<skip_text
	sta	OUTL
	lda	#>skip_text
	sta	OUTH

	jsr	hgr_put_string

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

	rts


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

	rts



	;================================
	; intro drain keyboard buffer
	;================================
	; because hgr_copy_faster isn't really
intro_drain_keyboard_buffer:
	ldx	KEY_OFFSET
	beq	done_intro_drain_keyboard_buffer

	ldx	#0

intro_drain_keyboard_buffer_loop:
	txa
	pha

	lda	keyboard_buffer,X
	and	#$7f
	cmp	#27
	bne	idk_not_esc

	inc	ESC_PRESSED

idk_not_esc:

	pla
	tax
	inx
	cpx	KEY_OFFSET
	bne	intro_drain_keyboard_buffer_loop

done_intro_drain_keyboard_buffer:
	ldx	#0		; reset
	stx	KEY_OFFSET
	rts

