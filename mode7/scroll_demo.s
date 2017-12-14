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
	sta	ANGLE

scroll_loop:

	ldx	#0
	ldy	ANGLE

	lda	DISP_PAGE
	beq	draw_page2

	lda	#4
	sta	sm1+2
	sta	sm2+2
	lda	#5
	sta	sm3+2
	sta	sm4+2
	jmp	draw_done

draw_page2:
	lda	#8
	sta	sm1+2
	sta	sm2+2
	lda	#9
	sta	sm3+2
	sta	sm4+2
draw_done:

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
	lda	ANGLE
	adc	#40
	cmp	scroll_length
	bne	blah
	lda	#0
	sta	ANGLE
	jmp	scroll_loop

blah:
	inc	ANGLE
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

