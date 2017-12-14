.include "zp.inc"


	;================================
	; Clear screen and setup graphics
	;================================

	jsr	clear_screens		 ; clear top/bottom of page 0/1
	jsr     set_gr_page0

	;===============
	; Init Variables
	;===============
	lda	#0
	sta	DISP_PAGE

scroll_loop:

	ldx	scroll_length
	ldy	#0
draw_loop:
	lda	scroll_row1,Y
	sta	$400,Y

	lda	scroll_row2,Y
	sta	$480,Y

	lda	scroll_row3,Y
	sta	$500,Y

	lda	scroll_row4,Y
	sta	$580,Y

	iny
	dex
	bne	draw_loop


	;==================
	; flip pages
	;==================

;	jsr	page_flip						; 6

	;==================
	; loop forever
	;==================

	jmp	scroll_loop						; 3

;===============================================
; External modules
;===============================================

.include "utils.s"

;===============================================
; Variables
;===============================================

.include "deater_scroll.inc"

	; waste memory with a lookup table
	; move this to the zeropage?

gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word 	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0

