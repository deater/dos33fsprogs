	;=========================================================
	; clear_all
	;=========================================================
	; clear 48 rows

clear_fullgr:
	clc								; 2
	lda	DRAW_PAGE						; 3

	adc	#4							; 2
	sta	__caf+2							; 3
	sta	__caf+5							; 3
	adc	#1							; 2
	sta	__caf+8							; 3
	sta	__caf+11						; 3
	adc	#1							; 2
	sta	__caf2+2						; 3
	sta	__caf2+5						; 3
	adc	#1							; 2
	sta	__caf2+8						; 3
	sta	__caf2+11						; 3


	ldy	#120							; 2
clear_all_color:
	lda	COLOR							; 2
clear_all_fast_loop:
__caf:
	sta	$400,Y							; 5
	sta	$480,Y							; 5
	sta	$500,Y							; 5
	sta	$580,Y							; 5
__caf2:
	sta	$600,Y							; 5
	sta	$680,Y							; 5
	sta	$700,Y							; 5
	sta	$780,Y							; 5

	dey								; 2
	bpl	clear_all_fast_loop					; 2nt/3

	rts								; 6
