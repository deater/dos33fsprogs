; Peasant's Quest

; Inn Graphics

;	a lot happens at the Inn

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"
.include "parse_input.inc"

LOCATION_BASE	= LOCATION_INSIDE_INN		; index starts here (27)

inside_inn:

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME

	jsr	hgr_make_tables		; necessary?
;	jsr	hgr2			; necessary?

	; decompress dialog to $D000

	lda	#<inn_text_lzsa
        sta     getsrc_smc+1
        lda     #>inn_text_lzsa
        sta     getsrc_smc+2

        lda     #$D0

        jsr     decompress_lzsa2_fast

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
	;==========================

	; setup default verb table

	jsr	setup_default_verb_table


	; we are INSIDE so locations 24...26 map to 0...2

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	verb_tables_low,X
	sta	INL
	lda	verb_tables_hi,X
	sta	INH
	jsr	load_custom_verb_table

	;===========================
	; load priority

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_priority_low,X
	sta	getsrc_smc+1
	lda	map_priority_hi,X
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_page1

	;=====================
	; load bg

	; we are INSIDE so locations 24...26 map to 0...2

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_backgrounds_low,X
	sta	getsrc_smc+1

	lda	map_backgrounds_hi,X
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast

	jsr	hgr_copy



	; put peasant text

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	; put score

	jsr	print_score

	;====================
	; save background

;	lda	PEASANT_X
;	sta	CURSOR_X
;	lda	PEASANT_Y
;	sta	CURSOR_Y

	;=======================
	; draw initial peasant

;	jsr	save_bg_1x28

;	jsr	draw_peasant

	;===========================
	;===========================
	;===========================
	; main loop
	;===========================
	;===========================
	;===========================

game_loop:

	;========================
	; move the peasant

	jsr	move_peasant

	;========================
	; draw the peasant

	jsr	draw_peasant

	;========================
	; increment the frame

	inc	FRAME

	;========================
	; check the keyboard

	jsr	check_keyboard

	;=====================
	; level specific
	;=====================

	lda	MAP_LOCATION
	cmp	#LOCATION_INSIDE_INN
	bne	skip_level_specific

exit_inside_inn:
	; check if leaving

	lda	PEASANT_Y
	cmp	#$95
	bcc	skip_level_specific

	; we're exiting, print proper message

;	lda	INVENTORY_2
;	and	#INV2_TRINKET
;	bne	after_trinket_message

;	lda	INVENTORY_2_GONE
;	and	#INV2_TRINKET
;	bne	after_trinket_message


;before_trinket_message:
;	ldx	#<inside_cottage_leaving_message
;	ldy	#>inside_cottage_leaving_message
;	jsr	finish_parse_message
;	jmp	done_trinket_message

;after_trinket_message:
;	ldx	#<inside_cottage_leaving_post_trinket_message
;	ldy	#>inside_cottage_leaving_post_trinket_message
;	jsr	finish_parse_message

done_trinket_message:

	; put outside door
	lda	#$9
	sta	PEASANT_X
	lda	#$69
	sta	PEASANT_Y

	; stop walking
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD


	; move back

	lda     #LOCATION_OUTSIDE_INN
	jsr	update_map_location


skip_level_specific:

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over


	; delay

	lda	#200
	jsr	wait


	jmp	game_loop

oops_new_location:
	jmp	new_location


	;========================
	; exit level
	;========================
level_over:

	rts


.include "move_peasant.s"
.include "draw_peasant.s"

.include "gr_copy.s"
.include "hgr_copy.s"

.include "new_map_location.s"

.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "graphics_inn/graphics_inn.inc"
.include "graphics_inn/priority_inn.inc"





map_backgrounds_low:
	.byte	<inside_inn_lzsa

map_backgrounds_hi:
	.byte	>inside_inn_lzsa

map_priority_low:
	.byte	<inside_inn_priority_lzsa

map_priority_hi:
	.byte	>inside_inn_priority_lzsa

verb_tables_low:
	.byte	<inside_inn_verb_table

verb_tables_hi:
	.byte	>inside_inn_verb_table



inn_text_lzsa:
.incbin "DIALOG_INN.LZSA"

.include "inn_actions.s"
