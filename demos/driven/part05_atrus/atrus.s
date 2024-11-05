.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"


; OK: was going to have hi-res top, scroll lo-res bottom
;	vapor lock (but using IIe)
;	problem is that won't work with 50Hz music / 60Hz screen

; I guess can try for smooth scroll bottom hires but do we have code for that?

; page flip  $2000/$4000
; scroll text $6000, 160..192 = 32?
;
;
;
;

	;=============================
	; draw the atrus scene
	;=============================

atrus_opener:
	lda	#0

	bit     SET_GR
        bit     HIRES
        bit     TEXTGR
        bit     PAGE1

	;=================================
	; intro
	;=================================

	lda	#<atrus03_graphics
	sta	zx_src_l+1
	lda	#>atrus03_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	lda	#<atrus_text
	sta	OUTL
	lda	#>atrus_text
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	jsr	wait_until_keypress

	;=================================
	; scroller
	;=================================
	bit	FULLGR

	lda	#<atrus10_graphics
	sta	zx_src_l+1
	lda	#>atrus10_graphics
	sta	zx_src_h+1
	lda	#$40				; on both pages
	jsr	zx02_full_decomp

	jsr	do_scroll

	jsr	wait_until_keypress


	;=================================
	; book start
	;=================================

	lda	#<atrus10_graphics
	sta	zx_src_l+1
	lda	#>atrus10_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	wait_until_keypress

	;=================================
	; plasma
	;=================================

	lda	#<atrus11_graphics
	sta	zx_src_l+1
	lda	#>atrus11_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	; load both pages as we page flip

	lda	#<atrus11_graphics
	sta	zx_src_l+1
	lda	#>atrus11_graphics
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp


	jsr	plasma_debut

	jsr	wait_until_keypress


	rts

atrus03_graphics:
	.incbin "graphics/atrus03_iipix.hgr.zx02"
atrus10_graphics:
	.incbin "graphics/atrus10_iipix.hgr.zx02"
atrus11_graphics:
	.incbin "graphics/atrus11_iipix.hgr.zx02"

atrus_text:
	.byte 7,20,"Thank God you've returned.",0
	.byte 4,22,"I need... Wait, is this a demo?",0
	.byte 9,23,"Sorry let me try again",0

.include "../wait_keypress.s"

.include "plasma.s"

.include "font/large_font.inc"


do_scroll:
	lda	#0
	sta	SCROLL_START
do_scroll_again:
	ldy	#0
	lda	SCROLL_START
	sta	SCROLL_OFFSET	; FIXME: SCROLL_OFFSET
do_scroll_loop:
	ldx	SCROLL_OFFSET
	lda	scroll_text,X
	sec
	sbc	#'@'
	asl
	tax
do_scroll_col_loop:
	; row1
	lda	large_font_row0,X
	sta	$22D0,Y
	; row2
	lda	large_font_row1,X
	sta	$26D0,Y
	; row3
	lda	large_font_row2,X
	sta	$2AD0,Y
	; row4
	lda	large_font_row3,X
	sta	$2ED0,Y
	; row5
	lda	large_font_row4,X
	sta	$32D0,Y
	; row6
	lda	large_font_row5,X
	sta	$36D0,Y
	; row7
	lda	large_font_row6,X
	sta	$3AD0,Y
	; row8
	lda	large_font_row7,X
	sta	$3ED0,Y
	; row9
	lda	large_font_row8,X
	sta	$2350,Y
	; row10
	lda	large_font_row9,X
	sta	$2750,Y
	; row11
	lda	large_font_row10,X
	sta	$2B50,Y
	; row12
	lda	large_font_row11,X
	sta	$2F50,Y
	; row13
	lda	large_font_row12,X
	sta	$3350,Y
	; row14
	lda	large_font_row13,X
	sta	$3750,Y
	; row15
	lda	large_font_row14,X
	sta	$3B50,Y
	; row16
	lda	large_font_row15,X
	sta	$3F50,Y

	inx
	iny
	tya
	and	#1
	bne	do_scroll_col_loop

	inc	SCROLL_OFFSET
	cpy	#40
	bne	do_scroll_loop

	; FIXME: also check keyboard

	lda	#200
	jsr	wait

	inc	SCROLL_START
	lda	SCROLL_START
	cmp	#80
	beq	do_scroll_done

	jmp	do_scroll_again

do_scroll_done:

	rts

scroll_text:  ;0123456789012345678901234567890123456789
	.byte "@@@@@@@@@@@@@@@@@@@@\]^_THE@QUICK@BROWN@"
	.byte "FOX@JUMPED@OVER@THE@LAZY@DOG@PACK@MY@BOX"
	.byte "@WITH@FIVE@DOZEN@LIQOUR@JUGS"
