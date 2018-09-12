; Display fancy Fireworks

; HGR plus 40x48d page1/page2 every-1-scanline pageflip mode

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
HGR_COLOR	= $E4
STATE		= $ED
DRAW_PAGE	= $EE
LASTKEY		= $F1
PADDLE_STATUS	= $F2
TEMP		= $FA
WHICH		= $FB

; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SPEAKER	= $C030
SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
PAGE0	= $C054 ; Page0
PAGE1	= $C055 ; Page1
LORES	= $C056	; Enable LORES graphics
HIRES	= $C057 ; Enable HIRES graphics

PADDLE_BUTTON0 = $C061
PADDL0	= $C064
PTRIG	= $C070

; ROM routines
;HGR	= $F3E2
;HPLOT0	= $F457
;HGLIN	= $F53A
;COLORTBL= $F6F6
TEXT	= $FB36				;; Set text mode
HOME	= $FC58				;; Clear the text screen
WAIT	= $FCA8				;; delay 1/2(26+27A+5A^2) us


;	jsr	draw_fireworks

	;==================================
	;==================================


setup_background:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	jsr	hgr
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE
	sta	STATE

	;=============================
	; Load graphic page0

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00

	lda	#<bg_final_low
	sta	GBASL
	lda	#>bg_final_low
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

	lda	#<bg_final_high
	sta	GBASL
	lda	#>bg_final_high
	sta	GBASH
	jsr	load_rle_gr

	lda	#0
	sta	DRAW_PAGE

	jsr	gr_copy_to_current

	; GR part
	bit	PAGE0

;	jsr	wait_until_keypressed


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock				; 6 for rts?

	; found first line of black after green, at up to line 26 on screen
        ; so we want roughly 22 lines * 4 = 88*65 = 5720 + 4550 = 10270
	; - 65 (for the scanline we missed) = 10205 - 12 = 10193

	jsr	gr_copy_to_current		; 6+ 9292
	; 10193 - 9298 - 6 = 889
	; Fudge factor (unknown) -24 = 865

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

	; We want to alternate between page1 and page2 every 65 cycles
        ;       vblank = 4550 cycles to do scrolling


	; 2 + 48*(  (4+2+25*(2+3)) + (4+2+23*(2+3)+4+5)) + 9)
	;     48*[(6+125)-1] + [(6+115+10)-1]

display_loop:

	; 152 * 65 = 9880 - 12 = 9868

	bit	HIRES						; 4
	bit	PAGE0						; 4

	; Try X=81 Y=24 cycles=9865 R3

	lda	DRAW_PAGE					; 3

	ldy	#24							; 2
sloop1:
	ldx	#81							; 2
sloop2:
	dex								; 2
	bne	sloop2							; 2nt/3

	dey								; 2
	bne	sloop1							; 2nt/3

	bit	LORES						; 4


	; bit(4) -1(fallthrough) + loop*5 -1(fallthrouh)+4 extra = 61
	; 5L = 55


	ldy	#20						; 2

bouter_loop:

	bit	PAGE0						; 4
	ldx	#12		; 65 cycles with PAGE0		; 2
bpage0_loop:			; delay 61+bit
	dex							; 2
	bne	bpage0_loop					; 2/3


	; bit(4) -1(fallthrough) + loop*5 -1(fallthrouh)+4 extra = 61
	; 5L = 55

	bit	PAGE1						; 4
	ldx	#11		; 65 cycles with PAGE1		; 2
				;
bpage1_loop:			; delay 115+(7 loop)+4 (bit)+4(extra)
	dex							; 2
	bne	bpage1_loop					; 2/3

	dey							; 2
	bne	bouter_loop					; 2/3



	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	;			4550
	;			  +1  fallthrough
	;			  -2  ldy at entry
	;			 -35  call through jumptable
	;			  -7  keyboard
	;			  -3  jmp
	;			========
	;			4504
	;========================
	; each subunit should take 4504 cycles

firework_state_machine:

	; if killing time, 16+19 = 35
	; if not, 	   16+19 = 35

	ldy	STATE						; 3
	inc     FRAME                                           ; 5
        lda     FRAME                                           ; 3
	and	#$3						; 2
	beq	kill_time					; 3
							;===========
							;	 16


	; Set up jump table that runs same speed on 6502 and 65c02
								;-1
	lda	jump_table+1,y                                  ; 4
	pha                                                     ; 3
	lda	jump_table,y                                    ; 4
	pha                                                     ; 3
	rts                                                     ; 6

							;=============
							;	 19

kill_time:

	; need 16 cycles nop
	ldy	STATE	; (nop)					; 3
	ldy	STATE	; (nop)					; 3
	ldy	STATE	; (nop)					; 3
	ldy	STATE	; (nop)					; 3
	nop							; 2
	nop							; 2
	jmp	action_stars					; 3

							;=============
							;	19

check_keyboard:

	lda	KEYPRESS				; 4
	bpl	no_keypress				; 3
	jmp	loop_forever
no_keypress:

	jmp	display_loop				; 3

loop_forever:
	jmp	loop_forever


jump_table:
        .word   (action_launch_firework-1)
        .word   (action_move_rocket-1)
        .word   (action_start_explosion-1)
        .word   (action_continue_explosion-1)



.include "state_machine.s"
.include "gr_hline.s"
.include "../asm_routines/gr_unrle.s"
.include "../asm_routines/keypress.s"
.include "gr_copy.s"
.include "random16.s"
.include "fw.s"
.include "hgr.s"
.include "vapor_lock.s"

background:

.include "background_final.inc"
