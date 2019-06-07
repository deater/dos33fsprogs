; Display a 40x48d lo-res image

; Uses the 40x48d page1/page2 every-1-scanline pageflip mode

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

MAX	= 1

	lda	#$ff
	sta	WHICH

start_over:
	inc	WHICH
	lda	WHICH
	cmp	#MAX
	bne	in_range
	lda	#0
	sta	WHICH

in_range:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE

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

	jsr	wait_until_keypressed


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

	; GR part
	bit	PAGE0

	jsr	wait_until_keypressed


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

	; now we have 322 left

	; 322 - 12 = 310
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



	; want colors 01234567
	; line 0: $X0
	; line 1: $X1
	; line 2: $X2
	; line 3: $X3
	; line 4: $4X
	; line 5: $5X
	; line 6: $6X
	; line 7: $7X

display_loop:

	; UNROLL 96 TIMES!  ARE WE MAD?  YES!

	; 0
	; 65 cycles total
	bit	PAGE0	; 4
	lda	#$01	; 2
	sta	$800	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$02	; 2
	sta	$400	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 1
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$03	; 2
	sta	$800	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$40	; 2
	sta	$400	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 2
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$50	; 2
	sta	$800	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$60	; 2
	sta	$400	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 3
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$70	; 2
	sta	$800	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$08	; 2
	sta	$480	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 4
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$09	; 2
	sta	$880	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$0A	; 2
	sta	$480	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 5
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$0B	; 2
	sta	$880	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$C0	; 2
	sta	$480	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 6
	; 65 cycles
	bit	PAGE0						; 4
	lda	#$D0	; 2
	sta	$880	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1						; 4
	lda	#$E0	; 2
	sta	$480	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 7
	; 65 cycles
	bit	PAGE0						; 4
	lda	#$F0	; 2
	sta	$880	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1						; 4
	lda	#$00	; 2
	sta	$500	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 8
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 9
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 10
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 11
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 12
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 13
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 14
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 15
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 16
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 17
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 18
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 19
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 20
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 21
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 22
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 23
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 24
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 25
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 26
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 27
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 28
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 29
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 30
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 31
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 32
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 33
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 34
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 35
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 36
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 37
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 38
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 39
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 40
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 41
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 42
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 43
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 44
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 45
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 46
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 47
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 48
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 49
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 50
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 51
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 52
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 53
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 54
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 55
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 56
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 57
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 58
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 59
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 60
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 61
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 62
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 63
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 64
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 66
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 67
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 68
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 69
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 70
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 71
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 72
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 73
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 74
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 75
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 76
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 77
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 78
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 79
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 80
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 81
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 82
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 83
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 84
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 85
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 86
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 87
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 88
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 89
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 90
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 91
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 92
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 93
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 94
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 95
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3




	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be
	;	4550
	;	  -6
	;        -10
	;=============
	;       4534

	jsr	do_nothing				; 6

	lda	KEYPRESS				; 4
	bpl	no_keypress				; 3
	jmp	start_over
no_keypress:

	jmp	display_loop				; 3



	;=================================
	; do nothing
	;=================================
	; and take 4534-6 = 4528 cycles to do it
do_nothing:

	; Try X=4 Y=174 cycles=4525 R2

	lda	TEMP	; 3

	ldy	#174							; 2
loop1:	ldx	#4							; 2
loop2:	dex								; 2
	bne	loop2							; 2nt/3
	dey								; 2
	bne	loop1							; 2nt/3

	rts							; 6



	;==================================
	; HLINE
	;==================================

	; Color in A
	; Y has which line
hline:
	pha							; 3
	ldx	gr_offsets,y					; 4+
	stx	hline_loop+1					; 4
	lda	gr_offsets+1,y					; 4+
	clc							; 2
	adc	DRAW_PAGE					; 3
	sta	hline_loop+2					; 4
	pla							; 4
	ldx	#39						; 2
hline_loop:
	sta	$5d0,X		; 38				; 5
	dex							; 2
	bpl	hline_loop					; 2nt/3
	rts							; 6

	;==========================
	; Clear gr screen
	;==========================
	; Color in A
clear_gr:
	ldy	#46
clear_page_loop:
	jsr	hline
	dey
	dey
	bpl	clear_page_loop
	rts

gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0


.include "../asm_routines/gr_unrle.s"
.include "../asm_routines/keypress.s"
.include "gr_copy.s"
.include "vapor_lock.s"
.include "delay_a.s"

pictures:
	.word k_low,k_high

.include "k_40_48d.inc"

krg:
	.byte $0
