	;=========================
	;=========================
	; elevator button pressed
	;=========================
	;=========================

elevator_button:

	; disable button temporarily

	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location18,Y

	; see which floor we are on

	ldy	#LOCATION_SOUTH_EXIT
	lda	location18,Y
	cmp	#OCTAGON_ELEVATOR_OUT
	bne	elevator_goto_library_level

elevator_goto_tower_level:

	; disable exit so we can't get off while running
	lda	#$ff
	sta	location18,Y

	; we want to go up the tower

	; animation starts at frame 5

	lda	#5
	sta	ANIMATE_FRAME

	rts

elevator_goto_library_level:
	; we want to move back to the library

	; disable exit so we can't get off while running
	lda	#$ff
	sta	location18,Y

	lda	#(5|128)
	sta	ANIMATE_FRAME

	jmp	change_location


	;===================================
	;===================================
	; open bookshelf (by touching frame)
	;===================================
	;===================================

open_bookshelf:

	; if already open, make noise

	ldy	#LOCATION_NORTH_EXIT
	lda	location8,Y
	cmp	#OCTAGON_BOOKSHELF_CLOSE
	beq	actually_open_shelf

	jsr	cant_noise

	rts

actually_open_shelf:

	; disable entering tunnel until complete
	; otherwise animate left still running

	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location1,Y

	; change background of bookshelf N

	ldy	#LOCATION_NORTH_BG
	lda	#<bookshelf_open_n_lzsa
	sta	location8,Y
	lda	#>bookshelf_open_n_lzsa
	sta	location8+1,Y

	; change background of door N

	lda	#<temple_door_closed_n_lzsa
	sta	location0,Y
	lda	#>temple_door_closed_n_lzsa
	sta	location0+1,Y

	; change background of center room S

	ldy	#LOCATION_SOUTH_BG
	lda	#<temple_center_closed_s_lzsa
	sta	location1,Y
	lda	#>temple_center_closed_s_lzsa
	sta	location1+1,Y

	; change background of door S

	lda	#<temple_door_closed_s_lzsa
	sta	location0,Y
	lda	#>temple_door_closed_s_lzsa
	sta	location0+1,Y

	; disable exit to S
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location0,Y

	; enable exit to N

	ldy	#LOCATION_NORTH_EXIT
	lda	#OCTAGON_TOWER_HALL1
	sta	location8,Y

	; start animation

	lda	#1
	sta	ANIMATE_FRAME

	rts

	;===================================
	;===================================
	; close bookshelf (by touching frame)
	;===================================
	;===================================


close_bookshelf:

	; if already closed, make noise

	ldy	#LOCATION_NORTH_EXIT
	lda	location8,Y
	cmp	#OCTAGON_BOOKSHELF_CLOSE
	bne	actually_close_shelf

	jsr	cant_noise

	rts

actually_close_shelf:

	; disable special until animation done

	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location1,Y

	; change background of bookshelf N

	ldy	#LOCATION_NORTH_BG
	lda	#<bookshelf_n_lzsa
	sta	location8,Y
	lda	#>bookshelf_n_lzsa
	sta	location8+1,Y

	; change background of door N

	lda	#<temple_door_n_lzsa
	sta	location0,Y
	lda	#>temple_door_n_lzsa
	sta	location0+1,Y

	; change background of center room S

	ldy	#LOCATION_SOUTH_BG
	lda	#<temple_center_s_lzsa
	sta	location1,Y
	lda	#>temple_center_s_lzsa
	sta	location1+1,Y

	; change background of door S

	lda	#<temple_door_s_lzsa
	sta	location0,Y
	lda	#>temple_door_s_lzsa
	sta	location0+1,Y

	; re-enable exit to S
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_S
	sta	location0,Y

	; disable exit to N

	ldy	#LOCATION_NORTH_EXIT
	lda	#OCTAGON_BOOKSHELF_CLOSE
	sta	location8,Y

	; start animation

	lda	#1
	sta	ANIMATE_FRAME

	rts





