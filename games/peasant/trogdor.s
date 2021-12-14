; Peasant's Quest Trgodor scene

; From when the sword hits Trogdor on

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

	lda	#<trogdor_text_lzsa
	sta	getsrc_smc+1
	lda	#>trogdor_text_lzsa
	sta	getsrc_smc+2

	lda	#$d0
	jsr	decompress_lzsa2_fast

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

	;=====================
	; load bg

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_backgrounds_low,X
	sta	getsrc_smc+1
	lda	map_backgrounds_hi,X
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_priority_low,X
	sta	getsrc_smc+1
	lda	map_priority_hi,X
	sta	getsrc_smc+2

	lda	#$20			; temporarily load to $2000

	jsr	decompress_lzsa2_fast

	; copy to $400

	jsr	gr_copy_to_page1

	; update name/score

	jsr	update_top


	;===========================
	; intro message

	ldx	#<trogdor_entry_message
	ldy	#>trogdor_entry_message
	jsr	finish_parse_message

game_loop:
;	jsr	move_peasant

	inc	FRAME

	jsr	check_keyboard

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over

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



;.include "decompress_fast_v2.s"
;.include "wait_keypress.s"
;.include "hgr_font.s"
;.include "draw_box.s"
;.include "hgr_rectangle.s"
;.include "hgr_1x5_sprite.s"
;.include "draw_peasant.s"
;.include "hgr_7x28_sprite_mask.s"
;.include "hgr_save_restore.s"
;.include "hgr_partial_save.s"
;.include "hgr_input.s"
;.include "hgr_tables.s"
;.include "hgr_text_box.s"
;.include "clear_bottom.s"
;.include "gr_offsets.s"
;.include "hgr_hgr2.s"
;.include "score.s"

.include "gr_copy.s"

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

;trogdor_string:
;	.byte   0,43,32, 0,253,82
;	.byte   8,41
;	.byte 34,"I can honestly say it'll",13
;	.byte "be a pleasure and an honor",13
;	.byte "to burninate you, Rather",13
;	.byte "Dashing.",34,0

;trogdor_string2:
;	.byte   0,43,32, 0,253,66
;	.byte   8,41
;	.byte "Aw that sure was nice of",13
;	.byte "him!",0

;trogdor_string3:
;	.byte   0,43,32, 0,253,90
;	.byte   8,41
;	.byte "Congratulations! You've",13
;	.byte "won! No one can kill",13
;	.byte "Trogdor but you came closer",13
;	.byte "than anybody ever! Way to",13
;	.byte "go!",0


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
	.byte   <trogdor_sleep_lzsa

map_backgrounds_hi:
	.byte   >trogdor_sleep_lzsa

map_priority_low:
	.byte   <trogdor_priority_lzsa

map_priority_hi:
	.byte   >trogdor_priority_lzsa

verb_tables_low:
	.byte   <trogdor_inner_verb_table

verb_tables_hi:
	.byte   >trogdor_inner_verb_table


trogdor_text_lzsa:
.incbin "DIALOG_TROGDOR.LZSA"

.include "trogdor_actions.s"
