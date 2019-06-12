; Uses the 40x48d page1/page2 every-1-scanline pageflip mode

; self modifying code to get some extra colors (pseudo 40x192 mode)

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
FRAME		= $60
BLARGH		= $69
DRAW_PAGE	= $EE
LASTKEY		= $F1
PADDLE_STATUS	= $F2
TEMP		= $FA
WHICH		= $FB
TEMPY		= $FC

OUTL		= $FE
OUTH		= $FF

ZERO		= $80


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


start_sprites:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE
	sta	WHICH

	;=============================
	; Load graphic page0

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00

	lda	WHICH
	asl
	asl				; which*4
	tay

	lda	pictures,Y
	sta	GBASL
	lda	pictures+1,Y
	sta	GBASH
	jsr	load_rle_gr

	lda	#4
	sta	DRAW_PAGE

	jsr	gr_copy_to_current	; copy to page1

	; GR part
	bit	PAGE1
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

;	jsr	wait_until_keypressed


	;=============================
	; Load graphic page1

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00

	lda	WHICH
	asl
	asl				; which*4
	tay

	lda	pictures+2,Y
	sta	GBASL
	lda	pictures+3,Y
	sta	GBASH
	jsr	load_rle_gr

	lda	#0
	sta	DRAW_PAGE

	jsr	gr_copy_to_current

;	; GR part
	bit	PAGE0

;	jsr	wait_until_keypressed


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	jsr	gr_copy_to_current			; 6+ 9292

	; 5070 + 4550 = 9620
	;		9292
	;		  12
	;		   6
	;		====
	;		 310

	; - 3 for jmp
	; 307

	; Try X=9 Y=6 cycles=307

	ldy	#6							; 2
loopA:	ldx	#9							; 2
loopB:	dex								; 2
	bne	loopB							; 2nt/3
	dey								; 2
	bne	loopA							; 2nt/3

	jmp	display_loop						; 3

.align  $100

	;================================================
	; Display Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; We want to alternate between page1 and page2 every 65 cycles
        ;       vblank = 4550 cycles to do scrolling


display_loop:

.include "sprites_screen.s"

	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================

	; 4550	-- VBLANK
	; 1820	-- draw ship (130*14)
	;  -10  -- keypress
	;=======
	; 2720


	;==========================
	; draw the ship
	; at Y=64 for now

	ldy	#64			; 2

	; line 0
	ldx	#0			; 2
	jsr	sprite_line		; 6+120
					;====
					; 128

	; line 1
	iny				; 2
	ldx	#7			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130

	; line 2
	iny				; 2
	ldx	#14			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130

	; line 3
	iny				; 2
	ldx	#21			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130

	; line 4
	iny				; 2
	ldx	#28			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130

	; line 5
	iny				; 2
	ldx	#35			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130

	; line 6
	iny				; 2
	ldx	#42			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130

	; line 7
	iny				; 2
	ldx	#49			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130

	; line 8
	iny				; 2
	ldx	#56			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130

	; line 9
	iny				; 2
	ldx	#63			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130

	; line 10
	iny				; 2
	ldx	#70			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130

	; line 11
	iny				; 2
	ldx	#77			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130

	; line 12
	iny				; 2
	ldx	#84			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130

	; line 13
	iny				; 2
	ldx	#91			; 2
	jsr	sprite_line		; 6+120
					;====
					; 130


