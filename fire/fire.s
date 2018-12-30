; Lo-res fire animation

; by deater (Vince Weaver) <vince@deater.net>

; based on code described here http://fabiensanglard.net/doom_fire_psx/

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


fire_demo:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	PAGE0

	;===================
	; init vars
	lda	#0

	;==============================
	; setup graphics for vapor lock
	;==============================

;	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

;	jsr	gr_copy_to_current		; 6+ 9292

	; now we have 322 left

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	; 322 - 12 = 310
	; -3 for jmp
	; 307

	; Try X=9 Y=6 cycles=307

;	ldy	#6							; 2
;wfloopA:ldx	#9							; 2
;wfloopB:dex								; 2
;	bne	wfloopB							; 2nt/3
;	dey								; 2
;	bne	wfloopA							; 2nt/3


fire_loop:
	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be         4550
	;			=============
	;			      15 cycles


	;====================
	; Handle keypresses
	; if no keypress, 9
	; if keypress, 6+43 = 49

	lda	KEYPRESS				; 4
	bmi	keypress
							; 2
no_keypress:
	jmp	fire_loop

keypress:
	jmp	keypress


.include "gr_hline.s"
;.include "../asm_routines/keypress.s"
.include "gr_copy.s"
.include "gr_unrolled_copy.s"
.include "vapor_lock.s"
.include "delay_a.s"

