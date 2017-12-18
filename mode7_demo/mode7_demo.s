.include "zp.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr     set_gr_page0
	bit	FULLGR
	jsr	clear_screens_notext	 ; clear top/bottom of page 0/1

	lda	#$4
	sta	DRAW_PAGE

	lda	#<demo_rle
	sta	GBASL
	lda	#>demo_rle
	sta	GBASH

	; Load offscreen
	lda	#<$c00
	sta	BASL
	lda	#>$c00
	sta	BASH

	jsr	load_rle_gr

demo_loop:

	;==========
	; Fade in
	;==========

	jsr	fade_in

	;==========================================
	; Make sure page0 and page1 show same image
	;==========================================

	jsr	gr_copy_to_current

	;===================
	; Scroll the message
	;===================

;	lda	#255
;	jsr	WAIT


	lda	#>deater_scroll
	sta	INH
	lda	#<deater_scroll
	sta	INL

;	lda	#10
	lda	#40
	sta	CV


	jsr	gr_scroll

	;=============
	; Fade out
	;=============
	jsr	fade_out


	jmp	demo_loop


;===============================================
; External modules
;===============================================

.include "../asm_routines/gr_unrle.s"
.include "../asm_routines/hlin_clearscreen.s"
.include "../asm_routines/gr_setpage.s"
.include "../asm_routines/pageflip.s"
.include "../asm_routines/gr_fade.s"
.include "../asm_routines/gr_copy.s"

.include "mode7_demo_backgrounds.inc"


scroll_row1	EQU     $8A00
scroll_row2	EQU	$8B00
scroll_row3	EQU	$8C00
scroll_row4	EQU	$8D00

SCROLL_LENGTH	EQU	$61
OFFSET		EQU	$62


	;========================
	; scroll some text
	;========================
	; RLE compressed data in INL/INH
	; CV is Y position to display at

gr_scroll:
	lda	#0
	sta	OFFSET

	;=======================
	; decompress scroll text
	;=======================

	jsr	decompress_scroll


scroll_loop:

	ldx	#0

	ldy	CV
	lsr

	lda	gr_offsets,Y		; get position
	sta	sm1+1
	lda	gr_offsets+2,Y		; get position
	sta	sm2+1
	lda	gr_offsets+4,Y		; get position
	sta	sm3+1
	lda	gr_offsets+6,Y		; get position
	sta	sm4+1


	iny

	clc

	lda	gr_offsets,Y		; get position
	adc	DRAW_PAGE
	sta	sm1+2
	lda	gr_offsets+2,Y		; get position
	adc	DRAW_PAGE
	sta	sm2+2
	lda	gr_offsets+4,Y		; get position
	adc	DRAW_PAGE
	sta	sm3+2
	lda	gr_offsets+6,Y		; get position
	adc	DRAW_PAGE
	sta	sm4+2

	ldy	OFFSET

draw_loop:

	lda	scroll_row1,Y
sm1:
	sta	$400,X

	lda	scroll_row2,Y
sm2:
	sta	$480,X

	lda	scroll_row3,Y
sm3:
	sta	$500,X

	lda	scroll_row4,Y
sm4:
	sta	$580,X

	iny
	inx
	cpx	#40
	bne	draw_loop

	;==================
	; flip pages
	;==================

	jsr	page_flip						; 6

	;==================
	; delay
	;==================

	lda	#125
	jsr	WAIT


	;==================
	; loop forever
	;==================
	clc
	lda	OFFSET
	adc	#40
	cmp	SCROLL_LENGTH
	bne	blah
	lda	#0
	sta	OFFSET
	jmp	scroll_loop

blah:
	inc	OFFSET
	jmp	scroll_loop						; 3



	;=======================
	; decompress scroll
	;=======================
decompress_scroll:
	ldy	#0
	jsr	scroll_load_and_increment
	sta	SCROLL_LENGTH

	lda	#<scroll_row1
	sta	OUTL
	lda	#>scroll_row1
	sta	OUTH

decompress_scroll_loop:
	jsr	scroll_load_and_increment	; load compressed value

	cmp	#$A1			; EOF marker
	beq	done_decompress_scroll	; if EOF, exit

	pha				; save

	and	#$f0			; mask
	cmp	#$a0			; see if special AX
	beq	decompress_scroll_special

	pla				; note, PLA sets flags!

	ldx	#$1			; only want to print 1
	bne	decompress_scroll_run

decompress_scroll_special:
	pla

	and	#$0f			; check if was A0

	bne	decompress_scroll_color	; if A0 need to read run, color

decompress_scroll_large:
	jsr	scroll_load_and_increment	; get run length

decompress_scroll_color:
	tax				; put runlen into X
	jsr	scroll_load_and_increment	; get color

decompress_scroll_run:
	sta	(OUTL),Y
	pha

	clc				; increment 16-bit pointer
	lda	OUTL
	adc	#$1
	sta	OUTL
	lda	OUTH
	adc	#$0
	sta	OUTH

	pla

	dex				; repeat for X times
	bne	decompress_scroll_run

	beq	decompress_scroll_loop	; get next run

done_decompress_scroll:
	rts


scroll_load_and_increment:
	lda	(INL),Y			; load and increment 16-bit pointer
	pha
	clc
	lda	INL
	adc	#$1
	sta	INL
	lda	INH
	adc	#$0
	sta	INH
	pla
	rts


;===============================================
; Variables
;===============================================

.include "deater_scroll.inc"


