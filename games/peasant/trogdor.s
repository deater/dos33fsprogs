; Peasant's Quest Trgodor scene

; The inner sanctum

; by Vince `deater` Weaver	vince@deater.net

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"
.include "parse_input.inc"

LOCATION_BASE = LOCATION_TROGDOR_LAIR	; 23

trogdor:
	lda	#0
	sta	LEVEL_OVER
	sta	FRAME

	jsr	hgr_make_tables		; needed?
	jsr	hgr2			; needed?

	; decompress dialog to $D000

	lda	#<trogdor_text_zx02
	sta	zx_src_l+1
	lda	#>trogdor_text_zx02
	sta	zx_src_h+1

	lda	#$d0
	jsr	zx02_full_decomp

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
	sta	FRAME

	;==========================
	; load updated verb table

	; setup default verb table

	jsr	setup_default_verb_table

	; local verb table

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	verb_tables_low,X
	sta	INL
	lda	verb_tables_hi,X
	sta	INH
	jsr	load_custom_verb_table


	;========================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_priority_low,X
	sta	zx_src_l+1
	lda	map_priority_hi,X
	sta	zx_src_h+1

	lda	#$20			; temporarily load to $2000

	jsr	zx02_full_decomp

	; copy to $400

	jsr	gr_copy_to_page1


	;=====================
	; load bg

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_backgrounds_low,X
	sta	zx_src_l+1
	lda	map_backgrounds_hi,X
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	hgr_copy

	;=====================
	; update name/score

	jsr	update_top

	;====================
	; save background

	lda	PEASANT_X
	sta	CURSOR_X
	lda	PEASANT_Y
	sta	CURSOR_Y

	;=======================
	; draw initial peasant

;	jsr	save_bg_1x5

	jsr	draw_peasant_tiny


	;===========================
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

	;===================
	; move peasant

	jsr	move_peasant_tiny

	;===================
	; always draw peasant

	jsr	draw_peasant_tiny

	;====================
	; increment frame

	inc	FRAME

	;====================
	; check keyboard

	jsr	check_keyboard

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


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

	lda	#200
	jsr	wait

	jmp	game_loop


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


.include "move_peasant_tiny.s"
.include "draw_peasant_tiny.s"
;.include "hgr_1x5_save_bg.s"

.include "gr_copy.s"
.include "hgr_copy.s"

.include "keyboard.s"
.include "wait.s"
.include "wait_a_bit.s"

.include "version.inc"

.include "speaker_beeps.inc"

.include "hgr_sprite.s"

.include "ssi263_simple_speech.s"
.include "trogdor_speech.s"

.include "graphics_trogdor/trogdor_graphics.inc"

.include "graphics_trogdor/priority_trogdor.inc"

.include "sprites/trogdor_sprites.inc"


update_top:
        ; put peasant text

        lda     #<peasant_text
        sta     OUTL
        lda     #>peasant_text
        sta     OUTH

        jsr     hgr_put_string

        ; put score

        jsr     print_score

        rts


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


trogdor_text_zx02:
.incbin "DIALOG_TROGDOR.ZX02"

.include "trogdor_actions.s"
