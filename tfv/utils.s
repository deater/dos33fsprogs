;=====================================================================
;= ROUTINES
;=====================================================================

	;==========
	; page_flip
	;==========

page_flip:
	lda	DISP_PAGE
	beq	page_flip_show_1
page_flip_show_0:
        bit	PAGE0
	lda	#4
	sta	DRAW_PAGE	; DRAW_PAGE=1
	lda	#0
	sta	DISP_PAGE	; DISP_PAGE=0
	rts
page_flip_show_1:
	bit	PAGE1
	sta	DRAW_PAGE	; DRAW_PAGE=0
	lda	#1
	sta	DISP_PAGE	; DISP_PAGE=1
	rts


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
	; gr_copy
	;=========================================================
	; for now copy 0xc00 to 0x400
	; 2 + 8*38 + 4*80*23 + 4*120*26 + 13 = 20,159 = 20ms = 50Hz
	; 
gr_copy:
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
	sta	OUTH							; 3
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

	bit	PADDLE_BUTTON0
	bpl	no_button
	lda	#' '+128
	jmp	save_key

no_button:
	lda	KEYPRESS
	bpl	no_key

figure_out_key:
	cmp	#' '+128		; the mask destroys space
	beq	save_key		; so handle it specially

	and	#$5f			; mask, to make upper-case
check_right_arrow:
	cmp	#$15
	bne	check_left_arrow
	lda	#'K'
check_left_arrow:
	cmp	#$08
	bne	check_up_arrow
	lda	#'J'
check_up_arrow:
	cmp	#$0B
	bne	check_down_arrow
	lda	#'I'
check_down_arrow:
	cmp	#$0A
	bne	check_escape
	lda	#'M'
check_escape:
        cmp	#$1B
	bne	save_key
	lda	#'Q'
	jmp	save_key

no_key:
	bit	PADDLE_STATUS
	bpl	no_key_store

	; check for paddle action
	; code from http://web.pdx.edu/~heiss/technotes/aiie/tn.aiie.06.html

	inc	PADDLE_STATUS
	lda	PADDLE_STATUS
	and	#$03
	beq	check_paddles
	jmp	no_key_store

check_paddles:
	lda	PADDLE_STATUS
	and	#$80
	sta	PADDLE_STATUS

	ldx	#$0
	LDA	PTRIG		;TRIGGER PADDLES
	LDY	#0		;INIT COUNTER
	NOP			;COMPENSATE FOR 1ST COUNT
	NOP
PREAD2:	LDA	PADDL0,X	;COUNT EVERY 11 uSEC.
	BPL	RTS2D		;BRANCH WHEN TIMED OUT
	INY			;INCREMENT COUNTER
	BNE	PREAD2		;CONTINUE COUNTING
	DEY			;COUNTER OVERFLOWED
RTS2D:				;RETURN W/VALUE 0-255

        cpy	#96
        bmi	paddle_left
	cpy	#160
	bmi	no_key_store
	lda	#'K'
	jmp	save_key
paddle_left:
	lda	#'J'
	jmp	save_key

no_key_store:
	lda	#0			; no key, so save a zero

save_key:
	sta	LASTKEY			; save the key to our buffer
	bit	KEYRESET		; clear the keyboard buffer
	rts

	;=============================================
	; put_sprite
	;=============================================
put_sprite:

	lda	#>tb1_sprite	; hardcoded for tb1 for now
	sta	INH
	lda	#<tb1_sprite
	sta	INL

	ldy	#0		; byte 0 is xsize
	lda	(INL),Y
	sta	CH
	iny

	lda	(INL),Y		; byte 1 is ysize
	sta	CV
	iny

	lda	YPOS		; make a copy of ypos
	sta	TEMPY		; as we modify it

put_sprite_loop:
	sty	TEMP		; save sprite pointer

	ldy	TEMPY
	lda	gr_offsets,Y	; lookup low-res memory address		; 5
	clc
	adc	XPOS		; add in xpos
	sta	OUTL		; store out low byte of addy		; 3
	lda	gr_offsets+1,Y	; look up high byte			; 5
	sta	OUTH		; and store it out			; 3
	ldy	TEMP		; restore sprite pointer		; 3

	ldx	CH

