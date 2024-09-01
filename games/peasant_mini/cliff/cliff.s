; Cliff climb minigame from Peasant's Quest
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


.include "zp.inc"
.include "hardware.inc"

;div7_table     = $400
;mod7_table     = $500
;hposn_high     = $600
;hposn_low      = $700

div7_table      = $b800
mod7_table      = $b900
hposn_high      = $ba00
hposn_low       = $bb00

cliff_base:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME
	sta	PEASANT_XADD
	sta	PEASANT_YADD
	sta	PEASANT_DIR	; 0 = up
	sta	ERASE_SPRITE_COUNT
	sta	PEASANT_STEPS

	lda	#10
	sta	PEASANT_X
	lda	#100
	sta	PEASANT_Y

	; default for peasant quest is the tables are for page2
	lda	#$40
	sta	HGR_PAGE
	jsr	hgr_make_tables

	;===================
	; Load graphics
	;===================

	lda     #<priority_data
	sta     ZX0_src
	lda     #>priority_data
	sta     ZX0_src+1

        lda     #$20                    ; temporarily load to $2000

	jsr	full_decomp

	; copy to $400

	jsr	gr_copy_to_page1



	;=============================


	;==========================
	; Load Image
	;===========================

load_image:

	; size in ldsizeh:ldsizel (f1/f0)

	lda	#<bg_data
	sta	ZX0_src
	lda	#>bg_data
	sta	ZX0_src+1


	lda	#$20

	jsr	full_decomp

	jsr	hgr_copy			; copy to page2

	bit	PAGE2



	;==========================
	;==========================
	; main loop
	;==========================
	;==========================
game_loop:

	;=====================
	; move peasant

	jsr	move_peasant

	;=====================
	; draw peasant

	jsr	draw_peasant


	;=====================
	;=====================
	; draw enemies
	;=====================
	;=====================

	;=====================
	; erase old
	;=====================

	; from A to X
	;	SAVED_Y1 to SAVED_Y2

erase_old_loop:
	ldx	ERASE_SPRITE_COUNT
	beq	done_erase_old

	dex				; index is one less than count

	lda	save_ystart,X
	sta	SAVED_Y1
	lda	save_yend,X
	sta	SAVED_Y2
	lda	save_xstart,X
	pha
	lda	save_xend,X
	tax
	pla

	jsr	hgr_partial_restore

	dec	ERASE_SPRITE_COUNT
	bpl	erase_old_loop


done_erase_old:

	lda	#0
	sta	ERASE_SPRITE_COUNT	; no doubt this could be optimized

	;=====================
	; draw bird
	;=====================

	lda	bird_x
	sta	SPRITE_X
	lda	bird_y
	sta	SPRITE_Y

	lda	FRAME
	and	#1
	tax

	ldy	ERASE_SPRITE_COUNT

	jsr	hgr_draw_sprite

	inc	ERASE_SPRITE_COUNT

	;=====================
	; draw rock
	;=====================

	MAX_ROCKS=3

	lda	#0
	sta	CURRENT_ROCK
draw_rock_loop:
	ldx	CURRENT_ROCK

	lda	rock_x,X
	sta	SPRITE_X
	lda	rock_y,X
	sta	SPRITE_Y

	lda	rock_state,X
	beq	do_draw_rock

	cmp	#3		; 1,2=exploding
	bcc	do_explode_rock		; blt

	; if we get here, rock not out
	; for now just skip

	bcs	skip_rock


do_explode_rock:
	; explode is 1 or 2
	; map to 6,7 or 12,13

	lda	rock_type,X
	beq	explode_big_rock
explode_small_rock:
	lda	#11
	bne	explode_common_rock	; bra

explode_big_rock:
	lda	#5

explode_common_rock:
	clc
	adc	rock_state,X
	bne	really_draw_rock

do_draw_rock:

	lda	rock_type,X
	beq	draw_big_rock
draw_small_rock:
	lda	#8
	bne	draw_common_rock	; bra

draw_big_rock:
	lda	#2

draw_common_rock:
	sta	rock_add_smc+1


	lda	FRAME
	and	#3
	clc
rock_add_smc:
	adc	#2	; rock

really_draw_rock:
	tax

	ldy	ERASE_SPRITE_COUNT

	jsr	hgr_draw_sprite

	inc	ERASE_SPRITE_COUNT

