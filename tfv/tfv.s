.define EQU =

;; SOFT SWITCHES
GR	EQU $C050
TEXT	EQU $C051
FULLGR	EQU $C052
TEXTGR	EQU $C053
PAGE0	EQU $C054
PAGE1	EQU $C055
LORES	EQU $C056
HIRES	EQU $C057

;; MONITOR ROUTINES
HLINE	EQU $F819			;; HLINE Y,$2C at A
VLINE	EQU $F828			;; VLINE A,$2D at Y
CLRSCR	EQU $F832			;; Clear low-res screen
CLRTOP	EQU $F836			;; clear only top of low-res screen
SETCOL	EQU $F864			;; COLOR=A
BASCALC	EQU $FBC1			;;
HOME	EQU $FC58			;; Clear the text screen
WAIT	EQU $FCA8			;; delay 1/2(26+27A+5A^2) us
SETINV	EQU $FE80			;; INVERSE
SETNORM	EQU $FE84			;; NORMAL
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
FIRST	EQU $F0

TEMP	EQU $FA
RUN	EQU $FA
TEMP2	EQU $FB

	;=============================
	; set low-res graphics, page 0
	;=============================
	jsr     HOME
	jsr     set_gr_page0

	;=================
	; clear the screen
	;=================
	jsr     CLRTOP


	lda     #>(title_image)
        sta     GBASH
	lda     #<(title_image)
        sta     GBASL
	jsr	load_rle_gr

	lda	#$4
	sta	BASH
	lda	#$0
	sta	BASL			; 0x400 is GR page 0

	; Return to BASIC?
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
	sta	(BASL),y
	inc	BASL
	bne	rle_skip3
	inc	BASH			; write out value
rle_skip3:
	inx
	cpx	CH
	bcc	rle_not_eol		; branch if less than

	pha

	lda	BASL
	cmp	#$a7
	bcc	rle_add_skip
	inc	BASH
rle_add_skip:
	clc
	adc	#$58
	sta	BASL
	inc	CV
	inc	CV
	lda	CV
	cmp	#15
	bcc	rle_no_wrap

	lda	#$0
	sta	CV
	sec				; set carry for borrow purpose
	lda	BASL
	sbc	#$d8			; perform subtraction on the LSBs
	sta	BASL
	lda	BASH			; do the same for the MSBs, with carry
	sbc	#$3			; set according to the previous result
	sta	BASH

rle_no_wrap:
	lda	#$0
	tax
	pla

rle_not_eol:
	dec	RUN
	bne	rle_run_loop

	ldy	TEMP2
	sec
	bcs	rle_loop

rle_done:
	lda	#$15
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
	bit	GR			; set graphics
	rts

.include "title.inc"
