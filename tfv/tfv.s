.define EQU =

KEYPRESS	EQU	$C000
KEYRESET	EQU	$C010

;; SOFT SWITCHES
SET_GR		EQU	$C050
SET_TEXT	EQU	$C051
FULLGR		EQU	$C052
TEXTGR		EQU	$C053
PAGE0		EQU	$C054
PAGE1		EQU	$C055
LORES		EQU	$C056
HIRES		EQU	$C057

PADDLE_BUTTON0	EQU	$C061
PADDL0		EQU	$C064
PTRIG		EQU	$C070

;; BASIC ROUTINES

NORMAL	EQU	$F273

;; MONITOR ROUTINES

HLINE	EQU $F819			;; HLINE Y,$2C at A
VLINE	EQU $F828			;; VLINE A,$2D at Y
CLRSCR	EQU $F832			;; Clear low-res screen
CLRTOP	EQU $F836			;; clear only top of low-res screen
SETCOL	EQU $F864			;; COLOR=A
TEXT	EQU $FB36
TABV	EQU $FB5B			;; VTAB to A
BASCALC	EQU $FBC1			;;
VTAB	EQU $FC22			;; VTAB to CV
HOME	EQU $FC58			;; Clear the text screen
WAIT	EQU $FCA8			;; delay 1/2(26+27A+5A^2) us
SETINV	EQU $FE80			;; INVERSE
SETNORM	EQU $FE84			;; NORMAL
COUT	EQU $FDED			;; output A to screen
COUT1	EQU $FDF0			;; output A to screen

;; Zero page addresses
WNDLFT	EQU $20
WNDWDTH	EQU $21
WNDTOP	EQU $22
WNDBTM	EQU $23
CH	EQU $24
CV	EQU $25
GBASL	EQU $26
GBASH	EQU $27
BASL	EQU $28
BASH	EQU $29
H2	EQU $2C
V2	EQU $2D
MASK	EQU $2E
COLOR	EQU $30
INVFLG	EQU $32

; Our zero-page addresses
; we try not to conflict with anything DOS, MONITOR or BASIC related

COLOR1		EQU	$E0
COLOR2		EQU	$E1
MATCH		EQU	$E2
XX		EQU	$E3
YY		EQU	$E4
YADD		EQU	$E5
LOOP		EQU	$E6
MEMPTRL		EQU	$E7
MEMPTRH		EQU	$E8
NAMEL		EQU	$E9
NAMEH		EQU	$EA
NAMEX		EQU	$EB
CHAR		EQU	$EC

FIRST		EQU	$F0
LASTKEY		EQU	$F1
PADDLE_STATUS	EQU	$F2
XPOS		EQU	$F3
YPOS		EQU	$F4
TEMP		EQU	$FA
RUN		EQU	$FA
TEMP2		EQU	$FB
TEMPY		EQU	$FB
INL		EQU	$FC
INH		EQU	$FD
OUTL		EQU	$FE
OUTH		EQU	$FF

	;=============================
	; set low-res graphics, page 0
	;=============================
	jsr     HOME
	jsr     set_gr_page0

	;=============================
	; show VMW splash screen
	;=============================
	jsr     CLRTOP

	lda	#100
	sta	MATCH
	jsr	draw_logo

	lda	#0
	sta	MATCH
shine_loop:

	jsr	draw_logo

	inc	MATCH
	lda	MATCH
	cmp	#30
	bne	shine_loop

	lda	#8
	sta	CH		; HTAB 9

	lda	#20
	jsr	TABV		; VTAB 21


	lda     #>(vmwsw_string)
        sta     OUTH
	lda     #<(vmwsw_string)
        sta     OUTL

	jsr	print_string		; print("A VMW SOFTWARE PRODUCTION");


	jsr	wait_until_keypressed

	;======================
	; show the title screen
	;======================

title_screen:

	jsr     CLRTOP

	lda	#$c
	sta	BASH
	lda	#$0
	sta	BASL			; load image off-screen 0xc00

	lda     #>(title_image)
        sta     GBASH
	lda     #<(title_image)
        sta     GBASL
	jsr	load_rle_gr

	jsr	gr_copy

	lda	#20
	sta	YPOS
	lda	#20
	sta	XPOS

	jsr	gr_copy

	jsr	wait_until_keypressed


enter_name:

	jsr	TEXT
	jsr	HOME

	lda     #>(enter_name_string)
        sta     OUTH
	lda     #<(enter_name_string)
        sta     OUTL

	jsr	print_string

	; zero out name

	lda	#<(name)
	sta	MEMPTRL
	sta	NAMEL
	lda	#>(name)
	sta	MEMPTRH
	sta	NAMEH
	lda	#0
	ldx	#8
	jsr	memset

name_loop:

	jsr	NORMAL

	lda	#11
	sta	CH		; HTAB 12

	lda	#2
	jsr	TABV		; VTAB 3

	ldy	#0
	sty	NAMEX

name_line:
	cpy	NAMEX
	bne	name_notx
	lda	#'+'
	jmp	name_next

