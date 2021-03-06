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

	;=======================
	; decompress scroll text
	;=======================

	lda	#10
	sta	CV

scroll_forever:
	lda	#>deater_scroll
	sta	INH
	lda	#<deater_scroll
	sta	INL


	jsr	gr_scroll

	jmp	scroll_forever


;===============================================
; Routines
;===============================================
.include "gr_fast_clear.s"
.include "gr_scroll.s"
.include "pageflip.s"
.include "gr_setpage.s"
.include "gr_offsets.s"

;===============================================
; Variables
;===============================================

.include "deater_scroll.inc"

