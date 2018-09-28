; Lo-res cycle-counting water transparency hack

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
FRAMEBUFFER	= $00	; $00 - $0F
YPOS		= $10
YPOS_SIN	= $11
CH		= $24
CV		= $25
GBASL		= $26
GBASH		= $27
BASL		= $28
BASH		= $29
MASK		= $2E
COLOR		= $30
FRAME		= $60
MB_VALUE	= $91
BIRD_STATE	= $E0
BIRD_DIR	= $E1
DRAW_PAGE	= $EE
LASTKEY		= $F1
PADDLE_STATUS	= $F2
XPOS		= $F3
OLD_XPOS	= $F4
TEMP		= $FA
TEMPY		= $FB
INL		= $FC
INH		= $FD
OUTL		= $FE
OUTH		= $FF

; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
PAGE0	= $C054 ; Page0
PAGE1	= $C055 ; Page1
LORES	= $C056	; Enable LORES graphics
PADDLE_BUTTON0 = $C061
PADDL0	= $C064
PTRIG	= $C070

; ROM routines

TEXT	= $FB36				;; Set text mode
HOME	= $FC58				;; Clear the text screen
WAIT	= $FCA8				;; delay 1/2(26+27A+5A^2) us

; location we don't care about

DUMMY	= $300

waterfall_demo:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	PAGE0

	;===================
	; init vars
	lda	#0
	sta	BIRD_DIR
	sta	BIRD_STATE
	sta	FRAME
	sta	OLD_XPOS

	lda	#4
	sta	DRAW_PAGE
	sta	XPOS

	;===================
	; Mockingboard
	jsr	mockingboard_init

	; Enable channel A tone+noise

	ldx     #7				; 2
	lda	#$36				; 2
	sta	MB_VALUE			; 3
	jsr     write_ay_both			; 6+65

	; enable white noise

	ldx     #6				; 2
	lda	#1				; 2
	sta	MB_VALUE			; 3
	jsr     write_ay_both                   ; 6+65
                                        ;===============
                                        ;       78


	;=============================
	; Load foreground to graphic page1 (apple page2)

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00

	lda	#<waterfall_page1
	sta	GBASL
	lda	#>waterfall_page1
	sta	GBASH
	jsr	load_rle_gr

	jsr	gr_copy_to_current	; copy to page1

	;=============================
	; Load bg to memory

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00

	lda	#<waterfall_page2
	sta	GBASL
	lda	#>waterfall_page2
	sta	GBASH
	jsr	load_rle_gr


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	jsr	gr_copy_to_current		; 6+ 9292

	; now we have 322 left

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	; 322 - 12 = 310
	; -3 for jmp
	; 307

	; Try X=9 Y=6 cycles=307

	ldy	#6							; 2
wfloopA:ldx	#9							; 2
wfloopB:dex								; 2
        bne	wfloopB							; 2nt/3
        dey								; 2
	bne	wfloopA							; 2nt/3

        jmp     display_loop

jump_table:
	.word	(display_even-1)
	.word	(display_odd-1)
	.word	(display_three-1)
	.word	(display_four-1)

.align  $100


	;================================================
	; Display Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; jump_table
	; 		38 + display_odd

	; we have 3 (the jmp back)
	;		 = 3 cycles that need to be eaten by the vblank

display_loop:
	inc	FRAME						; 5
	lda	FRAME						; 3
	and	#$30						; 2

	; 0011 0000, so more or less div by 16, 3.75Hz

	lsr							; 2
	lsr							; 2
	lsr							; 2
	tay							; 2 ; 18

	lda	jump_table+1,y					; 4
	pha							; 3
	lda	jump_table,y					; 4
	pha							; 3
	rts							; 6 ; 38

display_loop_return:

