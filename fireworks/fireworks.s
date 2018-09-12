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
LETTERL = $63
LETTERH = $64
LETTERX = $65
LETTERY = $66
LETTERD = $67
LETTER  = $68
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
SET_TEXT= $C051 ; Enable text
FULLGR	= $C052	; Full screen, no text
TEXTGR	= $C053 ; Split screen
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
init_letters:
        lda     #<letters
        sta     LETTERL
        lda     #>letters
        sta     LETTERH
        lda     #39
        sta     LETTERX
        lda     #22
        sta     LETTERY
        lda     #28
        sta     LETTERD


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

	;===================================
	; HIRES PAGE0 for the top 152 lines
	;===================================

	; 152 * 65 = 9880
	;	      -12 for HIRES/PAGE0 at top
	;	       -5 for LORES+ldy+br fallthrough at bottom
	;	     -121 for move_letters
	;	     9742

	bit	HIRES						; 4
	bit	PAGE0						; 4
	bit	FULLGR						; 4
							;===========
							;	 12
	jsr	move_letters					; 6+110

	; Try X=9 Y=191 cycles=9742

;	lda	DRAW_PAGE	; nop				; 3
;	nop							; 2


	ldy	#191							; 2
hgloop1:ldx	#9							; 2
hgloop2:dex								; 2
	bne	hgloop2							; 2nt/3
	dey								; 2
	bne	hgloop1							; 2nt/3

	bit	LORES						; 4


	;====================================================
	; LORES PAGE0/PAGE1 alternating for the next 24 lines
	;====================================================


	ldy	#12		; *2=24 lines			; 2

	; we set PAGE0 (4) then want to NOP (61) for a total of 65
bouter_loop:
	bit	PAGE0						; 4
	ldx	#12		; 65 cycles with PAGE0		; 2
bpage0_loop:			; delay 61+bit
	dex							; 2
	bne	bpage0_loop					; 2/3
							;=============
							; 6+(12*5)-1=65

	; we set PAGE1 (4) as well as dey (2) and bne (3) then nop (55)
	;

	bit	PAGE1						; 4
	ldx	#11		; 65 cycles with PAGE1		; 2
bpage1_loop:
	dex							; 2
	bne	bpage1_loop					; 2/3
							;=============
							; 6+(11*5)-1=60

	dey							; 2
	bne	bouter_loop					; 2/3
							;==============
							; 5 to make 65



	;=========================================================
	; LORES PAGE0/PAGE1+TEXT alternating for the next 16 lines
	;=========================================================


	ldy	#8		; *2=16 lines			; 2

	; we set PAGE0 (4) then want to NOP (61) for a total of 65
couter_loop:
	bit	FULLGR						; 4
	bit	PAGE0						; 4
	ldx	#5						; 2
cpage0_loop:
	dex							; 2
	bne	cpage0_loop					; 2/3
							;=============
							; 10+(5*5)-1=34
	bit	TEXTGR						; 4
	bit	$1000						; 4
	bit	$1000						; 4
	bit	$1000						; 4
	bit	$1000						; 4
	bit	$1000						; 4
	bit	$1000						; 4
	lda	DRAW_PAGE					; 3

	; we set PAGE1 (4) as well as dey (2) and bne (3) then nop (55)
	;

	bit	FULLGR						; 4
	bit	PAGE1						; 4
	ldx	#5						; 2
cpage1_loop:
	dex							; 2
	bne	cpage1_loop					; 2/3
							;=============
							; 10+(5*5)-1=34

	bit	TEXTGR						; 4
	bit	$1000						; 4
	bit	$1000						; 4
	bit	$1000						; 4
	lda	DRAW_PAGE					; 3
	nop							; 2
	lda	DRAW_PAGE					; 3
	nop							; 2

	dey							; 2
	bne	couter_loop					; 2/3
							;==============
							; 5 to make 65



	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	;			4550
	;			  +1  fallthrough
	;			  -2  for ldy in previous
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
	jmp	restart
no_keypress:

	jmp	display_loop				; 3


	; Restart and toggle sound
restart:
	; self mofifying code, flip from bit C030 to bit 0030
	lda	sound1+2
	eor	#$C0
	sta	sound1+2


	lda	sound2+2
	eor	#$C0
	sta	sound2+2

	jmp	setup_background


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
.include "move_letters.s"

background:

.include "background_final.inc"
