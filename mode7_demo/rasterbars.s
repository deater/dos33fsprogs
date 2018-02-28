; Not quite a raster-bar, but why not

; Turns out this is quite the CPU hog.
; Optimized a bit based on the version in the chiptune player

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

	ldy	#(NUM_ROWS-1)						; 2
	lda	#0							; 2

init_rows:
	sta	row_color,Y						; 5
	dey								; 2
	bpl	init_rows						; 2nt/3
							;================
							; 4+(10*20) = 204
							; could be 82 if unroll
							; at 6*code size
	;================
	; set colors

	ldy	SCREEN_Y						; 3

	lda	#COLOR_BOTH_AQUA	; aqua				; 2
	jsr	set_row_color						; 6+136

	lda	#COLOR_BOTH_MEDIUMBLUE	; medium blue			; 2
	jsr	set_row_color						; 6+136

	lda	#COLOR_BOTH_LIGHTGREEN	; light green			; 2
	jsr	set_row_color						; 6+136

	lda	#COLOR_BOTH_DARKGREEN	; green				; 2
	jsr	set_row_color						; 6+136

	lda	#COLOR_BOTH_YELLOW	; yellow			; 2
	jsr	set_row_color						; 6+136

	lda	#COLOR_BOTH_ORANGE	; orange			; 2
	jsr	set_row_color						; 6+136

	lda	#COLOR_BOTH_PINK	; pink				; 2
	jsr	set_row_color						; 6+136

	lda	#COLOR_BOTH_RED		; red				; 2
	jsr	set_row_color						; 6+136
							;======================
							; 3+(8*144) = 1155
	;=================
	; draw rows

	ldy	#(NUM_ROWS-1)						; 2
draw_rows_loop:
	lda	row_color,Y						; 5
	beq	draw_rows_skip		; skip if black			; 2nt/3

	sta	COLOR							; 3

	sty	TEMPY							; 3
	tya								; 2
	asl				; y*2				; 2
	tay								; 2

	; hlin_setup inlined

	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	sta	GBASL							; 3
	iny								; 2
	lda	gr_offsets,Y						; 4
	clc								; 2
	adc	DRAW_PAGE	; add in draw page offset		; 3
	sta	GBASH							; 3

	ldy	#39							; 2
	lda	COLOR							; 3
double_loop:
	sta	(GBASL),Y						; 6
	dey								; 2
	bpl	double_loop						; 2nt/3

	ldy	TEMPY							; 3

draw_rows_skip:
	dey								; 2
	bpl	draw_rows_loop						; 2nt/3
							;======================
							; 2+20*(53+11*40)=9862
							; *note* worst case

	;==================
	; update y pointer
	;==================
	ldy	SCREEN_Y						; 3
	iny								; 2
	cpy	#ELEMENTS						; 2
	bne	not_there						; 2nt/3
	ldy	#0							; 2
not_there:
	sty	SCREEN_Y						; 3


	rts								; 6
								;=============
								;	24

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
	sta	COLOR							; 3
	tya			; wrap y offset				; 2
	and	#(ELEMENTS-1)						; 2
	tax								; 2

	lda	fine_sine,X	; lookup sine value			; 4
				; pre-shifted right by 4, sign-extended
				; 18 added to center

sin_no_more:

	pha			; save row value			; 3
	jsr	put_color	; put color at row			; 6+44
	pla			; restore row value			; 4

	clc			; increment row value			; 2
	adc	#1							; 2

	jsr	put_color	; put color at row			; 6+44

	iny			; increment for next time		; 2

	rts								; 6
								;============
								;	132
	;==================
	; put_color
	;==================
	; A = row to set color of
	; A trashed
put_color:
	clc								; 2
	ror			; row/2, with even/odd in carry		; 2
	tax			; put row/2 in X			; 2

	bcc	even_line	; if even, skip to even			; 2nt/3
odd_line:
	lda	#$f0		; load mask for odd			; 2
	bcs	finish_line						; 2nt/3
