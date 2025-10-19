; VMW: convert text screen to hi-res and drop the chars

.include "zp.inc"
.include "hardware.inc"

drop_y		= $1000
drop_yadd	= $1400

hposn_low	= $1800
hposn_high	= $1900


font_drop:

	lda	#0
	sta	DRAW_PAGE

	;====================
	; setup HGR tables
	;====================

	jsr	build_tables

	;====================
	; setup drop tables
	;====================

	; set up Y table

	ldx	#0
setup_drop_y_outer:
	lda	gr_offsets_l,X
	sta	OUTL
	lda	gr_offsets_h,X
	clc
	adc	#(>drop_y-$4)
	sta	OUTH


	ldy	#0

	txa		; ypos = X*8
	asl
	asl
	asl
setup_drop_y_inner:

	sta	(OUTL),Y

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
	; draw text screen
	;===================

	jsr	draw_text_screen

	;===================
	; flip page
	;===================

retry:
	lda	KEYPRESS
	bpl	retry
	bit	KEYRESET

	jsr	hgr_page_flip

	jmp	drop_loop



	.include "font_putchar.s"
	.include "fonts/a2_lowercase_font.inc"


	.include "hgr_table.s"
	.include "hgr_clearscreen.s"
	.include "gr_offsets_split.s"

	.include "hgr_page_flip.s"

	;===================
	; draw text screen
	;===================
	; looks up YPOS from each char from drop_y

draw_text_screen:
	ldx	#0
	ldy	#0
	stx	TEXT_X
	sty	TEXT_Y
;	sty	copy_text_screen_ysmc+1

copy_text_screen_outer_loop:
	ldx	TEXT_Y
	lda	gr_offsets_l,X
	sta	OUTL
	sta	INL
	lda	gr_offsets_h,X
	sta	OUTH
	adc	#(>drop_y-$4)
	sta	INH

	ldy	#0
	sty	TEXT_X
copy_text_screen_inner_loop:


	ldy	TEXT_X		; xpos

	lda	(INL),Y		; ypos
	tax

	; A0 = 1010 0000 -> 20 0000
	lda	(OUTL),Y	; load from current line
	and	#$7f		; strip extraneous high bit
				; note: this means inverse not supported
	jsr	font_putchar

	inc	TEXT_X
	lda	TEXT_X
	cmp	#40
	bne	copy_text_screen_inner_loop

;	lda	copy_text_screen_ysmc+1
;	clc
;	adc	#8
;	sta	copy_text_screen_ysmc+1

	inc	TEXT_Y
	lda	TEXT_Y
	cmp	#24
	bne	copy_text_screen_outer_loop

	rts
