.include "zp.inc"

;===========
; CONSTANTS
;===========

	;=====================
	; Starfield
	;=====================

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	clear_screens		 ; clear top/bottom of page 0/1
	jsr     set_gr_page0

	; Initialize the 2kB of multiply lookup tables
	jsr	init_multiply_tables


	;===============
	; Init Variables
	;===============
	lda	#0

starfield_loop:

starfield_keyboard:

	jsr	get_key		; get keypress				; 6

	lda	LASTKEY							; 3

	cmp	#('Q')		; if quit, then return
	bne	skipskip
	rts

skipskip:

	;==================
	; flip pages
	;==================

	jsr	page_flip						; 6

	;==================
	; loop forever
	;==================

	jmp	starfield_loop						; 3


;===============================================
; External modules
;===============================================

.include "../asm_routines/hlin_clearscreen.s"
.include "../asm_routines/pageflip.s"
.include "../asm_routines/gr_setpage.s"
.include "../asm_routines/keypress.s"
.include "../asm_routines/gr_putsprite.s"
.include "../asm_routines/text_print.s"

;===============================================
; Variables
;===============================================


.include "../asm_routines/multiply_fast.s"


