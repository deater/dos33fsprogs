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
	lda	DISP_PAGE						; 3
	beq	page_flip_show_1					; 2nt/3
page_flip_show_0:
;        bit	PAGE0							; 4
;	lda	#4							; 2
	lda	#0
	sta	DRAW_PAGE	; DRAW_PAGE=1				; 3
	lda	#0							; 2
	sta	DISP_PAGE	; DISP_PAGE=0				; 3
	rts								; 6
page_flip_show_1:
;	bit	PAGE1							; 4
	lda	#0
	sta	DRAW_PAGE	; DRAW_PAGE=0				; 3
	lda	#1							; 2
	sta	DISP_PAGE	; DISP_PAGE=1				; 3
	rts								; 6
							;====================
							; DISP_PAGE=0 	26
							; DISP_PAGE=1	24

	;======================
	; memset
	;======================
	; a=value
	; x=length
	; MEMPTRL/MEMPTRH is address
memset:
	ldy	#0
memset_loop:
	sta	MEMPTRL,Y
	iny
	dex
	bne	memset_loop
	rts


	;=================
	; load RLE image
	;=================
	; Output is BASH/BASL
	; Input is in GBASH/GBASL
load_rle_gr:
	lda	#$0
	tax
	tay				; init X and Y to 0

	sta	CV			; ycoord=0

	lda	(GBASL),y		; load xsize
	sta	CH
	iny				; (we should check if we had
					;  bad luck and overflows page)

	iny				; skip ysize

rle_loop:
	lda	(GBASL),y		; load run value
	cmp	#$ff			; if 0xff
	beq	rle_done		; we are done
	sta	RUN
	iny				; point to next value
	bne	rle_yskip1		; if overflow, increment address
	inc	GBASH
rle_yskip1:
	lda	(GBASL),y		; load value to write
	iny
	bne	rle_yskip2
	inc	GBASH
rle_yskip2:
	sty	TEMP2			; save y for later
	pha
	lda	#$0
	tay
	pla				; convoluted way to set y to 0

rle_run_loop:
	sta	(BASL),y		; write out the value
	inc	BASL			; increment the pointer
	bne	rle_skip3		; if wrapped
	inc	BASH			; then increment the high value
rle_skip3:
	inx				; increment the X value
	cpx	CH			; compare against the image width
	bcc	rle_not_eol		; if less then keep going

	pha				; save out value on stack

	lda	BASL			; cheat to avoid a 16-bit add
	cmp	#$a7			; we are adding 0x58 to get
	bcc	rle_add_skip		; to the next line
	inc	BASH
rle_add_skip:
	clc
	adc	#$58			; actually do the 0x58 add
	sta	BASL			; and store it back

	inc	CV			; add 2 to ypos
	inc	CV			; each "line" is two high

	lda	CV			; load value
	cmp	#15			; if it's greater than 14 it wraps
	bcc	rle_no_wrap		; Thanks Woz

	lda	#$0			; we wrapped, so set to zero
	sta	CV

					; when wrapping have to sub 0x3d8
	sec				; this is a 16-bit subtract routine
	lda	BASL
	sbc	#$d8			; LSB
	sta	BASL
	lda	BASH			; MSB
	sbc	#$3			;
	sta	BASH

rle_no_wrap:
	lda	#$0			; set X value back to zero
	tax
	pla				; restore value to write from stack

rle_not_eol:
	dec	RUN			; decrement run value
	bne	rle_run_loop		; if not zero, keep looping

	ldy	TEMP2			; restore the input pointer
	sec
	bcs	rle_loop		; and branch always

rle_done:
	lda	#$15			; move the cursor somewhere sane
	sta	CV
	rts


	;==========================================================
	; set_text_page0
	;==========================================================
	;
set_text_page0:
	bit	PAGE0			; set page0
	bit	TEXT			; set text mode
	rts

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

	;=========================================================
	; gr_copy_to_current
	;=========================================================
	; copy 0xc00 to DRAW_PAGE
	; 2 + 8*38 + 4*80*23 + 4*120*26 + 13 = 20,159 = 20ms = 50Hz
	;
gr_copy_to_current:
	ldx	#0		; set y to zero				; 2

