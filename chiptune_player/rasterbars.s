; Not quite a raster-bar, but why not

;===========
; CONSTANTS
;===========

ELEMENTS	EQU	64
NUM_ROWS	EQU	20

	;=====================
	; Rasterbars
	;=====================

	;===========================
	;===========================
	; Main Loop
	;===========================
	;===========================
draw_rasters:

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
	; update y pointer
	;==================
	ldy	SCREEN_Y
	iny
	cpy	#ELEMENTS
	bne	not_there
	ldy	#0
not_there:
	sty	SCREEN_Y


	rts

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

	pha			; save row value
	jsr	put_color	; put color at row
	pla			; restore row value

	clc			; increment row value
	adc	#1

	jsr	put_color	; put color at row

	iny			; increment for next time

	rts

	;==================
	; put_color
	;==================
	; A = row to set color of
	; A trashed
put_color:
	clc
	ror			; row/2, with even/odd in carry
	tax			; put row/2 in X

	bcc	even_line	; if even, skip to even
odd_line:
	lda	#$f0		; load mask for odd
	bcs	finish_line
even_line:
	lda	#$0f		; load mask for even
finish_line:
	sta	MASK

	and	COLOR		; mask off color
	sta	COLOR2		; store for later

	lda	MASK
	eor	#$ff		; invert mask
	and	row_color,X	; load existing color

	ora	COLOR2		; combine
	sta	row_color,X	; store back

	rts

;======================
; some arrays
;======================

row_color:
.byte $00,$00,$00,$00,$00, $00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00, $00,$00,$00,$00,$00

; arithmatically shifted right by 4

; FIXME: exploit symmetry and get rid of 3/4 of this table
;	 possibly not worth the extra code
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