; TOWER ROTATION HINTS
; DOCK
; OCTOBER 11, 1984 10:04 AM
; JANUARY 17, 1207 5:46 AM
; NOVEMBER 23, 9791 6:57 PM


	;=============================
	; swirl the shelf picture frame
	;=============================
shelf_swirl:

	lda	ANIMATE_FRAME
	asl
	tay

	lda	shelf_swirl_sprites,Y
	sta	INL
	lda	shelf_swirl_sprites+1,Y
	sta	INH

	lda	#17

advance_swirl:
	sta	XPOS
	lda	#12
	sta	YPOS

	jsr	put_sprite_crop


	lda	FRAMEL
	and	#$f

	bne	shelf_swirl_no_inc

	inc	ANIMATE_FRAME

	lda	ANIMATE_FRAME
	cmp	#6
	bne	shelf_swirl_no_inc

	; reset animation, switch to bookshelf animation

	lda	LOCATION
	cmp	#OCTAGON_FRAME_SHELF
	bne	not_shelf

	lda	#1
	bne	done_shelf

not_shelf:
	lda	#10
done_shelf:

	sta	ANIMATE_FRAME

	lda	#OCTAGON_TEMPLE_CENTER
	sta	LOCATION

	jsr	change_location

shelf_swirl_no_inc:


	rts


	;=============================
	; swirl the door picture frame
	;=============================
door_swirl:

	lda	ANIMATE_FRAME
	asl
	tay

	lda	door_swirl_sprites,Y
	sta	INL
	lda	door_swirl_sprites+1,Y
	sta	INH

	lda	#16
	jmp	advance_swirl


cant_noise:
	ldx	#$ff
cant_noise_loop:
	bit	$c030
	nop
	nop
	nop
	bit	$c030
	nop
	nop
	nop
	dex
	bne	cant_noise_loop
	rts



	;=============================
	; animate_shelf_open
	;=============================
animate_shelf_open:

	lda	ANIMATE_FRAME
	cmp	#5
	bcs	animate_shelf_close

	asl
	tay

	lda	shelf_open_sprites,Y
	sta	INL
	lda	shelf_open_sprites+1,Y
	sta	INH

	lda	#15

advance_shelf_open:
	sta	XPOS
	lda	#14
	sta	YPOS

	jsr	put_sprite_crop


	lda	FRAMEL
	and	#$f

	bne	shelf_open_no_inc

	inc	ANIMATE_FRAME

	lda	ANIMATE_FRAME
	cmp	#4
	beq	update_final_shelf_bg
	cmp	#5
	bne	shelf_open_no_inc

	; reset animation/bg

	lda	#0
	sta	ANIMATE_FRAME

	; re-enable clicking

	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_ANY
	sta	location1,Y

shelf_open_no_inc:

	rts


	; 0 1 2 3 4 5 open
	;10 9 8 7 6 5 close

animate_shelf_close:

	lda	ANIMATE_FRAME
	sec
	sbc	#5

	asl
	tay

	lda	shelf_open_sprites,Y
	sta	INL
	lda	shelf_open_sprites+1,Y
	sta	INH

	lda	#15
	sta	XPOS
	lda	#14
	sta	YPOS

	jsr	put_sprite_crop


	lda	FRAMEL
	and	#$f

	bne	shelf_close_no_dec

	dec	ANIMATE_FRAME

	lda	ANIMATE_FRAME
	cmp	#6
	beq	update_final_shelf_bg
	cmp	#5
	bne	shelf_close_no_dec

	; reset animation

	lda	#0
	sta	ANIMATE_FRAME

	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_ANY
	sta	location1,Y

shelf_close_no_dec:

	rts


update_final_shelf_bg:

	ldy	#LOCATION_NORTH_EXIT
	lda	location8,Y
	cmp	#OCTAGON_BOOKSHELF_CLOSE
	bne	finally_open_shelf

	ldy	#LOCATION_NORTH_BG
	lda	#<temple_center_n_lzsa
	sta	location1,Y
	lda	#>temple_center_n_lzsa
	jmp	all_done_open_shelf

