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

; defines

MAX_ROCKS	= 3

cliff_climb:

	;===================
	; set graphics mode
	;===================

	jsr	HOME

	; clear keyboard

	bit	KEYRESET

; intro

	lda	#0
	sta	DRAW_PAGE

	lda	#<opening_text
	sta	OUTL
	lda	#>opening_text
	sta	OUTH

	jsr	move_and_print_list

wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer

restart_game:
	jsr	reset_enemy_state

; end intro

	bit	HIRES			; init graphics
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	lda	#0			; init variables
	sta	LEVEL_OVER
	sta	FRAME
	sta	PEASANT_XADD
	sta	PEASANT_YADD
	sta	PEASANT_DIR		; 0 = up
;	sta	ERASE_SPRITE_COUNT
	sta	PEASANT_STEPS
	sta	FLAME_COUNT
	sta	CLIMB_COUNT
	sta	MAP_LOCATION
	sta	PEASANT_FALLING
	sta	MAX_HEIGHT

	lda	#10				; starting location
	sta	PEASANT_X
	lda	#90
	sta	PEASANT_Y

	; default for peasant quest is the tables are for page2
	lda	#$40
	sta	HGR_PAGE
	jsr	hgr_make_tables


	jsr	load_graphics

	;========================
	; Load Peasant Sprites
	;========================

	lda     #<climbing_sprite_data
	sta     ZX0_src
	lda     #>climbing_sprite_data
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
	; draw bird
	;=====================
draw_bird:

	; erase the bird if needed

	ldy	#0			; always in erase slot 0
	jsr	hgr_partial_restore_by_num

	; only draw bird if it's out

	lda	bird_out
	beq	done_draw_bird


	; load in X/Y co-ords

	lda	bird_x
	sta	SPRITE_X
	lda	bird_y
	sta	SPRITE_Y

	; get wing flapping (which sprite) based on frame count

	lda	FRAME
	and	#1
	tax

	ldy	#0			; bird always erase slot #0

	jsr	hgr_draw_sprite

done_draw_bird:

	;=====================
	; draw rock
	;=====================

	lda	#0
	sta	CURRENT_ROCK
draw_rock_loop:

	ldy	CURRENT_ROCK
	iny					; rock erase slot=rock+1
	jsr	hgr_partial_restore_by_num

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

	; erase slot = rock+1
	ldy	CURRENT_ROCK
	iny

	jsr	hgr_draw_sprite

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

	; bird on base level,	12 .. 76	(MAP_LOCATION==0)
	; bird on other levels, 12 .. 140

	jsr	random16

	ldx	MAP_LOCATION
	bne	new_bird_wider

	and	#$3f		; 0... 64
new_bird_wider:
	and	#$7f		; 0... 128

	clc
	adc	#12		; skip top bar
	sta	bird_y

	lda	#37
	sta	bird_x
	inc	bird_out
	jmp	move_bird_done

move_bird:

	;=========================
	; collision detect here

	jsr	bird_collide
	bcc	no_bird_collision

	; collision happened!

	lda	#1
	sta	PEASANT_FALLING

no_bird_collision:

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

	; see if start new rock

	jsr	random16
	and	#7		; 1/8 of time start new rock
	bne	rock_good

start_new_rock:

	; pick x position
	;	bit of a hack, really should be from 0..38
	;	but we actually do 2..34 as it's easier

	jsr	random16
	and	#$1f		; 0... 31
	clc
	adc	#2		; push away from edge a bit
	sta	rock_x,X

	lda	#12		; start at top
	sta	rock_y,X

	lda	#0		; put in falling state
	sta	rock_state,X

	jmp	rock_good


move_rock_exploding:
	inc	rock_state,X
	jmp	rock_good

move_rock_normal:

	; two states.  If MAP_LOCATION==0, if ypos>105 start exploding
	;		else if ypos>190 or so just go away
	;		sprite code will truncate sprite so we don't
	;		run off screen and corrupt memory

	inc	rock_y,X
	inc	rock_y,X
	inc	rock_y,X

	lda	rock_y,X

	ldy	MAP_LOCATION
	beq	move_rock_base_level

move_rock_upper_level:
	cmp	#190			; if > 168 make disappear
	bcc	rock_good

	lda	#3			; make it go away
	sta	rock_state,X
	bne	rock_good		; bra

move_rock_base_level:

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

	;===========================
	; check level over
	;	a few ways to get here
	;	0 = fine, keep going
	;	$FF = hit top of screen, go to next
	;	$FF = falling and going down to next
	;	$80 = falling, end of game, key pressed
	;	? = won game

	lda	LEVEL_OVER
	cmp	#$80
	beq	cliff_game_over

	lda	LEVEL_OVER
	bne	cliff_reload_bg

	; delay

	lda	#200
	jsr	wait

	jmp	game_loop

cliff_game_over:

	jsr	clear_gr_all

	bit	SET_TEXT
	bit	PAGE1

	; update max height attained

	lda	MAX_HEIGHT
	and	#$f
	clc
	adc	#$30
	sta	losing_number+1

	lda	MAX_HEIGHT
	lsr
	lsr
	lsr
	lsr
	clc
	adc	#$30
	sta	losing_number

	lda	#<losing_text
	sta	OUTL
	lda	#>losing_text
	sta	OUTH

	jsr	move_and_print_list

	bit	KEYRESET

wait_until_keypress2:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress2			; 3
	bit	KEYRESET	; clear the keyboard buffer

	jmp	restart_game


cliff_reload_bg:
	jsr	reset_enemy_state

	jsr	load_graphics

	lda	#0
	sta	LEVEL_OVER

	jmp	game_loop


