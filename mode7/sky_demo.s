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
.include "../asm_routines/hlin_clearscreen.s"
.include "../asm_routines/gr_scroll.s"
.include "../asm_routines/pageflip.s"
.include "../asm_routines/gr_setpage.s"
.include "../asm_routines/keypress.s"

;===============================================
; Variables
;===============================================

.include "starry_sky.scroll"


	;==================
	; scroll background
	;==================
	; background already loaded
	; ANGLE 0-15 sets angle
	; CV is Y position to display at
	; 182/220... 220/16 = 13.75
	; 0 1   2  3  4  5  6  7  8   9  10  11  12  13  14  15  16
	; 0 11 22 34 45 56 68 79 91 102 113 125 136 147 159 170 182

scroll_offsets:
	.byte 0,11,22,34,45,56,68,79,91,102,113,125,136,147,159,170

scroll_background:
	ldy	ANGLE
	lda	scroll_offsets,Y
	sta	OFFSET

scrollbg_loop:

	ldx	#0

	ldy	CV
	lsr

	lda	gr_offsets,Y		; get position
	sta	bgsm1+1
	lda	gr_offsets+2,Y		; get position
	sta	bgsm2+1
	lda	gr_offsets+4,Y		; get position
	sta	bgsm3+1
	lda	gr_offsets+6,Y		; get position
	sta	bgsm4+1


	iny

	clc

	lda	gr_offsets,Y		; get position
	adc	DRAW_PAGE
	sta	bgsm1+2
	lda	gr_offsets+2,Y		; get position
	adc	DRAW_PAGE
	sta	bgsm2+2
	lda	gr_offsets+4,Y		; get position
	adc	DRAW_PAGE
	sta	bgsm3+2
	lda	gr_offsets+6,Y		; get position
	adc	DRAW_PAGE
	sta	bgsm4+2

	ldy	OFFSET

bgdraw_loop:

	lda	scroll_row1,Y
bgsm1:
	sta	$400,X

	lda	scroll_row2,Y
bgsm2:
	sta	$480,X

	lda	scroll_row3,Y
bgsm3:
	sta	$500,X

	lda	scroll_row4,Y
bgsm4:
	sta	$580,X

	iny
	inx
	cpx	#40
	bne	bgdraw_loop

	;==================
	; flip pages
	;==================

	jsr	page_flip						; 6

done_bgscrolling:
	rts


