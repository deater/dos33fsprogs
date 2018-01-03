
clear_screens:
	;===================================
	; Clear top/bottom of page 0
	;===================================

	lda	#$0
	sta	DRAW_PAGE
	jsr	clear_top
	jsr	clear_bottom

	;===================================
	; Clear top/bottom of page 1
	;===================================

	lda	#$4
	sta	DRAW_PAGE
	jsr	clear_top
	jsr	clear_bottom

        rts



	;=========================================================
	; clear_top
	;=========================================================
	; clear DRAW_PAGE
	; original = 14,558 cycles(?) 15ms, 70Hz
	; OPTIMIZED MAX (page0,48rows): 45*120+4+6 = 5410 = 5.4ms 185Hz
	;		(pageX,40rows): 50*120+4+6 = 6010 = 6.0ms 166Hz
	;				50*120+4+6+37 = 6055 = 6.0ms 166Hz
clear_top:
	lda	#0							; 2
clear_top_a:
	sta	COLOR							; 3
	clc								; 2
	lda	DRAW_PAGE						; 3

	adc	#4							; 2
	sta	__ctf+2							; 3
	sta	__ctf+5							; 3
	adc	#1							; 2
	sta	__ctf+8							; 3
	sta	__ctf+11						; 3
	adc	#1							; 2
	sta	__ctf2+2						; 3
	sta	__ctf2+5						; 3
	adc	#1							; 2
	sta	__ctf2+8						; 3
	sta	__ctf2+11						; 3


	ldy	#120							; 2
	lda	COLOR							; 3
clear_top_fast_loop:
__ctf:
	sta	$400,Y							; 5
	sta	$480,Y							; 5
	sta	$500,Y							; 5
	sta	$580,Y							; 5

	cpy	#80							; 2
	bpl	no_draw_bottom						; 2nt/3
__ctf2:
	sta	$600,Y							; 5
	sta	$680,Y							; 5
	sta	$700,Y							; 5
	sta	$780,Y							; 5
no_draw_bottom:

	dey								; 2
	bpl	clear_top_fast_loop					; 2nt/3

	rts								; 6




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


clear_screens_notext:
        ;===================================
        ; Clear top/bottom of page 0
        ;===================================

        lda     #$0
        sta     DRAW_PAGE
        jsr     clear_all

        ;===================================
        ; Clear top/bottom of page 1
        ;===================================

        lda     #$4
        sta     DRAW_PAGE
        jsr     clear_all

        rts


	;=========================================================
	; clear_all
	;=========================================================
	; clear 48 rows

clear_all:
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
	lda	#0							; 2
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
