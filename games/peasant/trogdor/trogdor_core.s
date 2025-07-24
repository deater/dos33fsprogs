; Peasant's Quest Trgodor scene

; The inner sanctum

; by Vince `deater` Weaver	vince@deater.net

.include "../location_common/include_common.s"

VERB_TABLE = trogdor_inner_verb_table


trogdor:
	lda	#0
	sta	LEVEL_OVER
	sta	FRAME

.include "../location_common/common_core.s"


	;====================================================
	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	;====================
	; intro message

	ldx	#<trogdor_entry_message
	ldy	#>trogdor_entry_message
	jsr	finish_parse_message


	;==========================
	;==========================
	;==========================
	; main loop
	;==========================
	;==========================
	;==========================

game_loop:

	;====================
	; check keyboard

	jsr	check_keyboard

	;===================
	; move peasant

	jsr	move_peasant_tiny

	;======================
	; check if done level

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	;=====================
	; update screen

	jsr	update_screen


	;====================
	; increment frame

	inc	FRAME

	;====================
	; increment flame

	jsr	increment_flame

	;=====================
	; flip page

;	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	game_loop



	;=======================
	; exit level
	;======================

oops_new_location:
level_over:

	; go to end credits

	lda     #LOAD_ENDING
        sta     WHICH_LOAD

        rts

erase_sprite_x:
.byte 18,18, 22, 18, 18,18
erase_sprite_y:
.byte 80,80,146,130,108,95
erase_sprite_l:
.byte <smoke1_sprite		; erase smoke5
.byte <smoke1_sprite		; do nothing
.byte <sleep1_sprite		; erase sleep2
.byte <smoke1_sprite		; erase smoke2
.byte <smoke1_sprite		; erase smoke3
.byte <smoke1_sprite		; erase smoke4
erase_sprite_h:
.byte >smoke1_sprite		; erase smoke5
.byte >smoke1_sprite		; do nothing
.byte >sleep1_sprite		; erase sleep2
.byte >smoke1_sprite		; erase smoke2
.byte >smoke1_sprite		; erase smoke3
.byte >smoke1_sprite		; erase smoke4


draw_sprite_x:
.byte  22, 22, 18, 18,18,18
draw_sprite_y:
.byte 146,146,130,108,95,80
draw_sprite_l:
.byte <sleep1_sprite		; do nothing
.byte <sleep2_sprite		; draw open mouth
.byte <smoke2_sprite		; draw smoke2
.byte <smoke3_sprite		; draw smoke3
.byte <smoke4_sprite		; draw smoke4
.byte <smoke5_sprite		; draw smoke5
draw_sprite_h:
.byte >sleep1_sprite
.byte >sleep2_sprite
.byte >smoke2_sprite
.byte >smoke3_sprite
.byte >smoke4_sprite
.byte >smoke5_sprite


; include bottom.s

.include "move_peasant_tiny.s"
.include "draw_peasant_tiny.s"

.include "../hgr_routines/hgr_sprite_bg_mask.s"
;.include "../gr_offsets.s"

.include "../location_common/peasant_common.s"
.include "../location_common/flame_common.s"

;.include "../new_map_location.s"

.include "../keyboard.s"

.include "../vblank.s"


; end include_bottom.s



;.include "../gr_copy.s"
.include "../hgr_routines/hgr_copy_fast.s"

.include "../wait_a_bit.s"


.include "../hgr_routines/hgr_sprite.s"

.include "../ssi263/ssi263_simple_speech.s"
.include "trogdor_speech.s"

;.include "graphics_trogdor/trogdor_graphics.inc"
;.include "graphics_trogdor/priority_trogdor.inc"

.include "sprites_trogdor/trogdor_sprites.inc"

.if 0
map_backgrounds_low:
	.byte   <trogdor_sleep_zx02

map_backgrounds_hi:
	.byte   >trogdor_sleep_zx02

map_priority_low:
	.byte   <trogdor_priority_zx02

map_priority_hi:
	.byte   >trogdor_priority_zx02

verb_tables_low:
	.byte   <trogdor_inner_verb_table

verb_tables_hi:
	.byte   >trogdor_inner_verb_table

.endif

;trogdor_text_zx02:
;.incbin "../text/DIALOG_TROGDOR.ZX02"

.include "trogdor_actions.s"





update_screen:

	;==========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	;===================
	; always draw peasant

	jsr	draw_peasant_tiny


	; draw sleeping trogdor
	; actual:
	; 	16 frames of nothing
	; 	17 - open mouth
	; 	60 - close mouth, puff1
	; 	64 puff2, 68 puff3, 72 puff4
	;	76 puff5, 80 puff6, 84 nothing
	; ours:
	;	16 frames of nothing
	;	17 open mouth
	;	48 puff2, 52 puff3, 56 puff4 60 puff5

	ldx	#0
	lda	FRAME		; mask off at 64
	and	#$3f
	beq	draw_sleep_sprites
	inx	; 1
	cmp	#17
	beq	draw_sleep_sprites
	inx	; 2
	cmp	#48
	beq	draw_sleep_sprites
	inx	; 3
	cmp	#52
	beq	draw_sleep_sprites
	inx	; 4
	cmp	#56
	beq	draw_sleep_sprites
	inx	; 5
	cmp	#60
	beq	draw_sleep_sprites
	bne	no_sleeping

draw_sleep_sprites:

	lda	erase_sprite_x,X
	sta	CURSOR_X
	lda	erase_sprite_y,X
	sta	CURSOR_Y
	lda	erase_sprite_l,X
	sta	INL
	lda	erase_sprite_h,X
	sta	INH

	txa
	pha

	jsr	hgr_draw_sprite

	pla
	tax

	lda	draw_sprite_x,X
	sta	CURSOR_X
	lda	draw_sprite_y,X
	sta	CURSOR_Y
	lda	draw_sprite_l,X
	sta	INL
	lda	draw_sprite_h,X
	sta	INH
	jsr	hgr_draw_sprite

no_sleeping:

	; delay

;	lda	#200
;	jsr	wait

;	jmp	game_loop

	rts
