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

	lda	#0
	sta	DRAW_PAGE
	jsr	move_and_print

	lda	#4
	sta	DRAW_PAGE
	jsr	move_and_print

	pla
	sta	DRAW_PAGE

	rts	; oops forgot this initially
		; explains the weird vertical stripes on the screen


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