finally_open_shelf:
	ldy	#LOCATION_NORTH_BG
	lda	#<temple_center_open_n_lzsa
	sta	location1,Y
	lda	#>temple_center_open_n_lzsa

all_done_open_shelf:
	sta	location1+1,Y
	jsr	change_location

	rts

;===============================================
;===============================================
; animate elevator ride
;===============================================
;===============================================

animate_elevator_ride:

	lda	ANIMATE_FRAME
	bpl	elevator_going_up

	jmp	elevator_going_down

;===============================================
; elevator going up
;===============================================

elevator_going_up:
	; we are going up the tower

	; close door				5
	; draw lib through slats 		6
	; darkness				7
	; 1 cycle of up				 8, 9,10,11,12,13,14,15
	; 1 cycle of right			16,17,18,19,20,21,22,23
	; 1 cycle of up				24,25,26,27,28,29,30,31
	; close door, tower background		32,33
	; open door, tower
	; done

	ldy	#LOCATION_SOUTH_BG

	cmp	#5
	beq	up_close_door
	cmp	#7
	bcc	up_draw_lib			; blt
	beq	up_light_off
	cmp	#16
	bcc	up_animate_up
	cmp	#24
	bcc	up_animate_right
	cmp	#32
	bcc	up_animate_up
	cmp	#34
	bcc	up_light_on
	bcs	up_open_door_tower


up_close_door:
	; Y already LOCATION_SOUTH_BG
	lda	#<elevator_door_closed_s_lzsa
	sta	location18,Y
	lda	#>elevator_door_closed_s_lzsa
	sta	location18+1,Y

	jsr	change_location

	jsr	gr_copy_to_current

	jmp	up_draw_lib

up_light_off:
	; Y already LOCATION_SOUTH_BG
	lda	#<elevator_dark_s_lzsa
	sta	location18,Y
	lda	#>elevator_dark_s_lzsa
	sta	location18+1,Y

	jsr	change_location

up_draw_lib:
	jsr	draw_elevator_window_lib

	jmp	up_increment

up_animate_up:
	lda	ANIMATE_FRAME
	and	#$7
	asl
	tay

	lda	elevator_window_up_sprites,Y
	sta	INL
	lda	elevator_window_up_sprites+1,Y
	sta	INH

	lda	#17
	sta	XPOS
	lda	#10
	sta	YPOS

	jsr	put_sprite_crop

	jmp	up_increment

up_animate_right:

	lda	ANIMATE_FRAME
	and	#$7
	asl
	tay

	lda	elevator_window_left_sprites,Y
	sta	INL
	lda	elevator_window_left_sprites+1,Y
	sta	INH

	lda	#17
	sta	XPOS
	lda	#10
	sta	YPOS

	jsr	put_sprite_crop

	jmp	up_increment

up_light_on:
	; Y already LOCATION_SOUTH_BG

	lda	#<elevator_door_closed_s_lzsa
	sta	location18,Y
	lda	#>elevator_door_closed_s_lzsa
	sta	location18+1,Y

	jsr	change_location

	jsr	draw_elevator_window_tower

	jmp	up_increment

up_increment:
	lda	FRAMEL
	and	#$f
	bne	done_up_increment

	inc	ANIMATE_FRAME

done_up_increment:
	rts

up_open_door_tower:

	; change bg image

	; Y already LOCATION_SOUTH_BG

	lda	#<elevator_tower_s_lzsa
	sta	location18,Y
	lda	#>elevator_tower_s_lzsa
	sta	location18+1,Y

	; change exit

	lda	#OCTAGON_TOWER_BOOK

common_open_door:

	ldy	#LOCATION_SOUTH_EXIT
	sta	location18,Y

	; re-enable button
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_S
	sta	location18,Y

	lda	#0
	sta	ANIMATE_FRAME

	jmp	change_location


;===============================================
; elevator going down
;===============================================

