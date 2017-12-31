;=====================================================================
;= ROUTINES
;=====================================================================


clear_screens:
	;===================================
	; Clear top/bottom of page 0
	;===================================

	lda     #$0
	sta     DRAW_PAGE
	jsr     clear_top
	jsr     clear_bottom

	;===================================
	; Clear top/bottom of page 1
	;===================================

	lda     #$4
	sta     DRAW_PAGE
	jsr     clear_top
	jsr     clear_bottom

	rts


clear_screens_notext:
	;===================================
	; Clear top/bottom of page 0
	;===================================

	lda     #$0
	sta     DRAW_PAGE
	jsr     clear_top
	lda	#$0
	jsr     clear_bottom_a

	;===================================
	; Clear top/bottom of page 1
	;===================================

	lda     #$4
	sta     DRAW_PAGE
	jsr     clear_top
	lda	#$0
	jsr     clear_bottom_a

	rts



	;=============================
	; clear_top
	;=============================
	; takes 2+10+	(24+703 )*20	+6
	; 14,558 cycles(?) 15ms, 70Hz
clear_top:
	lda	#$00							; 2

	;=============================
	; clear_top_a
	;=============================
clear_top_a:

	sta	COLOR							; 3

	; HLIN Y, V2 AT A

	lda	#39							; 2
	sta	V2							; 3

	lda	#0							; 2

clear_top_loop:
	ldy	#0							; 2
	pha								; 3

	jsr	hlin_double						; 6+

	pla								; 4
	clc								; 2
	adc	#$2							; 2
	cmp	#40							; 2
	bne	clear_top_loop						; 2nt/3

	rts								; 6

	;=============================
	; clear_bottom
	;=============================
clear_bottom:
	lda	#$a0	; NORMAL space

clear_bottom_a:

	sta	COLOR

	lda	#40
	sta	V2

clear_bottom_loop:
	ldy	#0
	pha

	jsr	hlin_double

	pla
	clc
	adc	#$2
	cmp	#48
	bne	clear_bottom_loop

	rts