skip_rock:
	inc	CURRENT_ROCK
	lda	CURRENT_ROCK
	cmp	#MAX_ROCKS
	bne	draw_rock_loop



	;=====================
	;=====================
	; move enemies
	;=====================
	;=====================

	;=====================
	; bird

	dec	bird_x
	bpl	bird_good

	lda	#37
	sta	bird_x

bird_good:

	;=====================
	; rock

	ldx	#0
	stx	CURRENT_ROCK
move_rock_loop:
	ldx	CURRENT_ROCK

	lda	rock_state,X
	beq	move_rock_normal
	cmp	#3
	bcc	move_rock_exploding

move_rock_waiting:

	lda	#0
	sta	rock_state,X

	lda	#12
	sta	rock_y,X
	jmp	rock_good


move_rock_exploding:
	inc	rock_state,X
	jmp	rock_good

move_rock_normal:
	inc	rock_y,X
	lda	rock_y,X
	cmp	#105
	bcc	rock_good
rock_start_explode:

	lda	#1
	sta	rock_state,X

rock_good:
	inc	CURRENT_ROCK
	lda	CURRENT_ROCK
	cmp	#MAX_ROCKS
	bne	move_rock_loop


	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; check keyboard

	jsr	check_keyboard

	lda	LEVEL_OVER
	bne	done_cliff

	; delay

	lda	#200
	jsr	wait

	jmp	game_loop


done_cliff:
	lda	#0
	sta	WHICH_LOAD
	rts


	.include	"hgr_tables.s"

	.include	"hgr_sprite.s"

	.include	"zx02_optim.s"

	.include	"wait.s"

	.include	"keyboard.s"

	.include	"draw_peasant.s"

	.include	"move_peasant.s"

	.include	"hgr_partial_restore.s"



	.include	"gr_copy.s"
	.include	"hgr_copy.s"

;	.include "cliff_graphics/peasant_robe_sprites.inc"

bg_data:
	.incbin "cliff_graphics/cliff_base.hgr.zx02"

priority_data:
	.incbin "cliff_graphics/cliff_base_priority.zx02"

sprites:
	.include "sprites/enemy_sprites.inc"


sprites_xsize:
	.byte	3, 3		; bird
	.byte	3, 3, 3, 3	; bigrock
	.byte 	3, 4		; bigrock_crash
	.byte	2, 2, 2, 2	; smallrock
	.byte 	2, 4		; smallrock_crash

sprites_ysize:
	.byte	16,14		; bird
	.byte	23,22,21,22	; bigrock
	.byte	18,21		; bigrock_crash
	.byte	15,14,15,14	; smallrock
	.byte	15,19		; smallrock_crash

sprites_data_l:
	.byte <bird0_sprite,<bird1_sprite
	.byte <bigrock0_sprite,<bigrock1_sprite
	.byte <bigrock2_sprite,<bigrock3_sprite
	.byte <bigrock_crash0_sprite,<bigrock_crash1_sprite
	.byte <smallrock0_sprite,<smallrock1_sprite
	.byte <smallrock2_sprite,<smallrock3_sprite
	.byte <smallrock_crash0_sprite,<smallrock_crash1_sprite
sprites_data_h:
	.byte >bird0_sprite,>bird1_sprite
	.byte >bigrock0_sprite,>bigrock1_sprite
	.byte >bigrock2_sprite,>bigrock3_sprite
	.byte >bigrock_crash0_sprite,>bigrock_crash1_sprite
	.byte >smallrock0_sprite,>smallrock1_sprite
	.byte >smallrock2_sprite,>smallrock3_sprite
	.byte >smallrock_crash0_sprite,>smallrock_crash1_sprite

sprites_mask_l:
	.byte <bird0_mask,<bird1_mask
	.byte <bigrock0_mask,<bigrock1_mask
	.byte <bigrock2_mask,<bigrock3_mask
	.byte <bigrock_crash0_mask,<bigrock_crash1_mask
	.byte <smallrock0_mask,<smallrock1_mask
	.byte <smallrock2_mask,<smallrock3_mask
	.byte <smallrock_crash0_mask,<smallrock_crash1_mask

sprites_mask_h:
	.byte >bird0_mask,>bird1_mask
	.byte >bigrock0_mask,>bigrock1_mask
	.byte >bigrock2_mask,>bigrock3_mask
	.byte >bigrock_crash0_mask,>bigrock_crash1_mask
	.byte >smallrock0_mask,>smallrock1_mask
	.byte >smallrock2_mask,>smallrock3_mask
	.byte >smallrock_crash0_mask,>smallrock_crash1_mask

	;========================================

	; background restore parameters
	; currently 4, should check this and error if we overflow

