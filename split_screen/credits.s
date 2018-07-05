.include "zp.inc"

	H2	= $2C
;	V2	= $2D
;	TEMPY	= $FB

	HGR	= $F3E2
	HPLOT0	= $F457
	HCOLOR	= $F6EC
;	HLINE	= $F819
;	VLINE	= $F828
;	COLOR	= $F864
;	TEXT 	= $FB36
;	HOME	= $FC58

	jsr	TEXT
	jsr	HOME

	lda	#0
	sta	DISP_PAGE
	lda	#0
	sta	DRAW_PAGE

	lda	#0
	sta	CH
	sta	CV
	lda	#<line1
	sta	OUTL
	lda	#>line1
	sta	OUTH
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	; draw the moon
	lda	#0
	sta	CV
	lda	#3
	sta	CH
	jsr	htab_vtab	; vtab(1); htab(4)
	lda	#32	; inverse space
	ldy	#0
	sta	(BASL),Y

	inc	CV
	dec	CH
	jsr	htab_vtab
	lda	#32
	ldy	#0
	sta	(BASL),Y

	inc	CV
	jsr	htab_vtab
	lda	#32
	ldy	#0
	sta	(BASL),Y

	inc	CV
	inc	CH
	jsr	htab_vtab
	lda	#32
	ldy	#0
	sta	(BASL),Y

	; Wait

	jsr	wait_until_keypressed

	; GR part
	bit	LORES
	bit	SET_GR
	bit	FULLGR

	lda	#$44
	sta	COLOR

	lda	#39
	sta	V2

	lda	#28

line_loop:
	pha

	ldy	#0

	jsr	hlin_double

	pla
	clc
	adc	#2
	cmp	#48
	bne	line_loop

	; Wait

	jsr	wait_until_keypressed

	bit	HIRES


	; Wait

	jsr	wait_until_keypressed


display_loop:
	; each scan line 65 cycles
	;	1 cycle each byte (40cycles) + 25 for horizontal
	;	Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	;	16666     = 17030      x=1021.8
	;         1000        x


	; TODO: find beginning of scan
	;	Text mode for 6*8=48 scanlines (3120 cycles)
	;	hgr for 64 scalines (4160 cycles)
	;	gr for 80 scalines (5200 cycles)
	;	vblank = 4550 cycles

	; text
	bit	SET_TEXT						; 4

	ldy	#15							; 2
loop2:

	; 5*255+2 = 197

	ldx	#39							; 2
loop1:
	dex								; 2
	bne	loop1							; 2nt/3

	dey								; 2
	bne	loop2							; 2nt/3

	; hgr
	bit	HIRES							; 4
	bit	SET_GR							; 4

	ldy	#15							; 2
loop3:

	; 5*255+2 = 197

	ldx	#39							; 2
loop4:
	dex								; 2
	bne	loop4							; 2nt/3

	dey								; 2
	bne	loop3							; 2nt/3



	; gr
	bit	LORES

	ldy	#15							; 2
loop5:

	; 5*255+2 = 197

	ldx	#39							; 2
loop6:
	dex								; 2
	bne	loop6							; 2nt/3

	dey								; 2
	bne	loop5							; 2nt/3




	jmp	display_loop						; 3

wait_until_keypressed:
	lda	KEYPRESS			; check if keypressed
	bpl	wait_until_keypressed		; if not, loop
	bit	KEYRESET
	rts

line1:.asciiz	"   *                            .      "
line2:.asciiz	"  *    .       T A L B O T          .  "
line3:.asciiz	"  *           F A N T A S Y            "
line4:.asciiz	"   *            S E V E N              "
line5:.asciiz	" .                          .    .     "
line6:.asciiz	"             .                         "

.include "../asm_routines/gr_offsets.s"
.include "../asm_routines/text_print.s"
.include "../asm_routines/gr_hlin_double.s"

.align	$1000

.incbin	"KATC.BIN"
