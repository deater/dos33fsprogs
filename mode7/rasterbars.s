; Not quite a raster-bar, but why not

.include "zp.inc"

;===========
; CONSTANTS
;===========

ELEMENTS	EQU	64
NUM_ROWS	EQU	20

	;=====================
	; Rasterbars
	;=====================

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	clear_screens		 ; clear top/bottom of page 0/1
	jsr     set_gr_page0


	;===============
	; Init Variables
	;===============
	lda	#0							; 2
	sta	DRAW_PAGE						; 3
	sta	SCREEN_Y						; 3

	;===========================
	;===========================
	; Main Loop
	;===========================
	;===========================
raster_loop:

	jsr	clear_top	; clear screen

	; clear rows

	ldy	#(NUM_ROWS-1)					; 2
	lda	#0						; 2

init_rows:
	sta	row_color,Y					; 5
	dey							; 2
	bpl	init_rows					; 2nt/3

	;================
	; set colors

	lda	#COLOR_BOTH_AQUA	; aqua
	ldy	SCREEN_Y
	jsr	set_row_color

	lda	#COLOR_BOTH_MEDIUMBLUE	; medium blue
	jsr	set_row_color

	lda	#COLOR_BOTH_LIGHTGREEN	; light green
	jsr	set_row_color

	lda	#COLOR_BOTH_DARKGREEN	; green
	jsr	set_row_color

	lda	#COLOR_BOTH_YELLOW	; yellow
	jsr	set_row_color

	lda	#COLOR_BOTH_ORANGE	; orange
	jsr	set_row_color

	lda	#COLOR_BOTH_PINK	; pink
	jsr	set_row_color

	lda	#COLOR_BOTH_RED		; red
	jsr	set_row_color

	;=================
	; draw rows

	ldy	#(NUM_ROWS-1)						; 2
draw_rows_loop:
	lda	row_color,Y						; 5
	beq	draw_rows_skip		; skip if black			; 2nt/3

	sta	COLOR							; 3


	tya								; 2
	pha								; 3
	asl								; 2

	ldy	#39							; 2
        sty	V2							; 3
        ldy	#0							; 2
        jsr	hlin_double		; hlin y,V2 at A	; 63+(X*16)
        pla								; 4
	tay								; 2
draw_rows_skip:
	dey								; 2
	bpl	draw_rows_loop						; 2


	;==================
	; flip pages
	;==================

	jsr	page_flip						; 6


	;==================
	; delay?
	;==================

	lda	#100
	jsr	WAIT


	;==================
	; update y pointer
	;==================
	ldy	SCREEN_Y
	iny
	cpy	#ELEMENTS
	bne	not_there
	ldy	#0
not_there:
	sty	SCREEN_Y


	;==================
	; loop forever
	;==================

	jmp	raster_loop						; 3


	;===================
	;===================
	; set_row_color
	;===================
	;===================
	; color in A
	; Y=offset
	; Y incremented
	; A, X trashed

set_row_color:
	sta	COLOR
	tya			; wrap y offset
	and	#(ELEMENTS-1)
	tax

	lda	fine_sine,X	; lookup sine value
				; pre-shifted right by 4, sign-extended

	clc
	adc	#18		; add in 18 to center on screen

sin_no_more:
	pha
	lsr
	tax
	pla
	pha

	jsr	put_color

	pla
	tax

	cpy	32
	beq	no_inc
	bmi	yes_inc

	dex
	dex
yes_inc:
	inx
no_inc:
	txa		; horrific
	pha
	lsr
	tax
	pla
	jsr	put_color

	iny			; increment for next time

	rts

put_color:
	and	#$1		; see if even or odd
	beq	even_line

	lda	COLOR
	and	#$f0
	sta	COLOR2

	lda	row_color,X
	and	#$0f

	jmp	done_line
even_line:
	lda	COLOR
	and	#$0f
	sta	COLOR2

	lda	row_color,X
	and	#$f0

done_line:
	ora	COLOR2
	sta	row_color,X

	rts

;===============================================
; External modules
;===============================================

.include "../asm_routines/pageflip.s"
.include "../asm_routines/gr_setpage.s"
;.include "../asm_routines/keypress.s"
.include "../asm_routines/gr_offsets.s"
.include "../asm_routines/gr_fast_clear.s"
.include "../asm_routines/gr_hlin.s"

;======================
; some arrays
;======================

row_color:
.byte $00,$00,$00,$00,$00, $00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00, $00,$00,$00,$00,$00

; arithmatically shifted right by 4
fine_sine:
.byte $00 ; 0.000000
.byte $01 ; 0.098017
.byte $03 ; 0.195090
.byte $04 ; 0.290285
.byte $06 ; 0.382683
.byte $07 ; 0.471397
.byte $08 ; 0.555570
.byte $0A ; 0.634393
.byte $0B ; 0.707107
.byte $0C ; 0.773010
.byte $0D ; 0.831470
.byte $0E ; 0.881921
.byte $0E ; 0.923880
.byte $0F ; 0.956940
.byte $0F ; 0.980785
.byte $0F ; 0.995185
.byte $0F ; 1.000000
.byte $0F ; 0.995185
.byte $0F ; 0.980785
.byte $0F ; 0.956940
.byte $0E ; 0.923880
.byte $0E ; 0.881921
.byte $0D ; 0.831470
.byte $0C ; 0.773010
.byte $0B ; 0.707107
.byte $0A ; 0.634393
.byte $08 ; 0.555570
.byte $07 ; 0.471397
.byte $06 ; 0.382683
.byte $04 ; 0.290285
.byte $03 ; 0.195090
.byte $01 ; 0.098017
.byte $00 ; 0.000000
.byte $FE ; -0.098017
.byte $FC ; -0.195090
.byte $FB ; -0.290285
.byte $F9 ; -0.382683
.byte $F8 ; -0.471397
.byte $F7 ; -0.555570
.byte $F5 ; -0.634393
.byte $F4 ; -0.707107
.byte $F3 ; -0.773010
.byte $F2 ; -0.831470
.byte $F1 ; -0.881921
.byte $F1 ; -0.923880
.byte $F0 ; -0.956940
.byte $F0 ; -0.980785
.byte $F0 ; -0.995185
.byte $F0 ; -1.000000
.byte $F0 ; -0.995185
.byte $F0 ; -0.980785
.byte $F0 ; -0.956940
.byte $F1 ; -0.923880
.byte $F1 ; -0.881921
.byte $F2 ; -0.831470
.byte $F3 ; -0.773010
.byte $F4 ; -0.707107
.byte $F5 ; -0.634393
.byte $F7 ; -0.555570
.byte $F8 ; -0.471397
.byte $F9 ; -0.382683
.byte $FB ; -0.290285
.byte $FC ; -0.195090
.byte $FE ; -0.098017

