; The interminable sub puzzle

; "We all live in a ramming submarine.." -- K. Boykin

; by deater (Vince Weaver) <vince@deater.net>



	;===========================
	; open door of sub (outside)
	;===========================
sub_selena_open:
	lda	#SUB_CLOSE_OPEN
	sta	LOCATION

	jmp	change_location


	;============================
	; close door of sub (outside)
	;============================
sub_selena_close:
	lda	#SUB_CLOSE
	sta	LOCATION

	jmp	change_location

	;===============================
	; open door of sub (from inside)
	;===============================
sub_door_selena_open:
	lda	#SUB_INSIDE_BACK_OPEN
	sta	LOCATION

	jmp	change_location

	;================================
	; close door of sub (from inside)
	;================================
sub_door_close:
	lda	#SUB_INSIDE_BACK
	sta	LOCATION

	jmp	change_location


	;=====================
	; sub controls
	;=====================

	;======================
	; sub turn right
	;======================
sub_turn_right:

	jsr	click_speaker

	inc	SUB_DIRECTION
	lda	SUB_DIRECTION
	cmp	#8
	bne	no_turn_right_oflo

	lda	#0
	sta	SUB_DIRECTION

no_turn_right_oflo:

	lda	#SUB_ROTATE_RIGHT_PATH_PATH
	sta	ANIMATE_FRAME

	jmp	start_animating


	;======================
	; sub turn left
	;======================
sub_turn_left:

	jsr	click_speaker

	dec	SUB_DIRECTION
	lda	SUB_DIRECTION
	bpl	no_turn_left_oflo

	lda	#7
	sta	SUB_DIRECTION

no_turn_left_oflo:

	lda	#SUB_ROTATE_LEFT_PATH_PATH
	sta	ANIMATE_FRAME

	jmp	start_animating



start_animating:
	; clear frame count
	lda	#00
	sta	FRAMEL

	; disable controls
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location9,Y			; SUB_INSIDE_FRONT_MOVING

	rts

	;===============================
	; sub controls moving
	;===============================
sub_controls_moving:

	lda	CURSOR_X
	cmp	#11
	bcc	sub_button_pressed

	lda	CURSOR_Y
	cmp	#30
	bcc	sub_forward_pressed	; blt
	cmp	#34
	bcs	sub_backtrack_pressed

	lda	CURSOR_X
	cmp	#18
	bcc	sub_turn_left
	bcs	sub_turn_right

sub_button_pressed:
	; prints/plays noise again?
	; not necessary for us?

done_sub_controls_moving:
	rts



sub_forward_pressed:

	jsr	click_speaker

	jsr	sub_point_to_struct

	ldy	SUB_DIRECTION

	lda	(INL),Y
	bmi	cant_get_there_from_here

	; update to new location
	sta	SUB_LOCATION

	cmp	#15
	bne	done_forwarding

	jmp	sub_now_at_book

done_forwarding:

	lda	#SUB_MOVE_FORWARD_PATH_PATH
	sta	ANIMATE_FRAME

	jmp	start_animating

cant_get_there_from_here:
	jsr	short_beep

	rts

sub_backtrack_pressed:

	jsr	click_speaker

	jsr	sub_point_to_struct

	ldy	#BACKTRACK_DIR_OFFSET
	lda	(INL),Y
	sta	SUB_DIRECTION

	ldy	#BACKTRACK_OFFSET
	lda	(INL),Y
	sta	SUB_LOCATION

	bne	done_backtracking

	; if 0, back at selena side

	jmp	sub_back_to_selena

done_backtracking:

	lda	#SUB_MOVE_BACKWARD_PATH_PATH
	sta	ANIMATE_FRAME

	jmp	start_animating

	;==============================
	; helper to point to proper sub struct
sub_point_to_struct:

	lda	SUB_LOCATION
	asl
	tay
	lda	sub_locations,Y
	sta	INL
	lda	sub_locations+1,Y
	sta	INH

	rts


	;===========================================
	; in selena, pressed forward -- toward_book
sub_controls_move_toward_book:

	; Enter the maze
	lda	#1
	sta	SUB_LOCATION

	; disable exit button
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location6,Y				; SUB_INSIDE_BACK

	; change so we use split mode when looking E
	ldy	#LOCATION_EAST_EXIT_DIR
	lda	#DIRECTION_E|DIRECTION_SPLIT
	sta	location6,Y				; SUB INSIDE_BACK
	; any controls take us to moving
	sta	DIRECTION

	lda	#SUB_INSIDE_FRONT_MOVING
	sta	LOCATION
	jsr	change_location

	lda	#SUB_DOWN_FROM_SELENA
	sta	ANIMATE_FRAME

	jmp	start_animating

	;====================
	; toward_selena