name_notx:
	lda	NAMEL,Y
	beq	name_zero
	ora	#$80
	bne	name_next

name_zero:
	lda	#('_'+$80)
name_next:
	jsr	COUT
	lda	#(' '+$80)
	jsr	COUT
	iny
	cpy	#8
	bne	name_line

	lda	#7
	sta	CV

	lda	#('@'+$80)
	sta	CHAR

print_letters_loop:
	lda	#11
	sta	CH		; HTAB 12
	jsr	VTAB

	ldy	#0

print_letters_inner_loop:
	lda	CHAR
	jsr	COUT
	inc	CHAR
	lda	#(' '+$80)
	jsr	COUT
	iny

	cpy	#$8
	bne	print_letters_inner_loop






	jsr	wait_until_keypressed

	;=====================
	; Start the game
	;=====================


flying_start:

	jsr     set_gr_page0

flying_loop:
	jsr	gr_copy

	jsr	put_sprite

	jsr	wait_until_keypressed





	lda	LASTKEY

	cmp	#('Q')
        beq	exit

	cmp	#('I')
	bne	check_down
	dec	YPOS
	dec	YPOS

check_down:
	cmp	#('M')
	bne	check_left
	inc	YPOS
	inc	YPOS

check_left:
	cmp	#('J')
	bne	check_right
	dec	XPOS

check_right:
	cmp	#('K')
	bne	check_done
	inc	XPOS

check_done:
	jmp	flying_loop



exit:

	lda	#$4
	sta	BASH
	lda	#$0
	sta	BASL			; restore to 0x400 (page 0)
					; copy to 0x400 (page 0)

	; call home
	jsr	HOME


	; Return to BASIC?
	rts

;=====================================================================
;= ROUTINES
;=====================================================================

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
	; display part of logo
	;=================
	;
draw_segment:
	lda	#0
	sta	LOOP

segment_loop:
	lda	YADD
	clc
	adc	YY
	sta	YY	; yy=yy+yadd

	lda	COLOR1
	sta	COLOR		; color=COLOR1

	lda	MATCH		; if (ram[XX]==ram[MATCH])
	cmp	XX
	bne	nocolmatch1

	lda	COLOR		; color_equals(ram[COLOR1]*3);
	clc
	adc	COLOR1
	adc	COLOR1
	sta	COLOR

nocolmatch1:
	lda	YY
	sta	V2
	lda	XX
	clc
	adc	#9
	tay
	lda	#10

	jsr	VLINE	; A,V2 at Y	vlin(10,ram[YY],9+ram[XX]);

	lda	COLOR2
	sta	COLOR		; color=COLOR2

	lda	MATCH		; if (ram[XX]==ram[MATCH])
	cmp	XX
	bne	nocolmatch2

	lda	COLOR		; color_equals(ram[COLOR2]*3);
	clc
	adc	COLOR2
	adc	COLOR2
	sta	COLOR

nocolmatch2:
	lda	#34
	sta	V2
	lda	XX
	clc
	adc	#9
	tay
	lda	YY
	cmp	#34
	beq	skip_bottom		   ; if (ram[YY]==34) skip
	jsr	VLINE	; A,V2 at Y	vlin(ram[YY],34,9+ram[XX]);

skip_bottom:


	inc	XX		; ram[XX]++;

	inc	LOOP
	lda	LOOP
	cmp	#4
	bne	segment_loop

	lda	YADD		; ram[YADD]=-ram[YADD];
	eor	#$ff
	clc
	adc	#1
	sta	YADD

	rts

	;=================
	; display VMW logo
	;=================
	;
draw_logo:
	lda	#0
	sta	XX		; start of logo
	lda	#10
	sta	YY		; draw at Y=10
	lda	#6
	sta	YADD		; step of 6

	lda	#$00
	sta	COLOR2
	lda	#$11
	sta	COLOR1		; first colors are red/black
	jsr	draw_segment
	lda	#$44
	sta	COLOR2		; now red/green
	jsr	draw_segment
	lda	#$22
	sta	COLOR1		; now green/blue
	jsr	draw_segment
	jsr	draw_segment
	jsr	draw_segment
	lda	#$00
	sta	COLOR2		; now blue/black
	jsr	draw_segment

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

vmwsw_string:
	.asciiz "A VMW SOFTWARE PRODUCTION"

enter_name_string:
	.asciiz	"PLEASE ENTER A NAME:"

name:
	.byte $0,$0,$0,$0,$0,$0,$0,$0


	; waste memory with a lookup table
	; maybe faster than using GBASCALC?

gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word 	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0

tb1_sprite:
	.byte $8,$4
	.byte $55,$50,$00,$00,$00,$00,$00,$00
	.byte $55,$55,$55,$00,$00,$00,$00,$00
	.byte $ff,$1f,$4f,$2f,$ff,$22,$20,$00
	.byte $5f,$5f,$5f,$5f,$ff,$f2,$f2,$f2

.include "title.inc"