save_xstart:
	.byte	0, 0, 0, 0, 0
save_xend:
	.byte	0, 0, 0, 0, 0
save_ystart:
	.byte	0, 0, 0, 0, 0
save_yend:
	.byte	0, 0, 0, 0, 0


	;========================================
	; data for the enemies

bird_x:
	.byte	37
bird_y:
	.byte	75


rock_type:		; 0=big, 1=little
	.byte	0, 1, 0
rock_state:
	.byte 	0, 0, 3	; 0 = falling, 1,2 = exploding, 3 = waiting?
rock_x:
	.byte	7, 12, 17	; remember, /7
rock_y:
	.byte	12,12,12


	.include "hgr_sprite_bg_mask.s"

	.include "sprites/walk_sprites.inc"



walk_sprites_xsize:
	.byte	2, 2, 2, 2, 2, 2	; right
	.byte	2, 2, 2, 2, 2, 2	; left
	.byte	2, 2, 2, 2, 2, 2	; up
	.byte	2, 2, 2, 2, 2, 2	; down

walk_sprites_ysize:
	.byte	30, 30, 30, 30, 30, 30	; right
	.byte	30, 30, 30, 30, 30, 30	; left
	.byte	30, 30, 30, 30, 30, 30	; up
	.byte	30, 30, 30, 30, 30, 30	; down

walk_sprites_data_l:
	.byte <walk_r0_sprite,<walk_r1_sprite,<walk_r2_sprite
	.byte <walk_r3_sprite,<walk_r4_sprite,<walk_r5_sprite
	.byte <walk_l0_sprite,<walk_l1_sprite,<walk_l2_sprite
	.byte <walk_l3_sprite,<walk_l4_sprite,<walk_l5_sprite
	.byte <walk_u0_sprite,<walk_u1_sprite,<walk_u2_sprite
	.byte <walk_u3_sprite,<walk_u4_sprite,<walk_u5_sprite
	.byte <walk_d0_sprite,<walk_d1_sprite,<walk_d2_sprite
	.byte <walk_d3_sprite,<walk_d4_sprite,<walk_d5_sprite

walk_sprites_data_h:
	.byte >walk_r0_sprite,>walk_r1_sprite,>walk_r2_sprite
	.byte >walk_r3_sprite,>walk_r4_sprite,>walk_r5_sprite
	.byte >walk_l0_sprite,>walk_l1_sprite,>walk_l2_sprite
	.byte >walk_l3_sprite,>walk_l4_sprite,>walk_l5_sprite
	.byte >walk_u0_sprite,>walk_u1_sprite,>walk_u2_sprite
	.byte >walk_u3_sprite,>walk_u4_sprite,>walk_u5_sprite
	.byte >walk_d0_sprite,>walk_d1_sprite,>walk_d2_sprite
	.byte >walk_d3_sprite,>walk_d4_sprite,>walk_d5_sprite

walk_mask_data_l:
	.byte <walk_r0_mask,<walk_r1_mask,<walk_r2_mask
	.byte <walk_r3_mask,<walk_r4_mask,<walk_r5_mask
	.byte <walk_l0_mask,<walk_l1_mask,<walk_l2_mask
	.byte <walk_l3_mask,<walk_l4_mask,<walk_l5_mask
	.byte <walk_u0_mask,<walk_u1_mask,<walk_u2_mask
	.byte <walk_u3_mask,<walk_u4_mask,<walk_u5_mask
	.byte <walk_d0_mask,<walk_d1_mask,<walk_d2_mask
	.byte <walk_d3_mask,<walk_d4_mask,<walk_d5_mask

walk_mask_data_h:
	.byte >walk_r0_mask,>walk_r1_mask,>walk_r2_mask
	.byte >walk_r3_mask,>walk_r4_mask,>walk_r5_mask
	.byte >walk_l0_mask,>walk_l1_mask,>walk_l2_mask
	.byte >walk_l3_mask,>walk_l4_mask,>walk_l5_mask
	.byte >walk_u0_mask,>walk_u1_mask,>walk_u2_mask
	.byte >walk_u3_mask,>walk_u4_mask,>walk_u5_mask
	.byte >walk_d0_mask,>walk_d1_mask,>walk_d2_mask
	.byte >walk_d3_mask,>walk_d4_mask,>walk_d5_mask