sub_controls_move_toward_selena:

	; disable exit button
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#$ff
	sta	location6,Y				; SUB_INSIDE_BACK

	; change so we use split mode when looking E
	ldy	#LOCATION_EAST_EXIT_DIR
	lda	#DIRECTION_E|DIRECTION_SPLIT
	sta	location6,Y				; SUB INSIDE_BACK

	; any controls take us to moving
	sta	DIRECTION

	; change destination of front of sub
	ldy	#LOCATION_EAST_EXIT
	lda	#SUB_INSIDE_FRONT_MOVING
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN
	sta	location6,Y				; SUN_INSIDE_BACK

	lda	#SUB_INSIDE_FRONT_MOVING
	sta	LOCATION
	jmp	change_location




	;===============================
	; sub controls arrival at destination
	;===============================


sub_back_to_selena:

	;==============
	; back at selena

	; re-enable exit button
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_S
	sta	location6,Y				; SUB_INSIDE_BACK

	; change so we use normal (not split) mode when looking forward
	ldy	#LOCATION_EAST_EXIT_DIR
	lda	#DIRECTION_E
	sta	location6,Y				; SUB INSIDE_BACK
	sta	DIRECTION

	; change destination of open door
	ldy	#LOCATION_SOUTH_EXIT
	lda	#SUB_CLOSE_OPEN
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_N
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN

	; change destination of front of sub
	ldy	#LOCATION_EAST_EXIT
	lda	#SUB_INSIDE_FRONT_SELENA
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN
	sta	location6,Y				; SUN_INSIDE_BACK

	; change background of open door
	ldy	#LOCATION_SOUTH_BG
	lda	#<inside_sub_back_selena_s_lzsa
	sta	location7,Y
	lda	#>inside_sub_back_selena_s_lzsa
	sta	location7+1,Y				; SUB_INSIDE_BACK_OPEN

;	lda	#SUB_INSIDE_FRONT_SELENA
;	sta	LOCATION
;	jsr	change_location

	lda	#SUB_UP_TO_SELENA
	sta	ANIMATE_FRAME

	jmp	start_animating

	;==============
	; now at book

sub_now_at_book:

	; re-enable exit button
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_S
	sta	location6,Y				; SUB_INSIDE_BACK

	; change so we use normal (not split) mode when looking forward
	ldy	#LOCATION_EAST_EXIT_DIR
	lda	#DIRECTION_E
	sta	location6,Y				; SUB INSIDE_BACK
	sta	DIRECTION

	; change destination of open door
	ldy	#LOCATION_SOUTH_EXIT
	lda	#SUB_OUTSIDE_BOOK
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN

	ldy	#LOCATION_SOUTH_EXIT_DIR
	lda	#DIRECTION_S
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN

	; change destination of front of sub
	ldy	#LOCATION_EAST_EXIT
	lda	#SUB_INSIDE_FRONT_BOOK
	sta	location7,Y				; SUB_INSIDE_BACK_OPEN
	sta	location6,Y				; SUN_INSIDE_BACK

	; change background of open door
	ldy	#LOCATION_SOUTH_BG
	lda	#<inside_sub_back_book_s_lzsa
	sta	location7,Y
	lda	#>inside_sub_back_book_s_lzsa
	sta	location7+1,Y				; SUB_INSIDE_BACK_OPEN

	lda	#SUB_TO_BOOKROOM
	sta	ANIMATE_FRAME

	jmp	start_animating


; further research shows that the re-use of directions in mechanical
; was sort of co-incidental and they always intended for the sub
; puzzle to be stand-alone
;
;         1         2         3
;123456789012345678901234567890123456789
; FOR THE SAKE OF ARGUMENT IMAGINE YOU
; JUST SPENT 45 MINUTES NAVIGATING AN
; OBSCURE MAZE BASED ON A CLUE YOU WERE
; SUPPOSED TO NOTICE IN MECHANICAL AGE


; sub solution
;	N, W, N, E, E
;	S, S, W, SW, W
;	NW, NE, N, SE

; N -- PLINK
; S -- BONK
; E -- PWING
; W -- BREETT

; forward goes forward
; backtrack takes you to previous location?
; presumably backwards in the tree (not a stack)

; 37 locations in maze?

; red button plays noise again
;	red barrier if you can't go a direction, plays burrrrrrrrr
;	noise if you can't go
; if at dead end, plays no noise at all
; some paths take you to a direction not the one you left in
;	let's not do that to keep things simple

; buttons dark if can't press them

NOISE_NONE	= $00
NOISE_N		= $01
NOISE_NE	= $02
NOISE_E		= $03
NOISE_SE	= $04
NOISE_S		= $05
NOISE_SW	= $06
NOISE_W		= $07
NOISE_NW	= $08

sub_noises:
.word sub_noise_none
.word sub_noise_n,sub_noise_ne,sub_noise_e,sub_noise_se
.word sub_noise_s,sub_noise_sw,sub_noise_w,sub_noise_nw