.if 0
	; line 0

	lda	#0			; 2
	sta	smc064+3	; 0	; 4
	sta	smc064+8	; 1	; 4
	sta	smc064+13	; 2	; 4
	sta	smc064+23	; 4	; 4
	sta	smc064+28	; 5	; 4
	sta	smc064+33	; 6	; 4
	lda	#$ff			; 2
	sta	smc064+18	; 3	; 4
					;====
					; 32

	; line 1

	lda	#0			; 2
	sta	smc065+3	; 0	; 4
	sta	smc065+8	; 1	; 4
	sta	smc065+13	; 2	; 4
	sta	smc065+23	; 4	; 4
	sta	smc065+28	; 5	; 4
	sta	smc065+33	; 6	; 4
	lda	#$ff			; 2
	sta	smc065+18	; 3	; 4
					;====
					; 32

	; line 2

	lda	#0			; 2
	sta	smc066+3	; 0	; 4
	sta	smc066+8	; 1	; 4
	sta	smc066+13	; 2	; 4
	sta	smc066+23	; 4	; 4
	sta	smc066+28	; 5	; 4
	sta	smc066+33	; 6	; 4
	lda	#$ff			; 2
	sta	smc066+18	; 3	; 4
					;====
					; 32

	; line 3

	lda	#0			; 2
	sta	smc067+3	; 0	; 4
	sta	smc067+8	; 1	; 4
	sta	smc067+13	; 2	; 4
	sta	smc067+23	; 4	; 4
	sta	smc067+28	; 5	; 4
	sta	smc067+33	; 6	; 4
	lda	#$ff			; 2
	sta	smc067+18	; 3	; 4
					;=====
					; 32

	; line 4

	lda	#0			; 2
	sta	smc068+3	; 0	; 4
	sta	smc068+8	; 1	; 4
	sta	smc068+13	; 2	; 4
	sta	smc068+23	; 4	; 4
	sta	smc068+28	; 5	; 4
	sta	smc068+33	; 6	; 4
	lda	#$77			; 2
	sta	smc068+18	; 3	; 4
					;====
					; 32

	; line 5

	lda	#0			; 2
	sta	smc069+3	; 0	; 4
	sta	smc069+8	; 1	; 4
	sta	smc069+13	; 2	; 4
	sta	smc069+33	; 6	; 4
	lda	#$ff			; 2
	sta	smc069+18	; 3	; 4
	sta	smc069+23	; 4	; 4
	lda	#$22			; 2
	sta	smc069+28	; 5	; 4
					;=====
					; 34
	; line 6

	lda	#0			; 2
	sta	smc070+3	; 0	; 4
	sta	smc070+8	; 1	; 4
	sta	smc070+33	; 6	; 4
	lda	#$ff			; 2
	sta	smc070+18	; 3	; 4
	sta	smc070+23	; 4	; 4
	lda	#$22			; 2
	sta	smc070+13	; 2	; 4
	sta	smc070+28	; 5	; 4
					;====
					; 34

	; line 7

	lda	#0			; 2
	sta	smc071+3	; 0	; 4
	sta	smc071+33	; 6	; 4
	lda	#$dd			; 2
	sta	smc071+8	; 1	; 4
	lda	#$66			; 2
	sta	smc071+13	; 2	; 4
	lda	#$11			; 2
	sta	smc071+18	; 3	; 4
	lda	#$22			; 2
	sta	smc071+23	; 4	; 4
	sta	smc071+28	; 5	; 4
					;====
					; 38
	; line 8

	lda	#$dd			; 2
	sta	smc072+3	; 0	; 4
	lda	#$99			; 2
	sta	smc072+8	; 1	; 4
	lda	#$22			; 2
	sta	smc072+13	; 2	; 4
	sta	smc072+28	; 5	; 4
	sta	smc072+33	; 6	; 4
	lda	#$44			; 2
	sta	smc072+18	; 3	; 4
	sta	smc072+23	; 4	; 4
					;====
					; 36
	; line 9

	lda	#$99			; 2
	sta	smc073+3	; 0	; 4
	lda	#$11			; 2
	sta	smc073+8	; 1	; 4
	lda	#$66			; 2
	sta	smc073+13	; 2	; 4
	lda	#$ff			; 2
	sta	smc073+18	; 3	; 4
	sta	smc073+23	; 4	; 4
	lda	#$22			; 2
	sta	smc073+28	; 5	; 4
	sta	smc073+33	; 6	; 4
					;====
					; 38

	; line 10

	lda	#$dd			; 2
	sta	smc074+3	; 0	; 4
	lda	#$99			; 2
	sta	smc074+8	; 1	; 4
	lda	#$22			; 2
	sta	smc074+13	; 2	; 4
	sta	smc074+28	; 5	; 4
	sta	smc074+33	; 6	; 4
	lda	#$ff			; 2
	sta	smc074+18	; 3	; 4
	sta	smc074+23	; 4	; 4
					;====
					; 36
	; line 11

	lda	#0			; 2
	sta	smc075+3	; 0	; 4
	lda	#$dd			; 2
	sta	smc075+8	; 1	; 4
	lda	#$66			; 2
	sta	smc075+13	; 2	; 4
	lda	#$77			; 2
	sta	smc075+18	; 3	; 4
	sta	smc075+23	; 4	; 4
	sta	smc075+28	; 5	; 4
	lda	#$ff			; 2
	sta	smc075+33	; 6	; 4
					;====
					; 38

	; line 12

	lda	#0			; 2
	sta	smc076+3	; 0	; 4
	sta	smc076+8	; 1	; 4
	lda	#$22			; 2
	sta	smc076+13	; 2	; 4
	lda	#$ff			; 2
	sta	smc076+18	; 3	; 4
	sta	smc076+23	; 4	; 4
	sta	smc076+33	; 6	; 4
	lda	#$77			; 2
	sta	smc076+28	; 5	; 4
					;====
					; 36

	; line 13

	lda	#0			; 2
	sta	smc077+3	; 0	; 4
	sta	smc077+8	; 1	; 4
	sta	smc077+13	; 2	; 4
	lda	#$ff			; 2
	sta	smc077+18	; 3	; 4
	sta	smc077+23	; 4	; 4
	sta	smc077+33	; 6	; 4
	lda	#$77			; 2
	sta	smc077+28	; 5	; 4
					;====
					; 34
