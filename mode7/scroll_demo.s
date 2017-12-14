.include "zp.inc"


scroll_row1	EQU     $8A00
scroll_row2	EQU	$8B00
scroll_row3	EQU	$8C00
scroll_row4	EQU	$8D00

SCROLL_LENGTH	EQU	$E6

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

	;=======================
	; decompress scroll text
	;=======================
	lda	#>deater_scroll
	sta	INH
	lda	#<deater_scroll
	sta	INL
	jsr	decompress_scroll


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
	cmp	SCROLL_LENGTH
	bne	blah
	lda	#0
	sta	ANGLE
	jmp	scroll_loop

blah:
	inc	ANGLE
	jmp	scroll_loop						; 3



	;=======================
	; decompress scroll
	;=======================
decompress_scroll:
	ldy	#0
	jsr	load_and_increment
	sta	SCROLL_LENGTH

	lda	#<scroll_row1
	sta	OUTL
	lda	#>scroll_row1
	sta	OUTH

decompress_scroll_loop:
	jsr	load_and_increment	; load compressed value

	cmp	#$A1			; EOF marker
	beq	done_decompress_scroll	; if EOF, exit

	pha				; save

	and	#$f0			; mask
	cmp	#$a0			; see if special AX
	beq	decompress_special

	pla				; note, PLA sets flags!

	ldx	#$1			; only want to print 1
	bne	decompress_run

decompress_special:
	pla

	and	#$0f			; check if was A0

	bne	decompress_color	; if A0 need to read run, color

decompress_large:
	jsr	load_and_increment	; get run length

decompress_color:
	tax				; put runlen into X
	jsr	load_and_increment	; get color

decompress_run:
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
	bne	decompress_run

	beq	decompress_scroll_loop	; get next run

done_decompress_scroll:
	rts


load_and_increment:
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

	;==========
	; page_flip
	;==========

page_flip:
;	lda	$c019		; wait for vertical refresh
;	bmi	page_flip

	lda	DISP_PAGE						; 3
	beq	page_flip_show_1					; 2nt/3
page_flip_show_0:
        bit	PAGE0							; 4
	lda	#4							; 2
	sta	DRAW_PAGE	; DRAW_PAGE=1				; 3
	lda	#0							; 2
	sta	DISP_PAGE	; DISP_PAGE=0				; 3
	rts								; 6
page_flip_show_1:
	bit	PAGE1							; 4
	sta	DRAW_PAGE	; DRAW_PAGE=0				; 3
	lda	#1							; 2
	sta	DISP_PAGE	; DISP_PAGE=1				; 3
	rts								; 6
							;====================
							; DISP_PAGE=0 	26
							; DISP_PAGE=1	24



	;==========================================================
	; set_gr_page0
	;==========================================================
	;
set_gr_page0:
	;lda	#4
	;sta	GR_PAGE
	bit	PAGE0			; set page 0
	bit	LORES			; Lo-res graphics
	bit	TEXTGR			; mixed gr/text mode
	bit	SET_GR			; set graphics
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