sub_noise_none:
.byte	15,22,"           ",0
sub_noise_n:
.byte	15,22,"   PLINK   ",0
sub_noise_ne:
.byte	15,22,"PLINK-PWING",0
sub_noise_e:
.byte	15,22,"   PWING   ",0
sub_noise_se:
.byte	15,22," BONK-PWING",0
sub_noise_s:
.byte	15,22,"   BONK    ",0
sub_noise_sw:
.byte	15,22," BONK-BREET",0
sub_noise_w:
.byte	15,22,"   BREET   ",0
sub_noise_nw:
.byte	15,22,"PLINK-BREET",0



BT_N		= $00
BT_NE		= $01
BT_E		= $02
BT_SE		= $03
BT_S		= $04
BT_SW		= $05
BT_W		= $06
BT_NW		= $07

; each location
;	8 exits, 1 sound, 1 backtrack
;	39 locations = 390 bytes???
;

sub_locations:
.word	sub_loc0, sub_loc1, sub_loc2, sub_loc3, sub_loc4, sub_loc5
.word	sub_loc6, sub_loc7, sub_loc8, sub_loc9, sub_loc10,sub_loc11
.word	sub_loc12,sub_loc13,sub_loc14,sub_loc15,sub_loc16,sub_loc17
.word	sub_loc18,sub_loc19,sub_loc20,sub_loc21,sub_loc22,sub_loc23
.word	sub_loc24,sub_loc25,sub_loc26,sub_loc27,sub_loc28,sub_loc29
.word	sub_loc30,sub_loc31,sub_loc32,sub_loc33,sub_loc34,sub_loc35
.word	sub_loc36,sub_loc37

BACKTRACK_OFFSET = 8
BACKTRACK_DIR_OFFSET = 9
NOISE_OFFSET = 10

	; N  NE   E  SE    S  SW   W  NW   backtrack    noise
	;==============================================================
sub_loc0:	; entrance
.byte	  1,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,BT_N,		NOISE_NONE

sub_loc1:	; N(loc2) [backtrack takes us to entrance]	[N ]
.byte	  2,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,BT_N,		NOISE_N

sub_loc2:	; W(loc3) S(loc1)				[W ]
.byte	$FF,$FF,$FF,$FF,   1,$FF,  3,$FF,	1,BT_N,		NOISE_W

sub_loc3:	; N(loc4) E(loc2)				[N ]
.byte	  4,$FF,  2,$FF, $FF,$FF,$FF,$FF,	2,BT_W,		NOISE_N

sub_loc4:	; E(loc5) S(loc3) N(loc16)			[E ]
.byte	 16,$FF,  5,$FF,   3,$FF,$FF,$FF,	3,BT_N,		NOISE_E

sub_loc5:	; E(loc6) W(loc4) N(loc17)			[E ]
.byte	 17,$FF,  6,$FF, $FF,$FF,  4,$FF,	4,BT_E,		NOISE_E

sub_loc6:	; S(loc7) W(loc5) NE(loc18)			[S bonk]
.byte	$FF, 18,$FF,$FF,   7,$FF,  5,$FF,	5,BT_E,		NOISE_S

	; N  NE   E  SE    S  SW   W  NW   backtrack    noise
	;==============================================================
sub_loc7:	; S(loc8) N(loc6) E(loc20)			[S bonk]
.byte	  6,$FF, 20,$FF,   8,$FF,$FF,$FF,	6,BT_S,		NOISE_S

sub_loc8:	; W(loc9) N(loc7) SE(loc22)			[W]
.byte	  7,$FF,$FF, 22, $FF,$FF,  9,$FF,	7,BT_S,		NOISE_W

sub_loc9:	; SW(loc10) N(loc8)				[SW]
.byte	  8,$FF,$FF,$FF, $FF, 10,$FF,$FF,	8,BT_W,		NOISE_SW

sub_loc10:	; W(loc11) NE(loc9) E(loc25) S(loc26)		[W]
.byte	$FF,  9, 25,$FF,  26,$FF, 11,$FF,	9,BT_SW,	NOISE_W

sub_loc11:	; NW(loc12) E(loc10) S(loc27) SW(loc29)	[NW]
.byte	$FF,$FF, 10,$FF,  27,$FF,$FF, 12,	10,BT_W,	NOISE_NW

sub_loc12:	; NE(loc13) SE(loc11) W(loc32)			[NE]
.byte	$FF, 13,$FF, 11, $FF,$FF, 32,$FF,	11,BT_NW,	NOISE_NE

	; N  NE   E  SE    S  SW   W  NW   backtrack    noise
	;==============================================================
sub_loc13:	; N(loc14) SW(loc12) NW(loc35)			[N]
.byte	 14,$FF,$FF,$FF, $FF, 12,$FF, 35,	12,BT_NE,	NOISE_N

sub_loc14:	; SE(loc15) S(loc13)				[SE]
.byte	$FF,$FF,$FF, 15,  13,$FF,$FF,$FF,	13,BT_N,	NOISE_SE

sub_loc15:	; exit
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	14,BT_SE,	NOISE_NONE


sub_loc16:	; S(loc4)					[ no noise ]
.byte	$FF,$FF,$FF,$FF,   4,$FF,$FF,$FF,	4,BT_N,		NOISE_NONE