gr_copy_loop:
	stx	TEMP		; save y				; 3
	txa			; move to A				; 2
	asl			; mult by 2				; 2
	tay			; put into Y				; 2
	lda	gr_offsets,Y	; lookup low byte for line addr		; 5
	sta	OUTL		; out and in are the same		; 3
	sta	INL							; 3
	lda	gr_offsets+1,Y	; lookup high byte for line addr	; 5
	adc	DRAW_PAGE
	sta	OUTH							; 3
	lda	gr_offsets+1,Y	; lookup high byte for line addr	; 5
	adc	#$8		; for now, fixed 0xc			; 2
	sta	INH							; 3
	ldx	TEMP		; restore y				; 3

	ldy	#0		; set X counter to 0			; 2
gr_copy_line:
	lda     (INL),Y		; load a byte				; 5
	sta     (OUTL),Y	; store a byte				; 6
	iny			; increment pointer			; 2

	cpx	#$4		; don't want to copy bottom 4*40	; 2
	bcs	gr_copy_above4						; 3

gr_copy_below4:
	cpy	#120		; for early ones, copy 120 bytes	; 2
	bne	gr_copy_line						; 3
	beq	gr_copy_line_done					; 3

gr_copy_above4:			; for last four, just copy 80 bytes
	cpy	#80							; 2
	bne	gr_copy_line						; 3

gr_copy_line_done:
	inx			; increment y value			; 2
	cpx	#8		; there are 8 of them			; 2
	bne	gr_copy_loop	; if not, loop				; 3
	rts								; 6

	;==========================================================
	; Wait until keypressed
	;==========================================================
	;

wait_until_keypressed:
	lda	KEYPRESS			; check if keypressed
	bpl	wait_until_keypressed		; if not, loop
	jmp     figure_out_key


	;==========================================================
	; Get Key
	;==========================================================
	;

get_key:

check_paddle_button:

	; check for paddle button

	bit	PADDLE_BUTTON0						; 4
	bpl	no_button						; 2nt/3
	lda	#' '+128						; 2
	jmp	save_key						; 3

no_button:
	lda	KEYPRESS						; 3
	bpl	no_key							; 2nt/3

figure_out_key:
	cmp	#' '+128		; the mask destroys space	; 2
	beq	save_key		; so handle it specially	; 2nt/3

	and	#$5f			; mask, to make upper-case	; 2
check_right_arrow:
	cmp	#$15							; 2
	bne	check_left_arrow					; 2nt/3
	lda	#'D'							; 2
check_left_arrow:
	cmp	#$08							; 2
	bne	check_up_arrow						; 2nt/3
	lda	#'A'							; 2
check_up_arrow:
	cmp	#$0B							; 2
	bne	check_down_arrow					; 2nt/3
	lda	#'W'							; 2
check_down_arrow:
	cmp	#$0A							; 2
	bne	check_escape						; 2nt/3
	lda	#'S'							; 2
check_escape:
        cmp	#$1B							; 2
	bne	save_key						; 2nt/3
	lda	#'Q'							; 2
	jmp	save_key						; 3

no_key:
	bit	PADDLE_STATUS						; 3
	bpl	no_key_store						; 2nt/3

	; check for paddle action
	; code from http://web.pdx.edu/~heiss/technotes/aiie/tn.aiie.06.html

	inc	PADDLE_STATUS						; 5
	lda	PADDLE_STATUS						; 3
	and	#$03							; 2
	beq	check_paddles						; 2nt/3
	jmp	no_key_store						; 3

check_paddles:
	lda	PADDLE_STATUS						; 3
	and	#$80							; 2
	sta	PADDLE_STATUS						; 3

	ldx	#$0							; 2
	LDA	PTRIG		;TRIGGER PADDLES			; 4
	LDY	#0		;INIT COUNTER				; 2
	NOP			;COMPENSATE FOR 1ST COUNT		; 2
	NOP								; 2
PREAD2:	LDA	PADDL0,X	;COUNT EVERY 11 uSEC.			; 4
	BPL	RTS2D		;BRANCH WHEN TIMED OUT			; 2nt/3
	INY			;INCREMENT COUNTER			; 2
	BNE	PREAD2		;CONTINUE COUNTING			; 2nt/3
	DEY			;COUNTER OVERFLOWED			; 2