elevator_going_down:
	; we want to move back to the library

	ldy	#LOCATION_SOUTH_BG

	and	#$7f

	cmp	#5
	beq	down_close_door
	cmp	#7
	bcc	down_draw_tower			; blt
	beq	down_light_off
	cmp	#16
	bcc	down_animate_down
	cmp	#24
	bcc	down_animate_left
	cmp	#32
	bcc	down_animate_down
	cmp	#34
	bcc	down_light_on
	bcs	down_open_door_tower


down_close_door:
	; Y already LOCATION_SOUTH_BG
	lda	#<elevator_door_closed_s_lzsa
	sta	location18,Y
	lda	#>elevator_door_closed_s_lzsa
	sta	location18+1,Y

	jsr	change_location

	jsr	gr_copy_to_current

	jmp	down_draw_tower

down_light_off:
	; Y already LOCATION_SOUTH_BG
	lda	#<elevator_dark_s_lzsa
	sta	location18,Y
	lda	#>elevator_dark_s_lzsa
	sta	location18+1,Y

	jsr	change_location

down_draw_tower:
	jsr	draw_elevator_window_tower

	jmp	down_increment

down_animate_down:
	lda	ANIMATE_FRAME
	and	#$7
	asl
	tay

	lda	elevator_window_down_sprites,Y
	sta	INL
	lda	elevator_window_down_sprites+1,Y
	sta	INH

	lda	#17
	sta	XPOS
	lda	#10
	sta	YPOS

	jsr	put_sprite_crop

	jmp	down_increment

down_animate_left:

	lda	ANIMATE_FRAME
	and	#$7
	asl
	tay

	lda	elevator_window_right_sprites,Y
	sta	INL
	lda	elevator_window_right_sprites+1,Y
	sta	INH

	lda	#17
	sta	XPOS
	lda	#10
	sta	YPOS

	jsr	put_sprite_crop

	jmp	down_increment

down_light_on:
	; Y already LOCATION_SOUTH_BG

	lda	#<elevator_door_closed_s_lzsa
	sta	location18,Y
	lda	#>elevator_door_closed_s_lzsa
	sta	location18+1,Y

	jsr	change_location

	jsr	draw_elevator_window_lib

	jmp	down_increment

down_increment:
	lda	FRAMEL
	and	#$f
	bne	done_down_increment

	inc	ANIMATE_FRAME

done_down_increment:
	rts

down_open_door_tower:
	; change south bg image
	ldy	#LOCATION_SOUTH_BG
	lda	#<elevator_lib_s_lzsa
	sta	location18,Y
	lda	#>elevator_lib_s_lzsa
	sta	location18+1,Y

	; change exit
	lda	#OCTAGON_ELEVATOR_OUT

	jmp	common_open_door



draw_elevator_window_lib:

	lda	#<elevator_window_lib_sprite
	sta	INL
	lda	#>elevator_window_lib_sprite

draw_window_common:

	sta	INH

	lda	#17
	sta	XPOS
	lda	#10
	sta	YPOS

	jsr	put_sprite_crop

	rts

draw_elevator_window_tower:

	lda	#<elevator_window_tower_sprite
	sta	INL
	lda	#>elevator_window_tower_sprite

	jmp	draw_window_common

;===================================================
;===================================================
; sprites
;===================================================
;===================================================

shelf_swirl_sprites:
	.word empty_swirl
	.word shelf_swirl1,shelf_swirl2,shelf_swirl3,shelf_swirl4
	.word empty_swirl

door_swirl_sprites:
	.word empty_swirl
	.word door_swirl1,door_swirl2,door_swirl3,door_swirl4
	.word empty_swirl

shelf_open_sprites:
	.word empty_swirl
	.word shelf_open1,shelf_open2,shelf_open3
	.word empty_swirl

shelf_close_sprites:
	.word empty_swirl
	.word shelf_open3,shelf_open2,shelf_open1
	.word empty_swirl


empty_swirl:
	.byte 1,1
	.byte	$AA