.endif

pad_time:


	;============================
	; WAIT for VBLANK to finish
	;============================

	; Try X=13 Y=57 cycles=4048 R4

	;Try X=79 Y=11 cycles=4412 R4

	; Try X=1 Y=247 cycles=2718 R2

	nop

	ldy	#247							; 2
loop1:	ldx	#1							; 2
loop2:	dex								; 2
	bne	loop2							; 2nt/3
	dey								; 2
	bne	loop1							; 2nt/3


	lda	KEYPRESS				; 4
	bpl	no_keypress				; 3
	jmp	display_loop
no_keypress:

	jmp	display_loop				; 3




	;========================
	; Draw a line of a sprite
	;========================
	; Y = y value
	; x = location in sprite
	; 17+10+(7*12)+3+6 = 120
sprite_line:
	sty	TEMPY			; 3

	lda	y_lookup_l,Y		; 4
	sta	OUTL			; 3
	lda	y_lookup_h,Y		; 4
	sta	OUTH			; 3
					;=======
					; 17

	; XPOS
	lda	#1	; xpos=1	; 2
	ldy	#0			; 2
	sta	(OUTL),Y		; 6
					;=======
					; 10
	; COL0
	ldy	#2			; 2
	lda	ship_sprite+0,X		; 4
	sta	(OUTL),Y		; 6
					;=======
					; 12
	; COL1
	ldy	#7			; 2
	lda	ship_sprite+1,X		; 4
	sta	(OUTL),Y		; 6

	; COL2
	ldy	#12			; 2
	lda	ship_sprite+2,X		; 4
	sta	(OUTL),Y		; 6

	; COL3
	ldy	#17			; 2
	lda	ship_sprite+3,X		; 4
	sta	(OUTL),Y		; 6

	; COL4
	ldy	#22			; 2
	lda	ship_sprite+4,X		; 4
	sta	(OUTL),Y		; 6

	; COL5
	ldy	#27			; 2
	lda	ship_sprite+5,X		; 4
	sta	(OUTL),Y		; 6

	; COL6
	ldy	#32			; 2
	lda	ship_sprite+6,X		; 4
	sta	(OUTL),Y		; 6

	ldy	TEMPY			; 3
	rts				; 6


.include "gr_simple_clear.s"
.include "gr_offsets.s"


.include "../asm_routines/gr_unrle.s"
.include "../asm_routines/keypress.s"
.align $100
.include "sprites_table.s"
.include "movement_table.s"
.include "gr_copy.s"
.include "vapor_lock.s"
.include "delay_a.s"

pictures:
	.word earth_low,earth_high

.include "earth.inc"

.align $100

ship_sprite:
	; l0:     0   1   2   3   4   5   6
	.byte	$00,$00,$00,$ff,$00,$00,$00
	; l1:
	.byte	$00,$00,$00,$ff,$00,$00,$00
	; l2:
	.byte	$00,$00,$00,$ff,$00,$00,$00
	; l3:
	.byte	$00,$00,$00,$ff,$00,$00,$00
	; l4:
	.byte	$00,$00,$00,$77,$00,$00,$00
	; l5:
	.byte	$00,$00,$00,$ff,$ff,$22,$00
	; l6:
	.byte	$00,$00,$22,$ff,$ff,$22,$00
	; l7:
	.byte	$00,$dd,$66,$11,$22,$22,$00
	; l8:
	.byte	$dd,$99,$22,$44,$44,$22,$22
	; l9:
	.byte	$99,$11,$66,$ff,$ff,$22,$22
	; l10:
	.byte	$dd,$99,$22,$ff,$ff,$22,$22
	; l11:
	.byte	$00,$dd,$66,$77,$77,$77,$ff
	; l12:
	.byte	$00,$00,$22,$ff,$ff,$77,$ff
	; l13:
	.byte	$00,$00,$00,$ff,$ff,$77,$ff

