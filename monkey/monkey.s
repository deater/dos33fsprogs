; Monkey Monkey

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"

monkey_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	TEXTGR

	;=================
	; set up location
	;=================

	lda	#<locations
	sta	LOCATIONS_L
	lda	#>locations
	sta	LOCATIONS_H

	lda	#29
	sta	GUYBRUSH_X
	lda	#18
	sta	GUYBRUSH_Y


	lda	#0
	sta	DRAW_PAGE
	sta	LEVEL_OVER
	sta	GUYBRUSH_DIRECTION
	sta	GUYBRUSH_SIZE
	sta	DISPLAY_MESSAGE
	sta	BAR_DOOR_OPEN
	sta	VALID_NOUN
	sta	ITEMS_PICKED_UP
	sta	INVENTORY_NEXT_SLOT
	sta	INVENTORY
	sta	INVENTORY2
	sta	INVENTORY3
	sta	INVENTORY4
	sta	INVENTORY5



	; init cursor

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	; set up initial location

	lda	#MONKEY_BAR
;	lda	#MONKEY_LOOKOUT
;	lda	#MONKEY_VOODOO1
	sta	LOCATION

	jsr	change_location

	lda	#1
	sta	CURSOR_VISIBLE		; visible at first

	lda	#0
	sta	ANIMATE_FRAME

	lda	#VERB_WALK
	sta	CURRENT_VERB

	lda	#$ff
	sta	DESTINATION_X
	sta	DESTINATION_Y

game_loop:
	;=================
	; reset things
	;=================

	lda	#0
	sta	IN_SPECIAL
	sta	IN_RIGHT
	sta	IN_LEFT

	;====================================
	; copy background to current page
	;====================================

	jsr	gr_copy_to_current

	;====================================
	; draw background sprites
	;====================================

	lda	LOCATION
	cmp	#MONKEY_LOOKOUT
	beq	animate_flame
	cmp	#MONKEY_BAR
	beq	do_draw_bar_door
	cmp	#MONKEY_ZIPLINE
	beq	do_draw_sign
	cmp	#MONKEY_VOODOO2
	beq	do_draw_smoke
	cmp	#MONKEY_BAR_INSIDE3
	beq	do_draw_meat

	jmp	nothing_special

animate_flame:
	jsr	draw_fire
	jmp	nothing_special

do_draw_bar_door:
	jsr	draw_bar_door
	jmp	nothing_special

do_draw_sign:
	jsr	draw_sign
	jmp	nothing_special

do_draw_smoke:
	jsr	draw_smoke
	jmp	nothing_special

do_draw_meat:
	jsr	draw_meat
	jmp	nothing_special

nothing_special:


	;====================================
	; move guybrush
	;====================================

	; only do it every 4th frame
	lda	FRAMEL
	and	#$3
	bne	done_move_guybrush

move_guybrush_x:
	lda	DESTINATION_X
	bmi	move_guybrush_y

	cmp	GUYBRUSH_X
	beq	guybrush_lr_done
	bcs	move_guybrush_right
move_guybrush_left:
	lda	#DIR_LEFT
	sta	GUYBRUSH_DIRECTION
	dec	GUYBRUSH_X
	jmp	move_guybrush_y
move_guybrush_right:
	lda	#DIR_RIGHT
	sta	GUYBRUSH_DIRECTION
	inc	GUYBRUSH_X
	jmp	move_guybrush_y

guybrush_lr_done:

	lda	#$ff
	sta	DESTINATION_X

move_guybrush_y:
	lda	DESTINATION_Y
	bmi	done_move_guybrush

	cmp	GUYBRUSH_Y
	beq	guybrush_ud_done
	bcs	move_guybrush_down
move_guybrush_up:
	lda	#DIR_UP
	sta	GUYBRUSH_DIRECTION
	dec	GUYBRUSH_Y
	dec	GUYBRUSH_Y
	jmp	done_move_guybrush
move_guybrush_down:
	lda	#DIR_DOWN
	sta	GUYBRUSH_DIRECTION
	inc	GUYBRUSH_Y
	inc	GUYBRUSH_Y
	jmp	done_move_guybrush

guybrush_ud_done:

	lda	#$ff
	sta	DESTINATION_Y

done_move_guybrush:

	;====================================
	; draw guybrush
	;====================================

	lda	GUYBRUSH_X
	sta	XPOS
	lda	GUYBRUSH_Y
	sta	YPOS

	lda	GUYBRUSH_SIZE

	cmp	#GUYBRUSH_BIG
	beq	big_guybrush

	cmp	#GUYBRUSH_MEDIUM
	beq	medium_guybrush

	lda	GUYBRUSH_SIZE
	cmp	#GUYBRUSH_TINY
	beq	tiny_guybrush

