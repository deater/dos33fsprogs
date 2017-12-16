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

	;================================
	; hlin_setup
	;================================
	; put address in GBASL/GBASH
	; Ycoord in A, Xcoord in Y
hlin_setup:
	sty	TEMPY							; 3
	tay			; y=A					; 2
	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	clc								; 2
	adc	TEMPY							; 3
	sta	GBASL							; 3
	iny								; 2

	lda	gr_offsets,Y						; 4
	adc	DRAW_PAGE	; add in draw page offset		; 3
	sta	GBASH							; 3
	rts								; 6
								;===========
								;	35
	;================================
	; hlin_double:
	;================================
	; HLIN Y, V2 AT A
	; Y, X, A trashed
	; start at Y, draw up to and including X
hlin_double:
;int hlin_double(int page, int x1, int x2, int at) {

	jsr	hlin_setup						; 41

	sec								; 2
	lda	V2							; 3
	sbc	TEMPY							; 3

	tax								; 2
	inx								; 2
								;===========
								;	53
	; fallthrough

	;=================================
	; hlin_double_continue:  width
	;=================================
	; width in X

hlin_double_continue:

	ldy	#0							; 2
	lda	COLOR							; 3
hlin_double_loop:
	sta	(GBASL),Y						; 6
	inc	GBASL							; 5
	dex								; 2
	bne	hlin_double_loop					; 2nt/3

	rts								; 6
								;=============
								; 53+5+X*16+5

	;================================
	; hlin_single:
	;================================
	; HLIN Y, V2 AT A
	; Y, X, A trashed
hlin_single:

	jsr	hlin_setup

	sec
	lda	V2
	sbc	TEMPY

	tax

	; fallthrough

	;=================================
	; hlin_single_continue:  width
	;=================================
	; width in X

hlin_single_continue:

hlin_single_top:
	lda	COLOR
	and	#$f0
	sta	COLOR

hlin_single_top_loop:
	ldy	#0
	lda	(GBASL),Y
	and	#$0f
	ora	COLOR
	sta	(GBASL),Y
	inc	GBASL
	dex
	bne	hlin_single_top_loop

	rts

hlin_single_bottom:

	lda	COLOR
	and	#$0f
	sta	COLOR

hlin_single_bottom_loop:
	ldy	#0
	lda	(GBASL),Y
	and	#$f0
	sta	(GBASL),Y
	inc	GBASL
	dex
	bne	hlin_single_bottom_loop

	rts


	;=============================
	; clear_top
	;=============================
clear_top:
	lda	#$00

	;=============================
	; clear_top_a
	;=============================
clear_top_a:

	sta	COLOR

	; VLIN Y, V2 AT A

	lda	#40
	sta	V2

	lda	#0

clear_top_loop:
	ldy	#0
	pha

	jsr	hlin_double

	pla
	clc
	adc	#$2
	cmp	#40
	bne	clear_top_loop

	rts

clear_bottom:
	lda	#$a0	; NORMAL space
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

	; move these to zero page for slight speed increase?
gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0