shelf_swirl1:
	.byte 7,6
	.byte $0d,$0d,$0d,$0d,$0d,$0d,$0d
	.byte $00,$00,$00,$d0,$d0,$08,$80
	.byte $00,$00,$80,$0d,$00,$dd,$88
	.byte $00,$88,$90,$00,$80,$08,$88
	.byte $00,$88,$90,$99,$00,$88,$00
	.byte $00,$98,$91,$90,$99,$98,$00

shelf_swirl2:
	.byte 7,6
	.byte $0d,$0d,$0d,$0d,$0d,$0d,$0d
	.byte $00,$00,$00,$08,$08,$80,$00
	.byte $90,$09,$08,$08,$90,$00,$88
	.byte $88,$00,$88,$00,$89,$00,$88
	.byte $88,$00,$00,$08,$00,$80,$08
	.byte $00,$99,$90,$90,$90,$90,$00

shelf_swirl3:
	.byte 7,6
	.byte $0d,$0d,$0d,$0d,$0d,$0d,$0d
	.byte $00,$00,$80,$80,$80,$00,$00
	.byte $80,$08,$80,$80,$80,$08,$89
	.byte $99,$00,$88,$80,$99,$00,$98
	.byte $00,$99,$d0,$d0,$09,$00,$99
	.byte $00,$90,$90,$90,$90,$99,$00

shelf_swirl4:
	.byte 7,6
	.byte $0d,$0d,$0d,$0d,$0d,$0d,$0d
	.byte $00,$00,$50,$00,$00,$00,$00
	.byte $00,$55,$00,$00,$90,$80,$00
	.byte $00,$85,$00,$08,$80,$04,$98
	.byte $00,$00,$08,$08,$00,$90,$09
	.byte $00,$90,$90,$90,$99,$90,$00


door_swirl1:
	.byte 7,5
	.byte $0d,$0d,$0d,$0d,$0d,$0d,$0d
	.byte $00,$00,$00,$07,$77,$70,$00
	.byte $00,$00,$00,$04,$47,$47,$00
	.byte $00,$00,$dd,$44,$47,$44,$00
	.byte $00,$00,$dd,$d4,$d0,$00,$00

door_swirl2:
	.byte 7,5
	.byte $0d,$0d,$0d,$7d,$0d,$0d,$0d
	.byte $00,$00,$d0,$d0,$07,$70,$00
	.byte $d0,$0d,$70,$70,$44,$77,$00
	.byte $dd,$00,$77,$04,$04,$77,$00
	.byte $99,$90,$90,$07,$07,$00,$00

door_swirl3:
	.byte 7,5
	.byte $0d,$0d,$0d,$0d,$0d,$0d,$0d
	.byte $00,$70,$07,$07,$00,$00,$00
	.byte $00,$77,$00,$44,$7d,$7d,$d0
	.byte $00,$07,$70,$74,$74,$77,$dd
	.byte $00,$00,$00,$00,$00,$90,$09

door_swirl4:
	.byte 7,5
	.byte $0d,$0d,$0d,$0d,$0d,$0d,$0d
	.byte $00,$70,$77,$47,$00,$00,$00
	.byte $00,$47,$77,$44,$00,$00,$00
	.byte $00,$00,$44,$44,$d4,$00,$00
	.byte $00,$00,$d0,$dd,$dd,$00,$00

shelf_open1:
	.byte 10,12
	.byte $88,$00,$00,$80,$88,$88,$80,$00,$00,$88
	.byte $08,$00,$88,$88,$88,$88,$88,$88,$00,$08
	.byte $00,$80,$88,$88,$88,$88,$88,$88,$88,$00
	.byte $08,$88,$98,$88,$98,$98,$08,$98,$98,$08
	.byte $00,$99,$99,$88,$99,$99,$00,$99,$99,$00
	.byte $58,$08,$58,$48,$08,$08,$08,$08,$28,$d8
	.byte $55,$dd,$55,$41,$30,$30,$00,$00,$11,$dd
	.byte $08,$08,$08,$68,$08,$08,$08,$08,$08,$48
	.byte $41,$41,$40,$6d,$11,$33,$11,$00,$11,$44
	.byte $58,$08,$d8,$08,$08,$08,$08,$08,$08,$08
	.byte $55,$44,$88,$30,$30,$00,$00,$60,$60,$00
	.byte $95,$94,$9d,$92,$92,$92,$90,$91,$91,$91

