; The interminable sub puzzle

; "We all live in a ramming submarine.." -- K. Boykin

; by deater (Vince Weaver) <vince@deater.net>




sub_selena_open:
	lda	#SUB_CLOSE_OPEN
	sta	LOCATION

	jmp	change_location

sub_selena_close:
	lda	#SUB_CLOSE
	sta	LOCATION

	jmp	change_location

sub_door_selena_open:
	lda	#SUB_INSIDE_BACK_OPEN
	sta	LOCATION

	jmp	change_location

sub_door_close:
	lda	#SUB_INSIDE_BACK
	sta	LOCATION

	jmp	change_location


	;=====================
	; sub controls
	;=====================


	;====================
	; toward_book
sub_controls_move_toward_book:

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
	jmp	change_location

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
	; moving
sub_controls_moving:

	; re-enable exit button
	ldy	#LOCATION_SPECIAL_EXIT
	lda	#DIRECTION_S
	sta	location6,Y				; SUB_INSIDE_BACK

	; change so we use normal (not split) mode when looking forward
	ldy	#LOCATION_EAST_EXIT_DIR
	lda	#DIRECTION_E
	sta	location6,Y				; SUB INSIDE_BACK
	sta	DIRECTION

	lda	CURSOR_Y
	cmp	#32
	bcc	sub_forward	; blt

	; "backward" taks us back to selena
sub_backward:

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

	lda	#SUB_INSIDE_FRONT_SELENA
	sta	LOCATION
	jmp	change_location

	; "forward" takes us to book
sub_forward:

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

	lda	#SUB_INSIDE_FRONT_BOOK
	sta	LOCATION
	jmp	change_location


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

; PLINK means you are there?

; forward goes forward
; backtrack takes you to previous locations?  has a stack?

; 37 locations in maze?

; red button plays noise again
;	red barrier if you can't go a direction, plays burrrrrrrrr
;	noise if you can't go
; if on wrong path, plays no noise at all?
; some paths take you to a direction not the one you left in
;	let's not do that to keep things simple

; buttons dark if can't press them

NOISE_NONE	= $00
NOISE_N		= $01

; each location
;	8 exits, 1 sound, 1 backtrack
;	39 locations = 390 bytes???
;

sub_loc0:	; entrance
sub_loc1:	; N(loc2) [backtrack takes us to entrance][N ]
	; N  NE   E  SE    S  SW   W  NW   backtrack    noise
.byte	  2,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_N
sub_loc2:	; W(loc3) S(loc1)				[W ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc3:	; N(loc4) E(loc2)				[N ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc4:	; E(loc5) S(loc3) N(loc16)		[E ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc5:	; E(loc6) W(loc4) N(loc17)		[E ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc6:	; S(loc7) W(loc5) NE(loc18)		[S bonk]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc7:	; S(loc8) N(loc6) E(loc20)		[S bonk]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc8:	; W(loc9) N(loc7) SE(loc22)		[W]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc9:	; SW(loc10) N(loc8)			[SW]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc10:	; W(loc11) NE(loc9) E(loc25) S(loc26)	[W]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc11:	; NW(loc12) E(loc10) S(loc27) SW(loc29)	[NW]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc12:	; NE(loc13) SE(loc11) W(loc32)		[NE]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc13:	; N(loc14) SW(loc12) NW(loc35)		[N]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc14:	; SE(loc15) S(loc13)			[SE]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc15:	; exit
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE

sub_loc16:	; S(loc4)					[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc17:	; S(loc5)					[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc18:	; SE[SW](loc6)	N (loc19)		[N plink]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc19:	; S(loc18)				[ no noise]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc20:	; W(loc7) SW(loc21)			[SW]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc21:	; NE(loc20)				[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc22:	; NW(loc8) SW(loc24) N(loc23)		[SW]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc23:	; S(loc22)				[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc24:	; NE(loc22)				[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc25:	; W(loc10)				[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc26:	; N(loc10)				[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc27:	; N(loc11) S(loc28)			[S]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc28:	; W(loc27)				[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc29:	; NE(loc11) S(loc30) W(loc31)		[S]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc30:	; N(loc29)				[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc31:	; E(loc29)				[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc32:	; E(loc12) S(loc33) N(loc34)		[S]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc33:	; N(loc32)				[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc34:	; S(loc32)				[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc35:	; SE(loc13) N(loc36)  W(loc37)		[W]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc36:	; S(loc35)				[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE
sub_loc37:	; E(loc35)				[ no noise ]
.byte	$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,	0,	NOISE_NONE

;	N, W, N, E, E
;	S, S, W, SW, W
;	NW, NE, N, SE




