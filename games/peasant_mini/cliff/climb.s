; Cliff climb minigame from Peasant's Quest
;
; the actual climbing part

;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


.include "zp.inc"
.include "hardware.inc"

div7_table      = $b800
mod7_table      = $b900
hposn_high      = $ba00
hposn_low       = $bb00

cliff_climb:

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
	sta	FLAME_COUNT
	sta	CLIMB_COUNT

	lda	#10
	sta	PEASANT_X
	lda	#90
	sta	PEASANT_Y

	; default for peasant quest is the tables are for page2
	lda	#$40
	sta	HGR_PAGE
	jsr	hgr_make_tables

	;========================
	; Load Priority graphics
	;========================

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
	; Load Background Graphics
	;===========================

load_image:

	lda	#<bg_data
	sta	ZX0_src
	lda	#>bg_data
	sta	ZX0_src+1


	lda	#$20

	jsr	full_decomp

	jsr	hgr_copy			; copy to page2

	bit	PAGE2



	;========================
	; Load Peasant Sprites
	;========================

	lda     #<walking_sprite_data
	sta     ZX0_src
	lda     #>walking_sprite_data
	sta     ZX0_src+1

        lda     #$a0

	jsr	full_decomp


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

	jsr	draw_peasant_climb


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

	lda	bird_out
	beq	done_draw_bird

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

done_draw_bird:

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

	lda	bird_out
	bne	move_bird
maybe_new_bird:

	jsr	random16
	and	#7		; 1/8 of time start new bird?
	bne	move_bird_done

	jsr	random16
	and	#$3f		; 0... 64
	clc
	adc	#12		; skip top bar
	sta	bird_y

	lda	#37
	sta	bird_x
	inc	bird_out
	jmp	move_bird_done

move_bird:
	dec	bird_x
	bpl	move_bird_done

	; off screen here

	lda	#0
	sta	bird_out

move_bird_done:

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

	jsr	random16
	and	#7		; 1/8 of time start new rock
	bne	rock_good

	jsr	random16
	and	#$1f		; 0... 31
	clc
	adc	#2		; skip to middle slightly
	sta	rock_x,X

	lda	#12
	sta	rock_y,X

	lda	#0
	sta	rock_state,X

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

	inc	FLAME_COUNT
	lda	FLAME_COUNT
	cmp	#3
	bne	flame_good


	lda	#0
	sta	FLAME_COUNT

flame_good:

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

	.include	"wait.s"

	.include	"hgr_tables.s"

	.include	"hgr_sprite.s"

	.include	"zx02_optim.s"

	.include	"keyboard_climb.s"

	.include	"draw_peasant_climb.s"

	.include	"move_peasant_climb.s"

	.include	"hgr_partial_restore.s"



	.include	"gr_copy.s"
	.include	"hgr_copy.s"

	.include	"random16.s"

	.include	"gr_offsets.s"

bg_data:
	.incbin "cliff_graphics/cliff_base.hgr.zx02"
	.incbin "cliff_graphics/cliff2.hgr.zx02"
	.incbin "cliff_graphics/cliff3.hgr.zx02"

priority_data:
	.incbin "cliff_graphics/cliff_base_priority.zx02"
	.incbin "cliff_graphics/cliff2_priority.zx02"
	.incbin "cliff_graphics/cliff3_priority.zx02"

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
	; currently 5, should check this and error if we overflow

save_xstart:
	.byte	0, 0, 0, 0, 0, 0
save_xend:
	.byte	0, 0, 0, 0, 0, 0
save_ystart:
	.byte	0, 0, 0, 0, 0, 0
save_yend:
	.byte	0, 0, 0, 0, 0, 0


	;========================================
	; data for the enemies

bird_out:
	.byte	0

bird_x:
	.byte	37
bird_y:
	.byte	75


rock_type:		; 0=big, 1=little
	.byte	0, 1, 0
rock_state:
	.byte 	3, 3, 3	; 0 = falling, 1,2 = exploding, 3 = waiting?
rock_x:
	.byte	7, 12, 17	; remember, /7
rock_y:
	.byte	12,12,12


	.include "hgr_sprite_bg_mask.s"

walking_sprite_data:
	.incbin "climbing_sprites.zx02"

peasant_sprite_offset = $a000

peasant_sprites_xsize = peasant_sprite_offset+0
peasant_sprites_ysize = peasant_sprite_offset+34
peasant_sprites_data_l = peasant_sprite_offset+68
peasant_sprites_data_h = peasant_sprite_offset+102
peasant_mask_data_l = peasant_sprite_offset+136
peasant_mask_data_h = peasant_sprite_offset+170