sub_loc17:	; S(loc5)					[ no noise ]
.byte	$FF,$FF,$FF,$FF,   5,$FF,$FF,$FF,	5,BT_N,		NOISE_NONE


	; N  NE   E  SE    S  SW   W  NW   backtrack    noise
	;==============================================================
sub_loc18:	; SE[SW](loc6)	N (loc19)			[N plink]
.byte	 19,$FF,$FF,  6, $FF,$FF,$FF,$FF,	6,BT_SW,	NOISE_N

sub_loc19:	; S(loc18)					[ no noise]
.byte	$FF,$FF,$FF,$FF,  18,$FF,$FF,$FF,	18,BT_N,	NOISE_NONE

sub_loc20:	; W(loc7) SW(loc21)				[SW]
.byte	$FF,$FF,$FF,$FF, $FF, 21,  7,$FF,	7,BT_E,		NOISE_SW

sub_loc21:	; NE(loc20)					[ no noise ]
.byte	$FF, 20,$FF,$FF, $FF,$FF,$FF,$FF,	20,BT_SW,	NOISE_NONE

sub_loc22:	; NW(loc8) SW(loc24) N(loc23)			[SW]
.byte	 23,$FF,$FF,$FF, $FF, 24,$FF,  8,	8,BT_SE,	NOISE_SW

sub_loc23:	; S(loc22)					[ no noise ]
.byte	$FF,$FF,$FF,$FF,  22,$FF,$FF,$FF,	22,BT_N,	NOISE_NONE

	; N  NE   E  SE    S  SW   W  NW   backtrack    noise
	;==============================================================
sub_loc24:	; NE(loc22)					[ no noise ]
.byte	$FF, 22,$FF,$FF, $FF,$FF,$FF,$FF,	22,BT_SW,	NOISE_NONE