shelf_open2:
	.byte 10,12
	.byte $88,$00,$00,$80,$88,$88,$80,$00,$00,$88
	.byte $08,$00,$88,$88,$88,$88,$88,$88,$00,$08
	.byte $00,$80,$88,$88,$88,$88,$88,$88,$88,$00
	.byte $08,$88,$98,$88,$98,$98,$08,$98,$98,$08
	.byte $00,$99,$99,$88,$99,$99,$00,$99,$99,$00
	.byte $00,$99,$99,$88,$99,$99,$00,$99,$99,$00
	.byte $00,$99,$99,$77,$77,$77,$77,$79,$99,$00
	.byte $58,$08,$58,$48,$08,$08,$08,$08,$28,$d8
	.byte $85,$8d,$85,$81,$80,$80,$80,$80,$81,$8d
	.byte $10,$10,$00,$d6,$20,$30,$20,$00,$20,$44
	.byte $58,$08,$d8,$08,$08,$08,$08,$08,$08,$08
	.byte $95,$94,$98,$90,$90,$90,$90,$90,$90,$90

shelf_open3:
	.byte 10,12
	.byte $88,$00,$00,$80,$88,$88,$80,$00,$00,$88
	.byte $08,$00,$88,$88,$88,$88,$88,$88,$00,$08
	.byte $00,$80,$88,$88,$88,$88,$88,$88,$88,$00
	.byte $08,$88,$98,$88,$98,$98,$08,$98,$98,$08
	.byte $00,$99,$99,$88,$99,$99,$00,$99,$99,$00
	.byte $00,$99,$99,$88,$99,$99,$00,$99,$99,$00
	.byte $00,$99,$99,$77,$77,$77,$77,$79,$99,$00
	.byte $00,$58,$08,$58,$48,$08,$08,$28,$d8,$00
	.byte $80,$85,$8d,$85,$81,$80,$80,$81,$8d,$80
	.byte $10,$10,$00,$d6,$20,$30,$20,$00,$20,$44
	.byte $58,$08,$d8,$08,$08,$08,$08,$08,$08,$08
	.byte $95,$94,$98,$90,$90,$90,$90,$90,$90,$90



elevator_window_lib_sprite:
	.byte 5,7
	.byte $dd,$dd,$00,$dd,$dd
	.byte $0d,$00,$00,$8d,$dd
	.byte $00,$80,$00,$00,$08
	.byte $80,$08,$00,$f0,$00
	.byte $88,$90,$00,$00,$00
	.byte $88,$99,$00,$00,$00
	.byte $88,$99,$00,$00,$00

elevator_window_tower_sprite:
	.byte 5,7
	.byte $00,$88,$00,$00,$00
	.byte $00,$88,$00,$80,$80
	.byte $00,$88,$00,$dd,$00
	.byte $dd,$88,$00,$dd,$dd
	.byte $dd,$88,$00,$d8,$d8
	.byte $dd,$88,$00,$00,$5d
	.byte $dd,$88,$00,$d0,$d0

elevator_window_up_sprites:
	.word elevator_window_up1_sprite,elevator_window_up1_sprite
	.word elevator_window_up1_sprite,elevator_window_up2_sprite
	.word elevator_window_up3_sprite,elevator_window_up4_sprite
	.word elevator_window_up5_sprite,elevator_window_up5_sprite

elevator_window_down_sprites:
	.word elevator_window_up5_sprite,elevator_window_up5_sprite
	.word elevator_window_up5_sprite,elevator_window_up4_sprite
	.word elevator_window_up3_sprite,elevator_window_up2_sprite
	.word elevator_window_up1_sprite,elevator_window_up1_sprite

elevator_window_right_sprites:
	.word elevator_window_right1_sprite,elevator_window_right1_sprite
	.word elevator_window_right1_sprite,elevator_window_right2_sprite
	.word elevator_window_right3_sprite,elevator_window_right4_sprite
	.word elevator_window_right5_sprite,elevator_window_right5_sprite