put_sprite_pixel:
	lda	(INL),Y			; get sprite colors
	iny				; increment sprite pointer

	sty	TEMP			; save sprite pointer
	ldy	#$0

	cmp	#$0			; if all zero, transparent
	beq	put_sprite_done_draw	; don't draw it

					; FIXME: use BIT?

	sta	COLOR			; save color for later
	and	#$f0			; check if top nibble zero
	bne	put_sprite_bottom	; if not skip ahead

	lda	#$0f			; setup mask
	sta	MASK
	bmi	put_sprite_mask

put_sprite_bottom:
	lda	COLOR			; re-load color
	and	#$0f			; check if bottom nibble zero
	bne	put_sprite_all		; if not, skip ahead
	lda	#$0f
	sta	MASK			; setup mask

put_sprite_mask:
	lda	(OUTL),Y		; get color at output
	and	MASK			; mask off unneeded part
	ora	COLOR			; or the color in
	sta	(OUTL),Y		; store it back

	jmp	put_sprite_done_draw	; we are done

put_sprite_all:
	lda	COLOR			; load color
	sta	(OUTL),Y		; and write it out


put_sprite_done_draw:

	ldy	TEMP			; restore sprite pointer

	inc	OUTL			; increment output pointer
	dex				; decrement x counter
	bne	put_sprite_pixel	; if not done, keep looping

	inc	TEMPY			; each line has two y vars
	inc	TEMPY
	dec	CV			; decemenet total y count
	bne	put_sprite_loop		; loop if not done

	rts				; return

print_string:
	ldy	#0
print_string_loop:
	lda	(OUTL),Y
	beq	done_print_string
	ora	#$80
	jsr	COUT1
	iny
	bne	print_string_loop
done_print_string:
	rts



	;=========================================
	; vlin
	;=========================================
	; X, V2 at Y
vlin:
;int vlin(int page, int y1, int y2, int at) {

	sty	TEMPY		; save Y (x location)
vlin_loop:
;        for(i=A;i<V2;i++) {


	txa			; a=x	(get first y)
	and	#$fe		; Clear bottom bit
	tay			; y=A
	lda	gr_offsets,Y	; lookup low-res memory address
	sta	GBASL
	iny
	lda	gr_offsets,Y
	clc
	adc	DRAW_PAGE	; add in draw page offset
	sta	GBASH

;               vlin_hi=i&1;

;	pha

	ldy	TEMPY

	lda	COLOR
	sta	(GBASL),Y

;	lda	#$0F
;	and	(GBASL),Y
;	sta	(GBASL),Y
;	lda	COLOR
;	and	#$f0
;	ora	(GBASL),Y
;	sta	(GBASL),Y

 ;               if (vlin_hi) {
  ;                      ram[vlin_addr]=ram[vlin_addr]&0x0f;
   ;                     ram[vlin_addr]|=ram[COLOR]&0xf0;
    ;            }
     ;           else {
      ;                  ram[vlin_addr]=ram[vlin_addr]&0xf0;
       ;                 ram[vlin_addr]|=ram[COLOR]&0x0f;
        ;        }

;	pla

	inx
	cpx	V2
	bcc	vlin_loop

	rts







	;================================
	; hlin_double:
	;================================
	; VLIN Y, V2 AT A
hlin_double:
;int hlin_double(int page, int x1, int x2, int at) {

	sty	TEMPY
	tay			; y=A
	lda	gr_offsets,Y	; lookup low-res memory address
	clc
	adc	TEMPY
	sta	GBASL
	iny

	lda	gr_offsets,Y
	adc	DRAW_PAGE	; add in draw page offset
	sta	GBASH

	sec
	lda	V2
	sbc	TEMPY

	tax

;	jsr	hlin_double_continue

;	rts
	; fallthrough

	;=================================
	; hlin_double_continue:  width
	;=================================
	; width in X

hlin_double_continue:

hlin_loop:
	ldy	#0
	lda	COLOR
	sta	(GBASL),Y
	inc	GBASL
	dex
	bne	hlin_loop

	rts


	;=============================
	; clear_top
	;=============================
clear_top:
	lda	#$00
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