RTS2D:				;RETURN W/VALUE 0-255

        cpy	#96							; 2
        bmi	paddle_left						; 2nt/3
	cpy	#160							; 2
	bmi	no_key_store						; 2nt/3
	lda	#'D'							; 2
	jmp	save_key						; 3
paddle_left:
	lda	#'A'							; 2
	jmp	save_key						; 3

no_key_store:
	lda	#0			; no key, so save a zero	; 2

save_key:
	sta	LASTKEY			; save the key to our buffer	; 2
	bit	KEYRESET		; clear the keyboard buffer	; 4
	rts								; 6
								;============
								; 33=nokey
								; 48=worstkey


	;=============================================
	; put_sprite
	;=============================================
	; Sprite to display in INH,INL
	; Location is XPOS,YPOS
	; Note, only works if YPOS is multiple of two?

put_sprite:

	ldy	#0		; byte 0 is xsize			; 2
	lda	(INL),Y							; 5
	sta	CH		; xsize is in CH			; 3
	iny								; 2

	lda	(INL),Y		; byte 1 is ysize			; 5
	sta	CV		; ysize is in CV			; 3
	iny								; 2

	lda	YPOS		; make a copy of ypos			; 3
	sta	TEMPY		; as we modify it			; 3
								;===========
								;	28
put_sprite_loop:
	sty	TEMP		; save sprite pointer			; 3

	ldy	TEMPY							; 3
	lda	gr_offsets,Y	; lookup low-res memory address		; 5
	clc								; 2
	adc	XPOS		; add in xpos				; 3
	sta	OUTL		; store out low byte of addy		; 3
	lda	gr_offsets+1,Y	; look up high byte			; 5
	adc	DRAW_PAGE	;					; 3
	sta	OUTH		; and store it out			; 3
	ldy	TEMP		; restore sprite pointer		; 3

				; OUTH:OUTL now points at right place

	ldx	CH		; load xsize into x			; 3
								;===========
								;	36
put_sprite_pixel:
	lda	(INL),Y			; get sprite colors		; 5
	iny				; increment sprite pointer	; 2

	sty	TEMP			; save sprite pointer		; 3
	ldy	#$0							; 2

	; check if completely transparent
	; if so, skip

	cmp	#$0			; if all zero, transparent	; 2
	beq	put_sprite_done_draw	; don't draw it			; 2nt/3
					; FIXME: use BIT?	;==============
								;	 17

	sta	COLOR			; save color for later		; 3

	; check if top pixel transparent

	and	#$f0			; check if top nibble zero	; 2
	bne	put_sprite_bottom	; if not skip ahead		; 2nt/3

	lda	#$f0			; setup mask			; 2
	sta	MASK							; 3
	bmi	put_sprite_mask						; 2nt/3

put_sprite_bottom:
	lda	COLOR			; re-load color			; 3
	and	#$0f			; check if bottom nibble zero	; 2
	bne	put_sprite_all		; if not, skip ahead		; 2nt/3
	lda	#$0f							; 2
	sta	MASK			; setup mask			; 3

put_sprite_mask:
	lda	(OUTL),Y		; get color at output		; 5
	and	MASK			; mask off unneeded part	; 3
	ora	COLOR			; or the color in		; 3
	sta	(OUTL),Y		; store it back			; 5

	jmp	put_sprite_done_draw	; we are done			; 3

put_sprite_all:
	lda	COLOR			; load color			; 3
	sta	(OUTL),Y		; and write it out		; 5


put_sprite_done_draw:

	ldy	TEMP			; restore sprite pointer	; 3

	inc	OUTL			; increment output pointer	; 5
	dex				; decrement x counter		; 2
	bne	put_sprite_pixel	; if not done, keep looping	; 2nt/3

	inc	TEMPY			; each line has two y vars	; 5
	inc	TEMPY							; 5
	dec	CV			; decemenet total y count	; 5
	bne	put_sprite_loop		; loop if not done		; 2nt/3

	rts				; return			; 6


	;================================
	; htab_vtab
	;================================
	; move to CH/CV
htab_vtab:
	lda	CV
	asl
	tay
	lda	gr_offsets,Y    ; lookup low-res memory address
	clc
	adc	CH		; add in xpos
	sta	BASL		; store out low byte of addy

	lda	gr_offsets+1,Y	; look up high byte
	adc	DRAW_PAGE	;
	sta	BASH		; and store it out
				; BASH:BASL now points at right place

	rts

	;================================
	; move_and_print
	;================================
	; move to CH/CV
