	;=========================
	;=========================
	; elevator button pressed
	;=========================
	;=========================

elevator_button:

	; see which floor we are on

	ldy	#LOCATION_SOUTH_EXIT
	lda	location18,Y
	cmp	#OCTAGON_ELEVATOR_OUT
	bne	elevator_goto_library_level

elevator_goto_tower_level:
	; we want to go up the tower

	; change exit
	lda	#OCTAGON_TOWER_BOOK
	sta	location18,Y

	; change bg image

	ldy	#LOCATION_SOUTH_BG
	lda	#<elevator_tower_s_lzsa
	sta	location18,Y
	lda	#>elevator_tower_s_lzsa
	sta	location18+1,Y

	jmp	change_location

elevator_goto_library_level:
	; we want to move back to the library

	; change exit
	lda	#OCTAGON_ELEVATOR_OUT
	sta	location18,Y

	; change south bg image
	ldy	#LOCATION_SOUTH_BG
	lda	#<elevator_lib_s_lzsa
	sta	location18,Y
	lda	#>elevator_lib_s_lzsa
	sta	location18+1,Y

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

	; change background of center room N

	ldy	#LOCATION_NORTH_BG
;	lda	#<temple_center_open_n_lzsa
;	sta	location1,Y
;	lda	#>temple_center_open_n_lzsa
;	sta	location1+1,Y

	; change background of bookshelf N

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

	; change background of center room N

	ldy	#LOCATION_NORTH_BG
;	lda	#<temple_center_n_lzsa
;	sta	location1,Y
;	lda	#>temple_center_n_lzsa
;	sta	location1+1,Y

	; change background of bookshelf N

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
	ldx	#$50
cant_noise_loop:
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



