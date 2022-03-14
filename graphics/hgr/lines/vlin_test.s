; hgr fast vlin test


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
BKGND0		= $F3F4		; clear screen to A
HPOSN           = $F411         ; (Y,X),(A)  (values stores in HGRX,XH,Y)
COLOR_SHIFT     = $F47E
COLORTBL        = $F6F6



main:
	; set graphics

	jsr	HGR


	; init tables

	jsr	vgi_init

	; draw lines

	; multicolor
	; for y=0 to 150 step 2:hgr_vlin 10,10+y at y: next

	ldy	#0
loop1:
	tya
	lsr
	lsr
	and	#$7
	tax
	jsr	set_hcolor

	tya
	pha

	tax			; X1=Y
	lda	#10		; Y1=A
;	ldy	#100		; Run = y
	jsr	hgr_vlin	; vlin (x,a) to (x,a+y)

	pla
	tay

	iny
	iny
	iny
	iny
	cpy	#160
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

	tax				; x1=Y
	tay				; yrun=y

	lda	#0			; y1=0

	jsr	hgr_vlin

	pla
	tay

	iny
	iny
	iny
	iny
	iny

	cpy	#150
	bne	loop2

	jsr	wait_until_keypress

; test 3


;	jsr	HGR2

	; note, clear to bgcolor=black2 or else edge looks a bit
	;	ragged when $FF touches $00

	lda	#$80
	jsr	BKGND0

	; draw lines
	ldy	#0
loop3:
	ldx	#7			; draw white
	jsr	set_hcolor

	tya
	pha
	tax				; X1=Y
					; Y1=A
	pha

	tya
	eor	#$ff
	sec
	adc	#191
	tay				; run=191-Y
	pla

	jsr	hgr_vlin

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
	tax				; X1=Y

	eor	#$ff
	sec
	adc	#192			; Y1=192-Y


					; run = Y

	jsr	hgr_vlin

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


.include "hgr_vlin.s"