elevator_window_left_sprites:
	.word elevator_window_right5_sprite,elevator_window_right5_sprite
	.word elevator_window_right5_sprite,elevator_window_right4_sprite
	.word elevator_window_right3_sprite,elevator_window_right2_sprite
	.word elevator_window_right1_sprite,elevator_window_right1_sprite



elevator_window_right1_sprite:
elevator_window_up1_sprite:
	.byte 5,7
	.byte $57,$57,$00,$57,$57
	.byte $55,$55,$00,$55,$55
	.byte $75,$75,$00,$75,$75
	.byte $55,$55,$00,$77,$55
	.byte $55,$55,$00,$77,$55
	.byte $57,$57,$00,$57,$57
	.byte $55,$55,$00,$55,$55

elevator_window_up2_sprite:
	.byte 5,7
	.byte $55,$55,$00,$77,$55
	.byte $57,$57,$00,$57,$57
	.byte $55,$55,$00,$55,$55
	.byte $75,$75,$00,$75,$75
	.byte $55,$55,$00,$77,$55
	.byte $55,$55,$00,$77,$55
	.byte $57,$57,$00,$57,$57

elevator_window_up3_sprite:
	.byte 5,7
	.byte $55,$55,$00,$77,$55
	.byte $55,$55,$00,$77,$55
	.byte $57,$57,$00,$57,$57
	.byte $55,$55,$00,$55,$55
	.byte $75,$75,$00,$75,$75
	.byte $55,$55,$00,$77,$55
	.byte $55,$55,$00,$77,$55

elevator_window_up4_sprite:
	.byte 5,7
	.byte $75,$75,$00,$75,$75
	.byte $55,$55,$00,$77,$55
	.byte $55,$55,$00,$77,$55
	.byte $57,$57,$00,$57,$57
	.byte $55,$55,$00,$55,$55
	.byte $75,$75,$00,$75,$75
	.byte $55,$55,$00,$77,$55

elevator_window_up5_sprite:
	.byte 5,7
	.byte $55,$55,$00,$55,$55
	.byte $75,$75,$00,$75,$75
	.byte $55,$55,$00,$77,$55
	.byte $55,$55,$00,$77,$55
	.byte $57,$57,$00,$57,$57
	.byte $55,$55,$00,$55,$55
	.byte $75,$75,$00,$75,$75

elevator_window_right2_sprite:
	.byte 5,7
	.byte $57,$57,$00,$57,$57
	.byte $55,$55,$00,$55,$55
	.byte $75,$75,$00,$75,$75
	.byte $55,$77,$00,$55,$55
	.byte $55,$77,$00,$55,$55
	.byte $57,$57,$00,$57,$57
	.byte $55,$55,$00,$55,$55

elevator_window_right3_sprite:
	.byte 5,7
	.byte $57,$57,$00,$57,$77
	.byte $55,$55,$00,$55,$77
	.byte $75,$75,$00,$75,$77
	.byte $55,$55,$00,$55,$55
	.byte $55,$55,$00,$55,$55
	.byte $57,$57,$00,$57,$77
	.byte $55,$55,$00,$55,$77

elevator_window_right4_sprite:
	.byte 5,7
	.byte $57,$57,$00,$57,$57
	.byte $55,$55,$00,$55,$55
	.byte $75,$75,$00,$75,$75
	.byte $55,$55,$00,$55,$55
	.byte $55,$55,$00,$55,$55
	.byte $57,$57,$00,$57,$57
	.byte $55,$55,$00,$55,$55

elevator_window_right5_sprite:
	.byte 5,7
	.byte $77,$57,$00,$57,$57
	.byte $77,$55,$00,$55,$55
	.byte $77,$75,$00,$75,$75
	.byte $55,$55,$00,$55,$55
	.byte $55,$55,$00,$55,$55
	.byte $77,$57,$00,$57,$57
	.byte $77,$55,$00,$55,$55