sub_loc25:	; W(loc10)					[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF, 10,$FF,	10,BT_E,	NOISE_NONE

sub_loc26:	; N(loc10)					[ no noise ]
.byte	 10,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	10,BT_S,	NOISE_NONE

sub_loc27:	; N(loc11) S(loc28)				[S]
.byte	 11,$FF,$FF,$FF,  28,$FF,$FF,$FF,	11,BT_S,	NOISE_S

sub_loc28:	; W(loc27)					[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF, 27,$FF,	27,BT_E,	NOISE_NONE

sub_loc29:	; NE(loc11) S(loc30) W(loc31)			[S]
.byte	$FF, 11,$FF,$FF,  30,$FF, 31,$FF,	11,BT_SW,	NOISE_S

	; N  NE   E  SE    S  SW   W  NW   backtrack    noise
	;==============================================================
sub_loc30:	; N(loc29)					[ no noise ]
.byte	  29,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	29,BT_S,	NOISE_NONE

sub_loc31:	; E(loc29)					[ no noise ]
.byte	$FF,$FF, 29,$FF, $FF,$FF,$FF,$FF,	29,BT_W,	NOISE_NONE

sub_loc32:	; E(loc12) S(loc33) N(loc34)		[S]
.byte	 34,$FF, 12,$FF,  33,$FF,$FF,$FF,	12,BT_W,	NOISE_S

sub_loc33:	; N(loc32)					[ no noise ]
.byte	 32,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	32,BT_S,	NOISE_NONE

sub_loc34:	; S(loc32)					[ no noise ]
.byte	$FF,$FF,$FF,$FF,  32,$FF,$FF,$FF,	32,BT_N,	NOISE_NONE

sub_loc35:	; SE(loc13) N(loc36)  W(loc37)			[W]
.byte	 36,$FF,$FF, 13, $FF,$FF, 37,$FF,	13,BT_NW,	NOISE_W

	; N  NE   E  SE    S  SW   W  NW   backtrack    noise
	;==============================================================
sub_loc36:	; S(loc35)					[ no noise ]
.byte	$FF,$FF,$FF,$FF,  35,$FF,$FF,$FF,	35,BT_N,	NOISE_NONE

sub_loc37:	; E(loc35)					[ no noise ]
.byte	$FF,$FF, 35,$FF, $FF,$FF,$FF,$FF,	35,BT_W,	NOISE_NONE



	;============================
	; draw_sub
	;============================

draw_sub:
	;=================
	; draw direction

	; only if not animating
	lda	ANIMATE_FRAME
	bne	draw_sub_window

	lda	SUB_DIRECTION
	tay
	lda	sub_direction_xs,Y
	sta	XPOS

	lda	#30
	sta	YPOS

	tya
	asl
	tay
	lda	sub_direction_sprites,Y
	sta	INL
	lda	sub_direction_sprites+1,Y
	sta	INH

	jsr	put_sprite_crop


	;=====================
	; print sound effect

	; only if not animating

	jsr	sub_point_to_struct

	ldy	#NOISE_OFFSET
	lda	(INL),Y

	asl
	tay
	lda	sub_noises,Y
	sta	OUTL
	lda	sub_noises+1,Y
	sta	OUTH
	jsr	move_and_print

	;===================================
	; draw oustide (possibly animated)
draw_sub_window:
	; handle animation

	lda	ANIMATE_FRAME
	beq	done_animate

	asl
	tay

	lda	sub_animations,Y
	sta	INL
	lda	sub_animations+1,Y
	sta	INH

	lda	#16
	sta	XPOS
	lda	#8
	sta	YPOS

	jsr	put_sprite_crop


	; see if increment frame

	lda	FRAMEL
	and	#$f

	bne	dont_increment_animate

	inc	ANIMATE_FRAME

	lda	ANIMATE_FRAME
	asl
	tay
	lda	sub_animations+1,Y		; page number, if 0, done
	bne	dont_increment_animate

	; re-enable controls
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_E
	sta	location9,Y			; SUB_INSIDE_FRONT_MOVING

	; special case at ends

	lda	ANIMATE_FRAME
	cmp	#58
	beq	arrive_back_in_selena
	cmp	#73
	beq	arrive_at_bookroom

	jmp	done_done_animate

arrive_at_bookroom:
	lda	#SUB_INSIDE_FRONT_BOOK
	sta	LOCATION
	jsr	change_location
	jmp	done_done_animate

arrive_back_in_selena:
	lda	#SUB_INSIDE_FRONT_SELENA
	sta	LOCATION
	jsr	change_location

done_done_animate:
	lda	#0
	sta	ANIMATE_FRAME

dont_increment_animate:
	jmp	regular_path

done_animate:

	jsr	sub_point_to_struct

	ldy	SUB_DIRECTION
	lda	(INL),Y

	bpl	regular_path

blocked_path:

	lda	#18
	sta	XPOS
	lda	#8
	sta	YPOS

	lda	#<blocked_sprite
	sta	INL
	lda	#>blocked_sprite
	sta	INH
	jsr	put_sprite_crop

regular_path:




	rts


blocked_sprite:
	.byte	3,3
	.byte	$20,$21,$20
	.byte	$22,$20,$22
	.byte	$22,$20,$22

sub_direction_xs:
	.byte 29,27,29,27
	.byte 29,26,29,26

sub_direction_sprites:
	.word sub_direction_sprite_n
	.word sub_direction_sprite_ne
	.word sub_direction_sprite_e
	.word sub_direction_sprite_se
	.word sub_direction_sprite_s
	.word sub_direction_sprite_sw
	.word sub_direction_sprite_w
	.word sub_direction_sprite_nw

sub_direction_sprite_n:
	.byte 4,3
	.byte $ff,$F0,$00,$ff
	.byte $ff,$00,$0f,$ff
	.byte $0f,$00,$00,$0f

sub_direction_sprite_s:
	.byte 4,3
	.byte $f0,$0f,$0f,$0f
	.byte $00,$0f,$0f,$f0
	.byte $0f,$0f,$0f,$00

sub_direction_sprite_e:
	.byte 4,3
	.byte $ff,$0f,$0f,$0f
	.byte $ff,$0f,$0f,$00
	.byte $0f,$0f,$0f,$0f

sub_direction_sprite_w:
	.byte 5,3
	.byte $ff,$00,$00,$00,$ff
	.byte $ff,$f0,$0f,$f0,$ff
	.byte $0f,$00,$00,$00,$0f


sub_direction_sprite_ne:
	.byte 9,3
	.byte $ff,$F0,$00,$ff,$00,$ff,$0f,$0f,$0f
	.byte $ff,$00,$0f,$ff,$00,$ff,$0f,$0f,$00
	.byte $0f,$00,$00,$0f,$00,$0f,$0f,$0f,$0f

sub_direction_sprite_se:
	.byte 9,3
	.byte $f0,$0f,$0f,$0f,$00,$ff,$0f,$0f,$0f
	.byte $00,$0f,$0f,$f0,$00,$ff,$0f,$0f,$00
	.byte $0f,$0f,$0f,$00,$00,$0f,$0f,$0f,$0f

sub_direction_sprite_nw:
	.byte 10,3
	.byte $ff,$F0,$00,$ff,$00,$ff,$00,$00,$00,$ff
	.byte $ff,$00,$0f,$ff,$00,$ff,$f0,$0f,$f0,$ff
	.byte $0f,$00,$00,$0f,$00,$0f,$00,$00,$00,$0f

sub_direction_sprite_sw:
	.byte 10,3
	.byte $f0,$0f,$0f,$0f,$00,$ff,$00,$00,$00,$ff
	.byte $00,$0f,$0f,$f0,$00,$ff,$f0,$0f,$f0,$ff
	.byte $0f,$0f,$0f,$00,$00,$0f,$00,$00,$00,$0f


; animations
; 0 means none

SUB_ROTATE_RIGHT_PATH_PATH	=	1
SUB_ROTATE_LEFT_PATH_PATH	=	6
SUB_MOVE_FORWARD_PATH_PATH	=	11
SUB_MOVE_BACKWARD_PATH_PATH	=	21
SUB_DOWN_FROM_SELENA		=	31
SUB_UP_TO_SELENA		=	45
SUB_TO_BOOKROOM			=	59

sub_animations:
	.word	$0000		; none		; 0

	.word	rotate_right_path_path_frame1	; 1
	.word	rotate_right_path_path_frame2	; 2
	.word	rotate_right_path_path_frame3	; 3
	.word	rotate_right_path_path_frame4	; 4

	.word	$0000		; none		; 5

	.word	rotate_right_path_path_frame4	; 6
	.word	rotate_right_path_path_frame3	; 7
	.word	rotate_right_path_path_frame2	; 8
	.word	rotate_right_path_path_frame1	; 9

	.word	$0000		; none		; 10

	.word	move_forward_path_path_frame1	; 11
	.word	move_forward_path_path_frame2	; 12
	.word	move_forward_path_path_frame3	; 13
	.word	move_forward_path_path_frame4	; 14
	.word	draw_nothing_sprite		; 15
	.word	move_forward_path_path_frame1	; 16
	.word	move_forward_path_path_frame2	; 17
	.word	move_forward_path_path_frame3	; 18
	.word	move_forward_path_path_frame4	; 19

	.word	$0000		; none		; 20

	.word	move_forward_path_path_frame4	; 21
	.word	move_forward_path_path_frame3	; 22
	.word	move_forward_path_path_frame2	; 23
	.word	move_forward_path_path_frame1	; 24
	.word	draw_nothing_sprite		; 25
	.word	move_forward_path_path_frame4	; 26
	.word	move_forward_path_path_frame3	; 27
	.word	move_forward_path_path_frame2	; 28
	.word	move_forward_path_path_frame1	; 29

	.word	$0000		; none		; 30

	.word	down_from_selena_frame1		; 31
	.word	down_from_selena_frame2		; 32
	.word	down_from_selena_frame3		; 33
	.word	down_from_selena_frame4		; 34
	.word	down_from_selena_frame5		; 35
	.word	down_from_selena_frame6		; 36
	.word	down_from_selena_frame7		; 37
	.word	down_from_selena_frame8		; 38
	.word	down_from_selena_frame9		; 39
	.word	down_from_selena_frame10	; 40
	.word	down_from_selena_frame11	; 41
	.word	down_from_selena_frame12	; 42
	.word	rotate_right_path_path_frame1	; 43

	.word	$0000		; none		; 44

	.word	rotate_right_path_path_frame1	; 45
	.word	down_from_selena_frame12	; 46
	.word	down_from_selena_frame11	; 47
	.word	down_from_selena_frame10	; 48
	.word	down_from_selena_frame9		; 49
	.word	down_from_selena_frame8		; 50
	.word	down_from_selena_frame7		; 51
	.word	down_from_selena_frame6		; 52
	.word	down_from_selena_frame5		; 53
	.word	down_from_selena_frame4		; 54
	.word	down_from_selena_frame3		; 55
	.word	down_from_selena_frame2		; 56
	.word	down_from_selena_frame1		; 57

	.word	$0000		; none		; 58

	.word	move_forward_path_path_frame1	; 59
	.word	move_forward_path_path_frame2	; 60
	.word	up_to_bookroom_frame1		; 61
	.word	up_to_bookroom_frame2		; 62
	.word	up_to_bookroom_frame3		; 63
	.word	up_to_bookroom_frame4		; 64
	.word	up_to_bookroom_frame5		; 65
	.word	up_to_bookroom_frame1		; 66
	.word	up_to_bookroom_frame2		; 67
	.word	up_to_bookroom_frame3		; 68
	.word	up_to_bookroom_frame4		; 69
	.word	up_to_bookroom_frame5		; 70
	.word	up_to_bookroom_frame1		; 71
	.word	up_to_bookroom_frame2		; 72

	.word	$0000		; none		; 73




; move left/right
; frames 4 5 6 7 DONE

rotate_right_path_path_frame1:
	.byte 7,7
	.byte $00,$00,$00,$00,$00,$00,$88
	.byte $00,$00,$00,$00,$20,$00,$88
	.byte $00,$00,$00,$00,$22,$00,$88
	.byte $75,$50,$75,$00,$22,$00,$88
	.byte $77,$55,$77,$98,$98,$00,$88
	.byte $77,$55,$77,$88,$00,$00,$88
;	.byte $55,$55,$55,$77,$00,$00,$88
	.byte $55,$77,$55,$00,$00,$77,$88

rotate_right_path_path_frame2:
	.byte 7,7
	.byte $00,$00,$00,$00,$88,$00,$00
	.byte $00,$00,$20,$00,$88,$00,$20
	.byte $00,$00,$22,$00,$88,$00,$22
	.byte $75,$00,$22,$00,$88,$00,$22
	.byte $77,$98,$98,$00,$88,$00,$98
	.byte $77,$88,$00,$00,$88,$00,$00
;	.byte $55,$77,$00,$00,$88,$00,$00
	.byte $55,$77,$00,$00,$88,$77,$00

rotate_right_path_path_frame3:
	.byte 7,7
	.byte $00,$00,$88,$00,$00,$00,$00
	.byte $20,$00,$88,$00,$20,$00,$00
	.byte $22,$00,$88,$00,$22,$00,$00
	.byte $22,$00,$88,$00,$22,$00,$75
	.byte $98,$00,$88,$00,$98,$98,$77
	.byte $00,$00,$88,$00,$00,$88,$77
;	.byte $00,$00,$88,$00,$00,$77,$55
	.byte $00,$77,$88,$00,$00,$77,$55

rotate_right_path_path_frame4:
	.byte 7,7
	.byte $88,$00,$00,$00,$00,$00,$00
	.byte $88,$00,$20,$00,$00,$00,$00
	.byte $88,$00,$22,$00,$00,$00,$00
	.byte $88,$00,$22,$00,$75,$50,$75
	.byte $88,$00,$98,$98,$77,$55,$77
	.byte $88,$00,$00,$88,$77,$55,$77
;	.byte $88,$00,$00,$77,$55,$55,$55
	.byte $88,$77,$00,$55,$55,$77,$55


; move forward/back
; frames 12 13 14 15 DONE

move_forward_path_path_frame1:
	.byte 7,7
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $22,$00,$00,$00,$00,$00,$22
	.byte $22,$00,$75,$50,$75,$00,$22
	.byte $22,$00,$77,$55,$77,$00,$22
	.byte $98,$98,$77,$55,$77,$98,$98
	.byte $00,$77,$55,$55,$55,$77,$00

move_forward_path_path_frame2:
	.byte 7,7
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$75,$50,$75,$00,$00
	.byte $00,$00,$77,$55,$77,$00,$00
	.byte $00,$00,$77,$55,$77,$00,$00
	.byte $98,$77,$55,$55,$55,$77,$98

move_forward_path_path_frame3:
	.byte 7,7
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$20,$00,$20,$00,$00
	.byte $00,$80,$22,$00,$22,$80,$00
	.byte $00,$00,$75,$50,$75,$00,$00
	.byte $00,$00,$77,$55,$77,$00,$00
	.byte $00,$00,$77,$55,$77,$00,$00
	.byte $00,$77,$55,$55,$55,$77,$00

move_forward_path_path_frame4:
	.byte 7,7
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$22,$00,$00,$00,$22,$00
	.byte $00,$22,$00,$00,$00,$22,$00
	.byte $08,$98,$75,$50,$75,$98,$08
	.byte $00,$00,$77,$55,$77,$88,$00
	.byte $00,$00,$77,$55,$77,$00,$00
	.byte $00,$77,$55,$55,$55,$77,$00

draw_nothing_sprite:
	.byte	1,1
	.byte	$AA

; move down from selena

down_from_selena_frame1:
	.byte 7,7
	.byte $00,$50,$50,$70,$50,$50,$00
	.byte $00,$55,$f0,$77,$f0,$55,$00
	.byte $00,$55,$f7,$77,$f7,$55,$00
	.byte $00,$55,$50,$17,$50,$55,$00
	.byte $20,$20,$20,$20,$20,$20,$20
	.byte $05,$55,$55,$55,$55,$55,$05
	.byte $15,$05,$15,$15,$05,$15,$15

down_from_selena_frame2:
	.byte 7,7
	.byte $00,$55,$f0,$77,$f0,$55,$00
	.byte $00,$55,$f7,$77,$f7,$55,$00
	.byte $00,$55,$50,$17,$50,$55,$00
	.byte $20,$20,$20,$20,$20,$20,$20
	.byte $05,$55,$55,$55,$55,$55,$05
	.byte $15,$05,$15,$15,$05,$15,$15
	.byte $51,$50,$51,$51,$50,$51,$51

down_from_selena_frame3:
	.byte 7,7
	.byte $f7,$55,$00,$55,$f7,$77,$f7
	.byte $50,$55,$00,$55,$50,$17,$50
	.byte $20,$20,$20,$20,$20,$20,$20
	.byte $55,$55,$05,$55,$55,$55,$55
	.byte $05,$15,$15,$05,$15,$15,$05
	.byte $50,$51,$51,$50,$51,$51,$50
	.byte $88,$88,$88,$88,$88,$88,$88

down_from_selena_frame4:
	.byte 7,7
	.byte $50,$17,$50,$55,$00,$55,$50
	.byte $20,$20,$20,$20,$20,$20,$20
	.byte $55,$55,$55,$55,$05,$55,$55
	.byte $15,$15,$05,$15,$15,$05,$15
	.byte $51,$51,$50,$51,$51,$50,$51
	.byte $88,$88,$88,$88,$88,$88,$88
	.byte $00,$00,$00,$00,$00,$00,$00

down_from_selena_frame5:
	.byte 7,7
	.byte $20,$20,$20,$20,$20,$20,$20
	.byte $05,$55,$55,$55,$55,$55,$05
	.byte $15,$05,$15,$15,$05,$15,$15
	.byte $51,$50,$51,$51,$50,$51,$51
	.byte $88,$88,$88,$88,$88,$88,$88
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00

down_from_selena_frame6:
	.byte 7,7
	.byte $55,$55,$05,$55,$55,$55,$55
	.byte $05,$15,$15,$05,$15,$15,$05
	.byte $50,$51,$51,$50,$51,$51,$50
	.byte $88,$88,$88,$88,$88,$88,$88
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$88,$88,$88,$00,$00,$00


down_from_selena_frame7:
	.byte 7,7
	.byte $15,$15,$05,$15,$15,$05,$15
	.byte $51,$51,$50,$51,$51,$50,$51
	.byte $88,$88,$88,$88,$88,$88,$88
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$88,$88,$88,$00
	.byte $00,$00,$00,$00,$88,$00,$00

down_from_selena_frame8:
	.byte 7,7
	.byte $51,$50,$51,$51,$50,$51,$51
	.byte $88,$88,$88,$88,$88,$88,$88
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$88,$88
	.byte $00,$00,$00,$00,$00,$00,$88
	.byte $00,$00,$00,$20,$00,$00,$88

down_from_selena_frame9:
	.byte 7,7
	.byte $88,$88,$88,$88,$88,$88,$88
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $20,$00,$00,$00,$00,$00,$20
	.byte $22,$00,$00,$00,$00,$00,$22



down_from_selena_frame10:
	.byte 7,7
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $88,$88,$00,$00,$00,$00,$00
	.byte $88,$00,$20,$00,$00,$00,$00
	.byte $88,$00,$22,$00,$00,$00,$00
	.byte $88,$00,$22,$00,$75,$50,$75

down_from_selena_frame11:
	.byte 7,7
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$88,$88,$88,$00,$00,$00
	.byte $00,$00,$88,$00,$00,$00,$00
	.byte $20,$00,$88,$00,$20,$00,$00
	.byte $22,$00,$88,$00,$22,$00,$00
	.byte $22,$00,$88,$00,$22,$00,$75
	.byte $98,$00,$88,$00,$98,$98,$77

down_from_selena_frame12:
	.byte 7,7
	.byte $00,$00,$00,$88,$88,$88,$00
	.byte $00,$00,$00,$00,$88,$00,$00
	.byte $00,$00,$20,$00,$88,$00,$20
	.byte $00,$00,$22,$00,$88,$00,$22
	.byte $75,$00,$22,$00,$88,$00,$22
	.byte $77,$98,$98,$00,$88,$00,$98
	.byte $77,$88,$00,$00,$88,$00,$00

; zoom through tunnels to book

up_to_bookroom_frame1:
	.byte 7,7
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$70,$50,$70,$00,$00
	.byte $00,$00,$77,$55,$55,$77,$00
	.byte $00,$77,$55,$55,$55,$55,$77
	.byte $00,$77,$55,$55,$55,$55,$77

up_to_bookroom_frame2:
	.byte 7,7
	.byte $00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$dd,$0d,$dd,$00,$00
	.byte $00,$00,$dd,$00,$dd,$00,$00
	.byte $00,$00,$75,$50,$75,$00,$00
	.byte $00,$00,$77,$55,$55,$77,$00
	.byte $00,$77,$55,$55,$55,$55,$77
	.byte $00,$77,$55,$55,$55,$55,$77

up_to_bookroom_frame3:
	.byte 7,7
	.byte $00,$00,$dd,$0d,$0d,$dd,$00
	.byte $00,$00,$dd,$00,$00,$dd,$00
	.byte $00,$00,$dd,$00,$00,$dd,$00
	.byte $00,$00,$dd,$50,$70,$dd,$00
	.byte $00,$00,$75,$55,$55,$75,$00
	.byte $00,$77,$55,$55,$55,$55,$77
	.byte $00,$77,$55,$55,$55,$55,$77

up_to_bookroom_frame4:
	.byte 7,7
	.byte $00,$dd,$00,$00,$00,$00,$dd
	.byte $00,$dd,$00,$00,$00,$00,$dd
	.byte $00,$dd,$00,$00,$00,$00,$dd
	.byte $00,$dd,$70,$50,$70,$00,$dd
	.byte $00,$dd,$77,$55,$55,$77,$dd
	.byte $00,$75,$55,$55,$55,$55,$75
	.byte $00,$77,$55,$55,$55,$55,$77

up_to_bookroom_frame5:
	.byte 7,7
	.byte $dd,$00,$00,$00,$00,$00,$dd
	.byte $dd,$00,$00,$00,$00,$00,$dd
	.byte $dd,$00,$00,$00,$00,$00,$dd
	.byte $dd,$00,$70,$50,$70,$00,$dd
	.byte $dd,$00,$77,$55,$55,$77,$dd
	.byte $dd,$77,$55,$55,$55,$55,$dd
	.byte $5d,$77,$55,$55,$55,$55,$5d


