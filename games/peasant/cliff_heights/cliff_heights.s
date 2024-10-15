; Peasant's Quest

; Cliff Heights

; Top of the cliff and outer trogdor lair

; by Vince `deater` Weaver	vince@deater.net
.include "../zp.inc"
.include "../hardware.inc"

.include "../peasant_sprite.inc"
.include "../qload.inc"
.include "../inventory/inventory.inc"
.include "../parse_input.inc"

collision_location = $bc00

LOCATION_BASE	= LOCATION_CLIFF_HEIGHTS ; (21 = $15)

cliff_heights:

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME
	sta	FLAME_COUNT
	sta	KEEPER_COUNT
	sta	IN_QUIZ

	jsr	hgr_make_tables

	;================================
	; decompress dialog to $D000

	lda	#<cliff_text_zx02
	sta	zx_src_l+1
	lda	#>cliff_text_zx02
	sta	zx_src_h+1

	lda	#$D0

	jsr	zx02_full_decomp

	;===============================
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

	lda     MAP_LOCATION
	sec
	sbc     #LOCATION_BASE
	tax

	lda	verb_tables_low,X
	sta	INL
	lda	verb_tables_hi,X
	sta	INH
	jsr	load_custom_verb_table

	;===============================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda     MAP_LOCATION
	sec
	sbc     #LOCATION_BASE
	tax

	lda	map_priority_low,X
	sta	zx_src_l+1
	lda	map_priority_hi,X
	sta	zx_src_h+1

	lda	#$20			; temporarily load to $2000

	jsr	zx02_full_decomp

	; copy to $400

	jsr	gr_copy_to_page1

	; copy collision detection info

	ldx	#0
col_copy_loop:
	lda	$2400,X
	sta	collision_location,X
	inx
	bne	col_copy_loop


	;=====================
	; load bg

	lda     MAP_LOCATION
	sec
	sbc     #LOCATION_BASE
	tax

	lda	map_backgrounds_low,X
	sta	zx_src_l+1
	lda	map_backgrounds_hi,X
	sta	zx_src_h+1

	lda	#$20				; load to $2000

	jsr	zx02_full_decomp

	jsr	hgr_copy			; copy to $4000

	;===================
	; put peasant text

	lda	#<peasant_text
	sta	OUTL
	lda	#>peasant_text
	sta	OUTH

	jsr	hgr_put_string

	;===================
	; put score

	jsr	print_score


	;======================
	; always activate text

	jsr	setup_prompt


	;========================
	; Load Peasant Sprites
	;========================
	; Note: to get to this point of the game you have to be
	;	in a robe and on fire, so we should enforce that

	lda	GAME_STATE_2
	ora	#ON_FIRE
	sta	GAME_STATE_2

	lda	#<robe_sprite_data
	sta	zx_src_l+1
	lda	#>robe_sprite_data
	sta	zx_src_h+1

	lda	#$a0

	jsr	zx02_full_decomp


	; clear the keyboard in case we were holding it down

	bit	KEYRESET

	; See if we need to give points

	lda	GAME_STATE_3
	and	#CLIFF_CLIMBED
	bne	cliff_already_climbed

	; only set this if just arrived, not if loading saved game

	lda	#14
	sta	PEASANT_X
	lda	#150
	sta	PEASANT_Y

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD

	; score points

	lda	#3
	jsr	score_points

	lda	GAME_STATE_3
	ora	#CLIFF_CLIMBED
	sta	GAME_STATE_3

	; print the message

	ldx	#<cliff_heights_top_message
	ldy	#>cliff_heights_top_message
	stx     OUTL
        sty     OUTH
        jsr     print_text_message

        jsr     wait_until_keypress

	jsr	restore_parse_message

cliff_already_climbed:

	;===========================
	;===========================
	;===========================
	; main loop
	;===========================
	;===========================
	;===========================
game_loop:

	;===================
	; move peasant

	jsr	move_peasant

	;====================
	; check if done level

	lda	LEVEL_OVER
	bmi	oops_new_location
	bne	level_over



	;=====================
	; draw lightning

	lda     MAP_LOCATION
	cmp	#LOCATION_CLIFF_HEIGHTS
	bne	no_lightning
	jsr	draw_lightning
no_lightning:

	;=====================
	; see if keeper triggered

	lda     MAP_LOCATION
	cmp	#LOCATION_TROGDOR_OUTER
	bne	no_keeper

