; do a (hopefully fast) roto-zoom

.include "zp.inc"
.include "hardware.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	HOME
	bit	PAGE0			; set page 0
	bit	LORES			; Lo-res graphics
	bit	TEXTGR			; mixed gr/text mode
	bit	SET_GR			; set graphics

	lda	#0
	sta	DISP_PAGE
	lda	#4
	sta	DRAW_PAGE

	;===================================
	; Clear top/bottom of page 0 and 1
	;===================================

	jsr	clear_screens

	;======================
	; show the title screen
	;======================

	; Title Screen

title_screen:

	;===========================
	; Clear both bottoms

	jsr     clear_bottoms

	;=============================
	; Load title

	lda     #<(title_lzsa)
        sta     getsrc_smc+1
	lda     #>(title_lzsa)
	sta	getsrc_smc+2

	lda	#$0c

	jsr     decompress_lzsa2_fast

	;=================================
	; copy to both pages

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

	;=================================
	; main loop

	lda	#0
	sta	ANGLE

main_loop:

	jsr	rotozoom

	jsr	page_flip

wait_for_keypress:
	lda	KEYPRESS
	bpl	wait_for_keypress

	bit	KEYRESET

	inc	ANGLE
	lda	ANGLE
	and	#$f
	sta	ANGLE

	jmp	main_loop



;===============================================
; External modules
;===============================================

.include "rotozoom.s"

.include "gr_pageflip.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "decompress_fast_v2.s"
.include "gr_offsets.s"

.include "gr_plot.s"
.include "gr_scrn.s"

;===============================================
; Data
;===============================================

.include "tfv_title.inc"