load_graphics:



	;========================
	; Load Priority graphics
	;========================

	ldx	MAP_LOCATION
	lda     priority_data_l,X
	sta     ZX0_src
	lda     priority_data_h,X
	sta     ZX0_src+1

        lda     #$20                    ; temporarily load to $2000

	jsr	full_decomp

	; copy to $400

	jsr	gr_copy_to_page1



	;=============================


	;==========================
	; Load Background Graphics
	;===========================

	ldx	MAP_LOCATION
	lda	bg_data_l,X
	sta	ZX0_src
	lda	bg_data_h,X
	sta	ZX0_src+1


	lda	#$20

	jsr	full_decomp

	jsr	hgr_copy			; copy to page2

	bit	PAGE2

	rts






	.include	"hgr_tables.s"

	.include	"hgr_sprite.s"


	.include	"zx02_optim.s"

	.include	"wait.s"


	.include	"keyboard_climb.s"


	.include	"draw_peasant_climb.s"

	.include	"move_peasant_climb.s"

	.include	"hgr_partial_restore.s"


	.include	"text_print.s"	; for z version

	.include	"gr_copy.s"
	.include	"hgr_copy.s"

	.include	"random16.s"

	.include	"gr_offsets.s"

opening_text:
.byte	0,0,"CLIFF CLIMB",0
.byte	0,2,"FROM PEASANTS QUEST BY VIDELECTRIX",0
.byte	0,4,"USE ARROWS OR WSAD TO CLIMB UP",0
.byte	0,6,"AVOID BIRDS AND ROCKS",0,$FF

losing_number=losing_text+34
losing_text:
.byte	0,0,"YOU FELL",0
.byte	0,2,"YOU MADE IT TO LEVEL 02",0
.byte	0,4,"GOOD JORB!",0,$FF

priority_data_l:
	.byte <priority_cliff1,<priority_cliff2,<priority_cliff3
priority_data_h:
	.byte >priority_cliff1,>priority_cliff2,>priority_cliff3

bg_data_l:
	.byte <bg_cliff1,<bg_cliff2,<bg_cliff3
bg_data_h:
	.byte >bg_cliff1,>bg_cliff2,>bg_cliff3

bg_cliff1:
	.incbin "cliff_graphics/cliff_base.hgr.zx02"
bg_cliff2:
	.incbin "cliff_graphics/cliff2.hgr.zx02"
bg_cliff3:
	.incbin "cliff_graphics/cliff3.hgr.zx02"

priority_cliff1:
	.incbin "cliff_graphics/cliff_base_priority.zx02"
priority_cliff2:
	.incbin "cliff_graphics/cliff2_priority.zx02"
priority_cliff3:
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

	; tried to dynamically do this, but in the end hard-coded

	; 0 = bird
	; 1,2,3 = boulders
	; 4 = peasant
	; 5 = flame

save_valid:
	.byte	0, 0, 0, 0, 0, 0
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

climbing_sprite_data:
	.incbin "climbing_sprites.zx02"

peasant_sprite_offset = $a000

peasant_sprites_xsize = peasant_sprite_offset+0
peasant_sprites_ysize = peasant_sprite_offset+34
peasant_sprites_data_l = peasant_sprite_offset+68
peasant_sprites_data_h = peasant_sprite_offset+102
peasant_mask_data_l = peasant_sprite_offset+136
peasant_mask_data_h = peasant_sprite_offset+170

	; call this when restarting, also when move to new screen
reset_enemy_state:

	lda	#0
	sta	bird_out

	lda	#3
	sta	rock_state
	sta	rock_state+1
	sta	rock_state+2

	rts

	;===========================
	; check for bird collisions

bird_collide:

	; bird is 3x16
	; peasant is 3x30

	; doing a sort of Minkowski Sum collision detection here
	; with the rectangular regions

	; might be faster to set it up so you can subtract, but that leads
	;	to issues when we go negative and bcc/bcs are unsigned compares

	; if (bird_x+1<PEASANT_X-1) no_collide
	;	equivalent, if (bird_x+2<PEASANT_X)
	;	equivalent, if (PEASANT_X-1 >= bird_x+1)

	lda	bird_x
	sta	TEMP_CENTER
	inc	TEMP_CENTER	; bird_x+1

	sec
	lda	PEASANT_X
	sbc	#1			; A is PEASANT_X-1
	cmp	TEMP_CENTER		; compare with bird_x+1
	bcs	bird_no_collide		; bge

	; if (bird_x+1>=PEASANT_X+3) no collide
	;	equivalent, if (bird_x-2>=PEASANT_X)
	;	equivalent, if (PEASANT_X+3<bird_x+1)

	; carry clear here
	adc	#4			; A is now PEASANT_X+3
	cmp	TEMP_CENTER
	bcc	bird_no_collide		; blt

	; if (bird_y+8<PEASANT_Y-8) no_collide
	;	equivalent, if (bird_y+16<PEASANT_Y)
	;	equivalent, if (PEASANT_Y-8>=bird_y+8)

	lda	bird_y
	clc
	adc	#8
	sta	TEMP_CENTER

	lda	PEASANT_Y
	sec
	sbc	#8			; A is now PEASANT_Y-8
	cmp	TEMP_CENTER
	bcs	bird_no_collide		; blt

	; if (bird_Y+8>=PEASANT_Y+38) no collide
	;	equivalent, if (bird_y-30>=PEASANT_Y)
	;	equivalent, if (PEASANT_Y+38<bird_y+8)

	; carry clead here
	adc	#38			; A is now bird_y+30
	cmp	TEMP_CENTER
	bcc	bird_no_collide		; blt

bird_yes_collide:
	sec
	rts

bird_no_collide:
	clc
	rts

