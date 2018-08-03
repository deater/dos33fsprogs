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
BIRD_STATE	= $E0
BIRD_DIR	= $E1
DRAW_PAGE	= $EE
LASTKEY		= $F1
PADDLE_STATUS	= $F2
XPOS		= $F3
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

	lda	#4
	sta	DRAW_PAGE
	sta	XPOS

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

	; Clear Page0
	lda	#$0
	sta	DRAW_PAGE
	lda	#$44
	jsr	clear_gr

	; Make screen half green
	lda	#$11
	ldy	#24
	jsr	clear_page_loop


	;=====================================================
	; attempt vapor lock
	;  by reading the "floating bus" we can see most recently
	;  written value of the display
	; we look for $55 (which is the grey line)
	;=====================================================
	; See:
	;	Have an Apple Split by Bob Bishop
        ;	Softalk, October 1982

	; Challenges: each scan line scans 40 bytes.
	; The blanking happens at the *beginning*
	; So 65 bytes are scanned, starting at adress of the line - 25

	; the scan takes 8 cycles, look for 4 repeats of the value
	; to avoid false positive found if the horiz blanking is mirroring
	; the line (max 3 repeats in that case)

vapor_lock_loop:		; first make sure we have all zeroes
	LDA #$11
zxloop:
	LDX #$04
wiloop:
	CMP $C051
	BNE zxloop
	DEX
	BNE wiloop

	LDA #$44		; now look for our border color (4 times)
zloop:
	LDX #$04
qloop:
	CMP $C051
	BNE zloop
	DEX
	BNE qloop

	; found first line of black after green, at up to line 26 on screen
        ; so we want roughly 22 lines * 4 = 88*65 = 5720 + 4550 = 10270
	; - 65 (for the scanline we missed) = 10205 - 12 = 10193

	jsr	gr_copy_to_current		; 6+ 9292
	; 10193 - 9298 = 895
	; Fudge factor (unknown) -30 = 865

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	; Try X=88 Y=2 cycles=893 R2

	nop
        ldy     #2							; 2
loopA:
        ldx	#88							; 2
loopB:
        dex                                                             ; 2
        bne     loopB                                                   ; 2nt/3

        dey                                                             ; 2
        bne     loopA                                                   ; 2nt/3

        jmp     display_loop
.align  $100


	;================================================
	; Display Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; if even, 10 + 9 + display_even + 2 (balance) = 21+display_even
	; if odd   10 + 8 + display_odd  + 3 (balance) = 21+display_odd

	; we have 3 (the jmp) + 6 (the rts) - 1 (fallthrough)
	;		 = 8 cycles that need to be eaten by the vblank

display_loop:
	inc	FRAME						; 5
	lda	FRAME						; 3
	lda	#$0						; 2
	beq	even
								; 2
	lda	FRAME		; (nop)				; 3
	jsr	display_odd					; 6
	jmp	vblank						; 3
even:
								; 3
	nop			; (nop)				; 2
	jsr	display_even					; 6
	jmp	vblank						; 3



vblank:
	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be         4550
	;				 -8 letfover from HBLANK code
	;				-49 check for keypress
	;			      -2252 copy screen
	;			      -2231 draw sprite
	;			=============
	;			      10 cycles

;	jsr	do_nothing					; 6

	; 17 cycles
	inc	YPOS		; 5
	inc	YPOS		; 5
;	inc	YPOS		; 5
;	nop			; 2
;	nop			; 2


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


	;=================================
	; do nothing
	;=================================
	; and take 11-6 = 5 cycles to do it
;do_nothing:

	; Try X=3 Y=1 cycles=22

;	nop	; 2
;	nop	; 2

;	ldy	#1							; 2
;loop1:
;	ldx	#3							; 2
;loop2:
;	dex								; 2
;	bne	loop2							; 2nt/3

;	dey								; 2
;	bne	loop1							; 2nt/3


;	rts							; 6



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
.include "gr_unrolled_copy.s"
.include "put_sprite.s"

.include "waterfall_page1.inc"
.include "waterfall_page2.inc"
.align	$100
.include "tfv_sprites.inc"

.align	$100

	;==========================================
	; DISPLAY ODD

display_odd:

	ldy	#96						; 2

outer_loop_odd:

	bit	PAGE0						; 4
	ldx	#12		; 65 cycles with PAGE0		; 2
page0_loop_odd:			; delay 61+bit
	dex							; 2
	bne	page0_loop_odd					; 2/3


	; bit(4) -1(fallthrough) + loop*5 -1(fallthrouh)+4 extra = 61
	; 5L = 55

	bit	PAGE1						; 4
	ldx	#11		; 65 cycles with PAGE1		; 2
				;
page1_loop_odd:			; delay 115+(7 loop)+4 (bit)+4(extra)
	dex							; 2
	bne	page1_loop_odd					; 2/3

	dey							; 2
	bne	outer_loop_odd					; 2/3

	rts


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


even_first_line:
	ldy	#95						; 2

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
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	asl	DUMMY						; 6
	lda	YPOS	; 3
	nop		; 2



outer_loop_even:

	bit	PAGE1						; 4
	ldx	#12		; 65 cycles with PAGE0		; 2
page1_loop_even:			; delay 61+bit
	dex							; 2
	bne	page1_loop_even					; 2/3


	; bit(4) -1(fallthrough) + loop*5 -1(fallthrouh)+4 extra = 61
	; 5L = 55

	bit	PAGE0						; 4
	ldx	#11		; 65 cycles with PAGE1		; 2
				;
page0_loop_even:			; delay 115+(7 loop)+4 (bit)+4(extra)
	dex							; 2
	bne	page0_loop_even					; 2/3

	dey							; 2
	bne	outer_loop_even					; 2/3

	rts							; 6
