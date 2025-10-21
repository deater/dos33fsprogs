; VMW: convert text screen to hi-res and drop the chars

drop_y		= $a000
drop_yadd	= $a400

; Note the fps values are going to change depending how many chars on screen

; Optimization (move_text_screen #0 to #1) (later draw_text_screen #1 to #2):
; $21391	= initial implementation	136081 = ~7.3 fps
; $1F0A9	= optimize move to use X,Y	127145 = ~7.9 fps
; $1E0A9	= make move fixed loop over 1k	123049 = ~8.1 fps
; $1DFC8	= inline put_char, optimize	122824 = ~8.1 fps
; $1A9BB	= optimize some more		108987 = ~9.2 fps
; $14E03	= inline move routine		 85507 = ~11.7 fps


font_drop:

	lda	#0
	sta	DRAW_PAGE


	;====================
	;====================
	; setup drop tables
	;====================
	;====================

reinit:

	ldx	#0
setup_drop_y_outer:
	lda	gr_offsets_l,X
	sta	OUTL				; OUTL is drop_y
	sta	INL				; INL is drop_yadd

	lda	gr_offsets_h,X
	clc
	adc	#(>drop_y-$4)
	sta	OUTH
	clc
	adc	#(>drop_yadd - >drop_y)
	sta	INH

	ldy	#0

	txa					; ypos = X*8
	asl
	asl
	asl
setup_drop_y_inner:

	sta	(OUTL),Y			; store out ypos


	pha

	jsr	random8				; random yadd
	and	#3				; from 3-4?
	adc	#3
	sta	(INL),Y

	pla

	iny
	cpy	#40
	bne	setup_drop_y_inner

	inx
	cpx	#24
	bne	setup_drop_y_outer


	;========================
	; draw initial screen
	;========================

	jsr	hgr_clear_screen

	jsr	draw_text_screen

	;===================
	; set graphics mode
	;===================

	bit	PAGE1
	bit	HIRES
	bit	FULLGR
	bit	SET_GR

	lda	#$20
	sta	DRAW_PAGE

	;===================
	;===================
	;===================
	; drop loop
	;===================
	;===================
	;===================


drop_loop:

	;===================
	; clear screen
	;===================

	jsr	hgr_clear_screen

	;=========================
	; draw text + move screen
	;=========================

	jsr	draw_text_screen

	;===================
	; flip page
	;===================

	jsr	hgr_page_flip

;retry:
;	lda	KEYPRESS
;	bpl	retry
;	bit	KEYRESET

	lda	KEYPRESS
	bmi	restart

	jmp	drop_loop

restart:
;	bit	KEYRESET
;	jmp	reinit


	rts

	.include "font/fonts/a2_lowercase_font.inc"


	;===================
	; draw text screen
	;===================
	; looks up YPOS from each char from drop_y

draw_text_screen:
	ldx	#0

copy_text_screen_outer_loop:
	stx	TEXT_Y			; backup X into text_y		; 3

	lda	gr_offsets_l,X		; setup OUTL/H to point		; 4+
	sta	ctsi_smc2+1		; to text line			; 4
	sta	ctsi_smc1+1						; 4
	sta	mts_drop_y_smc1+1					; 4
	sta	mts_drop_y_smc2+1					; 4
	sta	mts_drop_yadd_smc1+1					; 4

	lda	gr_offsets_h,X						; 4+
	sta	ctsi_smc2+2						; 4

	clc				; setup INL/H to point		; 2
	adc	#(>drop_y-$4)		;  to Ypos table		; 2
	sta	ctsi_smc1+2						; 4
	sta	mts_drop_y_smc1+2					; 4
	sta	mts_drop_y_smc2+2					; 4
	adc	#(>drop_yadd- >drop_y)					; 2
	sta	mts_drop_yadd_smc1+2					; 4

	ldy	#0			; xpos starts at 0		; 2

copy_text_screen_inner_loop:

ctsi_smc1:
	ldx	$dddd,Y		; ypos from table			; 4+

ctsi_smc2:
	lda	$dddd,Y		; load char from current line		; 4+
	and	#$7f		; strip extraneous high bit		; 2
				; note: this means inverse not supported

	cmp	#$20		; don't draw space character		; 2
	bne	font_putchar						; 2/3

	jmp	skip_space						; 3

	;================================
	; inline font_putchar

font_putchar:

	sta	ctsi_smc3+1	; save char for later			; 4

	clc			; only need to clear once		; 2
				; as not possible to overflow
				; going from $20 to $40

	; row0

	lda	hposn_low, X	; get low memory offset			; 4+
	sta	dcb2_row0+1						; 4
	lda	hposn_high, X	; get high memory offset		; 4+
	adc	DRAW_PAGE						; 3
	sta	dcb2_row0+2	; save it out				; 4

	; row1

	lda	hposn_low+1, X		; get low memory offset
	sta	dcb2_row1+1
	lda	hposn_high+1, X		; get high memory offset
	adc	DRAW_PAGE
	sta	dcb2_row1+2		; save it out

	; row2

	lda	hposn_low+2, X		; get low memory offset
	sta	dcb2_row2+1
	lda	hposn_high+2, X		; get high memory offset
	adc	DRAW_PAGE
	sta	dcb2_row2+2		; save it out

	; row3

	lda	hposn_low+3, X		; get low memory offset
	sta	dcb2_row3+1
	lda	hposn_high+3, X		; get high memory offset
	adc	DRAW_PAGE
	sta	dcb2_row3+2		; save it out

	; row4

	lda	hposn_low+4, X		; get low memory offset
	sta	dcb2_row4+1
	lda	hposn_high+4, X		; get high memory offset
	adc	DRAW_PAGE
	sta	dcb2_row4+2		; save it out

	; row5

	lda	hposn_low+5, X		; get low memory offset
	sta	dcb2_row5+1
	lda	hposn_high+5, X		; get high memory offset
	adc	DRAW_PAGE
	sta	dcb2_row5+2		; save it out

	; row6

	lda	hposn_low+6, X		; get low memory offset
	sta	dcb2_row6+1
	lda	hposn_high+6, X		; get high memory offset
	adc	DRAW_PAGE
	sta	dcb2_row6+2		; save it out

	; row7

	lda	hposn_low+7, X		; get low memory offset
	sta	dcb2_row7+1
	lda	hposn_high+7, X		; get high memory offset
	adc	DRAW_PAGE
	sta	dcb2_row7+2		; save it out


ctsi_smc3:
	ldx	#$DD			; get character

	lda	CondensedRow0-$19, X	; get 1-byte font row		; 4+
dcb2_row0:
	sta	$dddd,Y							; 5

	lda	CondensedRow1-$19, X	; get 1-byte font row
dcb2_row1:
	sta	$dddd,Y

	lda	CondensedRow2-$19, X	; get 1-byte font row
dcb2_row2:
	sta	$dddd,Y

	lda	CondensedRow3-$19, X	; get 1-byte font row
dcb2_row3:
	sta	$dddd,Y

	lda	CondensedRow4-$19, X	; get 1-byte font row
dcb2_row4:
	sta	$dddd,Y

	lda	CondensedRow5-$19, X	; get 1-byte font row
dcb2_row5:
	sta	$dddd,Y

	lda	CondensedRow6-$19, X	; get 1-byte font row
dcb2_row6:
	sta	$dddd,Y

	lda	CondensedRow7-$19, X	; get 1-byte font row
dcb2_row7:
	sta	$dddd,Y

	;=====================================

	;===========================
	; move text screen inlined

move_text_screen:

mts_drop_y_smc1:
	lda	drop_y,Y						; 4
	clc								; 2
mts_drop_yadd_smc1:
	adc	drop_yadd,Y						; 4

	cmp	#184							; 2
	bcs	skip_drop						; 2/3

mts_drop_y_smc2:
	sta	drop_y,Y						; 5

skip_drop:

	;==========================================================

skip_space:

	iny			; move to next text column		; 2
	cpy	#40		; see if hit end			; 2

	beq	goto_texty						; 2/3
	jmp	copy_text_screen_inner_loop				; 3

goto_texty:

	ldx	TEXT_Y		; restore ypos				; 3
	inx			; move to next text row			; 2
	cpx	#24		; see if hit end			; 2

	beq	goto_done						; 2/3

	jmp	copy_text_screen_outer_loop				; 3


goto_done:
	rts