check_keeper1:
	lda	INVENTORY_2
	and	#INV2_TROGSHIELD	; only if not have shield
	bne	check_keeper2

	lda	PEASANT_X		; only if ourx > 9
	cmp	#10
	bcc	check_keeper2

	jsr	handle_keeper1

check_keeper2:

no_keeper:


	;=====================
	; always draw peasant

	jsr	draw_peasant

	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; increment flame

	jsr	increment_flame

	;======================
	; check keyboard

	; original code also waited approximately 100ms?
	; this led to keypressed being lost

	lda	#13
	sta	WAIT_LOOP
wait_loop:
	jsr	check_keyboard

	lda	#50		; approx 7ms
	jsr	wait

	dec	WAIT_LOOP
	bne	wait_loop



	; delay

;	lda	#200
;	jsr	wait


	jmp	game_loop

oops_new_location:

	; new location but same file

	lda	MAP_LOCATION
	cmp	#LOCATION_CLIFF_HEIGHTS
	bne	not_the_cliff

	lda	PREVIOUS_LOCATION
	cmp	#LOCATION_TROGDOR_OUTER
	beq	to_cliff_from_outer

to_cliff_from_cliff:
	lda	#18
	sta	PEASANT_X
	lda	#140
	sta	PEASANT_Y
	bne	not_the_cliff		; bra

to_cliff_from_outer:
	lda	#32
	sta	PEASANT_X
	lda	#120
	sta	PEASANT_Y
	bne	not_the_cliff		; bra

not_the_cliff:

	lda	MAP_LOCATION
	cmp	#LOCATION_TROGDOR_OUTER
	bne	not_outer

	lda	#2
	sta	PEASANT_X
	lda	#100
	sta	PEASANT_Y

not_outer:
just_go_there:

	jmp	new_location


	;************************
	; exit level
	;************************
level_over:

	cmp	#NEW_FROM_LOAD		; see if loading save game
	beq	exiting_cliff

	; new location
	; in theory this can only be TROGDOR

	lda	#4
	sta	PEASANT_X
	lda	#170
	sta	PEASANT_Y

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD
exiting_cliff:
	rts


.include "../draw_peasant_new.s"
.include "../move_peasant_new.s"

.include "../hgr_sprite_bg_mask.s"
.include "../gr_offsets.s"
.include "../hgr_partial_restore.s"
.include "../hgr_sprite.s"

.include "../gr_copy.s"
.include "../hgr_copy.s"

.include "../new_map_location.s"

.include "../keyboard.s"

.include "../wait.s"
.include "../wait_a_bit.s"

.include "graphics_heights/cliff_heights_graphics.inc"
.include "graphics_heights/priority_cliff_heights.inc"

map_backgrounds_low:
	.byte   <cliff_heights_zx02
	.byte   <outer_zx02

map_backgrounds_hi:
	.byte   >cliff_heights_zx02
	.byte   >outer_zx02

map_priority_low:
	.byte	<cliff_heights_priority_zx02
	.byte	<outer_priority_zx02

map_priority_hi:
	.byte	>cliff_heights_priority_zx02
	.byte	>outer_priority_zx02

verb_tables_low:
	.byte	<cliff_heights_verb_table
	.byte	<cave_outer_verb_table

verb_tables_hi:
	.byte	>cliff_heights_verb_table
	.byte	>cave_outer_verb_table



cliff_text_zx02:
.incbin "../text/DIALOG_CLIFF_HEIGHTS.ZX02"

.include "heights_actions.s"

robe_sprite_data:
	.incbin "../sprites_peasant/robe_sprites.zx02"


.include "sprites_heights/ron_sprites.inc"

.include "draw_lightning.s"



;==========================================
; first keeper info
;
;	seems to trigger at approx peasant_x = 70 (10)
;

; 0 (4), move down/r
; 0 (4), move down/r
; 1 (4), no move
; 1 (5), move down/r

; 1 (5), move down/r
; 1 (5), move down/r
; 1 (5), move down/r
; 1 (5), move down/r

; 2 (5)
; 3 (4)
; 4 (10)
; 3 (10)

; 4 (15)
; 3 (5)
; 2 (5)
; 1 (11) ; starts talking

keeper_x:
.byte   9, 9,10,10
.byte  10,10,10,10
.byte  10,10,10,10, 10,10
.byte  10,10,10,10,10,10,10

keeper_y:
.byte	51,52,53,54
.byte   56,58,59,60
.byte	60,60,60,60, 60,60
.byte	60,60,60,60, 60,60,60

