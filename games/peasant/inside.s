; Peasant's Quest

; Inside Graphics

;	inside lady cottage, inside ned cottage, hidden glen

; by Vince `deater` Weaver	vince@deater.net

; with apologies to everyone

.include "hardware.inc"
.include "zp.inc"

.include "qload.inc"
.include "inventory.inc"
.include "parse_input.inc"

LOCATION_BASE	= LOCATION_HIDDEN_GLEN		; index starts here (24)

inside:

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME

	jsr	hgr_make_tables		; necessary?
;	jsr	hgr2			; necessary?

	; decompress dialog to $D000

	lda	#<inside_text_zx02
        sta     zx_src_l+1
        lda     #>inside_text_zx02
        sta     zx_src_h+1

        lda     #$D0

        jsr     zx02_full_decomp

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


	;======================
	; load priority to $400

	lda	MAP_LOCATION
	sec
	sbc	#LOCATION_BASE
	tax

	lda	map_priority_low,X
	sta	zx_src_l+1
	lda	map_priority_hi,X
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	jsr	gr_copy_to_page1


	;=====================
	; load bg

	; we are INSIDE so locations 24...26 map to 0...2

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


	;============================
	;============================
	;============================
	; main loop
	;============================
	;============================
	;============================

game_loop:

	;=====================
	; move peasant

	jsr	move_peasant

	;=====================
	; always draw peasant

	jsr	draw_peasant

	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; check keyboard

	jsr	check_keyboard

	;=====================
	; level specific
	;=====================

	lda	MAP_LOCATION
	cmp	#LOCATION_INSIDE_LADY
	beq	inside_lady_cottage
	cmp	#LOCATION_HIDDEN_GLEN
	beq	inside_hidden_glen
	cmp	#LOCATION_INSIDE_NN
	beq	inside_nn_cottage

	jmp	skip_level_specific

inside_nn_cottage:
	; check if leaving

	lda	PEASANT_Y
	cmp	#$95
	bcc	skip_level_specific

	; put outside door
	lda	#13
	sta	PEASANT_X
	lda	#$71
	sta	PEASANT_Y

	; stop walking
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD

	; move back

	lda     #LOCATION_OUTSIDE_NN
	jsr	update_map_location

	jmp	skip_level_specific

inside_lady_cottage:
	; check if leaving

	lda	PEASANT_Y
	cmp	#$95
	bcc	skip_level_specific

	; we're exiting, print proper message

	lda	INVENTORY_2
	and	#INV2_TRINKET
	bne	after_trinket_message

	lda	INVENTORY_2_GONE
	and	#INV2_TRINKET
	bne	after_trinket_message


before_trinket_message:
	ldx	#<inside_cottage_leaving_message
	ldy	#>inside_cottage_leaving_message
	jsr	finish_parse_message
	jmp	done_trinket_message

after_trinket_message:
	ldx	#<inside_cottage_leaving_post_trinket_message
	ldy	#>inside_cottage_leaving_post_trinket_message
	jsr	finish_parse_message

done_trinket_message:

	; put outside door
	lda	#$17
	sta	PEASANT_X
	lda	#$7D
	sta	PEASANT_Y

	; stop walking
	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD


	; move back

	lda     #LOCATION_OUTSIDE_LADY
	jsr	update_map_location

	jmp	skip_level_specific

inside_hidden_glen:

	;=====================================
	; check if in line of Dongolev's arrow

	; first check if he's there
	lda	GAME_STATE_0
	and	#HALDO_TO_DONGOLEV
	bne	skip_level_specific

	; check if in range
	lda	PEASANT_Y
	cmp	#$54
	bne	skip_level_specific

	; oops we're getting shot

	ldx	#<hidden_glen_walk_in_way_message
	ldy	#>hidden_glen_walk_in_way_message
	jsr	partial_message_step

	ldx	#<hidden_glen_walk_in_way_message2
	ldy	#>hidden_glen_walk_in_way_message2
	jsr	partial_message_step

	ldx	#<hidden_glen_walk_in_way_message3
	ldy	#>hidden_glen_walk_in_way_message3
	jsr	partial_message_step

	; this kills you
	lda	#LOAD_GAME_OVER
	sta	WHICH_LOAD

	lda	#NEW_FROM_DISK
	sta	LEVEL_OVER


	jmp	skip_level_specific


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

	cmp	#NEW_FROM_LOAD		; skip ahead if load from disk
	beq	really_level_over


	lda	MAP_LOCATION
	cmp	#LOCATION_OUTSIDE_INN
	bne	really_level_over

	; be sure we're in range
	lda	PEASANT_X
	cmp	#6
	bcc	really_level_over	; fine

	cmp	#18
	bcc	to_left
	cmp	#30
	bcc	to_right

really_level_over:

	rts

to_right:
	lda	#31
	sta	PEASANT_X
	rts

to_left:
	lda	#5
	sta	PEASANT_X
	rts


.include "move_peasant.s"
.include "draw_peasant.s"


.include "gr_copy.s"
.include "hgr_copy.s"

.include "new_map_location.s"

.include "keyboard.s"

.include "wait.s"
.include "wait_a_bit.s"

.include "graphics_inside/graphics_inside.inc"
.include "graphics_inside/priority_inside.inc"




map_backgrounds_low:
	.byte	<hidden_glen_zx02	; 24	-- hidden glen
	.byte	<inside_cottage_zx02	; 25	-- inside lady cottage
	.byte	<inside_nn_zx02		; 26	-- inside ned cottage

map_backgrounds_hi:
	.byte	>hidden_glen_zx02	; 24	-- hidden glen
	.byte	>inside_cottage_zx02	; 25	-- inside lady cottage
	.byte	>inside_nn_zx02		; 26	-- inside ned cottage

map_priority_low:
	.byte	<hidden_glen_priority_zx02	; 24	-- hidden glen
	.byte	<inside_cottage_priority_zx02	; 25	-- inside lady cottage
	.byte	<inside_nn_priority_zx02	; 26	-- inside ned cottage

map_priority_hi:
	.byte	>hidden_glen_priority_zx02	; 24	-- hidden glen
	.byte	>inside_cottage_priority_zx02	; 25	-- inside lady cottage
	.byte	>inside_nn_priority_zx02	; 26	-- inside ned cottage


verb_tables_low:
	.byte	<hidden_glen_verb_table		; 24	-- hidden glen
	.byte	<inside_cottage_verb_table	; 25	-- inside lady cottage
	.byte	<inside_nn_verb_table		; 26	-- inside ned cottage

verb_tables_hi:
	.byte	>hidden_glen_verb_table		; 24	-- hidden glen
	.byte	>inside_cottage_verb_table	; 25	-- inside lady cottage
	.byte	>inside_nn_verb_table		; 26	-- inside ned cottage




inside_text_zx02:
.incbin "DIALOG_INSIDE.ZX02"

.include "inside_actions.s"