vblank:
	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be         4550
	;				 -3 letfover from HBLANK code
	;				** -9
	;				-49 check for keypress
	;			      -2252 copy screen
	;			      -2231 draw sprite
	;			=============
	;			      15 cycles

	; 15 cycles
	inc	YPOS		; 5
	nop			; 2
	nop			; 2
	lda	YPOS		; 3
	lda	YPOS		; 3



	;=========================
	; Clear background
	;=========================

	jsr	gr_copy_row22					; 6+ 2246
							;=========
							;	2252


	;==========================
	; draw bird sprite
	;==========================
	; 					8 prefix
	; bird_walk_right=	14 + 2175	2206 (need 17)
	; bird_stand_right=	13 + 2190	2206 (need 3)
	; bird_walk_left=	15 + 2175	2206 (need 16)
	; bird_stand_left=	14 + 2190	2206 (need 2)
	; call to sprite			17 postfix
	;====================================================
	;					2231

	lda	BIRD_STATE						; 3
	and	#1							; 2
	ldx	BIRD_DIR						; 3
	bne	bird_left

bird_right:
									; 2
	cmp	#1							; 2
	beq	bird_walk_right
									; 2
bird_stand_right:
	ldx	#>bird_rider_stand_right				; 2
	ldy	#<bird_rider_stand_right				; 2
	lda	YPOS ; nop=3
	jmp	draw_bird						; 3
bird_walk_right:
									; 3
	ldx	#>bird_rider_walk_right					; 2
	ldy	#<bird_rider_walk_right					; 2
	jmp	kill_less_time						; 3

bird_left:
									; 3
	cmp	#1							; 2
	beq	bird_walk_left

bird_stand_left:
									; 2
	ldx	#>bird_rider_stand_left					; 2
	ldy	#<bird_rider_stand_left					; 2
	nop	; nop=2
	jmp	draw_bird						; 3
bird_walk_left:
									; 3
	ldx	#>bird_rider_walk_left					; 2
	ldy	#<bird_rider_walk_left					; 2

kill_time:
	nop		; 2	; need to kill 16
kill_less_time:
	lda	YPOS ; nop=3	; need to kill 14
	lda	YPOS ; nop=3
	lda	YPOS ; nop=3
	lda	YPOS ; nop=3
	nop		; 2


	jmp	draw_bird						; 3



draw_bird:
	stx	INH					; 3
	sty	INL					; 3

	lda	#22					; 2
	sta	YPOS					; 3

	jsr	put_sprite				; 6
							;=========
							; 17 + 2190



	;====================
	; Handle keypresses
	; if no keypress, 9
	; if keypress, 6+43 = 49

	lda	KEYPRESS				; 4
	bmi	keypress
							; 2
no_keypress:
	; kill 40 cycles
	ldx	#0					; 2
	inc	YPOS,X					; 6
	inc	YPOS,X					; 6
	inc	YPOS,X					; 6
	inc	YPOS,X					; 6
	inc	YPOS,X					; 6
	inc	YPOS,X					; 6
	nop						; 2

	jmp	display_loop				; 3


	;===================================================
	; key was pressed handling takes 12 + 20 + 11 = 43

keypress:
							; 1
	bit	KEYRESET				; 4
	inc	BIRD_STATE				; 5
	and	#$5f		; mask keypress		; 2

is_it_right:
	cmp	#$15		; right arrow		; 2
	bne	is_it_left
							; 2
	inc	XPOS					; 5
	lda	#0					; 2
	sta	BIRD_DIR				; 3
	lda	YPOS		; 3-cycle nop		; 3
convoluted:
	jmp	adjust_xpos				; 3	; 20 if right

is_it_left:
							; 5
	cmp	#$8		; left arrow		; 2
	beq	is_left
							; 2
	nop						; 2
	lda	YPOS		; 3-cycle nop
	jmp	convoluted				; 3
							; ------ 20 if neither

is_left:
							; 3
	dec	XPOS					; 5	; 20 if left
	lda	#1					; 2
	sta	BIRD_DIR				; 3


adjust_xpos:
	lda	XPOS					; 3
	and	#$1f		; keep in 0-31 range	; 2
	sta	XPOS					; 3

	jmp	display_loop				; 3