move_and_print:
	jsr	htab_vtab

	;================================
	; print_string
	;================================

print_string:
	ldy	#0
print_string_loop:
	lda	(OUTL),Y
	beq	done_print_string
	ora	#$80
	sta	(BASL),Y
	iny
	bne	print_string_loop
done_print_string:
	rts

	;====================
	; point_to_end_string
	;====================
point_to_end_string:
	iny
	tya
	clc
	adc	OUTL
	sta	OUTL
	lda	#0
	adc	OUTH
	sta	OUTH

	rts


	;================================
	; print_both_pages
	;================================
print_both_pages:
	lda	DRAW_PAGE
	pha

	lda	#4
	sta	DRAW_PAGE
	jsr	move_and_print

;	lda	#8
;	sta	DRAW_PAGE
;	jsr	move_and_print

	pla
	sta	DRAW_PAGE

	rts	; oops forgot this initially
		; explains the weird vertical stripes on the screen

	;=========================================
	; vlin
	;=========================================
	; X, V2 at Y
vlin:

	sty	TEMPY		; save Y (x location)
vlin_loop:

	txa			; a=x	(get first y)
	and	#$fe		; Clear bottom bit
	tay			;
	lda	gr_offsets,Y	; lookup low-res memory address low
	sta	GBASL		; put it into our indirect pointer
	iny
	lda	gr_offsets,Y	; lookup low-res memory address high
	clc
	adc	DRAW_PAGE	; add in draw page offset
	sta	GBASH		; put into top of indirect

	ldy	TEMPY		; load back in y (x offset)

	txa			; load back in x (current y)
	lsr			; check the low bit
	bcc	vlin_low	; if not set, skip to low

vlin_high:
	lda	#$F0		; setup masks
	sta	MASK
	lda	#$0f
	bcs	vlin_too_slow

vlin_low:			; setup masks
	lda	#$0f
	sta	MASK
	lda	#$f0
vlin_too_slow:

	and	(GBASL),Y	; mask current byte
	sta	(GBASL),Y	; and store back

	lda	MASK		; mask the color
	and	COLOR
	ora	(GBASL),Y	; or into the right place
	sta	(GBASL),Y	; store it

	inx			; increment X (current y)
	cpx	V2		; compare to the limit
	bcc	vlin_loop	; if <= then loop

	rts			; return


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

	;=====================
	; clear bottom
	;=====================
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

	;==========================
	; copy_page1_to_page0
	;==========================
	; x trashed

copy_page1_to_page0:
	bit	PAGE0
	ldx	#120					; 2
copy_p1p0_loop:
	lda	$800,X					; 4
	sta	$400,X					; 4
	lda	$880,X					; 4
	sta	$480,X					; 4
	lda	$900,X					; 4
	sta	$500,X					; 4
	lda	$980,X					; 4
	sta	$580,X					; 4
	lda	$a00,X					; 4
	sta	$600,X					; 4
	lda	$A80,X					; 4
	sta	$680,X					; 4
	lda	$B00,X					; 4
	sta	$700,X					; 4
	lda	$B80,X					; 4
	sta	$780,X					; 4
	dex						; 2
	bpl	copy_p1p0_loop				; 2nt/3
	rts						; 6
						; 2+ [((16*4)+2+3)*120] +5
						; 8287


	;==========================
	; copy_page2_to_aux
	;==========================
	; x trashed

copy_page2_to_aux:
	bit	PAGE1
	ldx	#120					; 2
copy_p2aux_loop:
	lda	$C00,X					; 4
	sta	$400,X					; 4
	lda	$C80,X					; 4
	sta	$480,X					; 4
	lda	$D00,X					; 4
	sta	$500,X					; 4
	lda	$D80,X					; 4
	sta	$580,X					; 4
	lda	$E00,X					; 4
	sta	$600,X					; 4
	lda	$E80,X					; 4
	sta	$680,X					; 4
	lda	$F00,X					; 4
	sta	$700,X					; 4
	lda	$F80,X					; 4
	sta	$780,X					; 4
	dex						; 2
	bpl	copy_p2aux_loop				; 2nt/3
	rts						; 6
						; 4+2+ [((16*4)+2+3)*120] +5
						; 8287
