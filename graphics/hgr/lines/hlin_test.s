; hgr fast hlin test


HGR_BITS	= $1C
GBASL		= $26
GBASH		= $27
HGR_COLOR	= $E4
HGR_PAGE	= $E6

div7_table	= $9000
mod7_table	= $9100

KEYPRESS	= $C000
KEYRESET	= $C010

HGR2            = $F3D8         ; clear PAGE2 to 0
HGR             = $F3E2         ; set hires page1 and clear $2000-$3fff
HPOSN           = $F411         ; (Y,X),(A)  (values stores in HGRX,XH,Y)
COLOR_SHIFT     = $F47E
COLORTBL        = $F6F6



main:
	; set graphics

	jsr	HGR


	; init tables

	jsr	vgi_init

	; draw lines
	ldy	#0
loop1:
	tya
	lsr
	and	#$7
	tax
	jsr	set_hcolor

	tya
	pha

	ldx	#10
;	lda	#10
;	ldy	#100
	jsr	hgr_hlin

	pla
	tay

	iny
	iny
	cpy	#190
	bne	loop1

	jsr	wait_until_keypress


; test 2


	jsr	HGR2

	; draw lines
	ldy	#0
loop2:
	ldx	#7			; draw white
	jsr	set_hcolor

	tya				; save y on stack
	pha

	tya				; line
	lsr
	sec
	eor	#$ff
	adc	#96
	tax

	tya

	jsr	hgr_hlin

	pla
	tay

	iny
	iny
	cpy	#192
	bne	loop2

	jsr	wait_until_keypress

; test 3


	jsr	HGR2

	; draw lines
	ldy	#0
loop3:
	ldx	#7			; draw white
	jsr	set_hcolor

	tya
	pha
	ldx	#0

	jsr	hgr_hlin

	pla
	tay

	iny
	cpy	#192
	bne	loop3

	jsr	wait_until_keypress

; test 4

	jsr	HGR2

	; draw lines
	ldy	#0
loop4:
	ldx	#3			; draw white1
	jsr	set_hcolor

	tya
	pha

	eor	#$ff
	sec
	adc	#192
	tax

	tya

	jsr	hgr_hlin

	pla
	tay

	iny
	cpy	#192
	bne	loop4

	jsr	wait_until_keypress



done:
	jmp	main

wait_until_keypress:
	bit	KEYRESET
keypress_loop:
	lda	KEYPRESS
	bpl	keypress_loop

	rts


	;=====================
	; make /7 %7 tables
	;=====================

vgi_init:

vgi_make_tables:

	ldy	#0
	lda	#0
	ldx	#0
div7_loop:
	sta	div7_table,Y

	inx
	cpx	#7
	bne	div7_not7

	clc
	adc	#1
	ldx	#0
div7_not7:
	iny
	bne	div7_loop


	ldy	#0
	lda	#0
mod7_loop:
	sta	mod7_table,Y
	clc
	adc	#1
	cmp	#7
	bne	mod7_not7
	lda	#0
mod7_not7:
	iny
	bne	mod7_loop

	rts


.include "hgr_hlin.s"