even_line:
	lda	#$0f		; load mask for even			; 2
finish_line:
	sta	MASK							; 3

	and	COLOR		; mask off color			; 3
	sta	COLOR2		; store for later			; 3

	lda	MASK							; 3
	eor	#$ff		; invert mask				; 2
	and	row_color,X	; load existing color			; 4

	ora	COLOR2		; combine				; 3
	sta	row_color,X	; store back				; 5

	rts								; 6

								;============
								;	44

;======================
; some arrays
;======================

row_color:
.byte $00,$00,$00,$00,$00, $00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00, $00,$00,$00,$00,$00

; arithmatically shifted right by 4, sign extended, added 18 to center

; FIXME: exploit symmetry and get rid of 3/4 of this table
;	 possibly not worth the extra code
fine_sine:
.byte $00+18 ; 0.000000		; a[y]     00..10
.byte $01+18 ; 0.098017		; a[32-y]  11..20
.byte $03+18 ; 0.195090		; ~a[y-33] 21..30
.byte $04+18 ; 0.290285		; ~a[64-y] 31..3f
.byte $06+18 ; 0.382683
.byte $07+18 ; 0.471397
.byte $08+18 ; 0.555570
.byte $0A+18 ; 0.634393
.byte $0B+18 ; 0.707107
.byte $0C+18 ; 0.773010
.byte $0D+18 ; 0.831470
.byte $0E+18 ; 0.881921
.byte $0E+18 ; 0.923880
.byte $0F+18 ; 0.956940
.byte $0F+18 ; 0.980785
.byte $0F+18 ; 0.995185

.byte $0F+18 ; 1.000000

.byte $0F+18 ; 0.995185
.byte $0F+18 ; 0.980785
.byte $0F+18 ; 0.956940
.byte $0E+18 ; 0.923880
.byte $0E+18 ; 0.881921
.byte $0D+18 ; 0.831470
.byte $0C+18 ; 0.773010
.byte $0B+18 ; 0.707107
.byte $0A+18 ; 0.634393
.byte $08+18 ; 0.555570
.byte $07+18 ; 0.471397
.byte $06+18 ; 0.382683
.byte $04+18 ; 0.290285
.byte $03+18 ; 0.195090
.byte $01+18 ; 0.098017

.byte $00+18 ; 0.000000
.byte ($FE+18)&$ff ; -0.098017
.byte ($FC+18)&$ff ; -0.195090
.byte ($FB+18)&$ff ; -0.290285
.byte ($F9+18)&$ff ; -0.382683
.byte ($F8+18)&$ff ; -0.471397
.byte ($F7+18)&$ff ; -0.555570
.byte ($F5+18)&$ff ; -0.634393
.byte ($F4+18)&$ff ; -0.707107
.byte ($F3+18)&$ff ; -0.773010
.byte ($F2+18)&$ff ; -0.831470
.byte ($F1+18)&$ff ; -0.881921
.byte ($F1+18)&$ff ; -0.923880
.byte ($F0+18)&$ff ; -0.956940
.byte ($F0+18)&$ff ; -0.980785
.byte ($F0+18)&$ff ; -0.995185

.byte ($F0+18)&$ff ; -1.000000
.byte ($F0+18)&$ff ; -0.995185
.byte ($F0+18)&$ff ; -0.980785
.byte ($F0+18)&$ff ; -0.956940
.byte ($F1+18)&$ff ; -0.923880
.byte ($F1+18)&$ff ; -0.881921
.byte ($F2+18)&$ff ; -0.831470
.byte ($F3+18)&$ff ; -0.773010
.byte ($F4+18)&$ff ; -0.707107
.byte ($F5+18)&$ff ; -0.634393
.byte ($F7+18)&$ff ; -0.555570
.byte ($F8+18)&$ff ; -0.471397
.byte ($F9+18)&$ff ; -0.382683
.byte ($FB+18)&$ff ; -0.290285
.byte ($FC+18)&$ff ; -0.195090
.byte ($FE+18)&$ff ; -0.098017

