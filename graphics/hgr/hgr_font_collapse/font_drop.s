; VMW: convert text screen to hi-res and drop the chars

.include "zp.inc"
.include "hardware.inc"

drop_y		= $1000
drop_yadd	= $1400

hposn_low	= $1800
hposn_high	= $1900

; Optimization (move_text_screen #0 to #1) $6613:
; $21391	= initial implementation	136081 = ~7.3 fps
; $1F0A9	= optimize move to use X,Y	127145 = ~7.9 fps
; $1E0A9	= make move fixed loop over 1k	123049 = ~8.1 fps
; $1DFC8	= inline put_char, optimize	122824 = ~8.1 fps]

font_drop:

	lda	#0
	sta	DRAW_PAGE

	;====================
	; setup HGR tables
	;====================

	jsr	build_tables

	;====================
	;====================
	; setup drop tables
	;====================
	;====================

reinit:
	;================
	; set up Y table

	ldx	#0
setup_drop_y_outer:
	lda	gr_offsets_l,X
	sta	OUTL
	sta	INL

	lda	gr_offsets_h,X
	clc
	adc	#(>drop_y-$4)
	sta	OUTH
	clc
	adc	#(>drop_yadd - >drop_y)
	sta	INH

	ldy	#0

	txa		; ypos = X*8
	asl
	asl
	asl
setup_drop_y_inner:

	sta	(OUTL),Y

	pha

	jsr	random8
	and	#3
	adc	#2
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

	jsr	hgr_clearscreen

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

	jsr	hgr_clearscreen

	;===================
	; move text screen
	;===================

	jsr	move_text_screen

	;===================
	; draw text screen
	;===================

	jsr	draw_text_screen

	;===================
	; flip page
	;===================

	jsr	hgr_page_flip

retry:
	lda	KEYPRESS
	bmi	restart

	jmp	drop_loop

restart:
	bit	KEYRESET
	jmp	reinit


	.include "fonts/a2_lowercase_font.inc"

	.include "hgr_table.s"
	.include "hgr_clearscreen.s"
	.include "gr_offsets_split.s"

	.include "hgr_page_flip.s"
	.include "random8.s"

	;===================
	; draw text screen
	;===================
	; looks up YPOS from each char from drop_y

draw_text_screen:
	ldx	#0
	ldy	#0
	stx	TEXT_X
	sty	TEXT_Y

copy_text_screen_outer_loop:
	ldx	TEXT_Y
	lda	gr_offsets_l,X
	sta	OUTL
	sta	INL
	lda	gr_offsets_h,X
	sta	OUTH
	clc
	adc	#(>drop_y-$4)
	sta	INH

	ldy	#0
	sty	TEXT_X
copy_text_screen_inner_loop:


	ldy	TEXT_X		; xpos

	lda	(INL),Y		; ypos
	tax

	lda	(OUTL),Y	; load from current line
	and	#$7f		; strip extraneous high bit
				; note: this means inverse not supported

	cmp	#$20		; don't draw space character
	bne	font_putchar

	jmp	skip_space

	;================================
	; inline font_putchar

font_putchar:

;	tay				; put letter to load into Y

	pha

	; row0

	lda	hposn_low, X		; get low memory offset
;	clc
;	adc	TEXT_X			; add in x-coord
	sta	dcb2_row0+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row0+2		; save it out


	inx				; go to next row

	; row1

	lda	hposn_low, X		; get low memory offset
;	clc
;	adc	TEXT_X			; add in x-coord
	sta	dcb2_row1+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row1+2		; save it out

	inx				; go to next row

	; row2

	lda	hposn_low, X		; get low memory offset
;	clc
;	adc	TEXT_X			; add in x-coord
	sta	dcb2_row2+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row2+2		; save it out

	inx				; go to next row

	; row3

	lda	hposn_low, X		; get low memory offset
;	clc
;	adc	TEXT_X			; add in x-coord
	sta	dcb2_row3+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row3+2		; save it out

	inx				; go to next row

	; row4

	lda	hposn_low, X		; get low memory offset
;	clc
;	adc	TEXT_X			; add in x-coord
	sta	dcb2_row4+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row4+2		; save it out

	inx				; go to next row

	; row5

	lda	hposn_low, X		; get low memory offset
;	clc
;	adc	TEXT_X			; add in x-coord
	sta	dcb2_row5+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row5+2		; save it out

	inx				; go to next row

	; row6

	lda	hposn_low, X		; get low memory offset
;	clc
;	adc	TEXT_X			; add in x-coord
	sta	dcb2_row6+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row6+2		; save it out

	inx				; go to next row

	; row7

	lda	hposn_low, X		; get low memory offset
;	clc
;	adc	TEXT_X			; add in x-coord
	sta	dcb2_row7+1
	lda	hposn_high, X		; get high memory offset
	clc
	adc	DRAW_PAGE
	sta	dcb2_row7+2		; save it out


	pla
	tay

	ldx	TEXT_X

	lda	CondensedRow0-$19, Y	; get 1-byte font row
dcb2_row0:
	sta	$8888,X

	lda	CondensedRow1-$19, Y	; get 1-byte font row
dcb2_row1:
	sta	$8888,X

	lda	CondensedRow2-$19, Y	; get 1-byte font row
dcb2_row2:
	sta	$8888,X

	lda	CondensedRow3-$19, Y	; get 1-byte font row
dcb2_row3:
	sta	$8888,X

	lda	CondensedRow4-$19, Y	; get 1-byte font row
dcb2_row4:
	sta	$8888,X

	lda	CondensedRow5-$19, Y	; get 1-byte font row
dcb2_row5:
	sta	$8888,X

	lda	CondensedRow6-$19, Y	; get 1-byte font row
dcb2_row6:
	sta	$8888,X

	lda	CondensedRow7-$19, Y	; get 1-byte font row
dcb2_row7:
	sta	$8888,X

	;=====================================

skip_space:

	inc	TEXT_X
	lda	TEXT_X
	cmp	#40
	beq	goto_texty
;	bne	copy_text_screen_inner_loop
	jmp	copy_text_screen_inner_loop

goto_texty:
	inc	TEXT_Y
	lda	TEXT_Y
	cmp	#24

	beq	goto_done

;	bne	copy_text_screen_outer_loop
	jmp	copy_text_screen_outer_loop


goto_done:
	rts



	;===================
	; move text screen
	;===================
	; drop the text

move_text_screen:
	lda	#>drop_y
	sta	mts_drop_y_smc1+2
	sta	mts_drop_y_smc2+2
	lda	#>drop_yadd
	sta	mts_drop_yadd_smc1+2

	ldy	#0							; 2
move_text_screen_inner_loop:

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

	iny								; 2
	bne	move_text_screen_inner_loop				; 2/3

	inc	mts_drop_y_smc1+2					; 6
	inc	mts_drop_y_smc2+2					; 6
	inc	mts_drop_yadd_smc1+2					; 6

	lda	mts_drop_y_smc1+2					; 4
	cmp	#(>drop_y + 4)						; 2
	bne	move_text_screen_inner_loop				; 2/3

	rts

