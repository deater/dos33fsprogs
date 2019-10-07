; Display a 40x48d lo-res image

; Uses the 40x48d page1/page2 every-1-scanline pageflip mode

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
;FRAME		= $60
;BLARGH		= $69
;DRAW_PAGE	= $EE
;LASTKEY		= $F1
;PADDLE_STATUS	= $F2
;TEMP		= $FA
WHICH		= $E3



book:
	lda	#0
	sta	WHICH

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE

	;=============================
	; Load graphic page0

	lda	WHICH
	asl
	asl				; which*4
	tay

	lda	pictures,Y
	sta	GBASL
	lda	pictures+1,Y
	sta	GBASH

	lda	#$c			; load image to $c00

	jsr	load_rle_gr

	lda	#4
	sta	DRAW_PAGE



	jsr	gr_copy_to_current	; copy to page1

	; GR part
	bit	PAGE1
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	jsr	wait_until_keypressed


	;=============================
	; Load graphic page1

	lda	WHICH
	asl
	asl				; which*4
	tay

	lda	pictures+2,Y
	sta	GBASL
	lda	pictures+3,Y
	sta	GBASH
	lda	#$c			; load image to $c00
	jsr	load_rle_gr

	lda	#0
	sta	DRAW_PAGE

	jsr	gr_copy_to_current

	; GR part
	bit	PAGE0

	jsr	wait_until_keypressed


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock

	; vapor lock returns with us at beginning of hsync in line
        ; 114 (7410 cycles), so with 5070 lines to go

        ; GR part
        bit     LORES                                                   ; 4
        bit     SET_GR                                                  ; 4
        bit     FULLGR                                                  ; 4

	jsr	gr_copy_to_current			; 6+ 9292

	; now we have 322 left

	; 322 - 12 = 310
	; - 3 for jmp
	; 307

	; Try X=9 Y=6 cycles=307

	ldy	#6							; 2
loopQ:	ldx	#9							; 2
loopR:	dex								; 2
	bne	loopR							; 2nt/3
	dey								; 2
	bne	loopQ							; 2nt/3

	jmp	book_loop						; 3
.align  $100


	;================================================
	; Display Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; We want to alternate between page1 and page2 every 65 cycles
        ;       vblank = 4550 cycles to do scrolling


	; 2 + 48*(  (4+2+25*(2+3)) + (4+2+23*(2+3)+4+5)) + 9)
	;     48*[(6+125)-1] + [(6+115+10)-1]

book_loop:

	ldy	#96						; 2

book_outer_loop:

	bit	PAGE0						; 4
	ldx	#12		; 65 cycles with PAGE0		; 2
book_page0_loop:			; delay 61+bit
	dex							; 2
	bne	book_page0_loop					; 2/3


	; bit(4) -1(fallthrough) + loop*5 -1(fallthrouh)+4 extra = 61
	; 5L = 55

	bit	PAGE1						; 4
	ldx	#11		; 65 cycles with PAGE1		; 2
				;
book_page1_loop:			; delay 115+(7 loop)+4 (bit)+4(extra)
	dex							; 2
	bne	book_page1_loop					; 2/3

	dey							; 2
	bne	book_outer_loop					; 2/3



	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be      4550+1 -2-9 -7= 4533

	jsr	book_do_nothing				; 6

	lda	KEYPRESS				; 4
	bpl	book_no_keypress				; 3
	rts
book_no_keypress:

	jmp	book_loop				; 3



	;=================================
	; do nothing
	;=================================
	; and take 4533-6 = 4527 cycles to do it
book_do_nothing:

	; Try X=4 Y=174 cycles=4525 R2

	nop	; 2

	ldy	#174							; 2
bloop1:
	ldx	#4							; 2
bloop2:
	dex								; 2
	bne	bloop2							; 2nt/3

	dey								; 2
	bne	bloop1							; 2nt/3


	rts							; 6


pictures:
	.word book_low,book_high


.include "book_40_48d.inc"