small_guybrush:
	lda	#<guybrush_small_sprite
	sta	INL
	lda	#>guybrush_small_sprite
	jmp	really_draw_guybrush

tiny_guybrush:
	lda	#<guybrush_tiny_sprite
	sta	INL
	lda	#>guybrush_tiny_sprite
	jmp	really_draw_guybrush

medium_guybrush:
	lda	GUYBRUSH_DIRECTION	; 00/01 or 02/03 or 04/05 or 06/07
	and	#$fe
	tay

	lda	guybrush_med_sprites,Y
	sta	INL
	lda	guybrush_med_sprites+1,Y
	jmp	really_draw_guybrush

big_guybrush:
	lda	GUYBRUSH_Y			; always even
	lsr
	eor	GUYBRUSH_X
	and	#$1				; 0 or 1
	ora	GUYBRUSH_DIRECTION	; 00/01 or 02/03 or 04/05 or 06/07
	asl
	tay

	lda	guybrush_sprites,Y
	sta	INL
	lda	guybrush_sprites+1,Y

really_draw_guybrush:
	sta	INH
	jsr	put_sprite_crop


	;====================================
	; draw foreground sprites
	;====================================

	lda	LOCATION
	cmp	#MONKEY_LOOKOUT
	beq	do_draw_wall
	cmp	#MONKEY_POSTER
	beq	do_draw_house
	cmp	#MONKEY_BAR
	beq	do_draw_building
	cmp	#MONKEY_VOODOO1
	beq	do_draw_voodoo1
	cmp	#MONKEY_CHURCH
	beq	do_draw_church

	jmp	nothing_foreground

do_draw_wall:
	jsr	draw_wall
	jmp	nothing_foreground

do_draw_house:
	jsr	draw_house
	jmp	nothing_foreground

do_draw_building:
	jsr	draw_bar_fg_building
	jmp	nothing_foreground

do_draw_voodoo1:
	jsr	voodoo1_draw_foreground
	jmp	nothing_foreground

do_draw_church:
	jsr	draw_church_foreground
	jmp	nothing_foreground


nothing_foreground:


	;====================================
	; what are we pointing too
	;====================================

	jsr	where_do_we_point

	;====================================
	; update bottom bar
	;====================================

	jsr	update_bottom

	;====================================
	; draw pointer
	;====================================

	jsr	draw_pointer

	;====================================
	; page flip
	;====================================

	jsr	page_flip

	;====================================
	; handle keypress/joystick
	;====================================

	jsr	handle_keypress

	;====================================
	; keep in bounds
	;====================================

keep_in_bounds_smc:
	jsr	$0000

	;====================================
	; check if exiting room
	;====================================

check_exit_smc:
	jsr	$0000

	;====================================
	; inc frame count
	;====================================

	inc	FRAMEL
	bne	room_frame_no_oflo
	inc	FRAMEH
room_frame_no_oflo:

	;====================================
	; check level over
	;====================================

	lda	LEVEL_OVER
	bne	really_exit
	jmp	game_loop

really_exit:
	jmp	end_level



	;==========================
	; includes
	;==========================

	; level graphics
	.include	"graphics/graphics.inc"

	; level data
	.include	"leveldata_monkey.inc"


	.include	"end_level.s"
	.include	"text_print.s"
	.include	"gr_offsets.s"
	.include	"gr_fast_clear.s"
	.include	"keyboard.s"
	.include	"gr_copy.s"
	.include	"gr_putsprite_crop.s"
	.include	"joystick.s"
	.include	"gr_pageflip.s"
	.include	"decompress_fast_v2.s"
	.include	"draw_pointer.s"
	.include	"common_sprites.inc"
	.include	"guy.brush"

	; Locations

	.include	"monkey_lookout.s"
	.include	"monkey_poster.s"
	.include	"monkey_dock.s"
	.include	"monkey_bar.s"
	.include	"monkey_town.s"
	.include	"monkey_map.s"
	.include	"monkey_church.s"
	.include	"monkey_zipline.s"
	.include	"monkey_mansion.s"
	.include	"monkey_mansion_path.s"
	.include	"monkey_bar_inside1.s"
	.include	"monkey_bar_inside2.s"
	.include	"monkey_bar_inside3.s"
	.include	"monkey_voodoo1.s"
	.include	"monkey_voodoo2.s"


	; cutscenes
	.include	"chapter1.s"
	.include	"cutscene_lechuck.s"

	.include	"monkey_actions.s"
	.include	"update_bottom.s"

