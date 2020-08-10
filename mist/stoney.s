; The Stone Ship level

; o/~ The monument of granite sent a beam into my eye o/~

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"
	.include "common_defines.inc"
	.include "common_routines.inc"

stoney_start:
	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	bit	SET_GR
	bit	PAGE0
	bit	LORES
	bit	FULLGR

	;=================
	; set up location
	;=================

	lda	#<locations
	sta	LOCATIONS_L
	lda	#>locations
	sta	LOCATIONS_H

	lda	#0
	sta	DRAW_PAGE
	sta	LEVEL_OVER

	; resets if you leave and come back
	sta	BATTERY_CHARGE

	; init cursor

	lda	#20
	sta	CURSOR_X
	sta	CURSOR_Y

	; set up initial location

	jsr	change_location

	; make sure book access and lights set up right
	jsr	update_compass_state
	jsr	update_tunnel_lights
	jsr	update_pump_state

	lda	#1
	sta	CURSOR_VISIBLE		; visible at first

	lda	#0
	sta	ANIMATE_FRAME

game_loop:
	;=================
	; reset things
	;=================

	lda	#0
	sta	IN_SPECIAL
	sta	IN_RIGHT
	sta	IN_LEFT


	;====================================
	; turn lights off (if applicable)
	;====================================

	; first check ship_lights
check_ship_lights:
	lda	COMPASS_STATE
	bne	check_tunnel_lights

	; turn off the ship cabin lights if applicable
	lda	LOCATION
	cmp	#STONEY_BOOK_STAIRS1
	beq	turn_off_the_lights
	cmp	#STONEY_BOOK_STAIRS2
	beq	turn_off_the_lights
	cmp	#STONEY_BOOK_ROOM
	beq	turn_off_the_lights

check_tunnel_lights:
	lda	BATTERY_CHARGE
	bne	dont_touch_lights

	lda	LOCATION
	cmp	#STONEY_LEFT_TUNNEL1
	beq	turn_off_the_lights
	cmp	#STONEY_LEFT_TUNNEL2
	beq	turn_off_the_lights
	cmp	#STONEY_LEFT_AIRLOCK
	beq	turn_off_the_lights
	cmp	#STONEY_CRAWLWAY_LEFT
	beq	turn_off_the_lights
	cmp	#STONEY_COMPASS_ROOM_LEFT
	beq	turn_off_the_lights
	cmp	#STONEY_COMPASS_ROSE_LEFT
	beq	turn_off_the_lights
	cmp	#STONEY_RIGHT_TUNNEL1
	beq	turn_off_the_lights
	cmp	#STONEY_RIGHT_TUNNEL2
	beq	turn_off_the_lights
	cmp	#STONEY_RIGHT_AIRLOCK
	beq	turn_off_the_lights
	cmp	#STONEY_CRAWLWAY_RIGHT
	beq	turn_off_the_lights
	cmp	#STONEY_COMPASS_ROOM_RIGHT
	beq	turn_off_the_lights
	cmp	#STONEY_COMPASS_ROSE_RIGHT
	beq	turn_off_the_lights
	cmp	#STONEY_CRAWLWAY_ENTRANCE_LEFT
	beq	turn_off_the_lights
	cmp	#STONEY_CRAWLWAY_ENTRANCE_RIGHT
	bne	dont_touch_lights

turn_off_the_lights:
	jsr	dark_translate

dont_touch_lights:


	;====================================
	; copy background to current page
	;====================================

	jsr	gr_copy_to_current

	;====================================
	; handle special-case forground logic
	;====================================

	; check to see if draw compass light
	jsr	compass_draw_light


	; check doorways for water/darkness
	lda	LOCATION
	cmp	#STONEY_DOORWAY1
	beq	handle_doorway1
	cmp	#STONEY_DOORWAY2
	beq	handle_doorway2
	cmp	#STONEY_RIGHT_TUNNEL1
	beq	handle_doorway_light
	cmp	#STONEY_LEFT_TUNNEL1
	beq	handle_doorway_light
	cmp	#STONEY_LEFT_AIRLOCK
	beq	handle_airlock_doorknob
	cmp	#STONEY_RIGHT_AIRLOCK
	beq	handle_airlock_doorknob
	cmp	#STONEY_ARRIVAL
	beq	handle_exit_tunnel

	bne	not_a_doorway
handle_exit_tunnel:
	jsr	draw_exit_tunnel
	jmp	not_a_doorway

handle_doorway1:
	jsr	draw_doorway1
	jmp	not_a_doorway