which_keeper_sprite:
.byte	0, 0, 1, 1
.byte	1, 1, 1, 1
.byte	2, 3, 4, 4, 3, 3

.byte   4, 4, 4, 3, 2, 1, 1


	;===============================
	; handle keeper1
	;===============================
	; handle keeper1
	;	stop walking
	;	have keeper come out to talk
	;	special limited handling
	;	can't walk unless win
handle_keeper1:

	lda	#0		; stop walking
	sta	PEASANT_XADD
	sta	PEASANT_YADD

	;===========================
	; animate keeper coming out


keeper1_loop:

	; erase prev keeper

	ldy	#3                      ; erase slot 3?
	jsr	hgr_partial_restore_by_num

	inc	KEEPER_COUNT
	ldx	KEEPER_COUNT

	lda     keeper_x,X
	sta     SPRITE_X
	lda     keeper_y,X
	sta     SPRITE_Y

        ; get offset for graphics

	ldx	KEEPER_COUNT
	lda	which_keeper_sprite,X
	clc
	adc	#5			; skip ron
	tax

	ldy     #3      ; ? slot

	jsr	hgr_draw_sprite_save

	;=======================
	; see if done animation

	lda	KEEPER_COUNT
	cmp	#20		;
	beq	keeper_talk1



	;========================
	; increment flame

	jsr	draw_peasant

	;========================
	; increment flame

	jsr	increment_flame

	;=========================
	; delay

	lda	#200
	jsr	wait


	jmp	keeper1_loop

	rts


	;====================
	; increment flame
	;====================
increment_flame:
	inc	FLAME_COUNT
	lda	FLAME_COUNT
	cmp	#3
	bne	flame_good

	lda	#0
	sta	FLAME_COUNT

flame_good:
	rts

keeper_talk1:
	; print the message

	ldx     #<cave_outer_keeper1_message1
	ldy     #>cave_outer_keeper1_message1
	jsr	finish_parse_message

	ldx     #<cave_outer_keeper1_message2
	ldy     #>cave_outer_keeper1_message2
	jsr     finish_parse_message

	ldx     #<cave_outer_keeper1_message3
	ldy     #>cave_outer_keeper1_message3
	jsr     finish_parse_message

	ldx     #<cave_outer_keeper1_message4
	ldy     #>cave_outer_keeper1_message4
	jsr     finish_parse_message

	;===============================================
	; if have sub print5, otherwise skip ahead

	lda	INVENTORY_2
	and	#INV2_MEATBALL_SUB
	beq	dont_have_sub

	ldx     #<cave_outer_keeper1_message4
	ldy     #>cave_outer_keeper1_message4
	stx     OUTL
	sty     OUTH
	jsr     print_text_message

	jsr     wait_until_keypress

dont_have_sub:

	lda	#0
	ldx	#39
	jsr	hgr_partial_restore

	lda	INVENTORY_2
	ora	#INV2_TROGSHIELD	; get the shield
	sta	INVENTORY_2

	jmp	game_loop



sprites_xsize:
	.byte  2, 2, 2, 2, 2			; ron 0..4
	.byte  2, 2, 3, 3, 3, 3, 3, 3		; keeper 0..7

sprites_ysize:
	.byte 29,30,30,30,30			; ron 0..4
	.byte 28,28,28,28,28,28,28,28		; keeper 0..7

sprites_data_l:
	.byte <ron0,<ron1,<ron2,<ron3,<ron4
	.byte <keeper0,<keeper1,<keeper2,<keeper3
	.byte <keeper4,<keeper5,<keeper6,<keeper7

sprites_data_h:
	.byte >ron0,>ron1,>ron2,>ron3,>ron4
	.byte >keeper0,>keeper1,>keeper2,>keeper3
	.byte >keeper4,>keeper5,>keeper6,>keeper7


sprites_mask_l:
	.byte <ron0_mask,<ron1_mask,<ron2_mask,<ron3_mask,<ron4_mask
	.byte <keeper0_mask,<keeper1_mask,<keeper2_mask,<keeper3_mask
	.byte <keeper4_mask,<keeper5_mask,<keeper6_mask,<keeper7_mask


sprites_mask_h:
	.byte >ron0_mask,>ron1_mask,>ron2_mask,>ron3_mask,>ron4_mask
	.byte >keeper0_mask,>keeper1_mask,>keeper2_mask,>keeper3_mask
	.byte >keeper4_mask,>keeper5_mask,>keeper6_mask,>keeper7_mask

.include "../hgr_sprite_save.s"