.include "gr_hline.s"
.include "../asm_routines/gr_unrle.s"
.align	$100
.include "../asm_routines/keypress.s"
.include "gr_copy.s"
.include "gr_unrolled_copy.s"
.align $100
.include "gr_putsprite.s"
.include "mockingboard.s"
.include "vapor_lock.s"
.include "delay_a.s"


.include "waterfall_page1.inc"
.include "waterfall_page2.inc"
.align	$100
.include "tfv_sprites.inc"



.align	$100

	;=================================
	; Display Even
	;=================================
	; we have 65 cycles per line
	; the first 25 are in hblank
	; we come in already 21 cycles into things
	; so the first scanline is a loss (but that's OK)

	; first scanline: 21+ 2 (from ldy) so need to kill 65-23 = 42
	; second scanline, again kill so 65 killed

display_even:

even_first_four_lines:

	; we do mockingboard here
	; we have 222 cycles (65*4 = 260 - 38 = 222)



								; 38
	; come in with 38
	; 222 - 100 = 122 to kill

	; kill 122

	ldx	#10						; 2
dummy_loop:
	asl	DUMMY						; 6
	dex							; 2
	bne	dummy_loop					; 3

	; -1 exit loop

	; 11 left over
	nop	;2
	lda	XPOS	; 3
	lda	XPOS	; 3
	lda	XPOS	; 3


	; high =   5 + 12+ 3 = 20
	; medium = 5 + 9 + 6 = 20
	; low =    5 + 9 + 6 = 20

	lda	XPOS		; 3

;	cmp	OLD_XPOS	; 3
;	beq	skip_mb		;
				; 2
;	sta	OLD_XPOS	; 3

	cmp	#23		; 2
	bmi	check_medium
				; 2
	lda	#35		; 2
	sec			; 2
	sbc	XPOS		; 3
	sta	YPOS ; (nop)	; 3
was_low:
	jmp	write_volume	; 3
check_medium:
				; 3
	nop			; 2
	nop			; 2
	cmp	#12		; 2
	bmi	was_low
was_medium:
				; 2
	lda	#12		; 2
	nop			; 2

write_volume:
	; write A/noise volume
	sta	MB_VALUE			; 3
	ldx     #8				; 2
	lda	#$2				; 2
	jsr     write_ay_both                   ; 6+65
                                        ;===============
                                        ;       78

skip_mb:


	; setup loop for next section
	ldy	#4						; 2

even_twinkle_stars:

twinkle_loop_even:

	; page1 for 4 lines, 65 - 4 = 61 -2 = 59 - 25 = 34

	; line 0
	bit	PAGE1						; 4
	lda	#34						; 2
	jsr	delay_a						; 25+34
	; line 1
	bit	PAGE1						; 4
	lda	#34						; 2
	jsr	delay_a						; 25+34
	; line 2
	bit	PAGE1						; 4
	lda	#34						; 2
	jsr	delay_a						; 25+34
	; line 3
	bit	PAGE1						; 4
	lda	#27						; 2
	jsr	delay_a						; 25+27

	; below: 7 if not zero
	; 	 7 (including ldy later) if is zero


	dey							; 2
	beq	twinkle_loop_even_done				; 3
								;-1
        jmp	twinkle_loop_even				; 3



twinkle_loop_even_done:

	ldy	#31						; 2
falls_loop_even:

; === line 0
	bit	PAGE0						; 4
	; delay 31
	lda	#4						; 2
	jsr	delay_a						; 25+4

	; delay 11
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4

	; delay 19
	nop							; 2
	nop							; 2
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

;=== line 1
	bit	PAGE0						; 4
	; delay 31
	lda	#4						; 2
	jsr	delay_a						; 25+4

	; delay 11
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4

	; delay 19
	nop							; 2
	nop							; 2
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

;=== line 2
	bit	PAGE0						; 4
	; delay 31
	lda	#4						; 2
	jsr	delay_a						; 25+4

	; delay 11
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4
	; delay 19
	nop							; 2
	nop							; 2
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

;== line 3
	bit	PAGE0						; 4
	; delay 31
	lda	#4						; 2
	jsr	delay_a						; 25+4

	; delay 11
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4 ; 46

	; delay 21 - 7 from loop
	nop							; 2
	nop							; 2
	asl	DUMMY						; 6
	nop							; 2 ; 58

	dey							; 2
	beq	falls_loop_even_done				; 3
								; -1
	jmp	falls_loop_even					; 3
falls_loop_even_done:

	ldy	#12						; 2

ground_loop_even:

;==== line 0
	bit	PAGE0						; 4
	; delay 61
	lda	#34						; 2
	jsr	delay_a						; 25+34

;==== line 1
	bit	PAGE1						; 4
	; delay 61
	lda	#34						; 2
	jsr	delay_a						; 25+34

;==== line 2
	bit	PAGE0						; 4
	; delay 61
	lda	#34						; 2
	jsr	delay_a						; 25+34

;=== line 3
	bit	PAGE1						; 4
	; delay 54
	lda	#27						; 2
	jsr	delay_a						; 25+27

	dey							; 2
	beq	ground_loop_even_done				; 3
								; -1
	jmp	ground_loop_even				; 3
ground_loop_even_done:
	nop							; 2

	jmp	display_loop_return				; 3

.align	$100

	;=================================
	; Display Odd
	;=================================
	; we have 65 cycles per line
	; the first 25 are in hblank

display_odd:
	; first scanline: comes in with 38

odd_first_four_lines:

	; line 0-3 = 65*4 = 260
	;		    -38
	;		     -2
	;                    -2
	;                   -25
	;=========================
	;		    193

	lda	#193						; 2
	jsr	delay_a						; 125

	ldy	#4						; 2

odd_twinkle_stars:

twinkle_loop_odd:

	; page1 for 4 lines, 65 - 4 = 61 -2 = 59 - 25 = 34

	; line 0
	bit	PAGE1						; 4
	lda	#34						; 2
	jsr	delay_a						; 25+34

	; line 1
	bit	PAGE1						; 4
	lda	#34						; 2
	jsr	delay_a						; 25+34

	; line 2
	bit	PAGE1						; 4
	lda	#34						; 2
	jsr	delay_a						; 25+34

	; line 3
	bit	PAGE1						; 4
	lda	#27						; 2
	jsr	delay_a						; 25+27

	dey							; 2
	beq	twinkle_loop_odd_done				; 3
								; -1
	jmp	twinkle_loop_odd				; 3
twinkle_loop_odd_done:

	ldy	#31						; 2
falls_loop_odd:

;=== line 0
	bit	PAGE0						; 4
	; delay 31
	lda	#4						; 2
	jsr	delay_a						; 25+4

	; falls 11
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4

	; delay 19
	nop							; 2
	nop							; 2
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

;==== line 1
	bit	PAGE0						; 4
	; delay 31
	lda	#4						; 2
	jsr	delay_a						; 25+4

	; falls 8
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4

	; delay 19
	nop							; 2
	nop							; 2
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

;=== line 2
	bit	PAGE0						; 4
	; delay 31
	lda	#4						; 2
	jsr	delay_a						; 25+4

	; falls 8
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4

	; delay 19
	nop							; 2
	nop							; 2
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

;===line 4
	bit	PAGE0						; 4

	; delay 31
	lda	#4						; 2
	jsr	delay_a						; 25+4

	; falls 11
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4 ; 44

	; end falls
	; delay 21 - 7 from loop
	nop							; 2
	nop							; 2
	asl	DUMMY						; 6
	nop							; 2 ; 58

	dey							; 2
	beq	falls_loop_odd_done				; 3
								;-1
	jmp	falls_loop_odd					; 3
falls_loop_odd_done:
								; 3
	ldy	#12						; 2

ground_loop_odd:

;=== line 0
	bit	PAGE1						; 4
	; delay 61
	lda	#34						; 2
	jsr	delay_a						; 25+34

;=== line 1
	bit	PAGE0						; 4
	; delay 61
	lda	#34						; 2
	jsr	delay_a						; 25+34

;==== line 2
	bit	PAGE1						; 4
	; delay 61
	lda	#34						; 2
	jsr	delay_a						; 25+34

;==== line 3
	bit	PAGE0						; 4
	; delay 54
	lda	#27						; 2
	jsr	delay_a						; 25+27

	dey							; 2
	beq	ground_loop_odd_done				; 3
								;-1
	jmp	ground_loop_odd					; 3
ground_loop_odd_done:


								; 3
	nop							; 2

	jmp	display_loop_return				; 3

	rts							; 6


.align	$100

	;=================================
	; Display 3
	;=================================
	; we have 65 cycles per line
	; the first 25 are in hblank
	; we come in already 21 cycles into things
	; so the first scanline is a loss (but that's OK)

	; first scanline: 21+ 2 (from ldy) so need to kill 65-23 = 42
	; second scanline, again kill so 65 killed

display_three:

three_first_four_lines:

	; we do mockingboard here
	; we have 222 cycles (65*4 = 260 - 38 = 222)



								; 38
	; come in with 38
	; 222 - 100 = 122 to kill

	; kill 122

	ldx	#10						; 2
dummy_loop2:
	asl	DUMMY						; 6
	dex							; 2
	bne	dummy_loop2					; 3

	; -1 exit loop

	; 11 left over
	nop	;2
	lda	XPOS	; 3
	lda	XPOS	; 3
	lda	XPOS	; 3


	; high =   5 + 12+ 3 = 20
	; medium = 5 + 9 + 6 = 20
	; low =    5 + 9 + 6 = 20

	lda	XPOS		; 3

;	cmp	OLD_XPOS	; 3
;	beq	skip_mb2		;
				; 2
;	sta	OLD_XPOS	; 3

	cmp	#23		; 2
	bmi	check_medium2
				; 2
	lda	#35		; 2
	sec			; 2
	sbc	XPOS		; 3
	sta	YPOS ; (nop)	; 3
was_low2:
	jmp	write_volume2	; 3
check_medium2:
				; 3
	nop			; 2
	nop			; 2
	cmp	#12		; 2
	bmi	was_low2
was_medium2:
				; 2
	lda	#12		; 2
	nop			; 2

write_volume2:
	; write A/noise volume
	sta	MB_VALUE			; 3
	ldx     #8				; 2
	lda	#$2				; 2
	jsr     write_ay_both                   ; 6+65
                                        ;===============
                                        ;       78

skip_mb2:


	; setup loop for next section
	ldy	#4						; 2

three_twinkle_stars:

twinkle_loop_three:

	; line 0
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4
	; endfalls
	; delay 21
;	asl	DUMMY						; 6
	nop
	nop
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 2
	bit	PAGE1						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE1						; 4
	; end falls
	; delay 21
;	asl	DUMMY						; 6
	nop
	nop
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 3
	bit	PAGE1						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE1						; 4
	; end falls
	; delay 21
;	asl	DUMMY						; 6
	nop
	nop
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 4
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4 ; 44
	; end falls
	; delay 21 - 7 from loop
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	nop							; 2 ; 58

	dey							; 2
	beq	twinkle_loop_three_done				;
								; 2
	jmp	twinkle_loop_three				; 3
twinkle_loop_three_done:

	ldy	#31						; 2
falls_loop_three:

	; line 0
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4
	; endfalls
	; delay 21
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 2
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4
	; end falls
	; delay 21
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 3
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4
	; end falls
	; delay 21
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 4
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4 ; 44
	; end falls
	; delay 21 - 7 from loop
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	nop							; 2 ; 58

	dey							; 2
	beq	falls_loop_three_done				;
								; 2
	jmp	falls_loop_three					; 3
falls_loop_three_done:
								; 3
	ldy	#12						; 2

ground_loop_three:

	; line 0
	bit	PAGE1						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE1						; 4
	; endfalls
	; delay 21
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 2
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4
	; end falls
	; delay 21
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 3
	bit	PAGE1						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE1						; 4
	; end falls
	; delay 21
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 4
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4 ; 44
	; end falls
	; delay 21 - 7 from loop
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	nop							; 2 ; 58

	dey							; 2
	beq	ground_loop_three_done				;
								; 2
	jmp	ground_loop_three					; 3
ground_loop_three_done:


								; 3
	nop							; 2

	jmp	display_loop_return				; 3


.align	$100

	;=================================
	; Display Four
	;=================================
	; we have 65 cycles per line
	; the first 25 are in hblank
	; we come in already 21 cycles into things
	; so the first scanline is a loss (but that's OK)

	; first scanline: 21+ 2 (from ldy) so need to kill 65-23 = 42
	; second scanline, again kill so 65 killed

display_four:

four_first_four_lines:


	; line 0
								; 38
	ldy	#4						; 2

	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop							; 2


	; line 1, 65 cycles

	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS	; 3
	nop		; 2

	; line 2, 65 cycles

	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS	; 3
	nop		; 2

	; line 3, 65 cycles

	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS	; 3
	nop		; 2

four_twinkle_stars:

twinkle_loop_four:

	; line 0
	bit	PAGE1						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE1						; 4
	; endfalls
	; delay 21
	nop
	nop
	;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 2
	bit	PAGE1						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE1						; 4
	; end falls
	; delay 21
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 3
	bit	PAGE1						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE1						; 4
	; end falls
	; delay 21
;	asl	DUMMY						; 6
	nop
	nop
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 4
	bit	PAGE1						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE1						; 4 ; 44
	; end falls
	; delay 21 - 7 from loop
;	asl	DUMMY						; 6
	nop
	nop
	asl	DUMMY						; 6
	nop							; 2 ; 58

	dey							; 2
	beq	twinkle_loop_four_done				;
								; 2
	jmp	twinkle_loop_four				; 3
twinkle_loop_four_done:

	ldy	#31						; 2
falls_loop_four:

	; line 0
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4
	; endfalls
	; delay 21
;	asl	DUMMY						; 6
	nop
	nop
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 2
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4
	; end falls
	; delay 21
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 3
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4
	; end falls
	; delay 21
;	asl	DUMMY						; 6
	nop
	nop
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 4
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4 ; 44
	; end falls
	; delay 21 - 7 from loop
;	asl	DUMMY						; 6
	nop
	nop
	asl	DUMMY						; 6
	nop							; 2 ; 58

	dey							; 2
	beq	falls_loop_four_done				;
								; 2
	jmp	falls_loop_four					; 3
falls_loop_four_done:
								; 3
	ldy	#12						; 2

ground_loop_four:

	; line 0
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4
	; endfalls
	; delay 21
;	asl	DUMMY						; 6
	nop
	nop
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 2
	bit	PAGE1						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE1						; 4
	; end falls
	; delay 21
;	asl	DUMMY						; 6
	nop
	nop
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 3
	bit	PAGE0						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE0						; 4
	lda	YPOS						; 3
	bit	PAGE0						; 4
	; end falls
	; delay 21
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3

	; line 4
	bit	PAGE1						; 4
	; delay 29
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS						; 3
	nop							; 2
	nop
	; falls
	bit	PAGE1						; 4
	lda	YPOS						; 3
	bit	PAGE1						; 4 ; 44
	; end falls
	; delay 21 - 7 from loop
	nop
	nop
;	asl	DUMMY						; 6
	asl	DUMMY						; 6
	nop							; 2 ; 58

	dey							; 2
	beq	ground_loop_four_done				;
								; 2
	jmp	ground_loop_four					; 3
ground_loop_four_done:


								; 3
	nop							; 2

	jmp	display_loop_return				; 3