handle_doorway2:
	jsr	draw_doorway2
	jmp	not_a_doorway
handle_doorway_light:
	jsr	draw_light_doorway
	jmp	not_a_doorway
handle_airlock_doorknob:
	jsr	draw_airlock_doorknob
	jmp	not_a_doorway

not_a_doorway:


	lda	LOCATION

	cmp	#STONEY_BOOK_TABLE_OPEN
	beq	animate_mist_book
	cmp	#STONEY_RED_DRESSER_OPEN
	beq	fg_draw_red_page
	cmp	#STONEY_BLUE_ROOM
	beq	fg_draw_blue_page
	cmp	#STONEY_UMBRELLA
	beq	draw_umbrella_light
	cmp	#STONEY_LIGHTHOUSE_UPSTAIRS
	beq	draw_crank_handle
	cmp	#STONEY_LIGHTHOUSE_BATTERY
	beq	draw_battery_level
	cmp	#STONEY_BOOK_TABLE
	beq	animate_magic_table
	cmp	#STONEY_TELESCOPE_VIEW
	beq	draw_telescope_view
	cmp	#STONEY_TRUNK_CLOSE
	beq	fg_draw_trunk_close
	cmp	#STONEY_LIGHTHOUSE_INSIDE
	beq	fg_draw_inside_lighthouse

	jmp	nothing_special

animate_magic_table:

	jsr	do_animate_magic_table
	jmp	nothing_special

animate_mist_book:
	lda     ANIMATE_FRAME
	cmp	#6
	bcc	mist_book_good			; blt

	lda	#0
	sta	ANIMATE_FRAME

mist_book_good:

	asl
	tay
	lda	mist_movie,Y
	sta	INL
	lda	mist_movie+1,Y
	sta	INH

	lda	#24
	sta	XPOS
	lda	#12
	sta	YPOS

	jsr	put_sprite_crop

	lda	FRAMEL
	and	#$f
	bne	done_animate_mist_book

	inc	ANIMATE_FRAME

done_animate_mist_book:
	jmp	nothing_special

fg_draw_red_page:
	jsr	draw_red_page
	jmp	nothing_special

fg_draw_blue_page:
	jsr     draw_blue_page
	jmp     nothing_special

draw_umbrella_light:
	jsr	do_draw_umbrella_light
	jmp	nothing_special

draw_crank_handle:
	jsr	do_draw_crank_handle
	jmp	nothing_special

draw_battery_level:
	jsr	do_draw_battery_level
	jmp	nothing_special


draw_telescope_view:
	jsr	display_telescope
	jmp	nothing_special

fg_draw_trunk_close:
	jsr	draw_trunk_close
	jmp	nothing_special

fg_draw_inside_lighthouse:
	jsr	draw_inside_lighthouse
	jmp	nothing_special

nothing_special:

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

stoney_take_red_page:
	lda	#STONEY_PAGE
	jmp	take_red_page

stoney_take_blue_page:
	lda	#STONEY_PAGE
	jmp	take_blue_page


	;=============================
	; handle pages
	;=============================

draw_red_page:

	lda     RED_PAGES_TAKEN
	and	#STONEY_PAGE
	bne	no_draw_page

	lda	#14
	sta	XPOS
	lda	#36
	sta	YPOS

	lda	#<red_page_sprite
	sta	INL
	lda	#>red_page_sprite
	sta	INH

	jmp	put_sprite_crop		; tail call

draw_blue_page:

	lda	DIRECTION
	cmp	#DIRECTION_W
	bne	no_draw_page

	lda	BLUE_PAGES_TAKEN
	and	#STONEY_PAGE
	bne	no_draw_page

	lda	#18
	sta	XPOS
	lda	#30
	sta	YPOS

	lda	#<blue_page_sprite
	sta	INL
	lda	#>blue_page_sprite
	sta	INH

	jmp	put_sprite_crop         ; tail call

no_draw_page:
	rts

	;======================
	; handle half message
stoney_half_message:

	lda	#STONEY_BLUE_HALFMESSAGE
	sta	LOCATION

	jsr	change_location

	bit	SET_TEXT		; set text mode

	rts



	;==========================
	; includes
	;==========================

	; level graphics
	.include	"graphics_stoney/stoney_graphics.inc"

	; linking books
	.include	"link_book_mist.s"

	; puzzles
	.include	"stoney_puzzles.s"
	.include	"handle_pages.s"

	.include	"lights_off.s"
	.include	"simple_sounds.s"
	.include	"hlin_list.s"

	; level data
	.include	"leveldata_stoney.inc"


