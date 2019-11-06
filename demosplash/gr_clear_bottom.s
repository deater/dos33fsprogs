;clear_screens:
;	;===================================
;	; Clear top/bottom of page 0
;	;===================================
;
;	lda	#$0
;	sta	DRAW_PAGE
;	jsr	clear_top
;	jsr	clear_bottom

;	;===================================
;	; Clear top/bottom of page 1
;	;===================================
;
;	lda	#$4
;	sta	DRAW_PAGE
;	jsr	clear_top
;	jsr	clear_bottom
;
;	rts

;clear_bottoms:

;	lda	DRAW_PAGE
;	pha

	;===================================
	; Clear bottom of page 0
	;===================================

;	lda	#$0
;	sta	DRAW_PAGE
;	jsr	clear_bottom

	;===================================
	; Clear bottom of page 1
	;===================================

;	lda	#$4
;	sta	DRAW_PAGE
;	jsr	clear_bottom

;	pla
;	sta	DRAW_PAGE

;	rts

	;=========================================================
	; clear_bottom
	;=========================================================
	; clear bottom of draw page

clear_bottom:
	clc								; 2
	lda	DRAW_PAGE						; 3

	adc	#6							; 2
	sta	__cbf2+2						; 3
	sta	__cbf2+5						; 3
	adc	#1							; 2
	sta	__cbf2+8						; 3
	sta	__cbf2+11						; 3


	ldy	#120							; 2
	lda	#$a0	; Normal Space					; 2
clear_bottom_fast_loop:
__cbf2:
	sta	$600,Y							; 5
	sta	$680,Y							; 5
	sta	$700,Y							; 5
	sta	$780,Y							; 5

	dey								; 2
	cpy	#80							; 2
	bpl	clear_bottom_fast_loop					; 2nt/3

	rts								; 6


