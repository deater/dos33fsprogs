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

	lda	#0
	sta	CV
	sta	ANGLE


	lda	#>sky_background
	sta	INH
	lda	#<sky_background
	sta	INL
	jsr	decompress_scroll

scroll_forever:
	jsr	scroll_background

	jsr	page_flip						; 6

;	lda	#250
;	jsr	WAIT

	jsr	wait_until_keypressed

	inc	ANGLE

	lda	ANGLE
	and	#$0f
	sta	ANGLE

	jmp	scroll_forever


;===============================================
; Routines
;===============================================
.include "../../asm_routines/gr_fast_clear.s"
.include "../../asm_routines/gr_scroll.s"
.include "../../asm_routines/pageflip.s"
.include "../../asm_routines/gr_setpage.s"
.include "../../asm_routines/keypress.s"
.include "../../asm_routines/bg_scroll.s"
.include "../../asm_routines/gr_offsets.s"

;===============================================
; Variables
;===============================================

.include "starry_sky.scroll"


